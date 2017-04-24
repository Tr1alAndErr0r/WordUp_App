//
//  individualSqares.h
//  WordUp
//
//  Created by blah on 4/28/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#ifndef WordUp_IndividualSqares_h
#define WordUp_IndividualSqares_h

#import <Foundation/Foundation.h>

@interface individualSquares : NSObject
{
}

-(void) setRow:(int)passedRow;
-(int) getRow;
-(void) setCol:(int)passedCol;
-(int) getCol;
-(void) setLetter:(NSString*)passedLetter;
-(NSString*) getLetter;

@end
#endif
