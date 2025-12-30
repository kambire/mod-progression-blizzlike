-- Fix: unlock Bracket 80_2_1 heroic dungeons (T7-era heroics)
-- Use this if a bad query accidentally disabled the heroics in `disables`.
-- Applies to:
-- - sourceType=2 (Map)
-- - sourceType=8 (RDF/LFG teleport)
--
-- Heroic dungeon mapIds:
-- 574 Utgarde Keep
-- 575 Utgarde Pinnacle
-- 576 The Nexus
-- 578 The Oculus
-- 595 The Culling of Stratholme
-- 599 Halls of Stone
-- 600 Drak'Tharon Keep
-- 601 Azjol-Nerub
-- 602 Halls of Lightning
-- 604 Gundrak
-- 608 The Violet Hold
-- 619 Ahn'kahet: The Old Kingdom
--
-- MySQL: 8.x compatible.

-- 1) Report current disables (should be empty after fix)
SELECT `sourceType`, `entry`, `flags`, `comment`
FROM `disables`
WHERE `sourceType` IN (2, 8)
  AND `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619)
ORDER BY `sourceType`, `entry`;

-- 2) Backup only what we're going to touch
CREATE TABLE IF NOT EXISTS `backupKambi_disables_unlock_80_2_1_20251230` LIKE `disables`;

REPLACE INTO `backupKambi_disables_unlock_80_2_1_20251230`
SELECT *
FROM `disables`
WHERE `sourceType` IN (2, 8)
  AND `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619);

-- 3) Unlock (delete disables for these heroics)
DELETE FROM `disables`
WHERE `sourceType` IN (2, 8)
  AND `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619);

-- 4) Verify (should return 0 rows)
SELECT `sourceType`, `entry`, `flags`, `comment`
FROM `disables`
WHERE `sourceType` IN (2, 8)
  AND `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619)
ORDER BY `sourceType`, `entry`;

-- If your worldserver is already running: run `.reload disables` (or restart) to apply the change live.

-- Optional restore:
-- REPLACE INTO `disables` SELECT * FROM `backupKambi_disables_unlock_80_2_1_20251230`;
