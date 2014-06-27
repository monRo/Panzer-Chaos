//
//  SimpleDPad2.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "SimpleDPad2.h"


@implementation SimpleDPad2

+ (SimpleDPad2 *)create
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;

    [self setupDPad];
    
	return self;
}

- (void)setupDPad
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    // right
    CCSpriteFrame *normalFrameRight = [CCSpriteFrame frameWithImageNamed:@"right.png"];
    CCSpriteFrame *highligterFrameRight = [CCSpriteFrame frameWithImageNamed:@"right_press.png"];
    CCButton *rightButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrameRight
                               highlightedSpriteFrame:highligterFrameRight
                                  disabledSpriteFrame:nil];
    [rightButton setTarget:self selector:@selector(pressedRight:)];
    
    // bottom
    CCSpriteFrame *normalFrameBottom = [CCSpriteFrame frameWithImageNamed:@"bottom.png"];
    CCSpriteFrame *highligterFrameBottom = [CCSpriteFrame frameWithImageNamed:@"bottom_press.png"];
    CCButton *bottomButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrameBottom
                                   highlightedSpriteFrame:highligterFrameBottom
                                      disabledSpriteFrame:nil];
    [bottomButton setTarget:self selector:@selector(pressedBottom:)];
    
    //left
    CCSpriteFrame *normalFrameLeft = [CCSpriteFrame frameWithImageNamed:@"left.png"];
    CCSpriteFrame *highligterFrameLeft = [CCSpriteFrame frameWithImageNamed:@"left_press.png"];
    CCButton *leftButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrameLeft
                                   highlightedSpriteFrame:highligterFrameLeft
                                      disabledSpriteFrame:nil];
    [leftButton setTarget:self selector:@selector(pressedLeft:)];
    
    //top
    CCSpriteFrame *normalFrameTop = [CCSpriteFrame frameWithImageNamed:@"top.png"];
    CCSpriteFrame *highligterFrameTop = [CCSpriteFrame frameWithImageNamed:@"top_press.png"];
    CCButton *topButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrameTop
                                   highlightedSpriteFrame:highligterFrameTop
                                      disabledSpriteFrame:nil];
    [topButton setTarget:self selector:@selector(pressedTop:)];
    
    CCLayoutBox *layoutBoxVertical = [[CCLayoutBox alloc] init];
    layoutBoxVertical.anchorPoint = ccp(0.5, 0.5);
    [layoutBoxVertical addChild:bottomButton];
    [layoutBoxVertical addChild:topButton];
    layoutBoxVertical.spacing = 10.f;
    layoutBoxVertical.direction = CCLayoutBoxDirectionVertical;
    [layoutBoxVertical layout];
    layoutBoxVertical.position = ccp(winSize.width/2, winSize.height/2 - 25);
    [self addChild:layoutBoxVertical];
    
    CCLayoutBox *layoutBoxHorizontal = [[CCLayoutBox alloc] init];
    layoutBoxHorizontal.anchorPoint = ccp(0.5, 0.5);
    [layoutBoxHorizontal addChild:leftButton];
    [layoutBoxHorizontal addChild:rightButton];
    layoutBoxHorizontal.spacing = 10.f;
    layoutBoxHorizontal.direction = CCLayoutBoxDirectionHorizontal;
    [layoutBoxHorizontal layout];
    layoutBoxHorizontal.position = ccp(winSize.width/2, winSize.height/2 - 25);
    [self addChild:layoutBoxHorizontal];
}

- (void)update:(CCTime)delta
{
    if (_isHeld) {
        [_delegate simpleDPad:self isHoldingDirection:_direction];
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    _isHeld = YES;
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _direction = CGPointZero;
    _isHeld = NO;
    [_delegate simpleDPadTouchEnded:self];
}

- (void)pressedRight:(id)sender
{
    _direction = ccp(1.0, 0.0);
    [_delegate simpleDPad:self didChangeDirectionTo:_direction];
}

- (void)pressedLeft:(id)sender
{
    _direction = ccp(-1.0, 0.0);
    [_delegate simpleDPad:self didChangeDirectionTo:_direction];
}

- (void)pressedBottom:(id)sender
{
    _direction = ccp(0.0, -1.0);
    [_delegate simpleDPad:self didChangeDirectionTo:_direction];
}

- (void)pressedTop:(id)sender
{
    _direction = ccp(0.0, 1.0);
    [_delegate simpleDPad:self didChangeDirectionTo:_direction];
}

@end
