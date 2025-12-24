# Guía de Uso - Configuración Actualizada

**Fecha**: 24 de Diciembre de 2025  
**Archivo**: `conf/progression_system.conf.dist`  
**Versión**: v2.0 (Con Descripciones Detalladas)

---

## 📖 Introducción

El archivo `conf/progression_system.conf.dist` ha sido actualizado con descripciones detalladas para todos los 38 brackets del sistema de progresión. Esta guía explica cómo usar este archivo para configurar la progresión del servidor.

---

## 🎮 Estructura Básica

Cada bracket en el archivo sigue este formato:

```
ProgressionSystem.Bracket_NAME = [0 o 1]
# Level XX | Expansion: Tier | Content Name (Format)
# Bosses (N): Boss1, Boss2, Boss3...
# Location: Instance Location
# Features: Key gameplay features and mechanics
# Release: Historical release date
```

### Explicación de Líneas

| Línea | Significado | Ejemplo |
|-------|------------|---------|
| `ProgressionSystem.Bracket_NAME` | Identificador del bracket | `ProgressionSystem.Bracket_60_1_1` |
| `= 0` | Estado: DESACTIVADO | No se carga en el servidor |
| `= 1` | Estado: ACTIVADO | Se carga en el servidor |
| `# Level XX` | Rango de nivel | Level 60, Levels 10-19 |
| `\| Expansion` | Qué expansión es | Vanilla, TBC, WotLK |
| `\| Tier` | Nivel de dificultad | Raid Tier 1, Normal Dungeons |
| `# Bosses (N)` | Número y nombres de bosses | Bosses (8): Lucifron, Magmadar... |
| `# Location` | Dónde está la instancia | Blackrock Mountain |
| `# Features` | Características especiales | Fire resistance mechanics |
| `# Release` | Fecha histórica de lanzamiento | November 23, 2004 |

---

## 🔧 Activar/Desactivar Brackets

### Para ACTIVAR un Bracket
Cambiar el `0` por `1`:

```
ProgressionSystem.Bracket_60_1_1 = 1    # ← Cambiar aquí de 0 a 1
```

### Para DESACTIVAR un Bracket
Cambiar el `1` por `0`:

```
ProgressionSystem.Bracket_60_1_1 = 0    # ← Cambiar aquí de 1 a 0
```

---

## 📋 Ejemplos de Configuraciones

### Ejemplo 1: Vanilla-Only Server

```powershell
# ENABLE: All Vanilla content (Levels 1-60)
ProgressionSystem.Bracket_0       = 1
ProgressionSystem.Bracket_1_19    = 1
ProgressionSystem.Bracket_20_29   = 1
ProgressionSystem.Bracket_30_39   = 1
ProgressionSystem.Bracket_40_49   = 1
ProgressionSystem.Bracket_50_59_1 = 1
ProgressionSystem.Bracket_50_59_2 = 1

# ENABLE: All Vanilla Raids
ProgressionSystem.Bracket_60_1_1  = 1    # Molten Core
ProgressionSystem.Bracket_60_1_2  = 1    # Onyxia
ProgressionSystem.Bracket_60_2_1  = 1    # Blackwing Lair
ProgressionSystem.Bracket_60_2_2  = 1    # Zul'Gurub
ProgressionSystem.Bracket_60_3_1  = 1    # AQ20
ProgressionSystem.Bracket_60_3_2  = 1    # AQ40
ProgressionSystem.Bracket_60_3_3  = 1    # AQ Post-Content

# DISABLE: TBC and WotLK
ProgressionSystem.Bracket_61_64   = 0
ProgressionSystem.Bracket_65_69   = 0
ProgressionSystem.Bracket_70_*    = 0    # All TBC level 70
ProgressionSystem.Bracket_71_74   = 0
ProgressionSystem.Bracket_75_79   = 0
ProgressionSystem.Bracket_80_*    = 0    # All WotLK level 80
```

---

### Ejemplo 2: TBC-Only Server

```powershell
# DISABLE: Vanilla content
ProgressionSystem.Bracket_0       = 0
ProgressionSystem.Bracket_1_19    = 0
...
ProgressionSystem.Bracket_60_*    = 0

# ENABLE: TBC Dungeons and Raids
ProgressionSystem.Bracket_61_64   = 1
ProgressionSystem.Bracket_65_69   = 1
ProgressionSystem.Bracket_70_1_1  = 1    # Normal Dungeons
ProgressionSystem.Bracket_70_1_2  = 1    # Heroic Dungeons
ProgressionSystem.Bracket_70_2_1  = 1    # Gruul/Mag + Arena Season 1
ProgressionSystem.Bracket_70_2_2  = 1    # Karazhan
ProgressionSystem.Bracket_70_3_1  = 1    # SSC
ProgressionSystem.Bracket_70_3_2  = 1    # The Eye
ProgressionSystem.Bracket_70_4_1  = 1    # Hyjal + Arena Season 2
ProgressionSystem.Bracket_70_4_2  = 1    # Black Temple
ProgressionSystem.Bracket_70_5    = 1    # Zul'Aman + Arena Season 3
ProgressionSystem.Bracket_70_6_1  = 1    # Isle of Quel'Danas
ProgressionSystem.Bracket_70_6_2  = 1    # Sunwell + Arena Season 4
ProgressionSystem.Bracket_70_6_3  = 1    # TBC Final Phase

# DISABLE: WotLK content
ProgressionSystem.Bracket_71_74   = 0
ProgressionSystem.Bracket_75_79   = 0
ProgressionSystem.Bracket_80_*    = 0
```

