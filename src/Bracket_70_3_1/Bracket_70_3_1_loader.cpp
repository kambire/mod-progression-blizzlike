/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ProgressionSystem.h"

void AddSC_serpentshrine_cavern_70();

void AddBracket_70_3_A_Scripts()
{
    if (!IsProgressionBracketEnabled("70_3_1"))
        return;

    AddSC_serpentshrine_cavern_70();
}
