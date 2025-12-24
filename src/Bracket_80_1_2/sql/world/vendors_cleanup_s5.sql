-- =====================================================
-- ARENA SEASON 5 - DALARAN VENDORS CLEANUP
-- Bracket: 80_1_2 (WotLK Start)
-- Fecha: Nov 13, 2008
-- NOTA: Esto es un NUEVO COMIENZO - no hay items heredados
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [DALARAN_VENDOR_ID]
  AND item_template NOT IN (
    -- S5 Items SOLAMENTE (Wrathful Gladiator Early)
    [S5_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S5 New (250k - Wrathful Gladiator - Early)
  [S5_ITEMS_WITH_PRICE_250000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [DALARAN_VENDOR_ID];
-- Resultado esperado: 60 items (S5 solamente - limpio)
