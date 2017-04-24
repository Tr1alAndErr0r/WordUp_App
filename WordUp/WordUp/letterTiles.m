//
//  letterTiles.m
//  WordUp
//
//  Created by Duke Le on 4/25/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "letterTiles.h"

@implementation letterTiles
{
    @public
    UIImageView *playerTiles[8];
    NSInteger playerTileValues[8];
    float originalPosX[8];
    float originalPosY[8];
}

-(id)initGameStartTiles
{
    lettersArray = [[NSMutableArray alloc] init];
    
    for (int l = 0; l < 7; l++) {
        [lettersArray addObject:@"a"];
    }
    
    //NSLog(@"string: %@", lettersArray);
    
    self = [super init];
    if(self)
    {
        int j = 0;
        for (int i = 0; i < 7; i++)
        {
            j = 1 + (arc4random() % 25);
            [self updateTile:i andTileValue:j];
            playerTiles[i].frame = CGRectMake(54+38*i, 465, 38, 38);
            originalPosX[i] = playerTiles[i].center.x;
            
            //NSLog(@"X = %f for element: %i", originalPosX[i], i);
            
            originalPosY[i] = playerTiles[i].center.y;
            
            //NSLog(@"Y = %f for element: %i", originalPosX[i], i);
            
            playerTiles[i].multipleTouchEnabled = YES;
            playerTiles[i].userInteractionEnabled = YES;
            [self addSubview:playerTiles[i]];
        }
    }
    //NSLog(@"string: %@", lettersArray);
    return self;
}

-(void)refillRack:(NSMutableArray*)array
{
    int j = 0;
    NSInteger len = [array count];
    
    for (int i = 0; i < len; i++)
    {
        NSInteger value = [[array objectAtIndex:i] integerValue];
        j = 1 + (arc4random() % 25);
        [self updateTile:value andTileValue:j];
        
        
        playerTiles[value].frame = CGRectMake(54+38*value, 465, 38, 38);
        originalPosX[value] = playerTiles[value].center.x;
        originalPosY[value] = playerTiles[value].center.y;
        playerTiles[value].multipleTouchEnabled = YES;
        playerTiles[value].userInteractionEnabled = YES;
        //[self addSubview:playerTiles[value]];
        
        
        //NSLog(@"X = %f for value: %li. i = %i", originalPosX[i], value, i);
        //NSLog(@"Y = %f for value: %li. i = %i", originalPosY[i], value, i);
     }
    //NSLog(@"refill string: %@", lettersArray);
    
}

-(void)emptyArray
{
    [lettersArray removeAllObjects];

    for (int l = 0; l < 7; l++) {
        playerTiles[l].image = nil;
        [lettersArray addObject:@""];
    }
    
    
    //[self removeFromSuperview:playerTiles];
}


-(void)recall:(NSMutableArray*)array
{
    NSInteger len = [array count];
    
    for (int i = 0; i < len; i++)
    {
        NSInteger value = [[array objectAtIndex:i] integerValue];
        playerTiles[value].frame = CGRectMake(54+38*value, 465, 38, 38);
        originalPosX[value] = playerTiles[value].center.x;
        originalPosY[value] = playerTiles[value].center.y;
        playerTiles[value].multipleTouchEnabled = YES;
        playerTiles[value].userInteractionEnabled = YES;
        [self addSubview:playerTiles[value]];
        
        //NSLog(@"X = %f for value: %li. i = %i", originalPosX[i], value, i);
        //NSLog(@"Y = %f for value: %li. i = %i", originalPosY[i], value, i);
    }
    
    
}

-(UIImageView*)getLetterImg:(NSInteger)element
{
    return playerTiles[element];
}

-(void)setHidden:(BOOL)val
{
    for (int i = 0; i< 8; i++)
    {
        playerTiles[i].hidden = val;
    }
}

-(void)setUserInteract:(NSInteger)element andBoolValue:(BOOL)val
{
    playerTiles[element].userInteractionEnabled = val;
}

-(void)setCenter:(NSInteger)element andCGPointVal:(CGPoint)val
{
    playerTiles[element].center = val;
}

-(float)getCenterX:(NSInteger)element
{
    return playerTiles[element].center.x;
    
}

-(float)getCenterY:(NSInteger)element
{
    return playerTiles[element].center.y;
}

-(float)getOriginalCenterX:(NSInteger)element
{
    return originalPosX[element];
}

-(float)getOriginalCenterY:(NSInteger)element
{
    return originalPosY[element];
}

-(NSString*)getLetter:(NSInteger)val
{
    return lettersArray[val];
}


-(void)updateTile:(NSInteger)element andTileValue:(NSInteger)val
{
    playerTileValues[element] = val;
    
    switch (val)
    {
        case 1:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"a"];
            //[lettersArray insertObject:@"a" atIndex:element];
            break;
        case 2:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"b"];
            break;
        case 3:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"c"];
            break;
        case 4:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"d"];
            break;
        case 5:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"e"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"e"];
            break;
        case 6:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"f"];
            //[lettersArray insertObject:@"f" atIndex:element];
            break;
        case 7:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"g"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"g"];
            break;
        case 8:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"h"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"h"];
            break;
        case 9:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"i"];
            break;
        case 10:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"j"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"j"];
            break;
        case 11:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"k"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"k"];
            break;
        case 12:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"l"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"l"];
            break;
        case 13:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"m"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"m"];
            break;
        case 14:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"n"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"n"];
            break;
        case 15:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"o"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"o"];
            break;
        case 16:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"p"];
            break;
        case 17:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"q"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"q"];
            break;
        case 18:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"r"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"r"];
            break;
        case 19:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"s"];
            break;
        case 20:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"t"];
            break;
        case 21:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"u"];
            break;
        case 22:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"v"];
            break;
        case 23:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"w"];
            break;
        case 24:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"x"];
            break;
        case 25:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"y"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"y"];
            break;
        case 26:
            playerTiles[element] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z"]];
            [lettersArray replaceObjectAtIndex:element withObject:@"z"];
            break;
        default:
            break;
    }
    
}


-(void)makeClickable:(NSInteger)element
{
    playerTiles[element].userInteractionEnabled = YES;
}


@end
