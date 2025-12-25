-- Set RDF/LFG daily quest rewards for Ulduar era (Bracket 80_2)
-- Keeps Triumph out of 80_2.
UPDATE `quest_template` SET `rewarditem1` = 40752 WHERE `ID` = 24790; -- Daily Nth, Heroism (normal)
UPDATE `quest_template` SET `rewarditem1` = 40752 WHERE `ID` = 24789; -- Daily Nth, Heroism (heroic)
UPDATE `quest_template` SET `rewarditem1` = 40753, `RewardAmount1` = 1 WHERE `ID` = 24788; -- Daily 1st, Valor (heroic)
