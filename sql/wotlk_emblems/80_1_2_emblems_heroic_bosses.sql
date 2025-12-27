-- ============================================================================
-- WotLK Bracket 80_1_2 - HEROIC 5-man BOSSES emblem normalization
-- MySQL 8.x | AzerothCore WotLK 3.3.5
--
-- GOAL:
--   Ensure HEROIC dungeon BOSSES (5-man) drop the emblem for this bracket.
--
-- IMPORTANT RULES (per spec):
--   - Touch ONLY HEROIC bosses using creature_template.difficulty_entry_1 mapping.
--   - Never modify normal-mode loot.
--   - Loot entry to touch: IF(cth.lootid = 0, cth.entry, cth.lootid)
--   - Limit by MAP IDs for this bracket.
--   - Modify ONLY emblem rows (items in the emblem set).
--
-- PARTS (in order):
--   A) REPORT  B) BACKUP  C) APPLY  D) VERIFY
--
-- GM reload note (best effort):
--   If your core supports it: .reload creature_loot_template
--   Otherwise restart worldserver (safest).
-- ============================================================================

-- -------------------------
-- Bracket configuration
-- -------------------------
SET @BRACKET := '80_1_2';
SET @EMBLEM_RIGHT := 40752; -- Emblem of Heroism
SET @EMBLEM_SET := '40752,40753,45624,47241,49426';

-- -------------------------
-- tmp_maps
-- -------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_maps;
CREATE TEMPORARY TABLE tmp_maps (
  mapId INT UNSIGNED NOT NULL PRIMARY KEY
) ENGINE=MEMORY;

-- WotLK launch dungeon maps (always included)
INSERT INTO tmp_maps (mapId) VALUES
 (574),(575),(576),(578),(595),(599),(600),(601),(602),(604),(608),(619);

-- -------------------------
-- Detect creature entry column (id1 vs id)
-- -------------------------
SELECT COUNT(*) INTO @HAS_CREATURE_ID1
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'creature'
  AND COLUMN_NAME = 'id1';

SET @CREATURE_ENTRY_COL := IF(@HAS_CREATURE_ID1 = 1, 'cr.`id1`', 'cr.`id`');

-- -------------------------
-- tmp_heroic_bosses: heroic boss lootids in target maps
-- -------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_heroic_bosses;
CREATE TEMPORARY TABLE tmp_heroic_bosses (
  mapId INT UNSIGNED NOT NULL,
  normal_entry INT UNSIGNED NOT NULL,
  heroic_entry INT UNSIGNED NOT NULL,
  normal_name VARCHAR(255) NOT NULL,
  heroic_name VARCHAR(255) NOT NULL,
  lootid INT UNSIGNED NOT NULL,
  PRIMARY KEY (mapId, normal_entry)
) ENGINE=MEMORY;

SET @SQL := CONCAT(
  'INSERT IGNORE INTO tmp_heroic_bosses (mapId, normal_entry, heroic_entry, normal_name, heroic_name, lootid)\n',
  'SELECT DISTINCT\n',
  '  cr.`map` AS mapId,\n',
  '  ', @CREATURE_ENTRY_COL, ' AS normal_entry,\n',
  '  ct.`difficulty_entry_1` AS heroic_entry,\n',
  '  ct.`name` AS normal_name,\n',
  '  cth.`name` AS heroic_name,\n',
  '  IF(cth.`lootid` = 0, cth.`entry`, cth.`lootid`) AS lootid\n',
  'FROM `creature` cr\n',
  'JOIN `creature_template` ct ON ct.`entry` = ', @CREATURE_ENTRY_COL, '\n',
  'JOIN tmp_maps m ON m.`mapId` = cr.`map`\n',
  'JOIN `creature_template` cth ON cth.`entry` = ct.`difficulty_entry_1`\n',
  'WHERE ct.`difficulty_entry_1` <> 0\n',
  '  AND ct.`rank` = 3\n'
);
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -------------------------
-- tmp_lootids_fix: lootids that currently drop a WRONG emblem
-- Wrong = any emblem in @EMBLEM_SET except @EMBLEM_RIGHT
-- -------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_lootids_fix;
CREATE TEMPORARY TABLE tmp_lootids_fix (
  lootid INT UNSIGNED NOT NULL PRIMARY KEY
) ENGINE=MEMORY;

