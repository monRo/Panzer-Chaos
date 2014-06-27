//
//  SimpleDPad2.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@class SimpleDPad2;

@protocol SimpleDPad2Delegate <NSObject>

-(void)simpleDPad:(SimpleDPad2 *)simpleDPad didChangeDirectionTo:(CGPoint)direction;
-(void)simpleDPad:(SimpleDPad2 *)simpleDPad isHoldingDirection:(CGPoint)direction;
-(void)simpleDPadTouchEnded:(SimpleDPad2 *)simpleDPad;

@end

@interface SimpleDPad2 : CCNode
{
    float _radius;
    CGPoint _direction;
}

@property(nonatomic,weak)id <SimpleDPad2Delegate> delegate;
@property(nonatomic,assign)BOOL isHeld;

+ (SimpleDPad2 *)create;

@end