---

### Ejemplo 3: Progresión Gradual Vanilla (Recomendado)

```powershell
# Week 1-2: Leveling zones only
ProgressionSystem.Bracket_0       = 1
ProgressionSystem.Bracket_1_19    = 1
ProgressionSystem.Bracket_20_29   = 0    # ← Habilitar en Week 2
ProgressionSystem.Bracket_30_39   = 0    # ← Habilitar en Week 3
ProgressionSystem.Bracket_40_49   = 0    # ← Habilitar en Week 4
ProgressionSystem.Bracket_50_59_1 = 0    # ← Habilitar en Week 5
ProgressionSystem.Bracket_50_59_2 = 0    # ← Habilitar en Week 6

# Week 8: First raid - Molten Core
ProgressionSystem.Bracket_60_1_1  = 0    # ← Habilitar en Week 8
ProgressionSystem.Bracket_60_1_2  = 0    # ← Habilitar en Week 10 (Onyxia)

# Week 12: Tier 2 raids
ProgressionSystem.Bracket_60_2_1  = 0    # ← Habilitar en Week 12 (BWL)
ProgressionSystem.Bracket_60_2_2  = 0    # ← Habilitar en Week 14 (ZG)

# Week 16: Tier 3 raids
ProgressionSystem.Bracket_60_3_1  = 0    # ← Habilitar en Week 16 (AQ20)
ProgressionSystem.Bracket_60_3_2  = 0    # ← Habilitar en Week 18 (AQ40)
ProgressionSystem.Bracket_60_3_3  = 0    # ← Habilitar en Week 20 (Post-AQ)
```

---

### Ejemplo 4: Progresión Gradual TBC (Recomendado)

```powershell
# Week 1: Outland opening
ProgressionSystem.Bracket_61_64   = 1
ProgressionSystem.Bracket_65_69   = 1

# Week 2: Level 70 Dungeons
ProgressionSystem.Bracket_70_1_1  = 1    # Normal Dungeons
ProgressionSystem.Bracket_70_1_2  = 0    # ← Habilitar en Week 3 (Heroic)

# Week 3: Tier 1 Raids + Arena Season 1
ProgressionSystem.Bracket_70_2_1  = 0    # ← Habilitar en Week 3 (Gruul/Mag)
ProgressionSystem.Bracket_70_2_2  = 0    # ← Habilitar en Week 4 (Karazhan)

# Week 8: Tier 2 Raids
ProgressionSystem.Bracket_70_3_1  = 0    # ← Habilitar en Week 8 (SSC)
ProgressionSystem.Bracket_70_3_2  = 0    # ← Habilitar en Week 10 (The Eye)

# Week 15: Tier 3 Raids + Arena Season 2
ProgressionSystem.Bracket_70_4_1  = 0    # ← Habilitar en Week 15 (Hyjal)
ProgressionSystem.Bracket_70_4_2  = 0    # ← Habilitar en Week 17 (Black Temple)

# Week 22: Tier 2.5 (10-man) + Arena Season 3
ProgressionSystem.Bracket_70_5    = 0    # ← Habilitar en Week 22 (Zul'Aman)

# Week 28: Tier 5 (Final) + Arena Season 4
ProgressionSystem.Bracket_70_6_1  = 0    # ← Habilitar en Week 26 (Isle of Quel'Danas)
ProgressionSystem.Bracket_70_6_2  = 0    # ← Habilitar en Week 28 (Sunwell)
ProgressionSystem.Bracket_70_6_3  = 0    # ← Habilitar en Week 32 (Final Phase)
```

---

### Ejemplo 5: Progresión Gradual WotLK

```powershell
# Week 1: Northrend opening
ProgressionSystem.Bracket_71_74   = 1
ProgressionSystem.Bracket_75_79   = 1

# Week 2: Level 80 Dungeons
ProgressionSystem.Bracket_80_1_1  = 1    # Normal Dungeons
ProgressionSystem.Bracket_80_1_2  = 0    # ← Habilitar en Week 3 (Heroic + Arena S5)

# Week 4: Tier 1 Raids + Arena Season 6
ProgressionSystem.Bracket_80_2    = 0    # ← Habilitar en Week 4 (Naxx/Eye/OS)
                                         # ← Ulduar en Week 16

# Week 18: Tier 2 Raids + Arena Season 7
ProgressionSystem.Bracket_80_3    = 0    # ← Habilitar en Week 18 (Trial/Onyxia)

# Week 26: Tier 3 (Final) + Arena Season 8
ProgressionSystem.Bracket_80_4_1  = 0    # ← Habilitar en Week 26 (ICC)

# Week 32: Post-Expansion
ProgressionSystem.Bracket_80_4_2  = 0    # ← Habilitar en Week 32 (Ruby Sanctum)
```

