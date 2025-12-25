/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ProgressionSystem.h"
#include "DBUpdater.h"
#include "Tokenize.h"
#include "StringConvert.h"

#include <filesystem>
#include <unordered_set>

inline std::string DetermineModuleBracketBasePath()
{
    namespace fs = std::filesystem;

    // Worldserver's working directory differs depending on how it is launched (Windows service,
    // IDE, acore.sh, etc). Probe a few common relative locations.
    std::array<std::string, 5> const candidates =
    {
        "modules/mod-progression-blizzlike/src/Bracket_",
        "../modules/mod-progression-blizzlike/src/Bracket_",
        "../../modules/mod-progression-blizzlike/src/Bracket_",
        "../../../modules/mod-progression-blizzlike/src/Bracket_",
        "../../../../modules/mod-progression-blizzlike/src/Bracket_",
    };

    for (std::string const& base : candidates)
    {
        // Probe only the module/bracket folder itself (independent of auth/characters/world).
        // Not every bracket ships sql/auth or sql/characters, so those folders must not be required.
        fs::path const probe = fs::path(base + "0");
        if (fs::exists(probe) && fs::is_directory(probe))
        {
            LOG_INFO("server.server", "[mod-progression-blizzlike] Using bracket SQL base path: '{}'", base);
            return base;
        }
    }

    LOG_WARN("server.server",
        "[mod-progression-blizzlike] Could not locate bracket SQL folders from the current working directory. "
        "Tried common relative paths like './modules/...'. Falling back to 'modules/mod-progression-blizzlike/src/Bracket_'.");
    return "modules/mod-progression-blizzlike/src/Bracket_";
}

inline std::vector<std::string> GetDatabaseDirectories(std::string const& folderName)
{
    std::vector<std::string> directories;

    namespace fs = std::filesystem;

    // DBUpdater expects paths relative to the worldserver working directory.
    // Using a relative path here avoids platform-specific absolute paths.
    std::string const path = DetermineModuleBracketBasePath();
    for (std::string const& bracketName : ProgressionBracketsNames)
    {
        if (!(sConfigMgr->GetOption<bool>("ProgressionSystem.Bracket_" + bracketName, false)))
        {
            continue;
        }

        std::string bracketPath = path + bracketName + "/sql/" + folderName;
        fs::path const bracketDir = fs::path(bracketPath);
        if (!fs::exists(bracketDir) || !fs::is_directory(bracketDir))
        {
            // Many brackets will not have sql/auth or sql/characters folders; that's OK.
            // Warn only for missing world folders since those carry the bulk of progression changes.
            if (folderName == "world")
            {
                LOG_WARN("server.server",
                    "[mod-progression-blizzlike] Enabled bracket '{}' but SQL directory not found: '{}' (cwd-sensitive)",
                    bracketName, bracketPath);
            }
            continue;
        }

        directories.push_back(std::move(bracketPath));
    }

    if (directories.empty())
    {
        LOG_INFO("server.server",
            "[mod-progression-blizzlike] DBUpdater will scan 0 '{}' directories (this can be normal).",
            folderName);
    }
    else
    {
        LOG_INFO("server.server",
            "[mod-progression-blizzlike] DBUpdater will scan {} '{}' directories.",
            directories.size(), folderName);
    }

    return directories;
}

template <typename TDatabase>
static void DeleteModuleUpdatesForEnabledBrackets(TDatabase& db, std::string const& folderName)
{
    // DBUpdater records executed updates into the `updates` table.
    // To force reapply, delete only rows that belong to this module's enabled bracket directories.
    // This is intentionally scoped (we do NOT delete global 'progression_%' entries).
    std::string const base = DetermineModuleBracketBasePath();

    for (std::string const& bracketName : ProgressionBracketsNames)
    {
        if (!sConfigMgr->GetOption<bool>("ProgressionSystem.Bracket_" + bracketName, false))
            continue;

        std::string const dirPrefix = base + bracketName + "/sql/" + folderName + "/";

        // Most AzerothCore setups store the relative path (including directory) in `updates.name`.
        // If a custom core stores only the filename, this won't match; in that case, force reapply
        // must be done by clearing `updates` manually.
        db.Query("DELETE FROM updates WHERE name LIKE '{}'", dirPrefix + "%");
    }
}

