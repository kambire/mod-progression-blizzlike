-- Tier vendors visibility (Bracket 80_3 - T9 activo)
-- Regla: mostrar T7, T8 y T9; ocultar T10.

-- T7 vendors (ensure enabled)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (33964,35578,35577,31582);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (33964,35578,35577,31582);

-- T8 vendors (ensure enabled)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (35494,35574);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (35494,35574);

-- T9 vendors (enable)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (35579,35580);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (
    35579, -- Valiant Bressia
    35580  -- Valiant Laradia
);

-- Ocultar T10
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 128 WHERE `entry` IN (31579,35573,31580,37942);
