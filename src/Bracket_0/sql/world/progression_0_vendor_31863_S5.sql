/* ---------------------------------------------------------
   NPC 31863 - BORRAR TODO y CARGAR VENDOR (desde wotlkdb HTML)
   AzerothCore WotLK - MySQL 8.4
   - Usa itemextendedcost_dbc existente (NO inventa IDs)
   - Limpia npc_vendor + game_event_npc_vendor (si aplica)
--------------------------------------------------------- */

START TRANSACTION;

SET @npc := 31863;

-- =========================================================
-- A) BACKUP + LIMPIEZA en npc_vendor (por entry)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_npc_vendor_31863_20260101;
CREATE TABLE backupKambi_npc_vendor_31863_20260101 LIKE npc_vendor;

INSERT INTO backupKambi_npc_vendor_31863_20260101
SELECT *
FROM npc_vendor
WHERE entry = @npc;

DELETE FROM npc_vendor
WHERE entry = @npc;

-- =========================================================
-- B) LIMPIEZA por EVENTO (si el vendor está por game_event_npc_vendor)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_game_event_npc_vendor_31863_20260101;
CREATE TABLE backupKambi_game_event_npc_vendor_31863_20260101 LIKE game_event_npc_vendor;

INSERT INTO backupKambi_game_event_npc_vendor_31863_20260101
SELECT gev.*
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc;

DELETE gev
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc;

