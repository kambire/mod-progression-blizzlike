-- =====================================================
-- ARENA SEASON 3 - GADGETZAN VENDORS CLEANUP
-- Bracket: 70_5 (TBC)
-- Fecha: Dec 11, 2007
-- =====================================================

DELETE FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID]
  AND item_template NOT IN (
    [S1_ITEM_IDS],
    [S2_ITEM_IDS],
    [S3_ITEM_IDS]
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- S1 Legacy (100k)
  [S1_ITEMS_WITH_PRICE_100000],
  -- S2 Legacy (100k)
  [S2_ITEMS_WITH_PRICE_100000],
  -- S3 New (200k - Hateful Gladiator)
  [S3_ITEMS_WITH_PRICE_200000]
;

SELECT COUNT(*) as total_items FROM npc_vendor WHERE entry = [GADGETZAN_VENDOR_ID];
-- Resultado esperado: 180 items (S1+S2+S3)
