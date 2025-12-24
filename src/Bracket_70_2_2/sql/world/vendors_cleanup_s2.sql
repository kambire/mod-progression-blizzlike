-- =====================================================
-- ARENA SEASON 2 - GADGETZAN VENDORS CLEANUP
-- Bracket: 70_2_2 (TBC)
-- Fecha: May 15, 2007
-- =====================================================
-- INSTRUCCIONES:
-- 1. Reemplaza [GADGETZAN_VENDOR_ID] con el ID real
-- 2. Agregar: Items S1 (100k gold - legacy) + Items S2 (200k gold - nuevos)
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID]
  AND item_template NOT IN (
    -- S1 Items (legacy)
    [S1_ITEM_IDS],
    -- S2 Items (nuevos)
    [S2_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S1 Items (LEGACY - 100k, descuento 33%)
  -- Gladiator items (Season 1 - ahora más baratos)
  [S1_ITEMS_WITH_PRICE_100000],
  
  -- S2 Items (NUEVOS - 200k, precio completo)
  -- Gladiator items (Season 2)
  [S2_ITEMS_WITH_PRICE_200000]
;

-- VALIDACIÓN
SELECT 
  COUNT(*) as total_items,
  SUM(CASE WHEN price_1 = 100000 THEN 1 ELSE 0 END) as s1_legacy_items,
  SUM(CASE WHEN price_1 = 200000 THEN 1 ELSE 0 END) as s2_new_items
FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID];
-- Resultado esperado: total_items=120, s1_legacy_items=60, s2_new_items=60
