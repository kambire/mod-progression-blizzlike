/* ---------------------------------------------------------------------------
   Xazi Pipa Humillo (33937) - Vendor Arena (Season 8 / Furious)
   REBUILD item-by-item con ExtendedCost correcto (IDs DBC)
   AzerothCore WotLK 3.3.5a | MySQL 8.6 | Navicat-safe
   Fecha: 2025-12-31
--------------------------------------------------------------------------- */

-- 0) BACKUP
CREATE TABLE IF NOT EXISTS backupKambi_npc_vendor_33937_20251231 LIKE npc_vendor;

REPLACE INTO backupKambi_npc_vendor_33937_20251231
SELECT *
FROM npc_vendor
WHERE entry = 33937;

-- 1) LIMPIAR vendor actual
DELETE FROM npc_vendor
WHERE entry = 33937;

-- 2) LISTA ITEM-BY-ITEM + GRUPO DE COSTO
-- costGroup:
-- 1 = 770 arena + 13200 honor  -> ExtendedCost 2956
-- 2 = 440 arena + 8000 honor   -> ExtendedCost 2957
-- 3 = 600 arena + 10550 honor  -> ExtendedCost 2955
-- 4 = 350 arena + 6400 honor + 700 rating -> ExtendedCost 2608
-- 5 = 100 arena                -> ExtendedCost 2596

DROP TABLE IF EXISTS tmp_vendor_items_33937;
CREATE TABLE tmp_vendor_items_33937 (
  slot      INT UNSIGNED NOT NULL,
  item      INT UNSIGNED NOT NULL,
  costGroup TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (slot),
  UNIQUE KEY uq_item (item),
  KEY idx_costGroup (costGroup)
);

INSERT INTO tmp_vendor_items_33937 (slot, item, costGroup) VALUES
-- PLATE
(0,  40790, 1),
(1,  40791, 1),
(2,  40792, 1),
(3,  40810, 2),
(4,  40811, 2),
(5,  40812, 2),
(6,  40829, 1),
(7,  40830, 1),
(8,  40831, 1),
(9,  40850, 1),
(10, 40851, 1),
(11, 40852, 1),
(12, 40870, 3),
(13, 40871, 3),
(14, 40872, 3),

-- PALADIN
(15, 40910, 1),
(16, 40928, 2),
(17, 40934, 1),
(18, 40940, 1),
(19, 40964, 3),

-- MAIL
(20, 40994, 1),
(21, 40995, 1),
(22, 41002, 2),
(23, 41008, 2),
(24, 41014, 1),
(25, 41020, 1),
(26, 41028, 1),
(27, 41034, 1),
(28, 41039, 3),
(29, 41045, 3),

-- MAIL (HUNTER/SHAMAN variants)
(30, 41082, 1),
(31, 41088, 1),
(32, 41138, 2),
(33, 41144, 2),
(34, 41152, 1),
(35, 41158, 1),
(36, 41200, 1),
(37, 41206, 1),
(38, 41212, 3),
(39, 41218, 3),

-- LEATHER / DRUID
(40, 41276, 3),
(41, 41282, 3),
(42, 41288, 2),
(43, 41294, 2),
(44, 41299, 1),
(45, 41305, 1),
(46, 41311, 1),
(47, 41317, 1),
(48, 41322, 1),
(49, 41328, 1),

-- ROGUE / DRUID / etc
(50, 41651, 1),
(51, 41656, 1),
(52, 41662, 1),
(53, 41668, 1),
(54, 41673, 1),
(55, 41679, 1),
(56, 41684, 3),
(57, 41716, 3),
(58, 41768, 2),
(59, 41774, 2),

-- CLOTH (MOONCLOTH)
(60, 41855, 1),
(61, 41860, 1),
(62, 41865, 1),
(63, 41870, 3),
(64, 41875, 2),

-- CLOTH (SATIN)
(65, 41916, 1),
(66, 41922, 1),
(67, 41928, 1),
(68, 41935, 3),
(69, 41941, 2),

-- CLOTH (SILK)
(70, 41947, 1),
(71, 41954, 1),
(72, 41960, 1),
(73, 41966, 3),
(74, 41972, 2),

-- CLOTH (FELWEAVE)
(75, 41994, 1),
(76, 41999, 1),
(77, 42006, 1),
(78, 42012, 3),
(79, 42018, 2),

-- RELICS (req rating 700)
(80, 42580, 4),
(81, 42585, 4),
(82, 42591, 4),
(83, 42599, 4),
(84, 42604, 4),
(85, 42609, 4),
(86, 42616, 4),
(87, 42622, 4),
(88, 42854, 4),

-- 100 arena
(89, 45706, 5);

-- 3) MAPA DE COSTOS
DROP TABLE IF EXISTS tmp_vendor_cost_33937;
CREATE TABLE tmp_vendor_cost_33937 (
  costGroup   TINYINT UNSIGNED NOT NULL PRIMARY KEY,
  ExtendedCost INT UNSIGNED NOT NULL
);

INSERT INTO tmp_vendor_cost_33937 (costGroup, ExtendedCost) VALUES
(1, 2956),  -- 13200 honor + 770 arena
(2, 2957),  -- 8000 honor + 440 arena
(3, 2955),  -- 10550 honor + 600 arena
(4, 2608),  -- 6400 honor + 350 arena + rating 700
(5, 2596);  -- 100 arena

-- 4) INSERT FINAL A npc_vendor
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, VerifiedBuild)
SELECT
  33937 AS entry,
  t.slot,
  t.item,
  0 AS maxcount,
  0 AS incrtime,
  c.ExtendedCost,
  0 AS VerifiedBuild
FROM tmp_vendor_items_33937 t
JOIN tmp_vendor_cost_33937 c ON c.costGroup = t.costGroup
ORDER BY t.slot;

-- 5) Verificación rápida
SELECT entry, slot, item, ExtendedCost
FROM npc_vendor
WHERE entry = 33937
ORDER BY slot;

-- 6) Limpieza
DROP TABLE IF EXISTS tmp_vendor_cost_33937;
DROP TABLE IF EXISTS tmp_vendor_items_33937;
