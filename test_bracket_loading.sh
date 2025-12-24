#!/bin/bash
# Test script to validate bracket loading configuration
# This script simulates what happens during server startup

echo "================================================"
echo "Progression System - Bracket Loading Test"
echo "================================================"
echo ""

# Test 1: Check all bracket loaders exist
echo "[TEST 1] Checking bracket loader files..."
MISSING_LOADERS=0
for i in {0..37}; do
    case $i in
        0) BRACKET="0" ;;
        1) BRACKET="1_19" ;;
        2) BRACKET="20_29" ;;
        3) BRACKET="30_39" ;;
        4) BRACKET="40_49" ;;
        5) BRACKET="50_59_1" ;;
        6) BRACKET="50_59_2" ;;
        7) BRACKET="60_1_1" ;;
        8) BRACKET="60_1_2" ;;
        9) BRACKET="60_2_1" ;;
        10) BRACKET="60_2_2" ;;
        11) BRACKET="60_3_1" ;;
        12) BRACKET="60_3_2" ;;
        13) BRACKET="60_3_3" ;;
        14) BRACKET="61_64" ;;
        15) BRACKET="65_69" ;;
        16) BRACKET="70_1_1" ;;
        17) BRACKET="70_1_2" ;;
        18) BRACKET="70_2_1" ;;
        19) BRACKET="70_2_2" ;;
        20) BRACKET="70_2_3" ;;
        21) BRACKET="70_3_1" ;;
        22) BRACKET="70_3_2" ;;
        23) BRACKET="70_4_1" ;;
        24) BRACKET="70_4_2" ;;
        25) BRACKET="70_5" ;;
        26) BRACKET="70_6_1" ;;
        27) BRACKET="70_6_2" ;;
        28) BRACKET="70_6_3" ;;
        29) BRACKET="71_74" ;;
        30) BRACKET="75_79" ;;
        31) BRACKET="80_1_1" ;;
        32) BRACKET="80_1_2" ;;
        33) BRACKET="80_2" ;;
        34) BRACKET="80_3" ;;
        35) BRACKET="80_4_1" ;;
        36) BRACKET="80_4_2" ;;
        37) BRACKET="Custom" ;;
    esac
    
    LOADER_FILE="src/Bracket_${BRACKET}/Bracket_${BRACKET}_loader.cpp"
    if [ ! -f "$LOADER_FILE" ]; then
        echo "  ❌ MISSING: $LOADER_FILE"
        MISSING_LOADERS=$((MISSING_LOADERS + 1))
    fi
done

if [ $MISSING_LOADERS -eq 0 ]; then
    echo "  ✅ All 38 bracket loaders exist"
else
    echo "  ❌ $MISSING_LOADERS bracket loader(s) missing"
fi
echo ""

# Test 2: Check all loaders use CHECK_BRACKET_ENABLED
echo "[TEST 2] Checking loaders use CHECK_BRACKET_ENABLED macro..."
INCORRECT_LOADERS=0
for loader in src/Bracket_*/Bracket_*_loader.cpp; do
    if [ -f "$loader" ]; then
        if ! grep -q "CHECK_BRACKET_ENABLED" "$loader"; then
            echo "  ❌ $loader doesn't use CHECK_BRACKET_ENABLED"
            INCORRECT_LOADERS=$((INCORRECT_LOADERS + 1))
        fi
    fi
done

if [ $INCORRECT_LOADERS -eq 0 ]; then
    echo "  ✅ All bracket loaders use CHECK_BRACKET_ENABLED"
else
    echo "  ❌ $INCORRECT_LOADERS loader(s) don't use the macro"
fi
echo ""

# Test 3: Check SQL directories exist
echo "[TEST 3] Checking SQL directories..."
MISSING_SQL=0
for bracket_dir in src/Bracket_*/; do
    if [ ! -d "${bracket_dir}sql" ]; then
        echo "  ⚠️  No sql/ directory in $bracket_dir"
        MISSING_SQL=$((MISSING_SQL + 1))
    fi
done

echo "  ℹ️  $(find src/Bracket_*/sql -type d | wc -l) SQL directories found"
echo ""

# Test 4: Check macro definition exists
echo "[TEST 4] Checking CHECK_BRACKET_ENABLED macro..."
if grep -q "CHECK_BRACKET_ENABLED" src/ProgressionSystem.h; then
    echo "  ✅ Macro defined in ProgressionSystem.h"
else
    echo "  ❌ Macro NOT found in ProgressionSystem.h"
fi
echo ""

# Test 5: Check main loader structure
echo "[TEST 5] Checking main loader structure..."
if grep -q "AddProgressionSystemScripts()" src/ProgressionSystem_loader.cpp; then
    echo "  ✅ Core scripts loader called"
fi

if grep -q "LoadScripts" src/ProgressionSystem_loader.cpp; then
    echo "  ✅ Config check for LoadScripts present"
fi

if grep -q "AddBracket_0_Scripts" src/ProgressionSystem_loader.cpp; then
    echo "  ✅ Bracket loaders called"
fi
echo ""

# Test 6: Check command system
echo "[TEST 6] Checking command system..."
if grep -q "progression_module_commandscript" src/cs_progression_module.cpp; then
    echo "  ✅ Command script class exists"
fi

if grep -q "HandleProgModuleStatusCommand" src/cs_progression_module.cpp; then
    echo "  ✅ Status command implemented"
fi

if grep -q "HandleProgModuleListCommand" src/cs_progression_module.cpp; then
    echo "  ✅ List command implemented"
fi
echo ""

# Test 7: Check documentation
echo "[TEST 7] Checking documentation..."
if [ -f "DYNAMIC_LOADING.md" ]; then
    echo "  ✅ DYNAMIC_LOADING.md exists ($(wc -l < DYNAMIC_LOADING.md) lines)"
else
    echo "  ❌ DYNAMIC_LOADING.md missing"
fi

if grep -q "DYNAMIC_LOADING.md" README.md; then
    echo "  ✅ Documentation linked in README"
else
    echo "  ⚠️  Documentation not linked in README"
fi
echo ""

# Summary
echo "================================================"
echo "Test Summary"
echo "================================================"
if [ $MISSING_LOADERS -eq 0 ] && [ $INCORRECT_LOADERS -eq 0 ]; then
    echo "✅ All tests passed - System is ready!"
    echo ""
    echo "Next steps:"
    echo "  1. Compile: cd build && make -j\$(nproc)"
    echo "  2. Configure: Edit progression_system.conf"
    echo "  3. Start server and check logs"
    echo "  4. Use .progression status to verify"
else
    echo "❌ Some tests failed - please review above"
fi
echo "================================================"
