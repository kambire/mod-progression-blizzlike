-- =====================================================
-- ARENA SEASON 1 - GADGETZAN VENDORS CLEANUP
-- Bracket: 70_2_1 (TBC)
-- Fecha: Jan 16, 2007
-- =====================================================
-- INSTRUCCIONES:
-- 1. Reemplaza [GADGETZAN_VENDOR_ID] con el ID real del vendor
-- 2. Reemplaza [S1_ITEM_IDS] con los IDs reales de items S1
-- 3. Ejecuta primero el DELETE, luego el INSERT
-- =====================================================

-- PASO 1: LIMPIAR - Borrar todos los items excepto S1
-- Este DELETE es seguro - no borra nada si ya está limpio
DELETE FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID]  -- REEMPLAZAR CON ID REAL (ej: 18945)
  AND item_template NOT IN (
    -- AGREGAR AQUÍ LOS IDS DE ITEMS S1 (Gladiator Season 1)
    -- Ejemplo: 23001, 23002, 23003, ... 23060
    [S1_ITEM_IDS]
  );

-- PASO 2: AGREGAR - Insertar items S1 con precios correctos
-- Precio S1: 150,000 gold (línea base)
INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  -- AGREGAR AQUÍ TODOS LOS ITEMS S1
  -- Formato: ([VENDOR_ID], [ITEM_ID], 0, 0, 0, 150000),
  -- Ejemplo:
  -- ([GADGETZAN_VENDOR_ID], 23001, 0, 0, 0, 150000),
  -- ([GADGETZAN_VENDOR_ID], 23002, 0, 0, 0, 150000),
  [S1_ITEMS_INSERT_STATEMENTS]
;

-- PASO 3: VALIDACIÓN - Verificar que se agregaron correctamente
SELECT 
  COUNT(*) as total_items,
  COUNT(DISTINCT item_template) as unique_items,
  MIN(price_1) as min_price,
  MAX(price_1) as max_price
FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID];
-- Resultado esperado: total_items=60, unique_items=60, min_price=150000, max_price=150000