-- =========================================================
-- C) CARGA: lista de items (ItemID, ArenaPoints, HonorPoints, Rating)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_items_31863;
CREATE TEMPORARY TABLE tmp_items_31863 (
    rn INT PRIMARY KEY AUTO_INCREMENT,
    item INT NOT NULL,
    arena INT NOT NULL,
    honor INT NULL,
    rating INT NOT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_items_31863 (item, arena, honor, rating) VALUES
    (40784,2250,,1870),
    (40785,2250,,1870),
    (40786,2250,,1870),
    (40804,1350,,1750),
    (40805,1350,,1750),
    (40806,1350,,1750),
    (40823,2250,,1990),
    (40824,2250,,1990),
    (40825,2250,,1990),
    (40844,2250,,1810),
    (40845,2250,,1810),
    (40846,2250,,1810),
    (40862,1750,,2050),
    (40863,1750,,2050),
    (40864,1750,,2050),
    (40905,2250,,1870),
    (40926,1350,,1750),
    (40932,2250,,1990),
    (40938,2250,,1810),
    (40962,1750,,2050),
    (40990,2250,,1870),
    (40991,2250,,1870),
    (41000,1350,,1750),
    (41006,1350,,1750),
    (41012,2250,,1990),
    (41018,2250,,1990),
    (41026,2250,,1810),
    (41032,2250,,1810),
    (41037,1750,,2050),
    (41043,1750,,2050),
    (41080,2250,,1870),
    (41086,2250,,1870),
    (41136,1350,,1750),
    (41142,1350,,1750),
    (41150,2250,,1990),
    (41156,2250,,1990),
    (41198,2250,,1810),
    (41204,2250,,1810),
    (41210,1750,,2050),
    (41216,1750,,2050),
    (41274,1750,,2050),
    (41280,1750,,2050),
    (41286,1350,,1750),
    (41292,1350,,1750),
    (41297,2250,,1810),
    (41303,2250,,1810),
    (41309,2250,,1870),
    (41315,2250,,1870),
    (41320,2250,,1990),
    (41326,2250,,1990),
    (41649,2250,,1870),
    (41654,2250,,1810),
    (41660,2250,,1870),
    (41666,2250,,1810),
    (41671,2250,,1990),
    (41677,2250,,1990),
    (41682,1750,,2050),
    (41714,1750,,2050),
    (41766,1350,,1750),
    (41772,1350,,1750),
    (41853,2250,,1990),
    (41858,2250,,1870),
    (41863,2250,,1810),
    (41868,1750,,2050),
    (41873,1350,,1750),
    (41914,2250,,1990),
    (41920,2250,,1870),
    (41926,2250,,1810),
    (41933,1750,,2050),
    (41939,1350,,1750),
    (41945,2250,,1990),
    (41951,2250,,1870),
    (41958,2250,,1810),
    (41964,1750,,2050),
    (41970,1350,,1750),
    (41992,2250,,1990),
    (41997,2250,,1870),
    (42004,2250,,1810),
    (42010,1750,,2050),
    (42016,1350,,1750),
    (42208,3150,,1930),
    (42227,3150,,1930),
    (42232,3150,,1930),
    (42237,3150,,1930),
    (42242,3150,,1930),
    (42248,3150,,1930),
    (42255,3150,,1930),
    (42260,3150,,1930),
    (42265,3150,,1930),
    (42270,3150,,1930),
    (42275,3150,,1930),
    (42280,3150,,1930),
    (42285,3150,,1930),
    (42290,3150,,1930),
    (42317,4500,,1930),
    (42322,4500,,1930),
    (42327,4500,,1930),
    (42332,4500,,1930),
    (42346,3150,,1930),
    (42352,3150,,1930),
    (42362,4500,,1930),
    (42384,4500,,1930),
    (42390,4500,,1930),
    (42450,2250,,1930),
    (42485,4500,,1930),
    (42490,4500,,1930),
    (42495,4500,,1930),
    (42502,2250,,1930),
    (42513,2250,,1930),
    (42519,2250,,1930),
    (42559,2250,,1930),
    (42564,2250,,1930),
    (42570,2250,,1930),
    (42578,1200,,1930),
    (42583,1200,,1930),
    (42588,1200,,1930),
    (42597,1200,,1930),
    (42602,1200,,1930),
    (42607,1200,,1930),
    (42614,1200,,1930),
    (42620,1200,,1930),
    (42852,1200,,1930),
    (44419,4500,,1930),
    (44420,4500,,1930);

-- Normaliza valores vacíos (NULL) a 0 para HonorPoints
UPDATE tmp_items_31863
SET honor = 0
WHERE honor IS NULL;

SELECT COUNT(*) AS tmp_items_rows FROM tmp_items_31863;

-- =========================================================
-- D) RESOLVER ExtendedCost existente (deduplicado por costo)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_cost_defs_31863;
CREATE TEMPORARY TABLE tmp_cost_defs_31863 (
    cost_rn INT PRIMARY KEY AUTO_INCREMENT,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL,
    extendedCostId INT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_cost_defs_31863 (arena, honor, rating)
SELECT DISTINCT arena, honor, rating
FROM tmp_items_31863
ORDER BY arena, honor, rating;

SELECT COUNT(*) AS distinct_cost_defs FROM tmp_cost_defs_31863;

UPDATE tmp_cost_defs_31863 d
SET d.extendedCostId = (
    SELECT iec.ID
    FROM itemextendedcost_dbc iec
    WHERE iec.HonorPoints = d.honor
      AND iec.ArenaPoints = d.arena
      AND iec.RequiredArenaRating = d.rating
      AND iec.ItemID_1 = 0 AND iec.ItemID_2 = 0 AND iec.ItemID_3 = 0 AND iec.ItemID_4 = 0 AND iec.ItemID_5 = 0
      AND iec.ItemCount_1 = 0 AND iec.ItemCount_2 = 0 AND iec.ItemCount_3 = 0 AND iec.ItemCount_4 = 0 AND iec.ItemCount_5 = 0
      AND iec.ItemPurchaseGroup = 0
    ORDER BY iec.ArenaBracket ASC, iec.ID ASC
    LIMIT 1
);

SET @missing_cost_defs := (
    SELECT COUNT(*)
    FROM tmp_cost_defs_31863
    WHERE extendedCostId IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;
SELECT arena, honor, rating FROM tmp_cost_defs_31863 WHERE extendedCostId IS NULL ORDER BY arena, honor, rating;
SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- =========================================================
-- E) INSERT: vendor en npc_vendor (entry=31863)
-- =========================================================

INSERT INTO npc_vendor
(entry, slot, item, maxcount, incrtime, ExtendedCost, VerifiedBuild)
SELECT @npc AS entry,
       (i.rn - 1) AS slot,
       i.item,
       0 AS maxcount,
       0 AS incrtime,
       d.extendedCostId AS ExtendedCost,
       0 AS VerifiedBuild
FROM tmp_items_31863 i
JOIN tmp_cost_defs_31863 d
  ON d.arena = i.arena
 AND d.honor = i.honor
 AND d.rating = i.rating
ORDER BY i.rn;

COMMIT;

-- =========================================================
-- F) CHECKS
-- =========================================================

SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_31863
FROM npc_vendor
WHERE entry = @npc;

SELECT *
FROM npc_vendor
WHERE entry = @npc
ORDER BY slot, item;

SELECT gev.eventEntry, gev.guid, gev.item, gev.ExtendedCost
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc
ORDER BY gev.eventEntry, gev.guid, gev.item;
