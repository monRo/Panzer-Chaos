//
//  GameLayer.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleDPad.h"

@class HUDLayer, Hero, Turrets, Bullet;

@interface GameLayer : CCNode <SimpleDPadDelegate>
{
    CCTiledMap *_tileMap;
    CCTiledMapLayer *_background;
    CCTiledMapLayer *_wall;
    CCTiledMapObjectGroup *_object;
    Hero *_hero;
    Bullet *_bullet;
    NSMutableArray *_enemy;
    CCTiledMapLayer *_meta;
    CGPoint _shootVector;
}

@property (weak, nonatomic) HUDLayer *hudLayer;

@end
