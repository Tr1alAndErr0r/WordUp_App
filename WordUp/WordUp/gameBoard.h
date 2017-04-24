//
//  gameBoard.h
//  WordUp
//
//  Created by Duke Le on 4/24/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LetterValue.h"

@interface gameBoard : NSObject

-(id)init;
-(void)emptyBoard;
-(LetterValue)valueAtColumn:(NSInteger)column andRow:(NSInteger)row;
-(void)setGameBoard:(LetterValue)letter forColumn:(NSInteger)column andRow:(NSInteger)row;

-(void)setCoordinateX:(float)coordValue forColumn:(NSInteger)column andRow:(NSInteger)row;
-(void)setCoordinateY:(float)coordValue forColumn:(NSInteger)column andRow:(NSInteger)row;
-(float)coordinateX:(NSInteger)column andRow:(NSInteger)row;
-(float)coordinateY:(NSInteger)column andRow:(NSInteger)row;


@end
