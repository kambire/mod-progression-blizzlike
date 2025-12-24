# 🎮 Progression System Module - AzerothCore

**Control total de progresión del servidor WoW - 38 brackets, 3 expansiones, 8 arena seasons**

[![License](https://img.shields.io/badge/license-GPL%203.0-blue.svg)](LICENSE)
[![AzerothCore](https://img.shields.io/badge/AzerothCore-3.3.5a-brightgreen.svg)](https://www.azerothcore.org/)
[![C++](https://img.shields.io/badge/C%2B%2B-17-green.svg)]()
[![SQL](https://img.shields.io/badge/Database-MySQL-orange.svg)]()

---

## 📋 Descripción General

Sistema modular de progresión para AzerothCore que permite liberar contenido de forma gradual, replicando exactamente el timeline de expansiones de World of Warcraft de **Noviembre 2004 a Junio 2010**.

**Características**:
- ✅ 38 brackets independientes (Vanilla, TBC, WotLK)
- ✅ 8 Arena Seasons integradas (S1-S8)
- ✅ Control granular de vendors por season
- ✅ Bloqueo automático de contenido futuro
- ✅ Carga de SQL y scripts dinámicos por bracket
- ✅ Sistema de configuración centralizado

---

## 🎯 Características Principales

### 1. Control Total de Vendors por Bracket
Sistema automático que asegura que jugadores solo vean items de su season actual:
- **TBC (S1-S4)**: Vendors en Gadgetzan (Tanaris)
- **WotLK (S5-S8)**: Vendors en Dalaran (Northrend)
- Precios ajustados por antigüedad (items viejos = más baratos)
- Desactivación automática de vendors al cambiar expansión

### 2. Bloqueadores de Contenido
- Restricción automática de acceso a dungeons/raids del futuro
- Validación de nivel y atunement por bracket
- Prevención de compra de items no autorizados
- Sistema de restricción de recompensas PvP

### 3. Configuración Flexible
```ini
# Activar/desactivar brackets por nombre
ProgressionSystem.Bracket_70_2_1 = 1           # Arena S1 activo
ProgressionSystem.Bracket_80_4_1 = 0           # Arena S8 desactivado

# Parámetros de control
ProgressionSystem.BlockFutureVendors = 1        # Bloquear vendors futuras
ProgressionSystem.EnforceItemRestrictions = 1   # Restringir items
ProgressionSystem.EnforceArenaVendorProgression = 1  # Control de arena
ProgressionSystem.RestrictArenaRewards = 1      # Restringir recompensas
```

---

## 📦 Estructura del Proyecto

```
mod-progression-system/
├── conf/
│   ├── progression_system.conf.dist       # Config principal
│   └── conf.sh.dist                       # Template bash
├── src/
│   ├── ProgressionSystem.h                # Estructura C++
│   ├── ProgressionSystem.cpp              # Implementación
│   ├── cs_progression_module.cpp          # Módulo de carga
│   ├── ProgressionSystem_loader.cpp       # Loader dinámico
│   └── Bracket_*/
│       ├── Bracket_*_loader.cpp           # Scripts de bracket
│       └── sql/
│           ├── world/                     # Cambios del mundo
│           ├── characters/                # Cambios de personajes
│           └── auth/                      # Cambios de autenticación
├── scripts/
│   └── local_release.ps1                  # Deploy script
└── README.md                              # Este archivo
```

---

## 🚀 Instalación Rápida

### 1. Clonar el módulo
```bash
cd ~/azerothcore-wotlk/modules
git clone https://github.com/tu-usuario/mod-progression-system.git
```

### 2. Configurar brackets
```bash
cd mod-progression-system/conf
cp progression_system.conf.dist progression_system.conf
# Editar progression_system.conf y activar brackets deseados
```

### 3. Compilar AzerothCore
```bash
cd ~/azerothcore-wotlk
./acore.sh client install
# Compilación automática incluye el módulo
```

### 4. Ejecutar actualización de BD
```sql
-- Los scripts SQL se cargan automáticamente
-- Cada bracket activo carga: world, characters, auth
```

### 5. Iniciar servidor y verificar
```bash
# En consola del servidor
.server info
# Debe mostrar módulos cargados
```

---

## 📊 Brackets Disponibles (38 Total)

### Vanilla (14 brackets - Nov 2004 a Jan 2005)
| Bracket | Nivel | Contenido | Fecha Release |
|---------|-------|-----------|---------------|
| **Bracket_0** | 1-10 | Zonas iniciales | Nov 23, 2004 |
| **Bracket_1_19** | 11-19 | Dungeons tempranos | Nov 23, 2004 |
| **Bracket_20_29** | 20-29 | Dungeons medianos | Nov 23, 2004 |
| **Bracket_30_39** | 30-39 | Dungeons avanzados | Nov 23, 2004 |
| **Bracket_40_49** | 40-49 | World dungeons | Nov 23, 2004 |
| **Bracket_50_59_1** | 50-59 | UBRS Attunement | Nov 23, 2004 |
| **Bracket_50_59_2** | 50-59 | Upper Blackrock | Nov 23, 2004 |
| **Bracket_60_1_1** | 60 | Molten Core | Nov 23, 2004 |
| **Bracket_60_1_2** | 60 | Onyxia | Nov 23, 2004 |
| **Bracket_60_2_1** | 60 | Blackwing Lair | Jan 19, 2005 |
| **Bracket_60_2_2** | 60 | Zul'Gurub | Jan 19, 2005 |
| **Bracket_60_3_1** | 60 | Ruins AQ | Jan 19, 2005 |
| **Bracket_60_3_2** | 60 | Temple AQ | Jan 19, 2005 |
| **Bracket_60_3_3** | 60 | AQ Final Phase | Jan 19, 2005 |

### The Burning Crusade (15 brackets - Jan 2007 a May 2008) + Arena S1-S4
| Bracket | Nivel | Arena | Contenido | Fecha |
|---------|-------|-------|-----------|-------|
| **Bracket_61_64** | 61-64 | - | Outland Intro | Jan 16, 2007 |
| **Bracket_65_69** | 65-69 | - | Mid-Level | Jan 16, 2007 |
| **Bracket_70_1_1** | 70 | - | Dungeons | Jan 16, 2007 |
| **Bracket_70_1_2** | 70 | - | Heroic Dungeons | Jan 16, 2007 |
| **Bracket_70_2_1** | 70 | **S1** | Gruul's/Magtheridon | Jan 16, 2007 |
| **Bracket_70_2_2** | 70 | **S2** | Karazhan | May 15, 2007 |
| **Bracket_70_3_1** | 70 | - | SSC Intro | May 15, 2007 |
| **Bracket_70_3_2** | 70 | **S2** | The Eye | May 15, 2007 |
| **Bracket_70_4_1** | 70 | - | Mount Hyjal | Aug 24, 2007 |
| **Bracket_70_4_2** | 70 | - | Black Temple | Sep 24, 2007 |
| **Bracket_70_5** | 70 | **S3** | Zul'Aman | Dec 11, 2007 |
| **Bracket_70_6_1** | 70 | - | Île Quel'Danas | May 22, 2008 |
| **Bracket_70_6_2** | 70 | **S4** | Sunwell Plateau | May 22, 2008 |
| **Bracket_70_6_3** | 70 | - | TBC Final | May 22, 2008 |

### Wrath of the Lich King (9 brackets - Nov 2008 a Jun 2010) + Arena S5-S8
| Bracket | Nivel | Arena | Contenido | Fecha |
|---------|-------|-------|-----------|-------|
| **Bracket_71_74** | 71-74 | - | Northrend Intro | Nov 13, 2008 |
| **Bracket_75_79** | 75-79 | - | Mid-Level | Nov 13, 2008 |
| **Bracket_80_1_1** | 80 | - | Dungeons | Nov 13, 2008 |
| **Bracket_80_1_2** | 80 | **S5** | Naxxramas 80 | Nov 13, 2008 |
| **Bracket_80_2** | 80 | **S6** | Ulduar | Mar 17, 2009 |
| **Bracket_80_3** | 80 | **S7** | Trial/Coliseum | Aug 4, 2009 |
| **Bracket_80_4_1** | 80 | **S8** | Icecrown Citadel | Dec 8, 2009 |
| **Bracket_80_4_2** | 80 | - | ICC Post-Heroic | Dec 8, 2009 |
| **Bracket_Custom** | - | - | Contenido personalizado | - |

---

## 🎮 Arena Seasons - Detalles Completos

### Season 1-4 (TBC) - Vendor: Gadgetzan
| Season | Bracket | Período | Calificación | Gear | Precio |
|--------|---------|---------|--------------|------|--------|
| **S1** | 70_2_1 | Abr 2007-May 2007 | 1500+ | Gladiator | 150,000g |
| **S2** | 70_2_2 | May 2007-Ago 2007 | 1500+ | Gladiator S2 | 200,000g |
| **S3** | 70_5_1 | Ago 2007-Nov 2007 | 1500+ | Hateful | 200,000g |
| **S4** | 70_6_2 | Nov 2007-Feb 2008 | 1500+ | Brutal | 200,000g |

### Season 5-8 (WotLK) - Vendor: Dalaran
| Season | Bracket | Período | Calificación | Gear | Precio |
|--------|---------|---------|--------------|------|--------|
| **S5** | 80_1_2 | Nov 2008-Mar 2009 | 2000+ | Wrathful (Early) | 250,000g |
| **S6** | 80_2 | Mar 2009-Jun 2009 | 2000+ | Wrathful/Glorious | 250,000g |
| **S7** | 80_3 | Jun 2009-Ago 2009 | 2000+ | Vindictive | 300,000g |
| **S8** | 80_4_1 | Sep 2009-Jun 2010 | 2000+ | Relentless | 300,000g |

---

## ⚙️ Configuración Detallada

### Parámetros Principales

```ini
# BLOQUEO DE CONTENIDO FUTURO
ProgressionSystem.BlockFutureVendors = 1
# Evita que jugadores accedan a vendors de temporadas futuras

ProgressionSystem.EnforceItemRestrictions = 1
# Restringe items no autorizados en el bracket actual

ProgressionSystem.EnforceArenaVendorProgression = 1
# Progresión controlada de arena seasons

ProgressionSystem.RestrictArenaRewards = 1
# Restringe recompensas de arena según bracket

# DESACTIVACIÓN Y LIMPIEZA
ProgressionSystem.AutoCleanVendorsOnBracketChange = 1
# Limpia vendors automáticamente al cambiar bracket

ProgressionSystem.LegacyItemDiscount = 30
# Descuento en porcentaje para items antiguos (30% = 70% del precio)
```

### Habilitar Brackets por Nombre

```ini
# VANILLA
ProgressionSystem.Bracket_0 = 1
ProgressionSystem.Bracket_1_19 = 1
# ... etc para todos los brackets

# TBC CON ARENAS
ProgressionSystem.Bracket_70_2_1 = 1  # Arena S1
ProgressionSystem.Bracket_70_2_2 = 1  # Arena S2
ProgressionSystem.Bracket_70_5 = 1    # Arena S3
ProgressionSystem.Bracket_70_6_2 = 1  # Arena S4

# WOTLK CON ARENAS
ProgressionSystem.Bracket_80_1_2 = 1  # Arena S5
ProgressionSystem.Bracket_80_2 = 1    # Arena S6
ProgressionSystem.Bracket_80_3 = 1    # Arena S7
ProgressionSystem.Bracket_80_4_1 = 1  # Arena S8
```

---

## 🛠️ FASE 0 - Control Total de Vendors

### El Problema Resuelto
```
❌ ANTES: Jugadores de TBC S1 ven items de WotLK S8
✅ DESPUÉS: Cada bracket solo ve sus items correctos
```

### Solución: Patrón DELETE + INSERT
```sql
-- 1. LIMPIAR - Borrar items no válidos
DELETE FROM npc_vendor 
WHERE entry = [VENDOR_ID] 
  AND item_template NOT IN ([VALID_ITEMS_FOR_THIS_SEASON]);

-- 2. AGREGAR - Insertar items correctos con precios
INSERT INTO npc_vendor (entry, item_template, price_1)
VALUES ([VENDOR_ID], [ITEM_ID], [PRICE]);

-- 3. VALIDAR - Verificar que funcionó
SELECT COUNT(*) FROM npc_vendor WHERE entry = [VENDOR_ID];
```

### Estructura de Scripts SQL

```
src/Bracket_70_2_1/sql/world/
└─ vendors_cleanup_s1.sql          # Arena S1 - Solo S1 items (60)

src/Bracket_70_2_2/sql/world/
└─ vendors_cleanup_s2.sql          # Arena S2 - S1+S2 items (120)

src/Bracket_70_5/sql/world/
└─ vendors_cleanup_s3.sql          # Arena S3 - S1+S2+S3 items (180)

src/Bracket_70_6_2/sql/world/
└─ vendors_cleanup_s4.sql          # Arena S4 - S1-S4 items (240)

src/Bracket_80_1_2/sql/world/
├─ vendors_transition.sql           # Transición TBC→WotLK
└─ vendors_cleanup_s5.sql          # Arena S5 - Limpio, solo S5 (60)

src/Bracket_80_2/sql/world/
└─ vendors_cleanup_s6.sql          # Arena S6 - S5+S6 items (120)

src/Bracket_80_3/sql/world/
└─ vendors_cleanup_s7.sql          # Arena S7 - S5-S7 items (180)

src/Bracket_80_4_1/sql/world/
└─ vendors_cleanup_s8.sql          # Arena S8 - S5-S8 items (240)
```

### Tabla de Precios por Season

| Season | Bracket | Nuevos | Legacy S1 | Legacy S2-N1 | Legacy S2+ |
|--------|---------|--------|-----------|-------------|-----------|
| **S1** | 70_2_1 | 150k | - | - | - |
| **S2** | 70_2_2 | 200k | 100k | - | - |
| **S3** | 70_5_1 | 200k | 100k | 100k | - |
| **S4** | 70_6_2 | 200k | 100k | 100k | 100k |
| **S5** | 80_1_2 | 250k | - | - | - |
| **S6** | 80_2 | 250k | - | - | 150k |
| **S7** | 80_3 | 300k | - | - | 150k |
| **S8** | 80_4_1 | 300k | - | - | 150k |

### Configuración Obligatoria para FASE 0

```ini
# ESTOS 4 PARÁMETROS DEBEN ESTAR EN 1
ProgressionSystem.BlockFutureVendors = 1
ProgressionSystem.EnforceItemRestrictions = 1
ProgressionSystem.EnforceArenaVendorProgression = 1
ProgressionSystem.RestrictArenaRewards = 1
```

---

## 📖 Implementación Paso a Paso

### Paso 1: Identificar Vendor IDs en tu BD

```sql
-- Encontrar vendor en Gadgetzan (TBC S1-S4)
SELECT entry, name FROM creature WHERE map=1 AND name LIKE '%vendor%';

-- Encontrar vendor en Area 52 (TBC backup)
SELECT entry, name FROM creature WHERE map=530 AND name LIKE '%vendor%';

-- Encontrar vendor en Dalaran (WotLK S5-S8)
SELECT entry, name FROM creature WHERE map=571 AND name LIKE '%vendor%';
```

### Paso 2: Mapear Items por Season

```sql
-- Items S1-S2
SELECT entry, name FROM item_template WHERE name LIKE '%Gladiator%' ORDER BY entry;

-- Items S3
SELECT entry, name FROM item_template WHERE name LIKE '%Hateful%' ORDER BY entry;

-- Items S4
SELECT entry, name FROM item_template WHERE name LIKE '%Brutal%' ORDER BY entry;

-- Items S5-S6
SELECT entry, name FROM item_template WHERE name LIKE '%Wrathful%' ORDER BY entry;

-- Items S7
SELECT entry, name FROM item_template WHERE name LIKE '%Vindictive%' ORDER BY entry;

-- Items S8
SELECT entry, name FROM item_template WHERE name LIKE '%Relentless%' ORDER BY entry;
```

### Paso 3: Crear Scripts SQL

**Template para cada bracket:**

```sql
-- Archivo: src/Bracket_70_2_1/sql/world/vendors_cleanup_s1.sql
-- =====================================================
-- ARENA SEASON 1 - CLEANUP & ADD
-- Bracket: 70_2_1 (TBC S1)
-- =====================================================

-- LIMPIAR: Borrar todo excepto items válidos
DELETE FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID] 
  AND item_template NOT IN (
    [S1_ITEM_1], [S1_ITEM_2], ... [S1_ITEM_60]
  );

-- AGREGAR: Insertar items S1 con precios
INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  ([GADGETZAN_VENDOR_ID], [S1_ITEM_1], 0, 0, 0, 150000),
  ([GADGETZAN_VENDOR_ID], [S1_ITEM_2], 0, 0, 0, 150000),
  -- ... 60 items total ...
;

-- VALIDAR
SELECT COUNT(*) as s1_items FROM npc_vendor 
WHERE entry = [GADGETZAN_VENDOR_ID];
-- Resultado esperado: 60
```

### Paso 4: Ejecutar en Servidor

```bash
# 1. Copiar archivos SQL a carpetas correctas
cp vendors_cleanup_s1.sql ~/azerothcore-wotlk/data/sql/updates/...

# 2. Recargar scripts en servidor
.server info  # Verifica que el módulo está cargado
.reload scripts

# 3. Ejecutar SQL scripts
mysql world < vendors_cleanup_s1.sql
```

### Paso 5: Validar en Juego

```
Bracket_70_2_1 (TBC S1):
[ ] Vendor visible en Gadgetzan
[ ] Solo items de S1 disponibles
[ ] Precio ~150,000 gold

Bracket_70_2_2 (TBC S2):
[ ] Vendor visible en Gadgetzan
[ ] Items de S1 (100k) y S2 (200k) disponibles
[ ] Total ~120 items

Bracket_80_1_2 (WotLK S5):
[ ] Gadgetzan vendor desaparecido
[ ] Nuevo vendor en Dalaran
[ ] Solo items de S5 disponibles
[ ] Precio ~250,000 gold
```

---

## 🔧 Troubleshooting

### Vendor no visible
```sql
-- Verificar que el vendor esté activo
SELECT entry, name, enabled FROM creature WHERE entry = [VENDOR_ID];

-- Activar si está desactivado
UPDATE creature SET enabled = 1 WHERE entry = [VENDOR_ID];
```

### Items incorrectos mostrando
```sql
-- Verificar qué items tiene el vendor
SELECT nv.entry, nv.item_template, it.name, nv.price_1
FROM npc_vendor nv
INNER JOIN item_template it ON nv.item_template = it.entry
WHERE nv.entry = [VENDOR_ID]
ORDER BY nv.item_template;

-- Ejecutar limpieza manualmente
DELETE FROM npc_vendor WHERE entry = [VENDOR_ID];
```

### Precios incorrectos
```sql
-- Verificar precios
SELECT nv.entry, nv.item_template, nv.price_1 
FROM npc_vendor nv
WHERE nv.entry = [VENDOR_ID];

-- Actualizar precios
UPDATE npc_vendor SET price_1 = [CORRECT_PRICE] 
WHERE entry = [VENDOR_ID] AND item_template = [ITEM_ID];
```

---

## 📚 Documentación Adicional

- **BRACKET_DESCRIPTIONS_COMPLETE.md** - Descripción detallada de cada uno de los 38 brackets
- **ARENA_SEASONS_VALIDATION.md** - Mapeo completo de 8 Arena Seasons
- **PARAMETROS_TECNICOS_DESARROLLO.md** - Parámetros técnicos y validaciones SQL

---

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu rama de features (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto está bajo licencia GPL 3.0. Ver archivo [LICENSE](LICENSE) para más detalles.

---

## 💬 Soporte

- **AzerothCore Discord**: [Unirse al servidor](https://discord.gg/azerothcore)
- **Documentación**: Consultar archivos .md en la raíz del proyecto
- **Issues**: Reportar problemas en GitHub Issues

---

## 📊 Estado del Proyecto

- ✅ Análisis completo de 38 brackets
- ✅ Documentación de 8 Arena Seasons
- ✅ Sistema de control de vendors (FASE 0)
- ✅ Validación de configuración
- 🟡 Implementación de scripts SQL
- ⏳ Testing completo en producción

---

**Última actualización**: 2025-01-09  
**Versión**: 1.0  
**Compatibilidad**: AzerothCore 3.3.5a

```
Creado con ❤️ para la comunidad de AzerothCore
```
