# 🔧 PARÁMETROS TÉCNICOS PARA DESARROLLO
**Fecha**: Diciembre 24, 2025  
**Enfoque**: Desarrollo y Implementación  
**Audiencia**: Developers, QA, System Admins

---

## 📋 TABLA RÁPIDA DE BRACKETS

### VANILLA - Parámetros Técnicos

```cpp
// ProgressionSystem.h - Array Definition
const uint8 BRACKET_VANILLA_START = 0;
const uint8 BRACKET_VANILLA_END = 13;
const uint8 BRACKET_VANILLA_RAID_START = 7; // Bracket_60_1_1

struct BracketInfo {
    uint8 id;
    string name;
    uint8 minLevel;
    uint8 maxLevel;
    string contentType;  // "Raid", "Dungeon", "World", "Attunement"
    uint32 bossCount;
    uint8 raidSize;      // 0=Dungeon, 10=10-man, 20=20-man, 40=40-man
    time_t releaseDate;
    bool hasAttunement;
    uint32 arenaSeasonId;
};
```

**Bracket Array**:
```
Index  Name            MinLvl MaxLvl Type       Bosses RaidSize Release
0      Bracket_0       1      10     Dungeon    0      0        Nov 23, 2004
1      Bracket_1_19    10     19     Dungeon    0      0        Nov 23, 2004
2      Bracket_20_29   20     29     Dungeon    0      0        Nov 23, 2004
3      Bracket_30_39   30     39     Dungeon    0      0        Nov 23, 2004
4      Bracket_40_49   40     49     World/Dung 0      0        Nov 23, 2004
5      Bracket_50_59_1 50     59     Raid-prep  0      10/40*   Nov 23, 2004 *UBRS
6      Bracket_50_59_2 50     59     Raid       0      10       Nov 23, 2004 *UBRS
7      Bracket_60_1_1  60     60     Raid       8      40       Nov 23, 2004 [MC]
8      Bracket_60_1_2  60     60     Raid       1      40       Nov 23, 2004 [Ony]
9      Bracket_60_2_1  60     60     Raid       8      40       Jan 19, 2005 [BWL]
10     Bracket_60_2_2  60     60     Raid       7      20       Jan 19, 2005 [ZG]
11     Bracket_60_3_1  60     60     Raid       4      20       Jan 19, 2005 [AQ20]
12     Bracket_60_3_2  60     60     Raid       11     40       Jan 19, 2005 [AQ40]
13     Bracket_60_3_3  60     60     World      0      0        Jan 19, 2005+
```

### TBC - Parámetros Técnicos

```
Index  Name            MinLvl MaxLvl Type       Arena Season Release
14     Bracket_61_64   61     64     Dungeon    -      Jan 16, 2007
15     Bracket_65_69   65     69     Dungeon    -      Jan 16, 2007
16     Bracket_70_1_1  70     70     Dungeon    -      Jan 16, 2007
17     Bracket_70_1_2  70     70     Dungeon    -      Jan 16, 2007 [Heroic]
18     Bracket_70_2_1  70     70     Raid (25m) S1     Jan 16, 2007 [Gruul+Mag]
19     Bracket_70_2_2  70     70     Raid (10m) S1     Jan 16, 2007 [Kara]
20     Bracket_70_2_3  70     70     World      -      Mar 19, 2008 [Ogri'la]
21     Bracket_70_3_1  70     70     Raid (25m) -      May 15, 2007 [SSC]
22     Bracket_70_3_2  70     70     Raid (25m) S2     May 15, 2007 [Eye]
23     Bracket_70_4_1  70     70     Raid (25m) S2     Aug 24, 2007 [Hyjal]
24     Bracket_70_4_2  70     70     Raid (25m) -      Sep 24, 2007 [BT]
25     Bracket_70_5    70     70     Raid (10m) S3     Dec 11, 2007 [ZA]
26     Bracket_70_6_1  70     70     World      -      May 22, 2008 [Isle]
27     Bracket_70_6_2  70     70     Raid (25m) S4     May 22, 2008 [Sunwell]
28     Bracket_70_6_3  70     70     World      -      Aug 19, 2008
```

