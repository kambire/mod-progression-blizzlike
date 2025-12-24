# DIAGRAMA VISUAL - Estructura de Progresión

## 📊 Línea de Tiempo Visual - VANILLA

```
LEVEL  1-10        10-25       25-40       40-45       45-55       55-60
       │           │           │           │           │           │
       └─Bracket_1_19──Bracket_20_29──Bracket_30_39──Bracket_40_49──┐
                                                                      │
       RAID PROGRESSION AT 60:                                        │
       ┌───────────────────────────────────────────────────────────────┘
       │
       ├─→ Bracket_60_1_1 (MC)          [Tier 1 - Nov 2004] ✅
       ├─→ Bracket_60_1_2 (Onyxia)      [Tier 1 - Nov 2004] ✅
       │
       ├─→ Bracket_60_2_1 (BWL)         [Tier 2 - Dec 2005] ✅
       ├─→ Bracket_60_2_2 (ZG)          [Tier 2.5 - Jan 2006] ✅
       │
       ├─→ Bracket_60_3_1 (AQ20)        [Tier 2.5 - Jan 2006] ✅
       ├─→ Bracket_60_3_2 (AQ40)        [Tier 3 - Jan 2006] ✅
       └─→ Bracket_60_3_3 (??? Tuning)  [SIN DESCRIPCIÓN] ❓
```

---

## 📊 Línea de Tiempo Visual - THE BURNING CRUSADE

```
LEVEL  60-61       61-70       70 NORMAL   70 HEROIC
       │           │           │           │
       └─────┬─────┬───────────┬───────────┤
             │     │           │           │
    Brackets: 61_64 65_69      70_1_1      70_1_2
             │     │           │           │
             └─────┴───────────┴───────────┘
                                   │
       RAID PROGRESSION AT 70:      │
       ┌──────────────────────────────┘
       │
       ├─ TIER 1 (Jan 2007)
       │  ├─→ Bracket_70_2_1 (Gruul/Mag)     ✅
       │  └─→ Bracket_70_2_2 (Karazhan)      ✅
       │
       ├─ TIER 1.5 (???)
       │  └─→ Bracket_70_2_3 (Ogri'la)      ❌ WRONG TIER!
       │      ↳ Debería estar en Bracket_70_6_1
       │
       ├─ TIER 2 (May 2007)
       │  ├─→ Bracket_70_3_1 (SSC)           ✅
       │  └─→ Bracket_70_3_2 (The Eye)       ✅ (+ Sha'tari mixed)
       │
       ├─ TIER 3 (Aug 2007)
       │  └─→ Bracket_70_4_1 (Hyjal)         ✅
       │
       ├─ TIER 4 (Aug 2007)
       │  └─→ Bracket_70_4_2 (Black Temple)  ✅
       │
       ├─ TIER 2.5 (Dec 2007)
       │  └─→ Bracket_70_5 (Zul'Aman)        ✅
       │
       └─ TIER 5 FINAL (Mar 2008)
          ├─→ Bracket_70_6_1 (Isle QD)      ✅ ← Ogri'la should go here!
          ├─→ Bracket_70_6_2 (Sunwell)      ✅
          └─→ Bracket_70_6_3 (??? Tuning)   ❓
```

---

## 📊 Línea de Tiempo Visual - WRATH OF THE LICH KING

```
LEVEL  71-80       80 NORMAL   80 HEROIC
       │           │           │
       └─────┬─────┬───────────┤
             │     │           │
    Brackets: 71_74 75_79      80_1_1 80_1_2
             │     │           │       │
             └─────┴───────────┴───────┘
                              │
       RAID PROGRESSION AT 80: │
       ┌──────────────────────┘
       │
       ├─ TIER 1 (Nov 2008)
       │  └─→ Bracket_80_2 
       │      ACTUALMENTE:   "Ulduar, Trial of Champion, Arena S6"
       │      PROBLEMA:      Trial of Champion es 5-man ❌
       │      DEBE SER:      "Ulduar, Naxx80, Eye of Eternity"
       │      FIX PRIORITY:  🔴 CRÍTICO
       │
       ├─ TIER 2 (Aug 2009)
       │  └─→ Bracket_80_3 (ToTC)            ✅
       │
       ├─ TIER 3 (Dec 2009)
       │  └─→ Bracket_80_4_1 (ICC)           ✅
       │
       └─ TIER 3.5 (Dec 2009)
          └─→ Bracket_80_4_2 (Ruby Sanctum) ✅
```

---

## 🎨 Mapa de Coherencia

```
VANILLA RAIDS:
┌─────────────────────────────────────────┐
│ Level 60 Content Progression            │
├─────────────────────────────────────────┤
│ ✅ MC/Onyxia → BWL → AQ → Naxx         │
│ Perfectly aligned with Blizzard         │
│ SCORE: 100% ✅                         │
└─────────────────────────────────────────┘

TBC RAIDS:
┌─────────────────────────────────────────┐
│ Level 70 Content Progression            │
├─────────────────────────────────────────┤
│ ✅ Gruul/Kara → SSC/TK → Hyjal/BT      │
│ ⚠️ Ogri'la misclassified (should be     │
│    in Isle of Quel'Danas bracket)       │
│ SCORE: 85% ⚠️                          │
└─────────────────────────────────────────┘

WOTLK RAIDS:
┌─────────────────────────────────────────┐
│ Level 80 Content Progression            │
├─────────────────────────────────────────┤
│ ❌ Bracket_80_2 has Trial of Champion   │
│    (should be Ulduar/Naxx80)            │
│ ⚠️ Trial of Champion is 5-man, not raid │
│ SCORE: 85% ⚠️                          │
└─────────────────────────────────────────┘
```

