//
//  gameBoardLogic.h
//  WordUp
//
//  Created by Duke Le on 4/24/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "gameBoard.h"

@interface gameBoardLogic : gameBoard

@property NSInteger playerOneScore;
@property NSInteger playerTwoScore;

-(void)gameStart;
-(NSInteger)getWhoseTurn;
-(void)setWhoseTurn:(NSInteger)player;

@end
