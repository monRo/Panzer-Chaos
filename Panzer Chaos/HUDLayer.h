//
//  HUDLayer.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 24.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SimpleDPad, SimpleDPad2;

@interface HUDLayer : CCNode {
    
}

@property(nonatomic,weak)SimpleDPad *dPad;

@end