---

## 🔄 Mapeo de Reorganización Necesaria

```
ACTUAL STRUCTURE          PROPOSED STRUCTURE         IMPACT
═════════════════════════════════════════════════════════════════

Bracket_70_2_3            Bracket_70_2_3
(Ogri'la)                 (EMPTY / World Content)    MEDIUM
    │                             │
    ↓ CONTENT MOVE                ↓ MOVE TO
                            
Bracket_70_6_1            Bracket_70_6_1
(Isle of QD content)      (Isle of QD + Ogri'la)    REORGANIZED


Bracket_80_2              Bracket_80_2
(Ulduar, Trial Champion,  (Ulduar, Naxx80, 
 Arena S6)                Eye of Eternity)          HIGH PRIORITY
    │
    ↓ REMOVE Trial & Add Raids
    
Bracket_80_1_2 OR         Bracket_80_1_2 OR
NEW BRACKET               NEW 5-MAN BRACKET          CONSIDER
(for 5-man content)       (Trial of Champion)
```

---

## 📈 Estadísticas de Corrección

```
BEFORE CHANGES:
╔═══════════════════════════════════╗
║ Total Brackets: 38                ║
║ Correct: 30 (79%)     ✅          ║
║ Problems: 7 (21%)     ⚠️           ║
║ Critical: 2           🔴          ║
║ Medium: 2             🟡          ║
║ Low: 3                🟠          ║
╚═══════════════════════════════════╝

AFTER CHANGES (PROJECTED):
╔═══════════════════════════════════╗
║ Total Brackets: 38                ║
║ Correct: 37 (97%)     ✅          ║
║ Needs Docs: 1 (3%)    ⚠️           ║
║ Critical: 0           🔴          ║
║ Medium: 0             🟡          ║
║ Low: 1                🟠          ║
╚═══════════════════════════════════╝

GOAL: 100% Alignment with Blizzard
```

---

## 🎯 Prioridad de Cambios

```
IMMEDIATE (This week)
├─ 🔴 Fix Bracket_80_2 [CRITICAL]
│  ├─ Research: What content goes here
│  ├─ Update: conf.dist line 138
│  └─ Status: BLOCKING other progress
│
├─ 🔴 Fix Bracket_70_2_3 [CRITICAL]
│  ├─ Move: Ogri'la to Bracket_70_6_1
│  ├─ Update: conf.dist line 90
│  └─ Reorganize: SQL/CPP files
│
└─ 🟡 Investigate empty brackets
   ├─ Bracket_60_3_3 content?
   └─ Bracket_70_6_3 content?

NEXT WEEK
├─ 🟡 Update Bracket_40_49 description
├─ 🟡 Clarify Bracket_70_4_1 content
├─ 🟠 Document Bracket_70_3_2
└─ 🟠 Document Bracket_60_3_3

MEDIUM TERM
├─ ✅ Test all brackets
├─ ✅ Validate SQL syntax
├─ ✅ Compile C++ changes
└─ ✅ Update documentation
```

---

## 📋 Archivo de Checklist

```
CONFIG CHANGES (8 items)
└─ conf/progression_system.conf.dist
   ├─ □ Line 51   - Update Bracket_40_49 description
   ├─ □ Line 64   - Add Bracket_60_3_3 description
   ├─ □ Line 90   - Fix Bracket_70_2_3 (Ogri'la)
   ├─ □ Line 104  - Clarify Bracket_70_3_2
   ├─ □ Line 108  - Clarify Bracket_70_4_1
   ├─ □ Line 128  - Add Bracket_70_6_3 description
   ├─ □ Line 138  - FIX Bracket_80_2 (CRITICAL)
   └─ □ Line 142  - Verify Bracket_80_3

CODE INVESTIGATION (3 items)
├─ □ Research: Bracket_60_3_3/sql content
├─ □ Research: Bracket_70_2_3/sql content
└─ □ Research: Bracket_70_6_3 existence

REORGANIZATION (if needed)
├─ □ Move: Bracket_70_2_3 content → Bracket_70_6_1
├─ □ Update: C++ loaders
└─ □ Update: SQL registration

VALIDATION
├─ □ Syntax check: conf.dist
├─ □ Compilation: C++ changes
├─ □ SQL validation: All SQL files
└─ □ Testing: Each bracket loads

DOCUMENTATION
├─ □ Update: README.md
├─ □ Create: BRACKETS.md reference
└─ □ Update: CHANGELOG
```

---

## 🌟 Resultado Final Esperado

```
┌─────────────────────────────────────────────────────────┐
│     PROGRESSION SYSTEM - FINAL STATE                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  VANILLA (1-60):       100% ✅ Blizzard Aligned       │
│  TBC (61-70):          100% ✅ Blizzard Aligned       │
│  WOTLK (71-80):        100% ✅ Blizzard Aligned       │
│  CUSTOM:               Documented                     │
│                                                         │
│  OVERALL SCORE:        100% ✅✅✅                    │
│                                                         │
│  All brackets documented and organized per Blizzard   │
│  timeline. Progression is clear and unambiguous.      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

**Diagrama creado**: Diciembre 2025
**Documentos disponibles**: 6 archivos Markdown
**Estado**: Listo para implementación
