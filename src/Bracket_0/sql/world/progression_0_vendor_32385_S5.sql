/* ---------------------------------------------------------
   NPC 32385 - BORRAR TODO y CARGAR VENDOR (desde wotlkdb HTML)
   AzerothCore WotLK - MySQL 8.4

   ENFASIS:
   - Este script RESPALDA y BORRA TODO lo existente del vendor
     (npc_vendor y game_event_npc_vendor) para el NPC 32385,
     y luego INSERTA nuevamente TODO con precios correctos.

   - Usa itemextendedcost_dbc existente (NO inventa IDs)
--------------------------------------------------------- */

START TRANSACTION;

SET @npc := 32385;

-- =========================================================
-- A) BACKUP + BORRADO FUERTE en npc_vendor (por entry)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_npc_vendor_32385_20260101;
CREATE TABLE backupKambi_npc_vendor_32385_20260101 LIKE npc_vendor;

INSERT INTO backupKambi_npc_vendor_32385_20260101
SELECT *
FROM npc_vendor
WHERE entry = @npc;

DELETE FROM npc_vendor
WHERE entry = @npc;

-- =========================================================
-- B) BACKUP + BORRADO FUERTE por EVENTO (game_event_npc_vendor)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_game_event_npc_vendor_32385_20260101;
CREATE TABLE backupKambi_game_event_npc_vendor_32385_20260101 LIKE game_event_npc_vendor;

INSERT INTO backupKambi_game_event_npc_vendor_32385_20260101
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

DROP TEMPORARY TABLE IF EXISTS tmp_items_32385;
CREATE TEMPORARY TABLE tmp_items_32385 (
    rn INT PRIMARY KEY AUTO_INCREMENT,
    item INT NOT NULL,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_items_32385 (item, arena, honor, rating) VALUES
    (40879,0,62000,1630),
    (40880,0,62000,1720),
    (40888,0,39400,1660),
    (40974,0,62000,1630),
    (40975,0,62000,1720),
    (40982,0,39400,1660),
    (41048,0,62000,1630),
    (41054,0,62000,1720),
    (41059,0,39400,1660),
    (41064,0,39400,1660),
    (41069,0,62000,1630),
    (41074,0,62000,1720),
    (41224,0,39400,1660),
    (41229,0,62000,1720),
    (41234,0,62000,1630),
    (41616,0,62000,1630),
    (41620,0,62000,1720),
    (41624,0,39400,1660),
    (41629,0,62000,1630),
    (41634,0,62000,1720),
    (41639,0,39400,1660),
    (41831,0,62000,1630),
    (41835,0,62000,1720),
    (41839,0,39400,1660),
    (41880,0,62000,1630),
    (41884,0,62000,1720),
    (41892,0,39400,1660),
    (41897,0,62000,1630),
    (41902,0,62000,1720),
    (41908,0,39400,1660),
    (42027,0,47400,1600),
    (42028,0,47400,1600),
    (42029,0,47400,1600),
    (42030,0,47400,1600),
    (42031,0,47400,1600),
    (42032,0,47400,1600),
    (42033,0,47400,1600),
    (42062,0,47400,1750),
    (42063,0,47400,1750),
    (42064,0,47400,1750),
    (42065,0,47400,1750),
    (42066,0,47400,1750),
    (42067,0,47400,1750),
    (42068,0,47400,1750),
    (42114,0,47400,1690),
    (42115,0,47400,1690),
    (42128,0,62000,1800),
    (42129,0,62000,1800),
    (42130,0,62000,1800),
    (42131,0,62000,1800),
    (42132,0,62000,1800)
;

SELECT COUNT(*) AS tmp_items_rows FROM tmp_items_32385;

-- =========================================================
-- D) RESOLVER ExtendedCost existente (deduplicado por costo)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_cost_defs_32385;
CREATE TEMPORARY TABLE tmp_cost_defs_32385 (
    cost_rn INT PRIMARY KEY AUTO_INCREMENT,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL,
    extendedCostId INT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_cost_defs_32385 (arena, honor, rating)
SELECT DISTINCT arena, honor, rating
FROM tmp_items_32385
ORDER BY arena, honor, rating;

SELECT COUNT(*) AS distinct_cost_defs FROM tmp_cost_defs_32385;

UPDATE tmp_cost_defs_32385 d
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
    FROM tmp_cost_defs_32385
    WHERE extendedCostId IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;
SELECT arena, honor, rating FROM tmp_cost_defs_32385 WHERE extendedCostId IS NULL ORDER BY arena, honor, rating;
SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- =========================================================
-- E) INSERT: vendor en npc_vendor (entry=32385)
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
FROM tmp_items_32385 i
JOIN tmp_cost_defs_32385 d
  ON d.arena = i.arena
 AND d.honor = i.honor
 AND d.rating = i.rating
ORDER BY i.rn;

COMMIT;

-- =========================================================
-- F) CHECKS
-- =========================================================

SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_32385
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


