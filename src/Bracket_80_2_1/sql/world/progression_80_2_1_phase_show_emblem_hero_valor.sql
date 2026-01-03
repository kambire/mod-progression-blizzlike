-- Unhide emblem vendors for Heroism/Valor at T7 (80_2_1).
-- NPCs: 31581 (Alianza), 31582 (Horda)

START TRANSACTION;

UPDATE creature
SET phaseMask = 1
WHERE id1 IN (31581,31582);

COMMIT;
