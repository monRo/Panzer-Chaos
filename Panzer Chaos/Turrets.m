//
//  Turrets.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 20.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "Turrets.h"
#import "GameScreenScene.h"
#import "Hero.h"
#import "CCAnimation.h"

@interface Turrets ()

@property (strong, nonatomic) GameScreenScene *target;
@property (assign, nonatomic) BOOL isReload;

@end

@implementation Turrets

@synthesize target = _target;


+ (Turrets *)create
{
    return [[self alloc] init];
}

- (id)init
{
    if ((self = [super initWithImageNamed:@"enemy_idle_1.png"]))
    {
        int i;
        
        //idle animation
        NSMutableArray *idleFrames = [NSMutableArray array];
        for(int i = 1; i <= 8; ++i)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"enemy_idle_%d.png", i]];
            [idleFrames addObject:spriteFrame];
        }
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:idleFrames delay:1.0/2.0];
        self.idleAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]];
        
        //attack animation
        NSMutableArray *attackFrames = [NSMutableArray array];
        for (i = 1; i <= 9; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"enemy_attack_%d.png", i]];
            [attackFrames addObject:spriteFrame];
        }
        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:attackFrames delay:1.0/24.0];
        
        self.attackAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:attackAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //hurt animation
        NSMutableArray *hurtFrames = [NSMutableArray array];
        for (i = 1; i <= 6; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"enemy_hurt_%d.png", i]];
            [hurtFrames addObject:spriteFrame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:hurtFrames delay:1.0/12.0];
        self.hurtAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:hurtAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //knocked out animation
        NSMutableArray *knockedOutFrames = [NSMutableArray array];
        for (i = 1; i <= 6; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"enemy_knocked_%d.png", i]];
            [knockedOutFrames addObject:spriteFrame];
        }
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithSpriteFrames:knockedOutFrames delay:1.0/12.0];
        self.knockedOutAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:knockedOutAnimation], [CCActionBlink actionWithDuration:2.0 blinks:10.0], nil];
        
        //reload animation
        NSMutableArray *reloadFrame = [NSMutableArray array];
        for (i = 1; i <= 6; i++) {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"enemy_reload_%d.png", i]];
            [reloadFrame addObject:spriteFrame];
        }
        CCAnimation *reloadAnimation = [CCAnimation animationWithSpriteFrames:reloadFrame delay:1.0/6.0];
        self.reloadAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:reloadAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        self.userInteractionEnabled = YES;
        self.anchorPoint = ccp(0.5f, 0.5f);
        self.centerToBottom = 64.0;
        self.centerToSides = 64.0;
        self.hitPoints = 100.0;
        self.damage = 40.0;
        self.attackRange = 200;
        self.fireRate = 3.0;
        self.isShoot = NO;
        self.isReload = NO;
    }  
    return self;
}

- (void)reload
{
    if (!self.isReload) {
        self.isReload = YES;
        [self schedule:@selector(endReload) interval:self.fireRate];
    }
}

- (void)endReload
{
    self.isShoot = NO;
    self.isReload = NO;
}

- (void)attack
{
    self.isShoot = YES;
    [super attack];
}

-(void)knockout
{
    [super knockout];
}

@end
