-- =====================================================
-- ARENA SEASON 8 - VENDORS CLEANUP (BLIZZLIKE)
-- Bracket: 80_4_1 (WotLK Final)
-- Fecha: Dec 8, 2009
-- NOTA: Última season, todos los items disponibles
-- =====================================================

DELETE FROM `npc_vendor`
WHERE `entry` IN ([S8_VENDOR_ENTRIES])
  AND `item` NOT IN (
    -- S5 Legacy
    [S5_ITEM_IDS],
    -- S6 Legacy
    [S6_ITEM_IDS],
    -- S7 Legacy
    [S7_ITEM_IDS],
    -- S8 New
    [S8_ITEM_IDS]
  );

INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`)
VALUES
  -- S5-S7 Legacy
  [S5_S6_S7_ITEMS_WITH_EXTENDEDCOST_LEGACY],
  -- S8 New
  [S8_ITEMS_WITH_EXTENDEDCOST_NEW]
;

SELECT COUNT(*) as total_items FROM `npc_vendor` WHERE `entry` IN ([S8_VENDOR_ENTRIES]);
