//
//  letterTiles.h
//  WordUp
//
//  Created by Duke Le on 4/25/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <stdlib.h>

@interface letterTiles : UIView
{
    NSMutableArray *lettersArray;
}

-(id)initGameStartTiles;
-(void)updateTile:(NSInteger)element andTileValue:(NSInteger)val;
-(UIImageView*)getLetterImg:(NSInteger)element;
-(void)setHidden:(BOOL)val;
-(void)setUserInteract:(NSInteger)element andBoolValue:(BOOL)val;
-(void)setCenter:(NSInteger)element andCGPointVal:(CGPoint)val;
-(float)getCenterX:(NSInteger)element;
-(float)getCenterY:(NSInteger)element;
-(float)getOriginalCenterX:(NSInteger)element;
-(float)getOriginalCenterY:(NSInteger)element;
-(void)emptyArray;

-(void)refillRack:(NSMutableArray*)array;
-(void)recall:(NSMutableArray*)array;
-(NSString*)getLetter:(NSInteger)val;

-(void)makeClickable:(NSInteger)element;

@end
