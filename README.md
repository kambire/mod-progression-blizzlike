# Progression System Module for AzerothCore

The Progression System Module allows for the automatic loading of scripts and SQL files based on level brackets. By defining which level brackets should be active in the configuration, C++ scripts from these brackets are loaded and replace the default "normal" scripts in AzerothCore.

This system enables **progressive content releases** that mimic Blizzard's original WoW expansions, allowing servers to unlock content gradually to recreate the exact progression timeline from November 2004 through December 2009.

## Quick Start

1. **Enable Brackets**: Edit `conf/progression_system.conf.dist` and set brackets to `1` to activate them
2. **Load SQL Files**: Ensure the auto database updater runs to apply SQL changes
3. **Load Scripts**: C++ scripts are loaded automatically from enabled brackets
4. **Test**: Verify content appears and is accessible at the correct level

## Available Brackets (38 Total)

See [BRACKET_DESCRIPTIONS_COMPLETE.md](BRACKET_DESCRIPTIONS_COMPLETE.md) for **detailed documentation** of every bracket with release dates, bosses, and mechanics.

### Vanilla (Levels 1-60)
- **Bracket_0**: Levels 1-10 - Starting Zones
- **Bracket_1_19**: Levels 10-19 - Early Dungeons
- **Bracket_20_29**: Levels 20-29 - Mid-Level Dungeons
- **Bracket_30_39**: Levels 30-39 - Advanced Dungeons
- **Bracket_40_49**: Levels 40-49 - World Dungeons (Dire Maul, UBRS Prep)
- **Bracket_50_59_1**: Levels 50-59 - UBRS Attunement
- **Bracket_50_59_2**: Levels 50-59 - Upper Blackrock Spire
- **Bracket_60_1_1**: Level 60 - Molten Core (40-man, Nov 23, 2004)
- **Bracket_60_1_2**: Level 60 - Onyxia's Lair (40-man, Nov 23, 2004)
- **Bracket_60_2_1**: Level 60 - Blackwing Lair (40-man, Jan 19, 2005)
- **Bracket_60_2_2**: Level 60 - Zul'Gurub (20-man, Jan 19, 2005)
- **Bracket_60_3_1**: Level 60 - Ruins of Ahn'Qiraj (20-man, Jan 19, 2005)
- **Bracket_60_3_2**: Level 60 - Temple of Ahn'Qiraj (40-man, Jan 19, 2005)
- **Bracket_60_3_3**: Level 60 - AQ Post-Content Phase

### The Burning Crusade (Levels 61-70)
- **Bracket_61_64**: Levels 61-64 - Outland Intro Dungeons (Jan 16, 2007)
- **Bracket_65_69**: Levels 65-69 - Mid-Level Outland Dungeons
- **Bracket_70_1_1**: Level 70 - Normal Dungeons (Jan 16, 2007)
- **Bracket_70_1_2**: Level 70 - Heroic Dungeons
- **Bracket_70_2_1**: Level 70 - Gruul's Lair + Magtheridon (25-man, Jan 16, 2007), **Arena Season 1**
- **Bracket_70_2_2**: Level 70 - Karazhan (10-man, Jan 16, 2007)
- **Bracket_70_2_3**: Level 70 - Ogri'la World Content Only
- **Bracket_70_3_1**: Level 70 - Serpentshrine Cavern (25-man, May 15, 2007)
- **Bracket_70_3_2**: Level 70 - The Eye (25-man Raid, May 15, 2007), **Arena Season 2**
- **Bracket_70_4_1**: Level 70 - Battle For Mount Hyjal (25-man, Aug 24, 2007), Netherwing Dailies
- **Bracket_70_4_2**: Level 70 - Black Temple (25-man, Sep 24, 2007)
- **Bracket_70_5**: Level 70 - Zul'Aman (10-man, Dec 11, 2007), **Arena Season 3**
- **Bracket_70_6_1**: Level 70 - Isle of Quel'Danas World Content (May 22, 2008)
- **Bracket_70_6_2**: Level 70 - Sunwell Plateau (25-man Final Raid, May 22, 2008), **Arena Season 4**
- **Bracket_70_6_3**: Level 70 - TBC Final Phase (Dragons, Events)

