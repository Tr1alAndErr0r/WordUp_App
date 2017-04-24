//
//  individualSquares.m
//  WordUp
//
//  Created by blah on 4/28/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "individualSquares.h"

@implementation individualSquares
{
    int row;
    int col;
    int positionPlayed;
    NSString *letter;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        row = 10;
        col = 10;
    }
    return self;
}


-(void) setRow:(int)passedRow
{
    row = passedRow;
}

-(int) getRow
{
    return row;
}

-(void) setCol:(int)passedCol
{
    col = passedCol;
}

-(int) getCol
{
    return col;
}

-(void) setLetter:(NSString*)passedLetter
{
    letter = passedLetter;
}

-(NSString*) getLetter
{
    return letter;
}

-(void) setPositionPlayed:(int)passedPosition
{
    positionPlayed = passedPosition;
}

-(int) getPositionPlayed
{
    return positionPlayed;
}

@end