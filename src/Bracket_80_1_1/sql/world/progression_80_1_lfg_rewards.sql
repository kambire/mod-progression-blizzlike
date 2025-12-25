-- Reset WotLK dungeon rewards
-- Desired behavior:
-- - First random heroic of the day: Valor (quest 24788)
-- - Subsequent random heroics: Heroism (quest 24789)
UPDATE `lfg_dungeon_rewards` SET `firstQuestId` = 24788, `otherQuestId`=24789 WHERE `dungeonId` IN (261, 262) AND `maxLevel`=80;