---

## 🎯 Entender la Información de Cada Bracket

### Vanill Raid Tiers

**Tier 1 (Week 1)**
- Bracket_60_1_1: Molten Core (8 bosses)
- Bracket_60_1_2: Onyxia's Lair (1 boss)

**Tier 2 (Week 8+)**
- Bracket_60_2_1: Blackwing Lair (8 bosses)
- Bracket_60_2_2: Zul'Gurub (6+ bosses)

**Tier 3 (Week 14+)**
- Bracket_60_3_1: AQ20 (3+ bosses)
- Bracket_60_3_2: AQ40 (9+ bosses)

### TBC Raid Tiers

| Semana | Tier | Bracket | Raid | Bosses |
|--------|------|---------|------|--------|
| 3 | Tier 1 | 70_2_1 | Gruul/Mag | 3 |
| 4 | Tier 1 | 70_2_2 | Karazhan | 11 |
| 8 | Tier 2 | 70_3_1 | SSC | 6 |
| 10 | Tier 2 | 70_3_2 | The Eye | 4 |
| 15 | Tier 3 | 70_4_1 | Hyjal | 5 |
| 17 | Tier 4 | 70_4_2 | Black Temple | 9 |
| 22 | Tier 2.5 | 70_5 | Zul'Aman | 6 |
| 28 | Tier 5 | 70_6_2 | Sunwell | 6 |

### WotLK Raid Tiers

| Semana | Tier | Bracket | Raid | Bosses |
|--------|------|---------|------|--------|
| 4 | Tier 1 | 80_2 | Naxx/Eye/OS | 34 |
| 16 | Tier 1 | 80_2 | Ulduar | 14 |
| 18 | Tier 2 | 80_3 | Trial/Onyxia | 6 |
| 26 | Tier 3 | 80_4_1 | ICC | 12 |
| 32 | Post | 80_4_2 | Ruby Sanctum | 4 |

---

## 💡 Recomendaciones

### Para Servidores Nuevos
1. Habilitar Vanilla completamente primero
2. Planificar transición a TBC en semana 20-24
3. Planificar transición a WotLK en semana 40-48

### Para Servidores de Progresión
1. Habilitar contenido semana a semana
2. Dejar ~2-3 semanas para cada tier
3. Monitorear actividad de jugadores

### Para Servidores Custom
1. Usar la información de bosses para crear custom raids
2. Adaptar las mecánicas según balance
3. Mantener notas de cambios en comentarios

---

## 📚 Dónde Encontrar Información Adicional

- **Boss Details**: Ver `BRACKET_DESCRIPTIONS_COMPLETE.md`
- **SQL Files**: Buscar en `src/Bracket_XX/sql/`
- **C++ Loaders**: Ver en `src/Bracket_XX/*_loader.cpp`
- **Arena Info**: Buscar "Arena Season" en config
- **Attunements**: Ver `ProgressionSystem.DisabledAttunements`

---

## ✅ Checklist de Configuración

Antes de iniciar el servidor:

```
☐ Revisar archivo conf/progression_system.conf.dist
☐ Habilitar brackets deseados (cambiar 0 a 1)
☐ Deshabilitar brackets no deseados (cambiar 1 a 0)
☐ Guardar los cambios
☐ Verificar sintaxis (no hay errores en carga)
☐ Revisar logs de SQL (databases aplicadas correctamente)
☐ Probar en-game un bracket habilitado
☐ Confirmar bosses aparecen correctamente
☐ Validar arena si está habilitada
```

---

## 🆘 Troubleshooting

### Problema: Bracket habilitado pero contenido no aparece

**Solución:**
1. Verificar que `= 1` está configurado
2. Revisar SQL en `src/Bracket_XX/sql/`
3. Comprobar logs para errores de SQL
4. Reiniciar servidor

### Problema: Boss nombres incorrectos o faltando

**Solución:**
1. Revisar descripción en config para nombres correctos
2. Comparar con `BRACKET_DESCRIPTIONS_COMPLETE.md`
3. Validar SQL de criaturas
4. Comprobar creature_template en database

### Problema: Arena Seasons no funcionando

**Solución:**
1. Verificar bracket contiene Arena Season
2. Revisar configuración de vendors
3. Comprobar items del season en database
4. Validar rating requirements

---

## 📞 Support

Para más información:
1. Consultar documentación completa
2. Revisar BRACKET_DESCRIPTIONS_COMPLETE.md
3. Verificar SQL files en src/
4. Consultar logs de error

---

**Última Actualización**: 24 de Diciembre de 2025  
**Versión**: v2.0  
**Status**: Production Ready ✅