template <typename TDatabase>
static void LogModulePendingSqlFiles(TDatabase& db, std::vector<std::string> const& directories, std::string const& folderName)
{
    bool const enabled = sConfigMgr->GetOption<bool>("ProgressionSystem.Debug.LogPendingSql", false);
    if (!enabled)
        return;

    uint32 const maxLines = static_cast<uint32>(std::max<int32>(0, sConfigMgr->GetOption<int32>("ProgressionSystem.Debug.MaxSqlLogLines", 200)));
    bool const reapply = sConfigMgr->GetOption<bool>("ProgressionSystem.ReapplyUpdates", false);

    namespace fs = std::filesystem;

    // Collect already-applied update names for these directories (best-effort).
    std::unordered_set<std::string> applied;
    applied.reserve(4096);

    for (std::string const& dir : directories)
    {
        auto result = db.Query("SELECT name FROM updates WHERE name LIKE '{}'", dir + "/%");
        if (!result)
            continue;

        do
        {
            applied.insert((*result)[0].Get<std::string>());
        } while (result->NextRow());
    }

    uint32 printed = 0;
    uint32 totalPending = 0;
    uint32 totalFiles = 0;

    for (std::string const& dir : directories)
    {
        fs::path const p(dir);
        if (!fs::exists(p) || !fs::is_directory(p))
            continue;

        for (fs::directory_iterator it(p); it != fs::directory_iterator(); ++it)
        {
            if (!it->is_regular_file())
                continue;
            if (it->path().extension() != ".sql")
                continue;

            ++totalFiles;

            std::string const updateName = dir + "/" + it->path().filename().string();
            bool const isApplied = (applied.find(updateName) != applied.end());
            bool const shouldPrint = reapply ? true : !isApplied;

            if (!isApplied)
                ++totalPending;

            if (!shouldPrint)
                continue;

            if (printed < maxLines)
            {
                LOG_INFO("server.server", "[mod-progression-blizzlike] {} SQL {}: {}",
                    folderName,
                    reapply ? "(reapply)" : "(pending)",
                    updateName);
                ++printed;
            }
        }
    }

    LOG_INFO("server.server",
        "[mod-progression-blizzlike] SQL summary for '{}': files_found={} pending_estimated={} printed={} max={} reapply={}",
        folderName, totalFiles, totalPending, printed, maxLines, reapply ? 1 : 0);
}

class ProgressionSystemLoadingDBUpdates : public DatabaseScript
{
public:
    ProgressionSystemLoadingDBUpdates() : DatabaseScript("ProgressionSystemLoadingDBUpdates") {}

    void OnAfterDatabasesLoaded(uint32 updateFlags) override
    {
        LOG_INFO("server.server", "Loading mod-progression-blizzlike updates...");

        if (DBUpdater<LoginDatabaseConnection>::IsEnabled(updateFlags))
        {
            if (sConfigMgr->GetOption<bool>("ProgressionSystem.ReapplyUpdates", false))
            {
                DeleteModuleUpdatesForEnabledBrackets(LoginDatabase, "auth");
            }

            std::vector<std::string> loginDatabaseDirectories = GetDatabaseDirectories("auth");
            if (!loginDatabaseDirectories.empty())
            {
                LogModulePendingSqlFiles(LoginDatabase, loginDatabaseDirectories, "auth");
                DBUpdater<LoginDatabaseConnection>::Update(LoginDatabase, &loginDatabaseDirectories);
            }
        }

        if (DBUpdater<CharacterDatabaseConnection>::IsEnabled(updateFlags))
        {
            if (sConfigMgr->GetOption<bool>("ProgressionSystem.ReapplyUpdates", false))
            {
                DeleteModuleUpdatesForEnabledBrackets(CharacterDatabase, "characters");
            }

            std::vector<std::string> charactersDatabaseDirectories = GetDatabaseDirectories("characters");
            if (!charactersDatabaseDirectories.empty())
            {
                LogModulePendingSqlFiles(CharacterDatabase, charactersDatabaseDirectories, "characters");
                DBUpdater<CharacterDatabaseConnection>::Update(CharacterDatabase, &charactersDatabaseDirectories);
            }
        }

        if (DBUpdater<WorldDatabaseConnection>::IsEnabled(updateFlags))
        {
            if (sConfigMgr->GetOption<bool>("ProgressionSystem.ReapplyUpdates", false))
            {
                DeleteModuleUpdatesForEnabledBrackets(WorldDatabase, "world");
            }

            std::vector<std::string> worldDatabaseDirectories = GetDatabaseDirectories("world");
            if (!worldDatabaseDirectories.empty())
            {
                LogModulePendingSqlFiles(WorldDatabase, worldDatabaseDirectories, "world");
                DBUpdater<WorldDatabaseConnection>::Update(WorldDatabase, &worldDatabaseDirectories);
            }
        }

        // Remove disabled attunements
        std::string disabledAttunements = sConfigMgr->GetOption<std::string>("ProgressionSystem.DisabledAttunements", "");
        for (auto& itr : Acore::Tokenize(disabledAttunements, ',', false))
            WorldDatabase.Query("DELETE FROM dungeon_access_requirements WHERE dungeon_access_id = {}", Acore::StringTo<uint32>(itr).value());
    }
};

void AddProgressionSystemScripts()
{
    if (sConfigMgr->GetOption<bool>("ProgressionSystem.LoadDatabase", true))
    {
        new ProgressionSystemLoadingDBUpdates();
    }
}
