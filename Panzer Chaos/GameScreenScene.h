//
//  GameScreenScene.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 19.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import "SimpleDPad.h"

@class GameLayer, HUDLayer;

@interface GameScreenScene : CCScene

@property (weak, nonatomic) GameLayer *gameLayer;
@property (weak, nonatomic) HUDLayer *hudlayer;

+ (GameScreenScene *)scene;
- (id)init;

@end
