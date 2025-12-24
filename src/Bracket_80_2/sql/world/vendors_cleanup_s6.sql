-- =====================================================
-- ARENA SEASON 6 - DALARAN VENDORS CLEANUP
-- Bracket: 80_2 (WotLK)
-- Fecha: Mar 17, 2009
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [DALARAN_VENDOR_ID]
  AND item_template NOT IN (
    -- S5 Legacy
    [S5_ITEM_IDS],
    -- S6 New
    [S6_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S5 Legacy (150k)
  [S5_ITEMS_WITH_PRICE_150000],
  -- S6 New (250k - Wrathful Gladiator)
  [S6_ITEMS_WITH_PRICE_250000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [DALARAN_VENDOR_ID];
-- Resultado esperado: 120 items (S5+S6)