### WotLK - Parámetros Técnicos

```
Index  Name            MinLvl MaxLvl Raids          Arena Season Release
29     Bracket_71_74   71     74     Dungeon        -           Nov 13, 2008
30     Bracket_75_79   75     79     Dungeon        -           Nov 13, 2008
31     Bracket_80_1_1  80     80     Dungeon        -           Nov 13, 2008
32     Bracket_80_1_2  80     80     Dungeon (H)    S5          Nov 13, 2008
33     Bracket_80_2    80     80     4-Raid-Set     S6          Nov 13-Apr 16, 2009
       ├─ Ulduar      (14 bosses)
       ├─ Naxx80      (15 bosses)
       ├─ Eye         (1 boss)
       └─ OS          (1-4 bosses)
34     Bracket_80_3    80     80     Trial + Onyxia S7          Apr 16-Aug 4, 2009
       ├─ Trial       (5 bosses)
       └─ Onyxia80    (1 boss)
35     Bracket_80_4_1  80     80     ICC + Dungeons S8          Dec 8, 2009
       └─ ICC         (12 bosses)
36     Bracket_80_4_2  80     80     Ruby Sanctum   -           Jun 29, 2010
37     Bracket_Custom  *      *      User-defined   -           N/A
```

---

## 🔒 CONTROL DE VENDORS POR BRACKET (CRÍTICO)

### Configuración Obligatoria

```ini
# DEBE estar = 1 para bloquear acceso a contenido futuro
ProgressionSystem.BlockFutureVendors = 1
ProgressionSystem.EnforceItemRestrictions = 1
ProgressionSystem.EnforceArenaVendorProgression = 1
ProgressionSystem.RestrictArenaRewards = 1
```

### Patrón de Limpieza + Agregar (SQL)

```sql
-- Template general para cada season
-- Reemplazar [VARIABLES] con valores reales

-- ============================================
-- LIMPIEZA: Borrar items no válidos
-- ============================================
DELETE FROM npc_vendor 
WHERE entry = [VENDOR_NPC_ID] 
  AND item NOT IN (
    SELECT entry FROM item_template 
    WHERE name LIKE '%[VALID_SEASON_NAME]%'
  );

-- ============================================
-- AGREGACIÓN: Insertar items correctos
-- ============================================
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, VerifiedBuild)
VALUES
  ([VENDOR_ID], 0, [ITEM_ID_1], 0, 0, [EXTENDED_COST_ID_1], 0),
  ([VENDOR_ID], 0, [ITEM_ID_2], 0, 0, [EXTENDED_COST_ID_2], 0),
  -- ... más items ...
;

-- ============================================
-- VALIDACIÓN: Contar items agregados
-- ============================================
SELECT COUNT(*) as total_items FROM npc_vendor 
WHERE entry = [VENDOR_NPC_ID];
-- Resultado esperado: 60+
```

### Ciudades Objetivo

| Ciudad | Map | NPC Entry | Brackets | Items por Season |
|--------|-----|-----------|----------|------------------|
| **Gadgetzan** | 1 | ??? | TBC (S1-S4) | 60+ |
| **Area 52** | 530 | ??? | TBC (S1-S4) backup | 30-40 |
| **Dalaran** | 571 | ??? | WotLK (S5-S8) | 80+ |

### Desactivación por Expansión

```sql
-- Cuando cambia de TBC a WotLK
-- Desactivar vendors TBC (quitar flag vendor bit 128)
UPDATE creature_template
SET npcflag = (npcflag & ~128)
WHERE entry IN ([TBC_VENDOR_ENTRIES]);

-- Activar vendors WotLK (agregar flag vendor bit 128)
UPDATE creature_template
SET npcflag = (npcflag | 128)
WHERE entry IN ([WOTLK_VENDOR_ENTRIES]);
```

---

## 🎪 Arena Season Mapping

