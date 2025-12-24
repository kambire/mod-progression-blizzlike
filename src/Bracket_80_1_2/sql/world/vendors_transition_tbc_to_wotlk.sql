-- =====================================================
-- TRANSICIÓN: TBC → WOTLK
-- Bracket: 80_1_2 (WotLK Start - Arena S5)
-- =====================================================
-- ACCIÓN CRÍTICA:
-- 1. DESACTIVAR vendors de TBC (Gadgetzan, Area 52)
-- 2. ACTIVAR vendor de WotLK (Dalaran)
-- 3. LIMPIAR items de TBC completamente
-- =====================================================

-- PASO 1: DESACTIVAR Gadgetzan (TBC S1-S4)
UPDATE creature 
SET enabled = 0, npcflag = 0
WHERE entry = [GADGETZAN_VENDOR_ID] 
  AND map = 1;

-- PASO 2: DESACTIVAR Area 52 (TBC Backup)
UPDATE creature 
SET enabled = 0, npcflag = 0
WHERE entry = [AREA52_VENDOR_ID] 
  AND map = 530;

-- PASO 3: ACTIVAR Dalaran (WotLK S5-S8)
UPDATE creature 
SET enabled = 1, npcflag = 128
WHERE entry = [DALARAN_VENDOR_ID] 
  AND map = 571;

-- PASO 4: LIMPIAR vendors viejos completamente
DELETE FROM npc_vendor 
WHERE entry IN ([GADGETZAN_VENDOR_ID], [AREA52_VENDOR_ID]);

-- VALIDACIÓN
SELECT 
  'Gadgetzan' as city, enabled, COUNT(*) as vendor_count 
FROM creature 
WHERE entry = [GADGETZAN_VENDOR_ID] 
GROUP BY enabled

UNION ALL

SELECT 
  'Dalaran', enabled, COUNT(*) as vendor_count 
FROM creature 
WHERE entry = [DALARAN_VENDOR_ID] 
GROUP BY enabled;

-- Resultado esperado: 
-- Gadgetzan: enabled=0
-- Dalaran: enabled=1
