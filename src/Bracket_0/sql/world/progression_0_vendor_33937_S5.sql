-- NPC vendor import (AzerothCore WotLK 3.3.5a)
-- NPC: 33937
-- Source items: reuse lista 31864 (Xazi Pipa Humillo)
-- Generated: 2026-01-03

START TRANSACTION;

SET @NPC_ENTRY := 33937;

-- Backups
DROP TABLE IF EXISTS `npc_vendor_backup_33937_20260103`;
CREATE TABLE `npc_vendor_backup_33937_20260103` LIKE `npc_vendor`;

INSERT INTO `npc_vendor_backup_33937_20260103`
SELECT *
FROM `npc_vendor`
WHERE `entry` = @NPC_ENTRY;

DROP TABLE IF EXISTS `game_event_npc_vendor_backup_33937_20260103`;
CREATE TABLE `game_event_npc_vendor_backup_33937_20260103` LIKE `game_event_npc_vendor`;

INSERT INTO `game_event_npc_vendor_backup_33937_20260103`
SELECT gev.*
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.guid = gev.guid
WHERE c.id1 = @NPC_ENTRY;

-- Items (copiados de NPC 31864)
DROP TEMPORARY TABLE IF EXISTS `tmp_items_33937`;
CREATE TEMPORARY TABLE `tmp_items_33937` (
  `rn` INT PRIMARY KEY AUTO_INCREMENT,
  `item` INT NOT NULL,
  `arena` INT NOT NULL DEFAULT 0,
  `honor` INT NOT NULL DEFAULT 0,
  `rating` INT NOT NULL DEFAULT 0
) ENGINE=Memory;

INSERT INTO `tmp_items_33937` (`item`, `arena`, `honor`, `rating`) VALUES
(40781, 700, 12000, 1675),
(40782, 700, 12000, 1675),
(40783, 700, 12000, 1675),
(40801, 400, 7200, 1615),
(40802, 400, 7200, 1615),
(40803, 400, 7200, 1615),
(40819, 700, 12000, 1735),
(40820, 700, 12000, 1735),
(40821, 700, 12000, 1735),
(40840, 700, 12000, 1645),
(40841, 700, 12000, 1645),
(40842, 700, 12000, 1645),
(40859, 550, 9600, 1775),
(40860, 550, 9600, 1775),
(40861, 550, 9600, 1775),
(40904, 700, 12000, 1675),
(40925, 400, 7200, 1615),
(40931, 700, 12000, 1735),
(40937, 700, 12000, 1645),
(40961, 550, 9600, 1775),
(40988, 700, 12000, 1675),
(40989, 700, 12000, 1675),
(40999, 400, 7200, 1615),
(41005, 400, 7200, 1615),
(41011, 700, 12000, 1735),
(41017, 700, 12000, 1735),
(41025, 700, 12000, 1645),
(41031, 700, 12000, 1645),
(41036, 550, 9600, 1775),
(41042, 550, 9600, 1775),
(41079, 700, 12000, 1675),
(41085, 700, 12000, 1675),
(41135, 400, 7200, 1615),
(41141, 400, 7200, 1615),
(41149, 700, 12000, 1735),
(41155, 700, 12000, 1735),
(41162, 700, 12000, 1645),
(41203, 700, 12000, 1645),
(41209, 550, 9600, 1775),
(41215, 550, 9600, 1775),
(41273, 550, 9600, 1775),
(41279, 550, 9600, 1775),
(41284, 400, 7200, 1615),
(41291, 400, 7200, 1615),
(41296, 700, 12000, 1645),
(41302, 700, 12000, 1645),
(41308, 700, 12000, 1675),
(41314, 700, 12000, 1675),
(41319, 700, 12000, 1735),
(41325, 700, 12000, 1735),
(41648, 700, 12000, 1675),
(41653, 700, 12000, 1645),
(41659, 700, 12000, 1675),
(41665, 700, 12000, 1645),
(41670, 700, 12000, 1735),
(41676, 700, 12000, 1735),
(41681, 550, 9600, 1775),
(41713, 550, 9600, 1775),
(41765, 400, 7200, 1615),
(41771, 400, 7200, 1615),
(41852, 700, 12000, 1735),
(41857, 700, 12000, 1675),
(41862, 700, 12000, 1645),
(41867, 550, 9600, 1775),
(41872, 400, 7200, 1615),
(41913, 700, 12000, 1735),
(41919, 700, 12000, 1675),
(41925, 700, 12000, 1645),
(41931, 550, 9600, 1775),
(41938, 400, 7200, 1615),
(41944, 700, 12000, 1735),
(41950, 700, 12000, 1675),
(41957, 700, 12000, 1645),
(41963, 550, 9600, 1775),
(41969, 400, 7200, 1615),
(41991, 700, 12000, 1735),
(42001, 700, 12000, 1675),
(42003, 700, 12000, 1645),
(42009, 550, 9600, 1775),
(42015, 400, 7200, 1615);

SELECT COUNT(*) AS tmp_items_rows FROM `tmp_items_33937`;

-- Cost definitions
DROP TEMPORARY TABLE IF EXISTS `tmp_cost_defs_33937`;
CREATE TEMPORARY TABLE `tmp_cost_defs_33937` (
  `arena` INT NOT NULL,
  `honor` INT NOT NULL,
  `rating` INT NOT NULL,
  `extendedCostId` INT NULL,
  PRIMARY KEY (`arena`, `honor`, `rating`)
) ENGINE=Memory;

INSERT IGNORE INTO `tmp_cost_defs_33937` (`arena`, `honor`, `rating`)
SELECT DISTINCT `arena`, `honor`, `rating`
FROM `tmp_items_33937`;

