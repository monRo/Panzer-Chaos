//
//  GameLayer.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "GameLayer.h"
#import "Hero.h"
#import "Turrets.h"
#import "Bullet.h"
#import "GameScreenScene.h"

@implementation GameLayer

#pragma mark -
#pragma mark - Init

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.UserInteractionEnabled = YES;
    [self initMap];
    [self initHero];
    [self initTurrets];
    
    return self;
}

- (void)initMap
{
    _tileMap = [CCTiledMap tiledMapWithFile:@"map.tmx"];
    _background = [_tileMap layerNamed:@"background"];
    _wall = [_tileMap layerNamed:@"wall"];
    _object = [_tileMap objectGroupNamed:@"objects"];
    _meta = [_tileMap layerNamed:@"Meta"];
    _meta.visible = NO;
    [self addChild:_tileMap z:-1];
    [self setContentSize:[_tileMap contentSize]];
}

- (void)initHero
{
    _hero = [Hero create];
    _hero.positionType = CCPositionTypePoints;
    CGPoint heroPosition = [self objectPosition:_object object:@"player"];
    _hero.position = ccp(heroPosition.x, heroPosition.y);
    [_tileMap addChild:_hero z:3];
    [self setViewPointCenter:_hero.position];
    _hero.desiredPosition = _hero.position;
    [_hero idle];
}

- (void)initTurrets
{
    _enemy = [NSMutableArray array];
    for (int i = 0; i < [_object.objects count]; i ++)
    {
        Turrets *turret = [Turrets create];
        [_enemy addObject:turret];
        turret.positionType = CCPositionTypePoints;
        CGPoint enemyPosition = [self objectPosition:_object object:[NSString stringWithFormat:@"enemy%d", i]];
        turret.position = ccp(enemyPosition.x, enemyPosition.y);
        [_tileMap addChild:turret z:1];
        turret.desiredPosition = turret.position;
        [turret randomDirection];
        [turret idle];
    }
}

#pragma mark -
#pragma mark - Touched

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [_hero attack];
    
    if (_hero.actionState == kActionStateAttack)
    {
        for (Turrets *turrets in _enemy) {
            if (turrets.actionState != kActionStateKnockedOut)
            {
//                if (fabsf(_hero.position.y - robot.position.y) < 10)
//                {
//                    if (CGRectIntersectsRect(_hero.attackBox.actual, robot.hitBox.actual))
//                    {
//                        [robot hurtWithDamage:_hero.damage];
//                    }
//                }
                [self shootWeaponToEnemy];
                [self damageTurret];
            }
        }
    }
}

#pragma mark -
#pragma mark - Delegate Method

- (void)simpleDPad:(SimpleDPad *)simpleDPad didChangeDirectionTo:(CGPoint)direction
{
    [_hero walkWithDirection:direction];
}

- (void)simpleDPad:(SimpleDPad *)simpleDPad isHoldingDirection:(CGPoint)direction
{
    [_hero walkWithDirection:direction];
}

- (void)simpleDPadTouchEnded:(SimpleDPad *)simpleDPad
{
    if (_hero.actionState == kActionStateWalk)
    {
        [_hero idle];
    }
}

#pragma mark -
#pragma mark - Custom Method

- (void)update:(CCTime)delta
{
    [_hero update:delta];
    [self updatePositions];
    [self updateEnemyDirection];
    [self setViewPointCenter:_hero.position];

}

- (void)updateEnemyDirection
{
    float distanceSQ;
    for (Turrets *turrets in _enemy) {
        if (turrets.actionState != kActionStateKnockedOut) {
            distanceSQ = ccpDistanceSQ(turrets.position, _hero.position);
            if (distanceSQ <= 300 * 150)
            {
                float deltaX = _hero.position.x - turrets.position.x;
                float deltaY = _hero.position.y - turrets.position.y;
                
                float angle = atan2f(deltaY, deltaX);
                turrets.rotation = 90.0f - CC_RADIANS_TO_DEGREES(angle);
                [self chosenEnemyForAttack:turrets];
            }
        }
    }
}

-(void)chosenEnemyForAttack:(Turrets *)turrets
{
    if (turrets.isShoot) {
        [turrets reload];
    } else {
        [turrets attack];
        [self shootWeaponFromTurrets:turrets];
    }
}

// for turrets
-(void)shootWeaponFromTurrets:(Turrets *)turrets
{
    CCSprite * bullet = [CCSprite spriteWithImageNamed:@"bullet.png"];
    [_tileMap addChild:bullet];
    [bullet setPosition:turrets.position];
    [bullet runAction:[CCActionSequence actions:
                       [CCActionMoveTo actionWithDuration:0.4
                                                 position:_hero.position],
                       [CCActionCallFunc actionWithTarget:self
                                           selector:@selector(damageEnemy)],
                       [CCActionCallFuncN actionWithTarget:self
                                            selector:@selector(removeBullet:)],
                       nil]];
}

// for hero
-(void)shootWeaponToEnemy
{
    CGPoint position;
    if (_hero.rotation == 0) {
        position = CGPointMake(_hero.position.x, SCREEN.height * 2);
    } else if (_hero.rotation == 90)
    {
        position = CGPointMake(SCREEN.width * 2, _hero.position.y);
    } else if (_hero.rotation == 180)
    {
        position = CGPointMake(_hero.position.x, -SCREEN.height * 2);
    } else if (_hero.rotation == 270)
    {
        position = CGPointMake( -SCREEN.width * 2, _hero.position.y);
    }
    _bullet = [Bullet create];
    [_tileMap addChild:_bullet];
    [_bullet setPosition:_hero.position];
    [_bullet runAction:[CCActionSequence actions:
                       [CCActionMoveTo actionWithDuration:0.6
                                                 position:position],
//                       [CCActionCallFunc actionWithTarget:self
//                                                 selector:@selector(damageTurret)],
                       [CCActionCallFuncN actionWithTarget:self
                                                  selector:@selector(removeBullet:)],
                       nil]];
}
/*
 if (CGRectIntersectsRect(_hero.attackBox.actual, robot.hitBox.actual))
 {
 [robot hurtWithDamage:_hero.damage];
 }
*/
- (void)damageTurret
{

}

- (void)damageEnemy
{
    [_hero hurtWithDamage:[[_enemy objectAtIndex:0] damage]];
}
- (void)removeBullet:(CCSprite *)bullet
{
    [bullet.parent removeChild:bullet cleanup:YES];
}

-(void)updatePositions {
    float posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - _hero.centerToSides, MAX(_hero.centerToSides, _hero.desiredPosition.x));
    float posY = MIN(_tileMap.mapSize.height * _tileMap.tileSize.height - _hero.centerToBottom, MAX(_hero.centerToBottom, _hero.desiredPosition.y));
    CGPoint tileCoord = [self tileCoordForPosition:CGPointMake(posX, posY)];
    int tileGid = [_meta tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = properties[@"Collidable"];
            if (collision && [collision isEqualToString:@"True"]) {
                return;
            }
        }
    }
    _hero.position = ccp(posX, posY);
}

- (void)setViewPointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    int x = MAX(position.x, winSize.width/2);
    int y = MAX(position.y, winSize.height/2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width) - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height) - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    
    self.position = viewPoint;
}

- (CGPoint)objectPosition:(CCTiledMapObjectGroup *)group object:(NSString *)object {
    
    CGPoint point;
    NSMutableDictionary* dic = [group objectNamed:object];
    point.x = [[dic valueForKey:@"x"] intValue];
    point.y = [[dic valueForKey:@"y"] intValue];
    return point;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
    return ccp(x, y);
}

@end
