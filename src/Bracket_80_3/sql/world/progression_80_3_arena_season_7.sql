-- Arena Season 7 Support (Bracket_80_3)
-- Season 7: August 2009 - December 2009
-- T9 Tier sets from Trial of the Crusader drops

-- Trial of the Crusader Tier 9 Loot
-- Already configured by default in AzerothCore
-- Tier 9 vendors will be enabled when Trial is active

-- Arena Season 7 vendors and items
-- These items are PvP gear for Season 7
-- Vendors located in: Orgrimmar, Stormwind

UPDATE `npc_vendor` SET `phaseMask` = 1 WHERE `entry` IN (
    33609,  -- Nargle Lashsnarl (Horde Vendor - Orgrimmar)
    33610   -- Joran Steelsmythe (Alliance Vendor - Stormwind)
) AND `item_template` IN (
    -- Season 7 Furious Gladiator items
    -- These are determined by your game version's PvP vendor system
    48717,  -- Furious Gladiator's Bracers (Caster)
    48718,  -- Furious Gladiator's Bracers (Melee)
    48719,  -- Furious Gladiator's Bracers (Plate)
    48720   -- etc...
);

-- NOTE: Full Arena Season 7 PvP vendor configuration 
-- should be imported from world database based on:
-- - Furious Gladiator title threshold (2200 rating)
-- - Seasonal armor and weapons 
-- - Enchantments and gems (Emblems of Triumph conversion)
-- - Tabards and other cosmetics
-- - Seasonal mounts and pets

-- Season 7 conquest point changes
-- Increased point values from arena matches
-- New gear vendors in faction capitals
-- Onyxia 80 loot available for transmog to PvP gear

-- Trial of the Crusader (not Trial of the Champion - 5-man dungeon)
-- Trial of the Crusader is the 10/25-man raid
-- Correct entries should be for TOTC raid bosses, not the dungeon