SELECT COUNT(*) AS distinct_cost_defs FROM `tmp_cost_defs_33937`;

-- Resolve ExtendedCost (exact, luego arena/2, luego arena/2 + rating redondeado a 50)
UPDATE `tmp_cost_defs_33937` d
SET d.`extendedCostId` = COALESCE(
  (
    SELECT iec.`ID`
    FROM `itemextendedcost_dbc` iec
    WHERE iec.`HonorPoints` = d.`honor`
      AND iec.`ArenaPoints` = d.`arena`
      AND iec.`RequiredArenaRating` = d.`rating`
      AND iec.`ItemID_1` = 0 AND iec.`ItemID_2` = 0 AND iec.`ItemID_3` = 0 AND iec.`ItemID_4` = 0 AND iec.`ItemID_5` = 0
      AND iec.`ItemCount_1` = 0 AND iec.`ItemCount_2` = 0 AND iec.`ItemCount_3` = 0 AND iec.`ItemCount_4` = 0 AND iec.`ItemCount_5` = 0
    ORDER BY (COALESCE(iec.`ItemPurchaseGroup`, 0) <> 0) ASC, COALESCE(iec.`ArenaBracket`, 0) ASC, iec.`ID` ASC
    LIMIT 1
  ),
  (
    SELECT iec.`ID`
    FROM `itemextendedcost_dbc` iec
    WHERE iec.`HonorPoints` = d.`honor`
      AND iec.`ArenaPoints` = (d.`arena` DIV 2)
      AND iec.`RequiredArenaRating` = d.`rating`
      AND iec.`ItemID_1` = 0 AND iec.`ItemID_2` = 0 AND iec.`ItemID_3` = 0 AND iec.`ItemID_4` = 0 AND iec.`ItemID_5` = 0
      AND iec.`ItemCount_1` = 0 AND iec.`ItemCount_2` = 0 AND iec.`ItemCount_3` = 0 AND iec.`ItemCount_4` = 0 AND iec.`ItemCount_5` = 0
    ORDER BY (COALESCE(iec.`ItemPurchaseGroup`, 0) <> 0) ASC, COALESCE(iec.`ArenaBracket`, 0) ASC, iec.`ID` ASC
    LIMIT 1
  ),
  (
    SELECT iec.`ID`
    FROM `itemextendedcost_dbc` iec
    WHERE iec.`HonorPoints` = d.`honor`
      AND iec.`ArenaPoints` = (d.`arena` DIV 2)
      AND iec.`RequiredArenaRating` = (FLOOR((d.`rating` + 25) / 50) * 50)
      AND iec.`ItemID_1` = 0 AND iec.`ItemID_2` = 0 AND iec.`ItemID_3` = 0 AND iec.`ItemID_4` = 0 AND iec.`ItemID_5` = 0
      AND iec.`ItemCount_1` = 0 AND iec.`ItemCount_2` = 0 AND iec.`ItemCount_3` = 0 AND iec.`ItemCount_4` = 0 AND iec.`ItemCount_5` = 0
    ORDER BY (COALESCE(iec.`ItemPurchaseGroup`, 0) <> 0) ASC, COALESCE(iec.`ArenaBracket`, 0) ASC, iec.`ID` ASC
    LIMIT 1
  )
);

SET @missing_cost_defs := (
  SELECT COUNT(*)
  FROM `tmp_cost_defs_33937`
  WHERE `extendedCostId` IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;
SELECT `arena`, `honor`, `rating`, `extendedCostId`
FROM `tmp_cost_defs_33937`
ORDER BY `arena`, `honor`, `rating`;
SELECT `arena`, `honor`, `rating`
FROM `tmp_cost_defs_33937`
WHERE `extendedCostId` IS NULL
ORDER BY `arena`, `honor`, `rating`;

SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- Safety: no row with NULL extendedCostId should survive
SELECT COUNT(*) AS sanity_no_null_extcost
FROM `tmp_cost_defs_33937`
WHERE `extendedCostId` IS NULL;

-- Vendor rows
DROP TEMPORARY TABLE IF EXISTS `tmp_vendor_33937`;
CREATE TEMPORARY TABLE `tmp_vendor_33937` AS
SELECT
  @NPC_ENTRY AS `entry`,
  (i.`rn` - 1) AS `slot`,
  i.`item` AS `item`,
  0 AS `maxcount`,
  0 AS `incrtime`,
  d.`extendedCostId` AS `ExtendedCost`,
  0 AS `VerifiedBuild`
FROM `tmp_items_33937` i
JOIN `tmp_cost_defs_33937` d
  ON d.`arena` = i.`arena` AND d.`honor` = i.`honor` AND d.`rating` = i.`rating`
WHERE d.`extendedCostId` IS NOT NULL;

-- Deletes (solo si mapping OK)
DELETE FROM `npc_vendor` WHERE `entry` = @NPC_ENTRY;

DELETE gev
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.guid = gev.guid
WHERE c.id1 = @NPC_ENTRY;

-- Insert final vendor
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`)
SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`
FROM `tmp_vendor_33937`;

COMMIT;

-- CHECKS
SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_33937
FROM `npc_vendor`
WHERE `entry` = @NPC_ENTRY;

SELECT *
FROM `npc_vendor`
WHERE `entry` = @NPC_ENTRY
ORDER BY `slot`, `item`;

SELECT gev.eventEntry, gev.guid, gev.item, gev.ExtendedCost
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.guid = gev.guid
WHERE c.id1 = @NPC_ENTRY
ORDER BY gev.eventEntry, gev.guid, gev.item;
