Release notes - Progression advanced configs (local changes)

Summary
-------
- Added 60 advanced configuration options to `conf/progression_system.conf.dist`.
- Purpose: provide strict control over bracket progression, item/vendor access, arena season vendor restrictions, event scheduling, and tracking.
- ALL OPTIONS ARE DISABLED BY DEFAULT (value = 0).

Critical note (PvP vendors / cantinas)
-------------------------------------
- New settings specifically target Arena season vendors to ensure each season's PvP vendors/cantinas appear only in their intended bracket:
  - `ProgressionSystem.Arena.Season1.BracketRestriction` ... `Season8`
  - `ProgressionSystem.Vendor.RestrictPVPVendors`
- Enable `ProgressionSystem.EnforceArenaVendorProgression = 1` and the appropriate `Arena.SeasonX.BracketRestriction = 1` to lock vendors to brackets.

What changed (high level)
-------------------------
- Item/equipment restrictions: `EnforceItemRestrictions`, `DisableNextBracketItems`.
- Vendor visibility and inventory controls: `BlockFutureVendors`, `Vendor.BlockOutdatedInventory`, `Vendor.ShowCompatibleVendorsOnly`.
- Arena vendor season restrictions (Season1..Season8).
- Progression enforcement: `EnforceDungeonAttunement`, `RequireSequentialProgression`, `BlockBracketTransition`.
- Notifications/tracking: `AnnounceNewBracket`, `TrackBracketProgress`, `LogBracketActivity`.
- Event automation: `AutoEventScheduling`, `WorldEventCooldown`.
- Loot and difficulty controls: `LootProgressionSystem`, `RaidDifficultyScaling`, `DynamicDifficultyScaling`.

How to enable locally (recommended quick steps)
-----------------------------------------------
1. Open `conf/progression_system.conf.dist` and change values from `0` to `1` for features you want to enable.
2. Run the local commit script to create a local commit and tag:

```powershell
# from repository root
PowerShell -ExecutionPolicy Bypass -File .\scripts\local_release.ps1 -Message "Enable arena vendor restrictions (local)"
```

3. Verify changes locally. When ready to push to remote, run:

```powershell
git push origin HEAD
git push origin --tags
```

Recommended first activation
----------------------------
- `ProgressionSystem.EnforceArenaVendorProgression = 1`
- `ProgressionSystem.Arena.Season1.BracketRestriction = 1` (and corresponding SeasonX for the season you want to enforce)
- `ProgressionSystem.Vendor.RestrictPVPVendors = 1`

Warnings
--------
- Enabling strict item/vendor restrictions may cause players to lose access to gear or vendors unexpectedly. Test on a staging environment or with a small group before enabling server-wide.
- Some features depend on SQL schema changes or script hooks. Review module docs and ensure database migrations are applied if needed.

Contact
-------
If you want, I can:
- Create a PR with these changes (requires push access), or
- Generate a patch file you can apply elsewhere, or
- Enable a minimal set of live changes and test them automatically.
