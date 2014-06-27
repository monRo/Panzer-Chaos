//
//  Defines.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#ifndef Panzer_Chaos_Defines_h
#define Panzer_Chaos_Defines_h

//convenience measurements
#define SCREEN [[CCDirector sharedDirector] viewSize]
#define CENTER ccp(SCREEN.width/2, SCREEN.height/2)

//enumerations
typedef enum _ActionState
{
    kActionStateNone = 0,
    kActionStateIdle,
    kActionStateAttack,
    kActionStateWalk,
    kActionStateHurt,
    kActionStateKnockedOut,
    kActionStateReload
} ActionState;

typedef enum _DirectionState
{
    kDirectionTop = 0,
    kDirectionBot,
    kDirectionLeft,
    kDireRight
} DirectionState;

//structures
typedef struct _BoundingBox
{
    CGRect actual;
    CGRect original;
} BoundingBox;

#endif