```cpp
// Relación Bracket → Arena Season (WotLK/TBC)
const std::map<uint8, uint8> BRACKET_TO_SEASON = {
    {18, 1},  // Bracket_70_2_1 → Season 1
    {19, 1},  // Bracket_70_2_2 → Season 1
    {22, 2},  // Bracket_70_3_2 → Season 2
    {23, 2},  // Bracket_70_4_1 → Season 2
    {25, 3},  // Bracket_70_5 → Season 3
    {27, 4},  // Bracket_70_6_2 → Season 4
    {32, 5},  // Bracket_80_1_2 → Season 5
    {33, 6},  // Bracket_80_2 → Season 6
    {34, 7},  // Bracket_80_3 → Season 7
    {35, 8},  // Bracket_80_4_1 → Season 8
};
```

### Vendors de Arena por Season

```sql
-- Season 1 (Jan 2007 - May 2007)
-- Rating: 1500+ para Gladiator title
-- Brackets: 18, 19 (Bracket_70_2_1, Bracket_70_2_2)
-- Vendor Entries: TBD (custom server specific)
-- Gear Prefix: Gladiator_*
-- Items per slot: ~10 piezas principales + accessories

-- Season 2 (Aug 2007 - Dec 2007)
-- Rating: 2000+ para título
-- Brackets: 22, 23 (Bracket_70_3_2, Bracket_70_4_1)
-- Vendor Entries: TBD
-- Gear Prefix: Merciless_Gladiator_*
-- Legacy: Season 1 gear cheaper (20% reduction)

-- Season 3 (Dec 2007 - Mar 2008)
-- Rating: 2000+ para título
-- Bracket: 25 (Bracket_70_5)
-- Vendor Entries: TBD
-- Gear Prefix: Vengeful_Gladiator_*
-- Legacy: S1 + S2 available at reduced prices

-- Season 4 (Mar 2008 - Nov 2008)
-- Rating: 2000+ para título
-- Bracket: 27 (Bracket_70_6_2)
-- Vendor Entries: TBD
-- Gear Prefix: Brutal_Gladiator_*
-- Overlap: Transición a WotLK

-- Season 5 (Nov 2008 - Apr 2009)
-- Rating: 2000+ para Hateful, Deadly tier
-- Bracket: 32 (Bracket_80_1_2)
-- Vendor Entries: TBD
-- Gear Prefix: Hateful_Gladiator_* / Deadly_Gladiator_*
-- Legacy: All S1-S4 available

-- Season 6 (Apr 2009 - Aug 2009)
-- Rating: 2000+ Deadly, 2200+ Glorious
-- Bracket: 33 (Bracket_80_2)
-- Vendor Entries: TBD
-- Gear Prefix: Glorious_Gladiator_*
-- Legacy: All previous seasons
-- Duration: 16 weeks (longest season)

-- Season 7 (Aug 2009 - Dec 2009)
-- Rating: 2000+ para título
-- Bracket: 34 (Bracket_80_3)
-- Vendor Entries: TBD
-- Gear Prefix: Furious_Gladiator_*
-- Legacy: All previous seasons

-- Season 8 (Dec 2009 - Nov 2010)
-- Rating: 2000+ para título
-- Bracket: 35 (Bracket_80_4_1)
-- Vendor Entries: TBD
-- Gear Prefix: Wrathful_Gladiator_*
-- Legacy: All previous seasons (final)
```

---

## 🎯 PARÁMETROS DE VALIDACIÓN

### Validación de Contenido por Bracket

```sql
-- Vanilla Validation
-- Bracket_60_1_1 (MC)
SELECT COUNT(*) as boss_count FROM creature_template 
WHERE boss_id IN (
    -- Lucifron, Magmadar, Gehennas, Garr, Shazzrah, 
    -- Baron Geddon, Golemagg, Ragnaros
)
EXPECT: 8

-- Bracket_60_2_1 (BWL)
SELECT COUNT(*) as boss_count FROM creature_template 
WHERE boss_id IN (
    -- Razorgore, Vaelastrasz, Broodlord, Firemaw,
    -- Ebonroc, Taerar, Ysondre, Victor Nefarius
)
EXPECT: 8

-- TBC Validation
-- Bracket_70_2_1 (Gruul + Mag)
SELECT COUNT(*) as boss_count FROM creature_template
WHERE boss_id IN (
    -- Gruul, Maulgar (Gruul's)
    -- Magtheridon (Mag's)
)
EXPECT: 3

-- WotLK Validation
-- Bracket_80_2 (Ulduar + Naxx + Eye + OS)
SELECT COUNT(*) as boss_count FROM creature_template
WHERE boss_id IN (
    -- Ulduar: 14 bosses
    -- Naxx80: 15 bosses
    -- Eye: 1 boss
    -- OS: 1 boss
)
EXPECT: 31 bosses total

-- Bracket_80_4_1 (ICC)
SELECT COUNT(*) as boss_count FROM creature_template
WHERE boss_id IN (
    -- ICC: 12 bosses
)
EXPECT: 12
```

