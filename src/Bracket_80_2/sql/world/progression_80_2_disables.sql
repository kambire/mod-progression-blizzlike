-- 80 level range - Tier 8 (Secrets of Ulduar) & Furious Gladiator

-- IMPORTANT:
-- This bracket must enforce the lock FIRST for any "future" 80 content, to support servers that jump straight
-- to WotLK brackets without having applied Bracket_0 baseline disables.
-- Ensure future 80 content remains locked during 80_2 (Ulduar era).
-- - Onyxia (reworked), Trial of the Crusader/Champion (ToC era)
-- - Icecrown Citadel and its 5-man dungeons (ICC era)
-- - Ruby Sanctum (RS era)
DELETE FROM `disables` WHERE `sourceType` = 2 AND `entry` IN (249, 631, 632, 649, 650, 658, 668, 724);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(2, 249, 3, '', '', 'Onyxia Lair'),
(2, 631, 15, '', '', 'Icecrown Citadel'),
(2, 632, 3, '', '', 'The Forge of Souls'),
(2, 649, 15, '', '', 'Trial of The Crusader'),
(2, 650, 3, '', '', 'Trial of the Champion'),
(2, 658, 3, '', '', 'Pit of Saron'),
(2, 668, 3, '', '', 'Halls of Reflection'),
(2, 724, 15, '', '', 'The Ruby Sanctum');

-- Makes instances (and RDF) Ulduar and Vault of Archavon available again.
DELETE FROM `disables` WHERE `sourceType` IN (2, 8) AND `entry` IN (603, 624);

-- Ensure WotLK heroic dungeons are enabled as well.
-- Some servers may jump straight to 80_2 without having previously applied 80_1_2.
DELETE FROM `disables` WHERE `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619) AND `sourceType` = 2;

-- ^ This needs to be added alongside with nax or re-worked / splitted ^
