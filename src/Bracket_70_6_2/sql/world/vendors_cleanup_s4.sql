-- =====================================================
-- ARENA SEASON 4 - GADGETZAN VENDORS CLEANUP
-- Bracket: 70_6_2 (TBC Final)
-- Fecha: May 22, 2008
-- NOTA: Este es el último bracket de TBC
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID]
  AND item_template NOT IN (
    [S1_ITEM_IDS],
    [S2_ITEM_IDS],
    [S3_ITEM_IDS],
    [S4_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- Legacy items S1-S3 (100k)
  [S1_S2_S3_ITEMS_WITH_PRICE_100000],
  -- S4 New (200k - Brutal Gladiator)
  [S4_ITEMS_WITH_PRICE_200000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [GADGETZAN_VENDOR_ID];
-- Resultado esperado: 240 items (S1+S2+S3+S4)