### Validación de Arena Vendors

```sql
-- Verificar que season actual tiene vendors correctos
-- Season 1
SELECT COUNT(*) FROM npc_vendor 
WHERE npc_entry IN (SELECT vendor_id FROM vendor_arena_s1)
EXPECT: >= 1 vendor activo

-- Season 6 (crítico - vendor más complejo)
SELECT npc_entry, COUNT(item_entry) as item_count
FROM npc_vendor
WHERE season_id = 6
GROUP BY npc_entry
EXPECT: >= 2 vendors, 50+ items cada uno

-- Validar prices correctas
SELECT avg(price) as avg_price FROM npc_vendor
WHERE season_id = 6 AND rating_required >= 2200
EXPECT: prices > season_5 prices (10-20% increase)
```

---

## 🔄 FLUJO DE CARGA SQL

### Orden de Carga (ProgressionSystem.cpp)

```cpp
// 1. Determinar brackets habilitados
std::vector<std::string> enabledBrackets;
for (const auto& bracket : ProgressionBracketsNames) {
    if (sConfigMgr->GetOption<bool>("ProgressionSystem.Bracket_" + bracket)) {
        enabledBrackets.push_back(bracket);
    }
}

// 2. Construir paths para cada DB
// Path pattern: /modules/mod-progression-blizzlike/src/Bracket_[NAME]/sql/[DB_TYPE]

// 3. Orden de ejecución:
// 3a. Login Database updates (auth folder)
// 3b. Character Database updates (characters folder)
// 3c. World Database updates (world folder)

// 4. Aplicar actualizaciones de tablas:
// - Crear tablas si no existen
// - Ejecutar migraciones
// - Insertar datos específicos de bracket

// 5. Limpieza:
// - Si ReapplyUpdates = 1: DELETE progresion entries
// - Si DisabledAttunements configurado: DELETE acceso
```

### Secuencia de Inicialización

```
1. Config file loaded (progression_system.conf.dist)
2. Bracket array initialized (ProgressionSystem.h)
3. GetDatabaseDirectories() called for each enabled bracket
4. SQL files discovered in order:
   - auth SQL (if exists)
   - characters SQL (if exists)
   - world SQL (if exists)
5. DBUpdater processes updates
6. Disabled attunement cleanup
7. Server ready
```

---

## 📦 ESTRUCTURA DE ARCHIVOS SQL

### Directorio Layout

```
src/Bracket_70_2_1/           # Season 1 (Gruul + Mag)
├─ sql/
│  ├─ auth/                   # (Usually empty for PvE)
│  ├─ characters/             # (Optional: character progression)
│  └─ world/
│     ├─ progression_001_gruul_lair.sql
│     ├─ progression_002_magtheridon.sql
│     ├─ progression_003_season_1_vendors.sql
│     └─ progression_004_attunement_quests.sql

src/Bracket_80_2/             # Ulduar + Naxx + Eye + OS
├─ sql/
│  ├─ auth/
│  ├─ characters/
│  └─ world/
│     ├─ progression_001_naxxramas_80.sql
│     ├─ progression_002_eye_of_eternity.sql
│     ├─ progression_003_obsidian_sanctum.sql
│     ├─ progression_004_ulduar.sql
│     ├─ progression_005_season_6_vendors.sql
│     └─ progression_006_attunements.sql
```

### Naming Convention

