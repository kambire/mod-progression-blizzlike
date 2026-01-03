-- Wrath riding costs and requirements
-- Expert Riding (flying) returns to Wrath pricing
UPDATE `npc_trainer` SET `MoneyCost`=2500000, `ReqLevel`=60 WHERE `ID`=202011 AND `SpellID`=34090;

-- Artisan Riding (keep Wrath-era cost/level)
UPDATE `npc_trainer` SET `MoneyCost`=50000000, `ReqLevel`=70 WHERE `ID`=202011 AND `SpellID`=34091;

-- Restore Epic Flight Form to Wrath rules
DELETE FROM `npc_trainer` WHERE `ID`=200006 AND `SpellID`=40120;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
(200006, 40120, 50000000, 762, 300, 70, 0);

-- Ensure normal Flight Form stays at 68
UPDATE `npc_trainer` SET `ReqLevel`=68 WHERE `ID`=200006 AND `SpellID`=33950;
