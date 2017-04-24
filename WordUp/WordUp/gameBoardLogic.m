//
//  gameBoardLogic.m
//  WordUp
//
//  Created by Duke Le on 4/24/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "gameBoardLogic.h"

@implementation gameBoardLogic
{
    NSInteger whoseTurn;
}

-(void)gameStart
{
    [super emptyBoard];
    _playerOneScore = 0;
    _playerTwoScore = 0;
    whoseTurn = 1;
}

-(NSInteger)getWhoseTurn
{
    return whoseTurn;
}

-(void)setWhoseTurn:(NSInteger)player
{
    whoseTurn = player;
}

@end
