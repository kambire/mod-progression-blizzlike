-- =====================================================
-- TRANSICIÓN: TBC → WOTLK
-- Bracket: 80_1_2 (WotLK Start - Arena S5)
-- =====================================================
-- ACCIÓN CRÍTICA:
-- 1. DESACTIVAR vendors de TBC (remover flag de vendor en creature_template)
-- 2. ACTIVAR vendors de WotLK (agregar flag de vendor en creature_template)
-- 3. (Opcional) LIMPIAR npc_vendor de vendors antiguos
-- =====================================================

-- PASO 1: DESACTIVAR vendors TBC
-- Vendor flag (AzerothCore): 128
UPDATE `creature_template`
SET `npcflag` = `npcflag` & ~128
WHERE `entry` IN ([TBC_VENDOR_ENTRIES]);

-- PASO 2: ACTIVAR vendors WotLK
UPDATE `creature_template`
SET `npcflag` = `npcflag` | 128
WHERE `entry` IN ([WOTLK_VENDOR_ENTRIES]);

-- PASO 3 (OPCIONAL): LIMPIAR vendors viejos completamente
DELETE FROM `npc_vendor`
WHERE `entry` IN ([TBC_VENDOR_ENTRIES]);

-- VALIDACIÓN
SELECT 
  `entry`,
  (`npcflag` & 128) as is_vendor
FROM `creature_template`
WHERE `entry` IN ([TBC_VENDOR_ENTRIES], [WOTLK_VENDOR_ENTRIES]);

-- Resultado esperado:
-- - Vendors TBC: is_vendor = 0
-- - Vendors WotLK: is_vendor = 128