```
progression_[NUMBER]_[DESCRIPTION].sql

Number: 001-999 (execution order)
Description: lowercase_with_underscores
Examples:
- progression_001_molten_core.sql
- progression_002_onyxia_lair.sql
- progression_010_attunement_quests.sql
- progression_100_arena_season_1_vendors.sql
- progression_200_item_fixes.sql
```

---

## ⚙️ CONFIGURACIÓN POR EXPANSIÓN

### Vanilla Configuration (Recommended)

```ini
# Enable Vanilla progression
ProgressionSystem.Bracket_60_1_1 = 1    # Molten Core
ProgressionSystem.Bracket_60_1_2 = 1    # Onyxia
ProgressionSystem.Bracket_60_2_1 = 1    # Blackwing Lair
ProgressionSystem.Bracket_60_2_2 = 0    # Zul'Gurub (optional)
ProgressionSystem.Bracket_60_3_1 = 0    # AQ20 (optional)
ProgressionSystem.Bracket_60_3_2 = 1    # AQ40

# Vanilla-specific options
ProgressionSystem.EnforceItemRestrictions = 0
ProgressionSystem.EnforceDungeonAttunement = 0
ProgressionSystem.RequireSequentialProgression = 0
```

### TBC + Arena Configuration

```ini
# Enable TBC progression with Arena
ProgressionSystem.Bracket_70_2_1 = 1    # Gruul + Mag + Arena S1
ProgressionSystem.Bracket_70_2_2 = 1    # Karazhan + Arena S1
ProgressionSystem.Bracket_70_3_1 = 1    # SSC
ProgressionSystem.Bracket_70_3_2 = 1    # The Eye + Arena S2
ProgressionSystem.Bracket_70_4_1 = 1    # Hyjal + Arena S2
ProgressionSystem.Bracket_70_4_2 = 1    # Black Temple
ProgressionSystem.Bracket_70_5 = 1      # Zul'Aman + Arena S3
ProgressionSystem.Bracket_70_6_2 = 1    # Sunwell + Arena S4

# TBC-specific options
ProgressionSystem.EnforceArenaVendorProgression = 1      # CRITICAL
ProgressionSystem.RestrictArenaRewards = 1
ProgressionSystem.EnforceDungeonAttunement = 1
ProgressionSystem.BlockFutureVendors = 1
```

### WotLK Full Configuration

```ini
# Enable full WotLK with all Arena Seasons
ProgressionSystem.Bracket_80_1_1 = 1    # Dungeons (normal)
ProgressionSystem.Bracket_80_1_2 = 1    # Dungeons (heroic) + Arena S5
ProgressionSystem.Bracket_80_2 = 1      # Ulduar/Naxx/Eye/OS + Arena S6
ProgressionSystem.Bracket_80_3 = 1      # Trial/Onyxia80 + Arena S7
ProgressionSystem.Bracket_80_4_1 = 1    # ICC + Arena S8
ProgressionSystem.Bracket_80_4_2 = 1    # Ruby Sanctum

# WotLK-specific options
ProgressionSystem.EnforceArenaVendorProgression = 1      # CRITICAL
ProgressionSystem.RestrictArenaRewards = 1
ProgressionSystem.EnforceDungeonAttunement = 0           # Optional
ProgressionSystem.BlockFutureVendors = 1
```

---

## 🎪 CASOS DE PRUEBA RECOMENDADOS

### Test Suite for Arena Seasons

```bash
# Test 1: Season 1 Vendors Visible
- Enable: Bracket_70_2_1
- Check: Gladiator vendors accessible in Orgrimmar/Stormwind
- Verify: Can purchase S1 items at correct price
- Rating: 1500+ required

# Test 2: Season Progression
- Enable: Bracket_70_2_1 + Bracket_70_3_2
- Verify: S2 vendors NOT visible in Bracket_70_2_1
- Enable: Bracket_70_3_2
- Verify: S2 vendors visible, S1 available (discounted)
- Check: S1 prices 20% lower than S2

# Test 3: WotLK Arena (Complex)
- Enable: Bracket_80_2
- Verify: S6 vendors (Glorious + Deadly)
- Check: 2200+ rating for Glorious items
- Check: 2000+ rating for Deadly items
- Legacy: S1-S5 available at correct prices

# Test 4: Item Level Validation
- Bracket_70_2_1 (S1): iLevel ~115-128
- Bracket_70_3_2 (S2): iLevel ~128-142
- Bracket_70_6_2 (S4): iLevel ~150-168
- Bracket_80_2 (S6): iLevel ~200-226
- Bracket_80_4_1 (S8): iLevel ~264-277

# Test 5: Rating Requirements
- S1: Require 1500+
- S2-S8: Require 2000+ (standard)
- S6: Allow 2200+ for Glorious tier
```

