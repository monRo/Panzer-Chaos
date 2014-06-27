//
//  HighscoreScreenScene.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 19.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "HighscoreScreenScene.h"


@implementation HighscoreScreenScene

+ (HighscoreScreenScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    
    
	return self;
}

@end
