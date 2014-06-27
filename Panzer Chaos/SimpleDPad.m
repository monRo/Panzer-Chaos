//
//  SimpleDPad.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 24.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "SimpleDPad.h"


@implementation SimpleDPad

+(id)dPadWithFile:(NSString *)fileName radius:(float)radius {
    return [[self alloc] initWithFile:fileName radius:radius];
}

-(id)initWithFile:(NSString *)filename radius:(float)radius {
    if ((self = [super initWithImageNamed:filename])) {
        self.userInteractionEnabled = YES;
        _radius = radius;
        _direction = CGPointZero;
        _isHeld = NO;
    }
    return self;
}

- (void)update:(CCTime)delta
{
    if (_isHeld) {
        [_delegate simpleDPad:self isHoldingDirection:_direction];
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float distanceSQ = ccpDistanceSQ(location, _position);
    if (distanceSQ <= _radius * _radius) {
        //get angle 4 directions
        [self updateDirectionForTouchLocation:location];
        _isHeld = YES;
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    [self updateDirectionForTouchLocation:location];
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _direction = CGPointZero;
    _isHeld = NO;
    [_delegate simpleDPadTouchEnded:self];
}

-(void)updateDirectionForTouchLocation:(CGPoint)location
{
    float radians = ccpToAngle(ccpSub(location, _position));
    float degrees = -1 * CC_RADIANS_TO_DEGREES(radians);
    
    if (degrees <= 22.5 && degrees >= -22.5)
    {
        //right
        _direction = ccp(1.0, 0.0);
    } else if (degrees >= 67.5 && degrees <= 112.5)
    {
        //bottom
        _direction = ccp(0.0, -1.0);
    } else if (degrees >= 157.5 || degrees <= -157.5)
    {
        //left
        _direction = ccp(-1.0, 0.0);
    } else if (degrees <= -67.5 && degrees >= -112.5)
    {
        //top
        _direction = ccp(0.0, 1.0);
    }
    [_delegate simpleDPad:self didChangeDirectionTo:_direction];
}

@end
