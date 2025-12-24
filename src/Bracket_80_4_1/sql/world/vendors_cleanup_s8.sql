-- =====================================================
-- ARENA SEASON 8 - DALARAN VENDORS CLEANUP
-- Bracket: 80_4_1 (WotLK Final)
-- Fecha: Dec 8, 2009
-- NOTA: Última season, todos los items disponibles
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [DALARAN_VENDOR_ID]
  AND item_template NOT IN (
    -- S5 Legacy
    [S5_ITEM_IDS],
    -- S6 Legacy
    [S6_ITEM_IDS],
    -- S7 Legacy
    [S7_ITEM_IDS],
    -- S8 New
    [S8_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S5-S7 Legacy (150k)
  [S5_S6_S7_ITEMS_WITH_PRICE_150000],
  -- S8 New (300k - Relentless Gladiator)
  [S8_ITEMS_WITH_PRICE_300000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [DALARAN_VENDOR_ID];
-- Resultado esperado: 240 items (S5+S6+S7+S8)