INSERT IGNORE INTO tmp_lootids_fix (lootid)
SELECT DISTINCT b.`lootid`
FROM tmp_heroic_bosses b
JOIN `creature_loot_template` cl ON cl.`entry` = b.`lootid`
WHERE FIND_IN_SET(cl.`Item`, @EMBLEM_SET) > 0
  AND cl.`Item` <> @EMBLEM_RIGHT;

-- ============================================================================
-- A) REPORT
-- ============================================================================
-- List heroic bosses in target maps that currently drop an emblem not matching @EMBLEM_RIGHT.
SELECT
  b.`mapId`                          AS mapId,
  b.`normal_name`                    AS normal_name,
  b.`heroic_name`                    AS heroic_name,
  b.`lootid`                         AS heroic_lootid,
  cl.`Item`                          AS item,
  cl.`mincount`                      AS mincount,
  cl.`maxcount`                      AS maxcount
FROM tmp_heroic_bosses b
JOIN `creature_loot_template` cl ON cl.`entry` = b.`lootid`
WHERE FIND_IN_SET(cl.`Item`, @EMBLEM_SET) > 0
  AND cl.`Item` <> @EMBLEM_RIGHT
ORDER BY b.`mapId`, b.`heroic_name`, cl.`Item`;

-- ============================================================================
-- B) BACKUP (reversible)
-- ============================================================================
SET @BACKUP_TABLE := 'backup_80_1_2_emblems_heroic_bosses';

SET @SQL := CONCAT('CREATE TABLE IF NOT EXISTS `', @BACKUP_TABLE, '` LIKE `creature_loot_template`');
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Insert ONLY rows that will be changed, avoid duplicates on re-run.
SET @SQL := CONCAT(
  'INSERT INTO `', @BACKUP_TABLE, '`\n',
  'SELECT cl.*\n',
  'FROM `creature_loot_template` cl\n',
  'JOIN tmp_lootids_fix t ON t.`lootid` = cl.`entry`\n',
  'WHERE FIND_IN_SET(cl.`Item`, ''', @EMBLEM_SET, ''') > 0\n',
  '  AND cl.`Item` <> ', @EMBLEM_RIGHT, '\n',
  '  AND NOT EXISTS (\n',
  '    SELECT 1 FROM `', @BACKUP_TABLE, '` b\n',
  '    WHERE b.`entry` = cl.`entry`\n',
  '      AND b.`Item` = cl.`Item`\n',
  '      AND b.`groupid` = cl.`groupid`\n',
  '      AND b.`mincount` = cl.`mincount`\n',
  '      AND b.`maxcount` = cl.`maxcount`\n',
  '  )'
);
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ============================================================================
-- C) APPLY
-- ============================================================================
UPDATE `creature_loot_template` cl
JOIN tmp_lootids_fix t ON t.`lootid` = cl.`entry`
SET cl.`Item` = @EMBLEM_RIGHT
WHERE FIND_IN_SET(cl.`Item`, @EMBLEM_SET) > 0
  AND cl.`Item` <> @EMBLEM_RIGHT;

-- ============================================================================
-- D) VERIFY
-- ============================================================================
SELECT
  @BRACKET AS bracket,
  COUNT(DISTINCT lootid) AS lootids_targeted
FROM tmp_lootids_fix;

SELECT
  @BRACKET AS bracket,
  'WRONG_REMAINING' AS label,
  COUNT(*) AS rows
FROM `creature_loot_template` cl
JOIN tmp_lootids_fix t ON t.`lootid` = cl.`entry`
WHERE FIND_IN_SET(cl.`Item`, @EMBLEM_SET) > 0
  AND cl.`Item` <> @EMBLEM_RIGHT;

SELECT
  @BRACKET AS bracket,
  'RIGHT_PRESENT' AS label,
  COUNT(*) AS rows
FROM `creature_loot_template` cl
JOIN tmp_lootids_fix t ON t.`lootid` = cl.`entry`
WHERE cl.`Item` = @EMBLEM_RIGHT;

-- ============================================================================
-- Resumen
-- - Bracket: 80_1_2
-- - Heroic bosses (5-man) en mapas launch => Emblem of Heroism (40752)
-- - GM reload: .reload creature_loot_template (si existe) o restart worldserver.
-- ============================================================================
