-- ============================================================================
-- ROLLBACK - WotLK Bracket 80_4_2 - HEROIC 5-man BOSSES emblem normalization
-- Restores rows from backup_80_4_2_emblems_heroic_bosses
-- ============================================================================

SET @BRACKET := '80_4_2';
SET @EMBLEM_SET := '40752,40753,45624,47241,49426';
SET @BACKUP_TABLE := 'backup_80_4_2_emblems_heroic_bosses';

SET @SQL := CONCAT('SELECT COUNT(*) INTO @HAS_BACKUP FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ''', @BACKUP_TABLE, '''');
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SELECT @BRACKET AS bracket, @HAS_BACKUP AS backup_table_present;

DROP TEMPORARY TABLE IF EXISTS tmp_restore_keys;
CREATE TEMPORARY TABLE tmp_restore_keys (
  entry INT UNSIGNED NOT NULL,
  groupid INT UNSIGNED NOT NULL,
  mincount INT UNSIGNED NOT NULL,
  maxcount INT UNSIGNED NOT NULL,
  PRIMARY KEY (entry, groupid, mincount, maxcount)
) ENGINE=MEMORY;

SET @SQL := CONCAT(
  'INSERT IGNORE INTO tmp_restore_keys (entry, groupid, mincount, maxcount)\n',
  'SELECT DISTINCT `entry`, `groupid`, `mincount`, `maxcount` FROM `', @BACKUP_TABLE, '`'
);
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;

DELETE cl
FROM `creature_loot_template` cl
JOIN tmp_restore_keys k
  ON k.`entry` = cl.`entry`
 AND k.`groupid` = cl.`groupid`
 AND k.`mincount` = cl.`mincount`
 AND k.`maxcount` = cl.`maxcount`
WHERE FIND_IN_SET(cl.`Item`, @EMBLEM_SET) > 0;

SET @SQL := CONCAT(
  'INSERT INTO `creature_loot_template`\n',
  'SELECT b.*\n',
  'FROM `', @BACKUP_TABLE, '` b\n',
  'WHERE NOT EXISTS (\n',
  '  SELECT 1 FROM `creature_loot_template` cl\n',
  '  WHERE cl.`entry` = b.`entry`\n',
  '    AND cl.`Item` = b.`Item`\n',
  '    AND cl.`groupid` = b.`groupid`\n',
  '    AND cl.`mincount` = b.`mincount`\n',
  '    AND cl.`maxcount` = b.`maxcount`\n',
  ')'
);
PREPARE stmt FROM @SQL; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SELECT @BRACKET AS bracket, 'ROLLBACK_DONE' AS status;

-- GM reload: .reload creature_loot_template (si existe) o restart worldserver.
