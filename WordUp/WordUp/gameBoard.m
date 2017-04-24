//
//  gameBoard.m
//  WordUp
//
//  Created by Duke Le on 4/24/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "gameBoard.h"

@implementation gameBoard
{
    NSInteger theBoard[9][9];
    float coordinateX[9][9];
    float coordinateY[9][9];
}

-(id)init
{
    if (self=[super init])
    {
        [self emptyBoard];
    }
    return self;
}

-(void)emptyBoard
{
    memset(theBoard, 0, sizeof(theBoard));
    memset(coordinateX, 0, sizeof(coordinateX));
    memset(coordinateY, 0, sizeof(coordinateY));
}

-(LetterValue)valueAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    return theBoard[column][row];
}

-(void)setGameBoard:(LetterValue)letter forColumn:(NSInteger)column andRow:(NSInteger)row
{
    theBoard[column][row] = letter;
}

-(float)coordinateX:(NSInteger)column andRow:(NSInteger)row
{
    return coordinateX[column][row];
}

-(float)coordinateY:(NSInteger)column andRow:(NSInteger)row
{
    return coordinateY[column][row];
    
}

-(void)setCoordinateX:(float)coordValue forColumn:(NSInteger)column andRow:(NSInteger)row
{
    coordinateX[column][row] = coordValue;
}

-(void)setCoordinateY:(float)coordValue forColumn:(NSInteger)column andRow:(NSInteger)row
{
    coordinateY[column][row] = coordValue;
}
@end
