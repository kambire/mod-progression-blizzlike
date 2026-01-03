
UPDATE `creature` SET `phaseMask` = 1 WHERE `id1` IN (33964,35578,35577,31582);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` IN (
    33964, -- Arcanist Firael
    35578, -- Valiant Bressia
    35577, -- Valiant Laradia
    31582  -- Magistrix Lambriesse
);

UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 128 WHERE `entry` IN (
    -- T8
    35494,35574,
    -- T9
    35579,35580,
    -- T10
    31579,35573,31580,37942
);
