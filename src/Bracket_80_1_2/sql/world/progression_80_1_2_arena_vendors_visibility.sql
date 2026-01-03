-- Arena vendors visibility (Season 5 active)
-- Regla: mostrar S5 y anteriores; ocultar S6, S7, S8.

-- Season 3 vendors (ensure enabled)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (19857);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (19857);

-- Season 4 vendors (ensure enabled)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (27721,27722,26384,20278);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (27721,27722,26384,20278);

-- Season 5 vendors (enable)
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (30407,32381,32385,32384,32382,32405,31863,32383,32380,31864,32865);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (
    30407,32381,32385,32384,32382,32405,31863,32383,32380,31864,32865
);

-- Season 6-8 vendors (hide)
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 128 WHERE `entry` IN (
    33915,34088,33917,33920,33916,34089,33918,33919,33921,34087,33922,33923,
    33924,34090,33929,33928,33932,34091,33931,33930,33927,34092,33926,33925,
    33939,34093,33934,33935,33933,34094,33940,33941,33936,34095,33937,33938
);
