//
//  Turrets.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 20.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ActionSprite.h"

@interface Turrets : ActionSprite

+ (Turrets *)create;

@property (nonatomic, assign) BOOL isShoot;

@end