---

## 🚨 PARÁMETROS CRÍTICOS PARA DEBUGGING

### Arena Vendor Issues

```sql
-- Diagnóstico de vendors inactivos
SELECT v.entry as vendor_id, 
       COUNT(nv.item_entry) as item_count,
       v.name,
       v.npcflag
FROM npc v
LEFT JOIN npc_vendor nv ON v.entry = nv.entry
WHERE v.name LIKE '%Arena%' OR v.name LIKE '%Gladiator%'
GROUP BY v.entry
ORDER BY v.entry;

-- Si item_count = 0: Vendor existe pero sin items
-- Si npcflag != 128 (VENDOR): Vendor no es NPC vendor

-- Verificar item existencia
SELECT item_entry, display_id, name, item_level
FROM item_template
WHERE name LIKE '%Gladiator%'
ORDER BY item_level DESC;

-- Si no hay resultados: Items no creados en DB
```

### Bracket Load Verification

```sql
-- Verificar qué brackets están activos en config
SELECT config_key, config_value
FROM config
WHERE config_key LIKE 'ProgressionSystem.Bracket_%'
  AND config_value = '1'
ORDER BY config_key;

-- Contar bosses por bracket cargado
SELECT COUNT(DISTINCT boss_id) as boss_count,
       'Molten Core' as bracket_name
FROM creature_template
WHERE encounter_guid LIKE '%MC%'
EXPECT: 8 bosses;

-- Verificar attunement quests
SELECT entry as quest_id, title
FROM quest_template
WHERE title LIKE '%Attunement%' OR title LIKE '%Key%'
ORDER BY entry;
```

### PvP Configuration Issues

```sql
-- Verificar season configuration
SELECT * FROM arena_season_config
WHERE season_id >= 1 AND season_id <= 8
ORDER BY season_id;

-- Columns esperadas:
-- season_id, rating_min, rating_max, item_level, vendor_ids, start_date, end_date

-- Validar precio escalado
SELECT season_id, item_entry, cost, cost/previous_season_cost as multiplier
FROM arena_vendor_items
WHERE season_id IN (1,2,3,4,5,6,7,8)
ORDER BY season_id, item_entry;

-- Expected multiplier: 1.0-1.2 (precios suben 0-20%)
```

---

## 📊 MATRIZ DE DECISIONES

### Cuando Habilitar Brackets

| Decisión | Bracket | Condición | Acción |
|----------|---------|-----------|--------|
| Habilitar MC | Bracket_60_1_1 | Vanilla ready | = 1 |
| Habilitar Raids Opcionales | Bracket_60_2_2, 60_3_1 | Solo si community quiere | = 0 \| 1 |
| Habilitar TBC | Bracket_70_1_1+ | Post-Vanilla complete | = 1 |
| Habilitar Arena S1 | Bracket_70_2_1, 70_2_2 | Con TBC content | = 1 |
| Habilitar WotLK | Bracket_80_1_1+ | Post-TBC complete | = 1 |
| Restricción Arena | EnforceArenaVendorProgression | Siempre con Arena | = 1 |

### Cuando Dividir Bracket_80_2

| Criterio | Mantener | Dividir |
|----------|----------|---------|
| Duration < 8 weeks | ✓ | ✗ |
| 4+ raid instances | ✗ | ✓ |
| Community size > 100 | ✗ | ✓ |
| New player friendly | ✓ | ✗ |
| Hardcore progression | ✗ | ✓ |

---

**Documento técnico de referencia**  
**Versión**: 1.0  
**Actualizado**: Dec 24, 2025  
**Mantener sincronizado con**: ANALISIS_COMPLETO_BRACKETS_SEASONS.md
