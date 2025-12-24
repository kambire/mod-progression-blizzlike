-- Arena Season Progression Validation
-- Verification script for proper Arena Season 1-8 implementation
-- Blizzard Timeline: Jan 2007 - Dec 2009

-- ==========================================
-- ARENA SEASON PROGRESSION GUIDE
-- ==========================================

-- SEASON 1 (Gladiator) - TBC Phase 1
-- Bracket: Bracket_70_2_1
-- Dates: Jan 2007 - May 2007
-- Rating threshold: 1500 for Gladiator title
-- Rewards: Gladiator gear (arena_season_1)
-- Vendors: Orgrimmar & Stormwind (Season 1)

-- SEASON 2 (Merciless Gladiator) - TBC Phase 3
-- Bracket: Bracket_70_4_1
-- Dates: Aug 2007 - Dec 2007
-- Rating threshold: 2000 for Merciless Gladiator title
-- Rewards: Merciless Gladiator gear (arena_season_2)
-- Vendors: Orgrimmar & Stormwind (Season 2)
-- NOTE: Season 1 vendors still available for lower-tier items

-- SEASON 3 (Vengeful Gladiator) - TBC Phase 4
-- Bracket: Bracket_70_5
-- Dates: Dec 2007 - Mar 2008
-- Rating threshold: 2000 for Vengeful Gladiator title
-- Rewards: Vengeful Gladiator gear (arena_season_3)
-- Vendors: Orgrimmar & Stormwind (Season 3)

-- SEASON 4 (Brutal Gladiator) - TBC Phase 5 / WotLK
-- Bracket: Bracket_70_6_2 / Bracket_80_1_1
-- Dates: Mar 2008 - Nov 2008
-- Rating threshold: 2000 for Brutal Gladiator title
-- Rewards: Brutal Gladiator gear (arena_season_4)
-- Vendors: Orgrimmar & Stormwind (Season 4)

-- SEASON 5 (Hateful Gladiator) - WotLK Phase 1
-- Bracket: Bracket_80_1_2
-- Dates: Nov 2008 - Apr 2009
-- Rating threshold: 2000 for Hateful Gladiator title
-- Rewards: Hateful Gladiator gear (arena_season_5)
-- Vendors: Orgrimmar & Stormwind (Season 5)

-- SEASON 6 (Deadly Gladiator / Glorious Gladiator) - WotLK Phase 2
-- Bracket: Bracket_80_2
-- Dates: Apr 2009 - Aug 2009
-- Rating threshold: 2000 for Deadly Gladiator, 2200 for Glorious Gladiator
-- Rewards: Glorious Gladiator gear (arena_season_6)
-- Vendors: Orgrimmar & Stormwind (Season 6)
-- T8 gear from Ulduar becomes PvP farmable

-- SEASON 7 (Furious Gladiator) - WotLK Phase 3
-- Bracket: Bracket_80_3
-- Dates: Aug 2009 - Dec 2009
-- Rating threshold: 2000 for Furious Gladiator title
-- Rewards: Furious Gladiator gear (arena_season_7)
-- Vendors: Orgrimmar & Stormwind (Season 7)
-- T9 gear from Trial of the Crusader becomes PvP farmable

-- SEASON 8 (Wrathful Gladiator) - WotLK Phase 4
-- Bracket: Bracket_80_4_1
-- Dates: Dec 2009 - Nov 2010 (overlaps with Cataclysm)
-- Rating threshold: 2000 for Wrathful Gladiator title
-- Rewards: Wrathful Gladiator gear (arena_season_8)
-- Vendors: Orgrimmar & Stormwind (Season 8)
-- T10 gear from Icecrown Citadel becomes PvP farmable

-- ==========================================
-- VALIDATION QUERIES
-- ==========================================

-- Check Arena Vendor counts per bracket
SELECT 
    'Bracket_70_2_1 (Season 1)' as Season,
    COUNT(*) as VendorCount
FROM npc_vendor 
WHERE entry IN (33609, 33610, 33611, 33612)
    AND item_template LIKE 'season_1'
UNION ALL
SELECT 'Bracket_70_4_1 (Season 2)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_2'
UNION ALL
SELECT 'Bracket_70_5 (Season 3)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_3'
UNION ALL
SELECT 'Bracket_70_6_2 (Season 4)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_4'
UNION ALL
SELECT 'Bracket_80_1_2 (Season 5)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_5'
UNION ALL
SELECT 'Bracket_80_2 (Season 6)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_6'
UNION ALL
SELECT 'Bracket_80_3 (Season 7)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_7'
UNION ALL
SELECT 'Bracket_80_4_1 (Season 8)', COUNT(*)
FROM npc_vendor 
WHERE entry IN (33609, 33610)
    AND item_template LIKE 'season_8';

-- ==========================================
-- IMPORTANT NOTES FOR ARENA SEASONS
-- ==========================================

-- 1. PvP VENDOR LOCATIONS:
--    Horde: Orgrimmar (exact coordinates per expansion)
--    Alliance: Stormwind (exact coordinates per expansion)

-- 2. SEASON RESET MECHANICS:
--    - Old season gear becomes cheaper when new season starts
--    - New season gear is more expensive initially
--    - Conquest points reset each season

-- 3. ITEM PROGRESSION:
--    - Season 1: 1500+ rating recommended
--    - Season 2-8: 2000+ rating for top-tier pieces
--    - Seasonal weapons > seasonal armor > seasonal off-pieces

-- 4. PvP TIER NAMING:
--    - Arena Season 1 = Gladiator
--    - Arena Season 2 = Merciless Gladiator
--    - Arena Season 3 = Vengeful Gladiator
--    - Arena Season 4 = Brutal Gladiator
--    - Arena Season 5 = Hateful Gladiator / Deadly Gladiator
--    - Arena Season 6 = Glorious Gladiator / Deadly Gladiator (S5 legacy)
--    - Arena Season 7 = Furious Gladiator
--    - Arena Season 8 = Wrathful Gladiator

-- 5. RATINGS AND TITLES:
--    Most seasons require 2000+ arena rating for top-tier items
--    Exception: Season 1 requires 1500+ for Gladiator title

-- 6. VENDOR NPC ENTRIES:
--    These vary by AzerothCore version but typically:
--    - Orgrimmar vendors: 33609, 34089, 32356, 24392
--    - Stormwind vendors: 33610, 34091, 32405, 32354

-- 7. SEASONAL MOUNTS:
--    Each season typically has an exclusive mount for top-rated players
--    Season 5+: Drakes and Hippogryphs based on season

-- 8. CONQUEST POINT AWARDS:
--    Varies per season but generally:
--    - 3v3 Arenas: 10 points/win
--    - 5v5 Arenas: 15-20 points/win
--    - RBGs (not in classic WotLK): 20-30 points/win

-- NOTE: Make sure all seasonal vendors are properly enabled/disabled
-- based on which bracket is active in your progression system
