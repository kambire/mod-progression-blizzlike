-- =====================================================
-- ARENA SEASON 3 - VENDORS CLEANUP (BLIZZLIKE)
-- Bracket: 70_5 (TBC)
-- Fecha: Dec 11, 2007
-- =====================================================

DELETE FROM `npc_vendor`
WHERE `entry` IN ([S3_VENDOR_ENTRIES])
  AND `item` NOT IN (
    [S1_ITEM_IDS],
    [S2_ITEM_IDS],
    [S3_ITEM_IDS]
  );

INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`)
VALUES
  -- S1 Legacy
  [S1_ITEMS_WITH_EXTENDEDCOST_LEGACY],
  -- S2 Legacy
  [S2_ITEMS_WITH_EXTENDEDCOST_LEGACY],
  -- S3 New
  [S3_ITEMS_WITH_EXTENDEDCOST_NEW]
;

SELECT COUNT(*) as total_items FROM `npc_vendor` WHERE `entry` IN ([S3_VENDOR_ENTRIES]);
