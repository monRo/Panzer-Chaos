//
//  Hero.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 20.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "Hero.h"
#import "CCAnimation.h"


@implementation Hero

+ (Hero *)create
{
    return [[self alloc] init];
}

- (id)init
{
    if ((self = [super initWithImageNamed:@"hero_idle_1.png"]))
    {
        int i;
    
        //idle animation
        NSMutableArray *idleFrames = [NSMutableArray array];
        for(int i = 1; i <= 6; ++i)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"hero_idle_%d.png", i]];
            [idleFrames addObject:spriteFrame];
        }
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:idleFrames delay:1.0/6.0];
        self.idleAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]];
        
        //attack animation
        NSMutableArray *attackFrames = [NSMutableArray array];
        for (i = 1; i <= 4; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"hero_attack_%d.png", i]];
            [attackFrames addObject:spriteFrame];
        }
        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:attackFrames delay:1.0/24.0];
        
        self.attackAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:attackAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //walk animation
        NSMutableArray *walkFrames = [NSMutableArray array];
        for (i = 1; i <= 4; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"hero_walk_%d.png", i]];
            [walkFrames addObject:spriteFrame];
        }
        CCAnimation *walkAnimation = [CCAnimation animationWithSpriteFrames:walkFrames delay:1.0/12.0];
        self.walkAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:walkAnimation]];
        
        //hurt animation
        NSMutableArray *hurtFrames = [NSMutableArray array];
        for (i = 1; i <= 6; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"hero_hurt_%d.png", i]];
            [hurtFrames addObject:spriteFrame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:hurtFrames delay:1.0/12.0];
        self.hurtAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:hurtAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //knocked out animation
        NSMutableArray *knockedOutFrames = [NSMutableArray array];
        for (i = 1; i <= 5; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"hero_knocked_%d.png", i]];
            [knockedOutFrames addObject:spriteFrame];
        }
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithSpriteFrames:knockedOutFrames delay:1.0/12.0];
        self.knockedOutAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:knockedOutAnimation], [CCActionBlink actionWithDuration:2.0 blinks:10.0], nil];
        
        self.userInteractionEnabled = YES;
        self.anchorPoint = ccp(0.5f, 0.5f);
        self.centerToBottom = 64.0;
        self.centerToSides = 64.0;
        self.hitPoints = 100.0;
        self.damage = 20.0;
        self.walkSpeed = 80;
        
    }
    return self;
}

-(void)knockout
{
    [super knockout];
}

@end
