    //
//  ViewController.h
//  WordUp
//
//  Created by Duke Le on 4/17/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameBoardLogic.h"
#import "gameBoard.h"
#import "individualSquares.h"

#import "letterTiles.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface ViewController : UIViewController
{
    NSString *playerOneScore;
    NSString *playerTwoScore;
    NSString *theWord;
    NSMutableString *name;
    //NSMutableString *wordToBeTested;
    NSMutableArray *boardTilesArray;
    //NSMutableArray *wordsPlayedArray;
    NSInteger wordsPlayedCount;
    NSInteger boardTilesArrayIndex;
    individualSquares *boardSquares;
}
@property (strong, nonatomic) IBOutlet UILabel *playOneNameDisplay;
@property (strong, nonatomic) IBOutlet UILabel *playerTwoNameDisplay;
@property (weak, nonatomic) IBOutlet UILabel *scoreOneDisplay;
@property (weak, nonatomic) IBOutlet UILabel *scoreTwoDisplay;

@property(strong, nonatomic) NSString *playerOneNamePassed;
@property(strong, nonatomic) NSString *playerTwoNameTwoPassed;

//@property (nonatomic) BOOL lastWord;
@property (nonatomic) BOOL skipCol;
@property (nonatomic) BOOL didSwap;
@property (nonatomic) BOOL programSentButton;
@property (nonatomic) BOOL inMiddleOfPlayingTurn;
@property (nonatomic) BOOL hasBeenSet0;
@property (nonatomic) BOOL hasBeenSet1;
@property (nonatomic) BOOL hasBeenSet2;
@property (nonatomic) BOOL hasBeenSet3;
@property (nonatomic) BOOL hasBeenSet4;
@property (nonatomic) BOOL hasBeenSet5;
@property (nonatomic) BOOL hasBeenSet6;
@property (nonatomic, strong) NSMutableArray *tilesPlayedOnBoard;
@property (strong, nonatomic) NSString *words;
@property (strong, nonatomic) NSString *databasePath;
//@property (copy, nonatomic) NSMutableArray *wordsPlayedArray;

-(void) played;
-(void) dictionaryChallenge;
-(IBAction)endTurnButton:(id)sender;
-(IBAction)recalled:(id)sender;
-(IBAction)swap:(id)sender;



@end

