-- =====================================================
-- ARENA SEASON 7 - DALARAN VENDORS CLEANUP
-- Bracket: 80_3 (WotLK)
-- Fecha: Aug 4, 2009
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [DALARAN_VENDOR_ID]
  AND item_template NOT IN (
    -- S5 Legacy
    [S5_ITEM_IDS],
    -- S6 Legacy
    [S6_ITEM_IDS],
    -- S7 New
    [S7_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S5-S6 Legacy (150k)
  [S5_S6_ITEMS_WITH_PRICE_150000],
  -- S7 New (300k - Vindictive Gladiator)
  [S7_ITEMS_WITH_PRICE_300000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [DALARAN_VENDOR_ID];
-- Resultado esperado: 180 items (S5+S6+S7)
