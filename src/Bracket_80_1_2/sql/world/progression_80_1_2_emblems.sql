-- WotLK early-era emblem fix (Bracket 80_1_2):
-- - Heroic 5-man dungeon BOSSES should drop Emblem of Heroism (40752).
-- - This is intentionally scoped to 5-man instance boss creatures to avoid touching raid loot.
--
-- Emblem item IDs (WotLK):
-- Heroism 40752
-- Valor   40753
-- Conquest 45624
-- Triumph 47241

-- Direct emblem rows on boss loot
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 40752
WHERE cl.`Item` IN (47241, 40753, 45624)
	AND ct.`rank` = 3
	AND EXISTS (
		SELECT 1
		FROM `creature` cr
		JOIN `instance_template` it ON it.`map` = cr.`map`
		WHERE cr.`id1` = cl.`entry`
			AND it.`maxPlayers` = 5
	);

-- Emblems coming from reference loot templates
UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET rl.`Item` = 40752
WHERE rl.`Item` IN (47241, 40753, 45624)
	AND ct.`rank` = 3
	AND EXISTS (
		SELECT 1
		FROM `creature` cr
		JOIN `instance_template` it ON it.`map` = cr.`map`
		WHERE cr.`id1` = cl.`entry`
			AND it.`maxPlayers` = 5
	);
