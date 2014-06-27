//
//  GameScreenScene.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 19.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "GameScreenScene.h"
#import "GameLayer.h"
#import "HUDLayer.h"


@implementation GameScreenScene


+ (GameScreenScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    _gameLayer = [GameLayer node];
    [self addChild:_gameLayer z:10];
    
    _hudlayer = [HUDLayer node];
    [self addChild:_hudlayer z:20];
    
    _hudlayer.dPad.delegate = _gameLayer;
    _gameLayer.hudLayer = _hudlayer;
    
	return self;
}

//- (CGPoint)tileCoordForPosition:(CGPoint)position {
//    int x = position.x / _tileMap.tileSize.width;
//    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
//    return ccp(x, y);
//}
//
//- (CGPoint)objectPosition:(CCTiledMapObjectGroup *)group object:(NSString *)object {
//    
//    CGPoint point;
//    NSMutableDictionary* dic = [group objectNamed:object];
//    point.x = [[dic valueForKey:@"x"] intValue];
//    point.y = [[dic valueForKey:@"y"] intValue];
//    return point;
//}
//
//- (void)setViewPointCenter:(CGPoint) position {
//    
//    CGSize winSize = [[CCDirector sharedDirector] viewSize];
//    
//    int x = MAX(position.x, winSize.width/2);
//    int y = MAX(position.y, winSize.height/2);
//    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width) - winSize.width / 2);
//    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height) - winSize.height/2);
//    CGPoint actualPosition = ccp(x, y);
//    
//    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
//    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
//    
//    self.position = viewPoint;
//}
//
//#pragma mark - handle touches
//
//-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchLocation = [touch locationInView:touch.view];
//    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//    touchLocation = [self convertToNodeSpace:touchLocation];
//    
//    CGPoint playerPos = _hero.position;
//    CGPoint diff = ccpSub(touchLocation, playerPos);
//    
//    if ( abs(diff.x) > abs(diff.y) ) {
//        if (diff.x > 0) {
//            playerPos.x = touchLocation.x;
//        } else {
//            playerPos.x = touchLocation.x;
//        }
//    } else {
//        if (diff.y > 0) {
//            playerPos.y = touchLocation.y;
//        } else {
//            playerPos.y = touchLocation.y;
//        }
//    }
//    
//    CCLOG(@"playerPos %@",CGPointCreateDictionaryRepresentation(playerPos));
//    
//    // safety check on the bounds of the map
//    if (playerPos.x <= (_tileMap.mapSize.width * _tileMap.tileSize.width) &&
//        playerPos.y <= (_tileMap.mapSize.height * _tileMap.tileSize.height) &&
//        playerPos.y >= 0 &&
//        playerPos.x >= 0 )
//    {
//        [self setPlayerPosition:playerPos];
//    }
//    
//    [self setViewPointCenter:_hero.position];
//}
//
//- (void)update:(CCTime)delta
//{
//    [self setViewPointCenter:_hero.position];
//    [self checkPlayerPosition];
//}
//
//- (void)checkPlayerPosition
//{
//    CGPoint tileCoord = [self tileCoordForPosition:_hero.position];
//    int tileGid = [_meta tileGIDAt:tileCoord];
//    CGPoint curPossition = _hero.position;
//    if (tileGid) {
//        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
//        if (properties) {
//            NSString *collision = properties[@"Collidable"];
//            if (collision && [collision isEqualToString:@"True"]) {
//                _hero.position = curPossition;
//                return;
//            }
//        }
//    }
//}
//
//- (void)setPlayerPosition:(CGPoint)position
//{
//    CGPoint tileCoord = [self tileCoordForPosition:position];
//    int tileGid = [_meta tileGIDAt:tileCoord];
//    if (tileGid) {
//        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
//        if (properties) {
//            NSString *collision = properties[@"Collidable"];
//            if (collision && [collision isEqualToString:@"True"]) {
//                return;
//            }
//        }
//    }
//    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:0.7f position:ccp(position.x, position.y)];
//    moveTo.tag = 10;
//    [_hero runAction:moveTo];
//
//}

@end
