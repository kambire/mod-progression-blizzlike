-- Arena Season 6 Support (Bracket_80_2)
-- Season 6: May 2009 - August 2009
-- T8 Tier sets from Ulduar drops

-- Ulduar Tier 8 Loot (T8 armor drops)
-- Already configured by default in AzerothCore
-- Tier 8 vendors will be enabled when Ulduar is active

-- Arena Season 6 vendors and items
-- These items are PvP gear for Season 6
-- Vendors located in: Orgrimmar, Stormwind

UPDATE `npc_vendor` SET `phaseMask` = 1 WHERE `entry` IN (
    33609,  -- Nargle Lashsnarl (Horde Vendor - Orgrimmar)
    33610   -- Joran Steelsmythe (Alliance Vendor - Stormwind)
) AND `item_template` IN (
    -- Season 6 Glorious Gladiator items
    -- These are determined by your game version's PvP vendor system
    41382,  -- Glorious Gladiator's Bracers (Caster)
    41383,  -- Glorious Gladiator's Bracers (Melee)
    41384,  -- Glorious Gladiator's Bracers (Plate)
    41385   -- etc...
);

-- NOTE: Full Arena Season 6 PvP vendor configuration 
-- should be imported from world database based on:
-- - Glorious Gladiator title threshold (2200 rating)
-- - Seasonal armor and weapons 
-- - Enchantments and gems
-- - Tabards and other cosmetics

-- Season 6 badges and ratings
-- Players need 2200 rating to buy Glorious items
-- Conquest points reward rates are increased in Season 6
