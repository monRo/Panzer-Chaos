//
//  HUDLayer.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 24.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "HUDLayer.h"
#import "SimpleDPad2.h"
#import "SimpleDPad.h"

@implementation HUDLayer

-(id)init {
    if ((self = [super init])) {
        self.userInteractionEnabled = YES;
        _dPad = [SimpleDPad dPadWithFile:@"dPad.png" radius:64];
//        _dPad = [SimpleDPad2 create];
        _dPad.position = ccp(64.0, 89.0);
        _dPad.opacity = 100;
        [self addChild:_dPad];
    }
    return self;
}

@end
