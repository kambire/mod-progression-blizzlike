-- Baseline: ocultar todos los vendors de tier (T7-T10) al inicio
-- Fase GM: moverlos a phaseMask 16384 para que sólo los GM los vean.
UPDATE `creature` SET `phaseMask` = 16384 WHERE `id1` IN (
    -- T7
    33964,35578,35577,31582,
    -- T8
    35494,35574,
    -- T9
    35579,35580,
    -- T10
    31579,35573,31580,37942
);

UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 128 WHERE `entry` IN (
    -- T7
    33964,35578,35577,31582,
    -- T8
    35494,35574,
    -- T9
    35579,35580,
    -- T10
    31579,35573,31580,37942
);