### Wrath of the Lich King (Levels 71-80)
- **Bracket_71_74**: Levels 71-74 - Northrend Intro Dungeons (Nov 13, 2008)
- **Bracket_75_79**: Levels 75-79 - Mid-Level Northrend Dungeons
- **Bracket_80_1_1**: Level 80 - Normal Dungeons
- **Bracket_80_1_2**: Level 80 - Heroic Dungeons, **Arena Season 5** (Nov 2008)
- **Bracket_80_2**: Level 80 - Ulduar (Apr 16, 2009) + Naxxramas 80 (Nov 13, 2008) + Eye of Eternity + Obsidian Sanctum, **Arena Season 6** (Apr 15, 2009)
- **Bracket_80_3**: Level 80 - Trial of the Crusader (Aug 4, 2009) + Onyxia 80, **Arena Season 7** (Aug 4, 2009)
- **Bracket_80_4_1**: Level 80 - Icecrown Citadel (Dec 8, 2009), **Arena Season 8**
- **Bracket_80_4_2**: Level 80 - Ruby Sanctum (Post-Expansion, Jun 29, 2010)
- **Bracket_Custom**: Custom User-Defined Content (All Levels)

## CONFIG

In the [configuration file](https://github.com/azerothcore/mod-progression-system/blob/main/conf/progression_system.conf.dist#L40-L68), you can set which level brackets should be loaded. This is a boolean configuration where `0` deactivates and `1` activates the brackets. You can add custom files to the `Bracket_Custom` section, which will be executed last, meaning all previous brackets will be loaded before the custom one. Custom SQL files should follow the naming convention `progression_custom_%%%%` to ensure the correct apply order.

## SQL FILES

SQL files can be loaded into your database once you have enabled the auto DB updater in your worldserver config. Place SQL files in the appropriate folder to be loaded for a specific level bracket. For example, SQLs related to the 40-49 bracket should be placed in [this folder](https://github.com/UltraNix/mod_progression-system/tree/master/src/Bracket_40_49/sql/world).

**File Naming Convention**: `progression_BRACKET_DESCRIPTION.sql`
- Example: `progression_80_2_naxxramas_80_enable.sql`
- Custom files: `progression_custom_%%%%`

**SQL File Organization**:
```
src/
├── Bracket_0/sql/world/
├── Bracket_1_19/sql/world/
├── Bracket_20_29/sql/world/
...
├── Bracket_80_4_2/sql/world/
└── Bracket_Custom/sql/world/
```

### SQL File Examples

**Creature Activation**:
```sql
UPDATE creature_template SET flags_extra = flags_extra | 0x1 WHERE id IN (123, 456);
```

**Quest Activation**:
```sql
UPDATE quest_template SET flags = flags | 0x100 WHERE id IN (123, 456);
```

**Item Availability**:
```sql
UPDATE npc_vendor SET created_by_bracket = 'Bracket_X' WHERE entry = 12345;
```

### Important Warnings

**⚠️ WARNING: SQL files cannot be "unloaded" once executed.** If you configure the system to use the 30-39 level bracket and later change it to the 20-29 bracket, the SQL files from the 30-39 bracket will still be in your database.

**To undo changes made by SQL files, create a new SQL file** to restore the previous state in another bracket.

**⚠️ WARNING: If you enable bracket 20-29 but DO NOT enable the bracket that reverts the SQL applied at 20-29, the changes will remain in your database leading to DATABASE POLLUTION!**

**Easiest way to revert all changes:** Uninstall the module and reset your world database.

**⛔ DO NOT ENABLE BRACKETS IF YOU ARE NOT SURE YOU WANT TO USE THEM.** This will lead to database pollution if not reverted properly. If you do not know how to revert changes, reset your world database.

## C++ SCRIPTS

C++ scripts can also be automatically loaded based on the bracket level. To do this, copy and paste the C++ script you want to modify into the appropriate folder, make your changes, and create a new script loader function. You do not need to change the script's name in the database or the C++ script's name (only the script object name).

[Here](https://github.com/UltraNix/mod-progression-system/commit/aad916bbe068f28ce769d028f138f434ba4655a8) is an example of how to do it.

### Script Implementation Steps

1. **Copy the Original Script**: Copy the script from AzerothCore core into the bracket folder
2. **Rename the Script**: Rename to avoid conflicts (e.g., `boss_ragnaros.cpp` → `boss_ragnaros_60_1_1.cpp`)
3. **Update the Script Object**: Rename the script loading function
4. **Add to Bracket Loader**: Include in the bracket's loader file

### Naming Conventions:
1. **Rename your custom script** to something slightly different to avoid conflicts with the old script. For example, rename `boss_drakkisath` to `boss_drakkisath_50_59_b`. Also, rename the script loader function from `AddSC_boss_drakkisath` to `AddSC_boss_drakkisath_50_59_b`.

2. **Include in bracket loader**: The renamed script loader function should be declared and defined in the bracket loader. For instance, `AddSC_boss_drakkisath_50_59_b` should be in `Bracket_50_59_B_loader.cpp` ([example](https://github.com/azerothcore/mod-progression-system/blob/NewModule/src/Bracket_50_59_B/Bracket_50_59_B_loader.cpp)).

3. **Main Script Updates**: If you make changes to a main script in AzerothCore that are independent of the level bracket, ensure these changes are also applied to your progressive script.

### File Structure Example

```
src/Bracket_60_1_1/
├── Bracket_60_1_1_loader.cpp    (Main loader file)
├── scripts/
│   └── boss_ragnaros_60_1_1.cpp  (Modified script)
└── sql/world/
    ├── progression_60_1_1_molten_core.sql
    └── progression_60_1_1_rewards.sql
```

## Arena Seasons (PvP Progression)

The module includes complete Arena Season support across all expansions:

| Season | Bracket | Tier | Dates | Rating | Gear Name |
|--------|---------|------|-------|--------|-----------|
| 1 | 70_2_1 | T6/T7 | Jan-May 2007 | 1500+ | Gladiator |
| 2 | 70_3_2 | T8 | Aug-Dec 2007 | 2000+ | Merciless |
| 3 | 70_5 | T8.5 | Dec 2007-Mar 2008 | 2000+ | Vengeful |
| 4 | 70_6_2 | T9 | Mar-Nov 2008 | 2000+ | Brutal |
| 5 | 80_1_2 | T9.5 | Nov 2008-Apr 2009 | 2000+ | Hateful |
| 6 | 80_2 | T10 | Apr-Aug 2009 | 2200+ | Glorious |
| 7 | 80_3 | T10.5 | Aug-Dec 2009 | 2200+ | Furious |
| 8 | 80_4_1 | T11 | Dec 2009-Nov 2010 | 2200+ | Wrathful |

### PvP Vendor Setup

Arena vendors are set up automatically with bracket progression. Each season provides:
- **Rating-Based Gear**: Top-tier items require specific rating thresholds
- **Conquest Points**: Currency earned through arena victories
- **Seasonal Rewards**: Exclusive mounts, weapons, and armor

See [ARENA_SEASONS_VALIDATION.md](ARENA_SEASONS_VALIDATION.md) for complete Arena Season documentation.

## Content Timeline (Blizzard Historical Order)

### Vanilla (November 23, 2004 - January 19, 2005)
1. **November 23, 2004**: WoW Launch - Molten Core, Onyxia, Dungeons
2. **January 19, 2005**: Blackwing Lair, Zul'Gurub, AQ20, AQ40 release

### The Burning Crusade (January 16, 2007 - May 22, 2008)
1. **January 16, 2007**: TBC Launch - Karazhan, Gruul, Magtheridon
2. **May 15, 2007**: Serpentshrine Cavern, The Eye (Arena Season 2)
3. **August 24, 2007**: Battle for Mount Hyjal (Arena Season 2 continues)
4. **September 24, 2007**: Black Temple
5. **December 11, 2007**: Zul'Aman (Arena Season 3)
6. **March 25, 2008**: Isle of Quel'Danas, Sunwell Plateau (Arena Season 4)
7. **May 22, 2008**: Sunwell Plateau Raid opens (continued)
8. **August 19, 2008**: TBC Final Phase, Dragons event

### Wrath of the Lich King (November 13, 2008 - June 29, 2010)
1. **November 13, 2008**: WotLK Launch - Naxxramas 80, Eye of Eternity, Obsidian Sanctum
2. **November 13, 2008**: Dungeons available (Arena Season 5)
3. **April 16, 2009**: Ulduar (Arena Season 6 begins April 15)
4. **August 4, 2009**: Trial of the Crusader, Onyxia 80 (Arena Season 7)
5. **December 8, 2009**: Icecrown Citadel (Arena Season 8)
6. **June 29, 2010**: Ruby Sanctum (Post-expansion bonus raid)

## Configuration Examples

### Enable Full Vanilla Progression
```properties
ProgressionSystem.Bracket_60_1_1  = 1    # Molten Core
ProgressionSystem.Bracket_60_1_2  = 1    # Onyxia
ProgressionSystem.Bracket_60_2_1  = 1    # Blackwing Lair
ProgressionSystem.Bracket_60_2_2  = 1    # Zul'Gurub
ProgressionSystem.Bracket_60_3_1  = 1    # AQ20
ProgressionSystem.Bracket_60_3_2  = 1    # AQ40
ProgressionSystem.Bracket_60_3_3  = 1    # AQ Post-Content
```

### Enable TBC Progression
```properties
ProgressionSystem.Bracket_70_2_1  = 1    # Gruul/Mag + Arena S1
ProgressionSystem.Bracket_70_2_2  = 1    # Karazhan
ProgressionSystem.Bracket_70_3_1  = 1    # SSC
ProgressionSystem.Bracket_70_3_2  = 1    # The Eye + Arena S2
ProgressionSystem.Bracket_70_4_1  = 1    # Hyjal
ProgressionSystem.Bracket_70_4_2  = 1    # Black Temple
ProgressionSystem.Bracket_70_5    = 1    # Zul'Aman + Arena S3
ProgressionSystem.Bracket_70_6_2  = 1    # Sunwell + Arena S4
```

### Enable WotLK Progression
```properties
ProgressionSystem.Bracket_80_1_1  = 1    # Normal Dungeons
ProgressionSystem.Bracket_80_1_2  = 1    # Heroic + Arena S5
ProgressionSystem.Bracket_80_2    = 1    # Ulduar/Naxx80/Eye/OS + Arena S6
ProgressionSystem.Bracket_80_3    = 1    # Trial/Onyxia + Arena S7
ProgressionSystem.Bracket_80_4_1  = 1    # ICC + Arena S8
```

## Detailed Bracket Documentation

**For complete, detailed information about every bracket**, see:
- [BRACKET_DESCRIPTIONS_COMPLETE.md](BRACKET_DESCRIPTIONS_COMPLETE.md) - Complete reference guide with all bosses, mechanics, and release dates
- [ANTES_VS_AHORA.md](ANTES_VS_AHORA.md) - Comparison of before/after implementation
- [ARENA_SEASONS_VALIDATION.md](ARENA_SEASONS_VALIDATION.md) - Arena Seasons timeline and validation

## DISCLAIMER

This module is used by Chromiecraft, and the progression order often reflects Chromiecraft's progression. If you prefer a different progression, you are free to change the order of the files (file locations) and scripts as needed.

The default configuration is set to **100% Blizzlike progression**, matching the exact release timeline and content order from Blizzard's original servers (November 2004 - December 2009).
