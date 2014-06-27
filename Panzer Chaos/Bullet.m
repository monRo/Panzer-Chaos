//
//  Bullet.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 26.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

+ (Bullet *)create
{
    return [[self alloc] init];
}

- (id)init
{
    if ((self = [super initWithImageNamed:@"bullet.png"]))
    {
    }
    return self;
}

@end
