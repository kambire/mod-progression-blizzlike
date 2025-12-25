-- 80 level range - Tier 8 (Secrets of Ulduar) & Furious Gladiator

-- Makes instances (and RDF) Ulduar and Vault of Archavon available again.
DELETE FROM `disables` WHERE `sourceType` IN (2, 8) AND `entry` IN (603, 624);

-- Ensure WotLK heroic dungeons are enabled as well.
-- Some servers may jump straight to 80_2 without having previously applied 80_1_2.
DELETE FROM `disables` WHERE `entry` IN (574, 575, 576, 578, 595, 599, 600, 601, 602, 604, 608, 619) AND `sourceType` = 2;

-- ^ This needs to be added alongside with nax or re-worked / splitted ^
