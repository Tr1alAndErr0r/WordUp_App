//
//  ViewController.m
//  WordUp
//
//  Created by Duke Le on 4/17/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageBoard[9][9];
    gameBoardLogic *theBoard;
    float boardCoordsYTemp[82];
    float boardCoordsXTemp[82];
    letterTiles *playerOneTiles;
    letterTiles *playerTwoTiles;
    NSInteger whoseTurn;
    NSInteger a, b, c, d, e, f, g;
    NSInteger playerOneTilesPlayed;
    NSInteger playerTwoTilesPlayed;
    
    NSMutableString *wordToBeTested;
    NSMutableArray *wordsPlayedArray;
}

@end

const int numberOfSquares = 81;
const int numberOfLetterTiles = 7;
const int cellW = 40;
const int cellH = 40;
const int topY = 230-4*cellH;
const int bottomY = topY+8.5*cellH;
const int leftX = 165-4*cellW;
const int rightX = leftX+8.5*cellW;
int which;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.tilesPlayedOnBoard = [[NSMutableArray alloc] init];
    
    wordsPlayedArray = [[NSMutableArray alloc] init];
    boardTilesArray = [[NSMutableArray alloc] init];
    boardTilesArrayIndex = 0;
    
    for (int i = 0; i < 100; i++) {
    [boardTilesArray addObject: [[individualSquares alloc] init]];
        
    }
    
    theBoard = [[gameBoardLogic alloc] init];
    [theBoard gameStart];
    playerOneTiles = [[letterTiles alloc] initGameStartTiles];
    playerTwoTiles = [[letterTiles alloc] initGameStartTiles];
    whoseTurn = 1;
    
    int firstColor = 0;
    int row;
    int col;
    
    for (row = 0; row <9 ; row++)
    {
        for (col = 0; col <9 ; col++)
        {
            if (firstColor==0)
            {
                imageBoard[col][row] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GridBoard1"]];
            }
            else
            {
                imageBoard[col][row] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GridBoard2"]];
            }
            imageBoard[col][row].frame = CGRectMake(leftX+cellW*col, topY+cellH*row, cellW, cellH);
            [theBoard setCoordinateX:imageBoard[col][row].center.x forColumn:col andRow:row];
            [theBoard setCoordinateY:imageBoard[col][row].center.y forColumn:col andRow:row];
            
            [self.view addSubview:imageBoard[col][row]];
            firstColor=1-firstColor;
        }
    }
    for (int i = 0; i < 7; i++)
    {
        [self.view addSubview:[playerOneTiles getLetterImg:i]];
        [self.view addSubview:[playerTwoTiles getLetterImg:i]];
    }
    
    [playerOneTiles setHidden:NO];
    [playerTwoTiles setHidden:YES];
    
    self.words = @"words.db";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.words];
    
    self.playOneNameDisplay.text = _playerOneNamePassed;
    self.playerTwoNameDisplay.text = _playerTwoNameTwoPassed;
    
    
}



-(void)played
{
    
    self.hasBeenSet0 = NO;
    self.hasBeenSet1 = NO;
    self.hasBeenSet2 = NO;
    self.hasBeenSet3 = NO;
    self.hasBeenSet4 = NO;
    self.hasBeenSet5 = NO;
    self.hasBeenSet6 = NO;
    
    long tempScore;
    
    if (whoseTurn == 1)
    {
        if (self.didSwap == NO)
        {
            
            [playerOneTiles refillRack:self.tilesPlayedOnBoard];
            
            NSInteger len = [self.tilesPlayedOnBoard count];
            
            for (int i = 0; i < len; i++)
            {
                NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                [self.view addSubview:[playerOneTiles getLetterImg:value]];
                // [self.view addSubview:[playerTwoTiles getLetterImg:value]];
            }
            for (int i = 0; i < 7; i++)
            {
                [self.view bringSubviewToFront:[playerOneTiles getLetterImg:i]];
            }
            //NSLog(@"player ONE bringsubviewtofront ran");
            
            
            [self.tilesPlayedOnBoard removeAllObjects];
            //NSLog(@"does this run on swap?");

        
            self.inMiddleOfPlayingTurn = NO;
            //NSLog(@"player 1, index increased to: %li", boardTilesArrayIndex);
            
            tempScore = len + [self.scoreOneDisplay.text intValue];
            self.scoreOneDisplay.text = [NSString stringWithFormat:@"%li", tempScore];
            playerOneTilesPlayed = 0;
        }
    
    whoseTurn = 2;
    [playerOneTiles setHidden:YES];
        
        
        if (self.programSentButton == NO) {
            UIButton *button;
            UIAlertController *alertController;
            UIAlertAction *continueAction;
            
            alertController = [UIAlertController alertControllerWithTitle:nil
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
            continueAction = [UIAlertAction actionWithTitle:_playerTwoNameTwoPassed
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                        [playerTwoTiles setHidden:NO];
                                                        
                                                        
                                                    }];
            [alertController addAction:continueAction];
            [alertController setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [alertController
                                                             popoverPresentationController];
            popPresenter.sourceView = button;
            popPresenter.sourceRect = button.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
       
                                                     
                                                     
    }
    
    else if (whoseTurn == 2)
    {
        if (self.didSwap == NO)
        {
            [playerTwoTiles refillRack:self.tilesPlayedOnBoard];
            
            NSInteger len = [self.tilesPlayedOnBoard count];
            
            for (int i = 0; i < len; i++)
            {
                NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                //[self.view addSubview:[playerOneTiles getLetterImg:value]];
                [self.view addSubview:[playerTwoTiles getLetterImg:value]];
            }
            
            for (int i = 0; i < 7; i++)
            {
                [self.view bringSubviewToFront:[playerTwoTiles getLetterImg:i]];
            }
            //NSLog(@"player TWO bringsubviewtofront ran");
            
            [self.tilesPlayedOnBoard removeAllObjects];
        

        
        
        //[playerOneTiles setHidden:NO];
        self.inMiddleOfPlayingTurn = NO;
        //NSLog(@"player two, index increased to: %li", boardTilesArrayIndex);
        
        tempScore = len + [self.scoreTwoDisplay.text intValue];
        self.scoreTwoDisplay.text = [NSString stringWithFormat:@"%li", tempScore];
        playerTwoTilesPlayed = 0;
    }

        whoseTurn = 1;
        [playerTwoTiles setHidden:YES];
        
        
        if (self.programSentButton == NO) {
            UIButton *button;
            UIAlertController *alertController;
            UIAlertAction *continueAction;
            
            alertController = [UIAlertController alertControllerWithTitle:nil
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
            continueAction = [UIAlertAction actionWithTitle:_playerOneNamePassed
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                        [playerOneTiles setHidden:NO];
                                                        
                                                        
                                                        
                                                    }];
            [alertController addAction:continueAction];
            [alertController setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [alertController
                                                             popoverPresentationController];
            popPresenter.sourceView = button;
            popPresenter.sourceRect = button.bounds;
            [self presentViewController:alertController animated:YES completion:nil];
        }
       
    
    }
    
    self.didSwap = NO;
    self.programSentButton = NO;
}




-(void) dictionaryChallenge
{
    NSString *tmp;
    
    FMDatabase *database = [FMDatabase databaseWithPath:_databasePath];
    [database open];
    
    FMResultSet *results = [database executeQuery:@"SELECT * FROM words WHERE word LIKE ?;", wordToBeTested];
    
   
    while([results next]) {
        tmp = [results stringForColumn:@"word"];
        //NSLog(@"tmp in dicChallenge: %@" ,tmp);
    }
    
    if (tmp == 0) {
        name = 0;
    }
    else {
        [name setString:tmp];
        //[wordsPlayedArray addObject:name];
        //wordsPlayedCount ++;
    }
    
    //NSLog(@"words in array: %@", wordsPlayedArray);
    
    [database close];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    int i;
    which = 10;
    
    
    if (whoseTurn == 1)
    {
        for (i = 0; i < 7; i++)
        {
            if ([touch view]==[playerOneTiles getLetterImg:i])
            {
                [playerOneTiles setCenter:i andCGPointVal:location];
                which = i;
            }
        }
    }
    
    else if (whoseTurn == 2)
    {
        for (i = 0; i < 7; i++)
        {
            if ([touch view]==[playerTwoTiles getLetterImg:i])
            {
                [playerTwoTiles setCenter:i andCGPointVal:location];
                which = i;
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    int min;
    int closestCol = 0;
    int closestRow = 0;
    int col = 0;
    int row;
    
    float dSquared = 0.0;
    float dX, dY;
    
    
    if (whoseTurn == 1)
    {
        if (which!=10)
        {
            
            if ([playerOneTiles getCenterX:which] > leftX && [playerOneTiles getCenterX:which] < rightX && [playerOneTiles getCenterY:which] > topY && [playerOneTiles getCenterY:which] < bottomY)
            {
                dX = [playerOneTiles getCenterX:which] - [theBoard coordinateX:0 andRow:0];
                dY = [playerOneTiles getCenterY:which] - [theBoard coordinateY:0 andRow:0];
                min = dX*dX+dY*dY+1;
                
                for (row = 0; row < 9; row++)
                {
                    for (col = 0; col < 9; col++)
                    {
                        dX = [playerOneTiles getCenterX:which] - [theBoard coordinateX:col andRow:row];
                        dY = [playerOneTiles getCenterY:which] - [theBoard coordinateY:col andRow:row];
                        dSquared = dX*dX*dY*dY;
                        if (dSquared<min)
                        {
                            min = dSquared;
                            closestCol = col;
                            closestRow = row;
                        }
                    }
                }
                [playerOneTiles setCenter:which andCGPointVal:(CGPointMake([theBoard coordinateX:closestCol andRow:closestRow], [theBoard coordinateY:closestCol andRow:closestRow]))];
                [self.view bringSubviewToFront:[playerOneTiles getLetterImg:which]];
                self.inMiddleOfPlayingTurn = YES;

                if (which == 0) {
                    
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                         if (self.hasBeenSet0) {
                             [[boardTilesArray objectAtIndex:a] setRow:0];
                             [[boardTilesArray objectAtIndex:a] setCol:0];
                             [[boardTilesArray objectAtIndex:a] setLetter:0];
                             a = boardTilesArrayIndex;
                         }
                         else {
                             self.hasBeenSet0 = YES;
                             a = boardTilesArrayIndex;
                         }
                }
                
                else if (which == 1) {
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                        [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                        if (self.hasBeenSet1) {
                            [[boardTilesArray objectAtIndex:b] setRow:0];
                            [[boardTilesArray objectAtIndex:b] setCol:0];
                            [[boardTilesArray objectAtIndex:b] setLetter:0];
                            b = boardTilesArrayIndex;
                        }
                        else {
                            self.hasBeenSet1 = YES;
                            b = boardTilesArrayIndex;
                        }
                }

                else if (which == 2) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                    if (self.hasBeenSet2) {
                        [[boardTilesArray objectAtIndex:c] setRow:0];
                        [[boardTilesArray objectAtIndex:c] setCol:0];
                        [[boardTilesArray objectAtIndex:c] setLetter:0];
                        c = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet2 = YES;
                        c = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 3) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                    if (self.hasBeenSet3) {
                        [[boardTilesArray objectAtIndex:d] setRow:0];
                        [[boardTilesArray objectAtIndex:d] setCol:0];
                        [[boardTilesArray objectAtIndex:d] setLetter:0];
                        d = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet3 = YES;
                        d = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 4) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                    if (self.hasBeenSet4) {
                        [[boardTilesArray objectAtIndex:e] setRow:0];
                        [[boardTilesArray objectAtIndex:e] setCol:0];
                        [[boardTilesArray objectAtIndex:e] setLetter:0];
                        e = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet4 = YES;
                        e = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 5) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                    if (self.hasBeenSet5) {
                        [[boardTilesArray objectAtIndex:f] setRow:0];
                        [[boardTilesArray objectAtIndex:f] setCol:0];
                        [[boardTilesArray objectAtIndex:f] setLetter:0];
                        f = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet5 = YES;
                        f = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 6) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerOneTiles getLetter:which]];
                    if (self.hasBeenSet6) {
                        [[boardTilesArray objectAtIndex:g] setRow:0];
                        [[boardTilesArray objectAtIndex:g] setCol:0];
                        [[boardTilesArray objectAtIndex:g] setLetter:0];
                        g = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet6 = YES;
                        g = boardTilesArrayIndex;
                    }
                }
                
                boardTilesArrayIndex++;
                playerOneTilesPlayed++;
                
                if (![self.tilesPlayedOnBoard containsObject:[NSNumber numberWithInt:which]]) {
                [self.tilesPlayedOnBoard   addObject:[NSNumber numberWithInt:which]];
                }
                
                
                /*
                for (int index = 0; index < 20; index++) {
                    NSString *instanceLetter = [[boardTilesArray objectAtIndex:index] getLetter];
                    int instanceCol = [[boardTilesArray objectAtIndex:index] getCol];
                    int instanceRow = [[boardTilesArray objectAtIndex:index] getRow];
                    
                    NSLog(@"in player ONE During tile placed: %@ %i %i", instanceLetter, instanceRow, instanceCol);
                }*/
                
            }
            else
            {
                CGPoint temp = CGPointMake([playerOneTiles getOriginalCenterX:which], [playerOneTiles getOriginalCenterY:which]);
                [playerOneTiles setCenter:which andCGPointVal:temp];
                if ([self.tilesPlayedOnBoard containsObject:[NSNumber numberWithInt:which]]) {
                    [self.tilesPlayedOnBoard   removeObject:[NSNumber numberWithInt:which]];
                    //NSLog(@"%@", self.tilesPlayedOnBoard);
                }
            }
        }
    }
    
    else if (whoseTurn == 2)
    {
        if (which!=10)
        {
            if ([playerTwoTiles getCenterX:which] > leftX && [playerTwoTiles getCenterX:which] < rightX && [playerTwoTiles getCenterY:which] > topY && [playerTwoTiles getCenterY:which] < bottomY)
            {
                dX = [playerTwoTiles getCenterX:which] - [theBoard coordinateX:0 andRow:0];
                dY = [playerTwoTiles getCenterY:which] - [theBoard coordinateY:0 andRow:0];
                min = dX*dX+dY*dY+1;
                
                for (row = 0; row < 9; row++)
                {
                    for (col = 0; col < 9; col++)
                    {
                        dX = [playerTwoTiles getCenterX:which] - [theBoard coordinateX:col andRow:row];
                        dY = [playerTwoTiles getCenterY:which] - [theBoard coordinateY:col andRow:row];
                        dSquared = dX*dX*dY*dY;
                        if (dSquared<min)
                        {
                            min = dSquared;
                            closestCol = col;
                            closestRow = row;
                        }
                    }
                }
                [playerTwoTiles setCenter:which andCGPointVal:(CGPointMake([theBoard coordinateX:closestCol andRow:closestRow], [theBoard coordinateY:closestCol andRow:closestRow]))];
                [self.view bringSubviewToFront:[playerTwoTiles getLetterImg:which]];
                self.inMiddleOfPlayingTurn = YES;
                
                
                if (which == 0) {
                    
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet0) {
                        [[boardTilesArray objectAtIndex:a] setRow:0];
                        [[boardTilesArray objectAtIndex:a] setCol:0];
                        [[boardTilesArray objectAtIndex:a] setLetter:0];
                        a = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet0 = YES;
                        a = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 1) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet1) {
                        [[boardTilesArray objectAtIndex:b] setRow:0];
                        [[boardTilesArray objectAtIndex:b] setCol:0];
                        [[boardTilesArray objectAtIndex:b] setLetter:0];
                        b = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet1 = YES;
                        b = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 2) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet2) {
                        [[boardTilesArray objectAtIndex:c] setRow:0];
                        [[boardTilesArray objectAtIndex:c] setCol:0];
                        [[boardTilesArray objectAtIndex:c] setLetter:0];
                        c = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet2 = YES;
                        c = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 3) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet3) {
                        [[boardTilesArray objectAtIndex:d] setRow:0];
                        [[boardTilesArray objectAtIndex:d] setCol:0];
                        [[boardTilesArray objectAtIndex:d] setLetter:0];
                        d = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet3 = YES;
                        d = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 4) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet4) {
                        [[boardTilesArray objectAtIndex:e] setRow:0];
                        [[boardTilesArray objectAtIndex:e] setCol:0];
                        [[boardTilesArray objectAtIndex:e] setLetter:0];
                        e = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet4 = YES;
                        e = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 5) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet5) {
                        [[boardTilesArray objectAtIndex:f] setRow:0];
                        [[boardTilesArray objectAtIndex:f] setCol:0];
                        [[boardTilesArray objectAtIndex:f] setLetter:0];
                        f = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet5 = YES;
                        f = boardTilesArrayIndex;
                    }
                }
                
                else if (which == 6) {
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setRow:closestRow];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setCol:closestCol];
                    [[boardTilesArray objectAtIndex:boardTilesArrayIndex] setLetter:[playerTwoTiles getLetter:which]];
                    if (self.hasBeenSet6) {
                        [[boardTilesArray objectAtIndex:g] setRow:0];
                        [[boardTilesArray objectAtIndex:g] setCol:0];
                        [[boardTilesArray objectAtIndex:g] setLetter:0];
                        g = boardTilesArrayIndex;
                    }
                    else {
                        self.hasBeenSet6 = YES;
                        g = boardTilesArrayIndex;
                    }
                }
                
                boardTilesArrayIndex++;
                playerTwoTilesPlayed++;
                
                
                if (![self.tilesPlayedOnBoard containsObject:[NSNumber numberWithInt:which]]) {
                    [self.tilesPlayedOnBoard   addObject:[NSNumber numberWithInt:which]];
                    //NSLog(@"%@", self.tilesPlayedOnBoard);
                }
                
                
                /*
                for (int index = 0; index < 20; index++) {
                    NSString *instanceLetter = [[boardTilesArray objectAtIndex:index] getLetter];
                    int instanceCol = [[boardTilesArray objectAtIndex:index] getCol];
                    int instanceRow = [[boardTilesArray objectAtIndex:index] getRow];
                    
                    //NSLog(@"in player TWO During tile placed: %@ %i %i", instanceLetter, instanceRow, instanceCol);
                }*/
            }
            else
            {
                CGPoint temp = CGPointMake([playerTwoTiles getOriginalCenterX:which], [playerTwoTiles getOriginalCenterY:which]);
                [playerTwoTiles setCenter:which andCGPointVal:temp];
                //NSLog(@"Sent %i back to rack", which);
                
                if ([self.tilesPlayedOnBoard containsObject:[NSNumber numberWithInt:which]]) {
                    [self.tilesPlayedOnBoard   removeObject:[NSNumber numberWithInt:which]];
                    //NSLog(@"%@", self.tilesPlayedOnBoard);
                }
            }
        }
    }
}

- (IBAction)endTurnButton:(UIButton *)sender {
    
    //if (self.programSentButton == NO) {
    
    wordToBeTested = [[NSMutableString alloc] init];
    name = [[NSMutableString alloc] init];
    
    UIButton *button;
    UIAlertController *alertController;
    UIAlertAction *challengeAction;
    UIAlertAction *continueAction;
    
    alertController = [UIAlertController alertControllerWithTitle:_playerTwoNameTwoPassed
                                                          message:@"\n\n\n"
                                                    preferredStyle:UIAlertControllerStyleActionSheet];
    challengeAction = [UIAlertAction actionWithTitle:@"CHALLENGE LAST MOVE"
                                             style:UIAlertActionStyleDestructive
                                           handler:^(UIAlertAction *action) {
                                              
                                               NSSortDescriptor *sortDescriptor;
                                               sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"col" ascending:YES];
                                               NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                                               NSArray *sortedColArray;
                                               sortedColArray = [boardTilesArray sortedArrayUsingDescriptors:sortDescriptors];
                                               
                                            
                                               
                                               //self.skipCol = YES;
                                               int lastCol = 0;
                                               //long lengthOfString;
                                               long maxIndex = [sortedColArray count];
                                               NSString *instanceLetter;
                                               int instanceRow;
                                               int instanceCol;
                                               int numberOfWordsAddedToDictionary = 0;
                                               
                                               /*
                                               for (int index = 0; index < maxIndex; index++) {
                                                   NSString *pinstanceLetter = [[sortedColArray objectAtIndex:index] getLetter];
                                                   int pinstanceCol = [[sortedColArray objectAtIndex:index] getCol];
                                                   int pinstanceRow = [[sortedColArray objectAtIndex:index] getRow];
                                                   NSLog(@"in player TWO During tile placed: %@ %i %i", pinstanceLetter, pinstanceRow, pinstanceCol);
                                               }*/
                                               
                                               
                                               
                                               
                                               for (int currentRow = 0; currentRow < 9; currentRow++) {
                                                   
                                                   for (long index = 0; index < maxIndex; index++) {
                                                       instanceLetter = [[sortedColArray objectAtIndex:index] getLetter];
                                                       instanceRow = [[sortedColArray objectAtIndex:index] getRow];
                                                       instanceCol = [[sortedColArray objectAtIndex:index] getCol];
                                              
                                                        if (instanceRow == currentRow) {
                                                            
                                                           if ([wordToBeTested length] < 1 && [instanceLetter length] > 0) {
                                                               lastCol = [[sortedColArray objectAtIndex:index] getCol];
                                                               [wordToBeTested appendString:instanceLetter];
                                                           }
                                                           
                                                           else if ([wordToBeTested length] > 1 && lastCol + 1 != instanceCol) {
                                                               
                                                               if (![wordsPlayedArray containsObject:wordToBeTested]) {
                                                                   //NSLog(@"FIRST and ROW if, word to test: %@",wordToBeTested);
                                                                   [self dictionaryChallenge];
                                                                   //NSLog(@"log for name: %@", name);
                                                                   
                                                                   if ([name length] != 0) {
                                                                       NSLog(@"%@ exists", name);
                                                                       [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                                       numberOfWordsAddedToDictionary++;
                                                                       [wordToBeTested setString:@""];
                                                                   }
                                                                   
                                                                   else {
                                                                       NSLog(@"%@ word does NOT exist", wordToBeTested);
                                                                       for (int i = 0; i < numberOfWordsAddedToDictionary; i++) {
                                                                           [wordsPlayedArray removeLastObject];
                                                                       }
                                                                       [self recalled:self];
                                                                       [self played];
                                                                       self.skipCol = YES;
                                                                       [wordToBeTested setString:@""];
                                                                   }
                                                               }
                                                               
                                                               else {
                                                                   [wordToBeTested setString:@""];
                                                               }
                                                                   
                                                               if (instanceCol != 0){
                                                                   lastCol = instanceCol;
                                                                   [wordToBeTested appendString:instanceLetter];
                                                               }
                                                           }
                                                            
                                                           else if ([wordToBeTested length] > 0 && lastCol + 1 == instanceCol) {
                                                               [wordToBeTested appendString:instanceLetter];
                                                               lastCol++;
                                                           }
                                                           
                                                           else if (instanceCol != 0){
                                                               [wordToBeTested setString:@""];
                                                               lastCol = instanceCol;
                                                               [wordToBeTested appendString:instanceLetter];
                                                           }
                                                            
                                                           else {
                                                               [wordToBeTested setString:@""];
                                                           }
                                                       }
                                                       
                                                        if ([wordToBeTested length] > 1 && index + 1 == maxIndex) {
                                                            
                                                            if (![wordsPlayedArray containsObject:wordToBeTested]) {
                                                                //NSLog(@"FINAL and ROW if, word to test: %@",wordToBeTested);
                                                                [self dictionaryChallenge];
                                                                //NSLog(@"log for name: %@", name);
                                                                
                                                                if ([name length] != 0) {
                                                                    NSLog(@"%@ exists", name);
                                                                    [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                                    numberOfWordsAddedToDictionary++;
                                                                    [wordToBeTested setString:@""];
                                                                }
                                                                
                                                                else {
                                                                    NSLog(@"%@ word does NOT exist", wordToBeTested);
                                                                    for (int i = 0; i < numberOfWordsAddedToDictionary; i++) {
                                                                        [wordsPlayedArray removeLastObject];
                                                                    }
                                                                [self recalled:self];
                                                                [self played];
                                                                self.skipCol = YES;
                                                                [wordToBeTested setString:@""];
                                                                }
                                                            }
                                                            else {
                                                                [wordToBeTested setString:@""];
                                                            }
                                                        }
                                                   }
                                                   [wordToBeTested setString:@""];
                                               }
                                                       
                                                       
                                              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                       

                                            if (self.skipCol == NO) {
                                                /*
                                               NSSortDescriptor *rowSortDescriptor;
                                               sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
                                               NSArray *rowSortDescriptors = [NSArray arrayWithObject:rowSortDescriptor];
                                               NSArray *sortedRowArray;
                                               sortedRowArray = [sortedColArray sortedArrayUsingDescriptors:rowSortDescriptors];
                                               */
                                                NSSortDescriptor *sortRowDescriptor;
                                                sortRowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
                                                NSArray *sortRowDescriptors = [NSArray arrayWithObject:sortRowDescriptor];
                                                NSArray *sortedRowArray;
                                                sortedRowArray = [boardTilesArray sortedArrayUsingDescriptors:sortRowDescriptors];
                                                
                                               //self.skipCol = YES;
                                               int lastRow = 0;
                                               /*long lengthOfString;
                                               long maxIndex = [sortedColArray count];
                                               NSString *instanceLetter;
                                               int instanceRow;
                                               int instanceCol;
                                               */
                                               
                                               for (int currentCol = 0; currentCol < 9; currentCol++) {
                                                   
                                                   for (long index = 0; index < maxIndex; index++) {
                                                       instanceLetter = [[sortedRowArray objectAtIndex:index] getLetter];
                                                       instanceCol = [[sortedRowArray objectAtIndex:index] getCol];
                                                       instanceRow = [[sortedRowArray objectAtIndex:index] getRow];
                                                       
                                                       if (instanceCol == currentCol) {
                                                           
                                                           if ([wordToBeTested length] < 1 && [instanceLetter length] > 0) {
                                                               lastRow = [[sortedRowArray objectAtIndex:index] getRow];
                                                               [wordToBeTested appendString:instanceLetter];
                                                           }
                                                           
                                                           else if ([wordToBeTested length] > 1 && lastRow + 1 != instanceRow) {
                                                               
                                                               if (![wordsPlayedArray containsObject:wordToBeTested]) {
                                                                   //NSLog(@"FIRST and COL if, word to test: %@",wordToBeTested);
                                                                   [self dictionaryChallenge];
                                                                   //NSLog(@"log for name: %@", name);
                                                                   
                                                                   if ([name length] != 0) {
                                                                       NSLog(@"%@ exists", name);
                                                                       if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                                           [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                                           numberOfWordsAddedToDictionary++;
                                                                       }
                                                                      
                                                                       [wordToBeTested setString:@""];
                                                                   }
                                                                   
                                                                   else {
                                                                       NSLog(@"%@ word does NOT exist", wordToBeTested);
                                                                       for (int i = 0; i < numberOfWordsAddedToDictionary; i++) {
                                                                           [wordsPlayedArray removeLastObject];
                                                                       }
                                                                       [self recalled:self];
                                                                       [self played];
                                                                       [wordToBeTested setString:@""];
                                                                   }
                                                               }
                                                               
                                                               else {
                                                                   [wordToBeTested setString:@""];
                                                               }
                                                               
                                                               if (instanceRow != 0){
                                                                   lastRow = instanceRow;
                                                                   [wordToBeTested appendString:instanceLetter];
                                                               }
                                                           }
                                                           
                                                           else if ([wordToBeTested length] > 0 && lastRow + 1 == instanceRow) {
                                                               [wordToBeTested appendString:instanceLetter];
                                                               lastRow++;
                                                           }
                                                           
                                                           else if (instanceRow != 0){
                                                               [wordToBeTested setString:@""];
                                                               lastRow = instanceRow;
                                                               [wordToBeTested appendString:instanceLetter];
                                                           }
                                                           
                                                           else {
                                                               [wordToBeTested setString:@""];
                                                           }
                                                       }
                                                       
                                                       if ([wordToBeTested length] > 1 && index + 1 == maxIndex) {
                                                           
                                                           if (![wordsPlayedArray containsObject:wordToBeTested]) {
                                                               //NSLog(@"FINAL and COL if, word to test: %@",wordToBeTested);
                                                               [self dictionaryChallenge];
                                                               //NSLog(@"log for name: %@", name);
                                                               
                                                               if ([name length] != 0) {
                                                                   NSLog(@"%@ exists", name);
                                                                   if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                                       [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                                       numberOfWordsAddedToDictionary++;
                                                                   }
                                                                   [wordToBeTested setString:@""];
                                                               }
                                                               
                                                               else {
                                                                   NSLog(@"%@ word does NOT exist", wordToBeTested);
                                                                   for (int i = 0; i < numberOfWordsAddedToDictionary; i++) {
                                                                       [wordsPlayedArray removeLastObject];
                                                                   }
                                                                   [self recalled:self];
                                                                   [self played];
                                                                   [wordToBeTested setString:@""];
                                                               }
                                                           }
                                                           else {
                                                               [wordToBeTested setString:@""];
                                                           }
                                                       }
                                                   }
                                                   [wordToBeTested setString:@""];
                                               }
                                            }

                                               NSLog(@"contents of wordsplayedarray: %@", wordsPlayedArray);
                                               self.skipCol = NO;
                                               self.programSentButton = YES;
                                               [self played];
                                               //self.programSentButton = YES;
                                               [self played];
                                           }];
    
                                               
    continueAction = [UIAlertAction actionWithTitle: @"CONTINUE"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             
                                  
                                            
                                             NSSortDescriptor *sortDescriptor;
                                             sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"col" ascending:YES];
                                             NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                                             NSArray *sortedColArray;
                                             sortedColArray = [boardTilesArray sortedArrayUsingDescriptors:sortDescriptors];
                                             
                                             int lastCol = 0;
                                             long maxIndex = [boardTilesArray count];
                                             NSString *instanceLetter;
                                             int instanceRow;
                                             int instanceCol;
                                             
                                             for (int currentRow = 0; currentRow < 9; currentRow++) {
                                                 
                                                 for (long index = 0; index < maxIndex; index++) {
                                                     instanceLetter = [[boardTilesArray objectAtIndex:index] getLetter];
                                                     instanceRow = [[boardTilesArray objectAtIndex:index] getRow];
                                                     instanceCol = [[boardTilesArray objectAtIndex:index] getCol];
                                                     
                                                     if (instanceRow == currentRow) {
                                                         
                                                         if ([wordToBeTested length] < 1 && [instanceLetter length] > 0) {
                                                             lastCol = [[boardTilesArray objectAtIndex:index] getCol];
                                                             [wordToBeTested appendString:instanceLetter];
                                                         }
                                                         
                                                         else if ([wordToBeTested length] > 1 && lastCol + 1 != instanceCol) {
                                                             
                                                             if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                                 NSLog(@"SECOND if, word to added to wordsplayedarray: %@",wordToBeTested);
                                                                 [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                             }
                                                             [wordToBeTested setString:@""];
                                                             
                                                             
                                                             if (instanceCol != 0){
                                                                 lastCol = instanceCol;
                                                                 [wordToBeTested appendString:instanceLetter];
                                                             }
                                                         }
                                                         
                                                         else if ([wordToBeTested length] > 0 && lastCol + 1 == instanceCol) {
                                                             [wordToBeTested appendString:instanceLetter];
                                                             lastCol++;
                                                         }
                                                         
                                                         else if (instanceCol != 0){
                                                             [wordToBeTested setString:@""];
                                                             lastCol = instanceCol;
                                                             [wordToBeTested appendString:instanceLetter];
                                                         }
                                                         
                                                         else {
                                                             [wordToBeTested setString:@""];
                                                         }
                                                     }
                                                     
                                                     if ([wordToBeTested length] > 1 && index + 1 == maxIndex) {
                                                         
                                                         if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                             NSLog(@"FINAL if, word to add to wordsplayedarray: %@",wordToBeTested);
                                                             [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                         }
                                                         [wordToBeTested setString:@""];
                                                         
                                                     }
                                                 }
                                                 [wordToBeTested setString:@""];
                                             }
                                             
                                             
                                             /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                             
                                             
                                             if (self.skipCol == NO) {
                                                 
                                                 
                                                 NSSortDescriptor *sortRowDescriptor;
                                                 sortRowDescriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
                                                 NSArray *sortRowDescriptors = [NSArray arrayWithObject:sortRowDescriptor];
                                                 NSArray *sortedRowArray;
                                                 sortedRowArray = [boardTilesArray sortedArrayUsingDescriptors:sortRowDescriptors];
                                                 
                                                
                                                 int lastRow = 0;
                                                 
                                                 for (int currentCol = 0; currentCol < 9; currentCol++) {
                                                     
                                                     for (long index = 0; index < maxIndex; index++) {
                                                         instanceLetter = [[sortedRowArray objectAtIndex:index] getLetter];
                                                         instanceCol = [[sortedRowArray objectAtIndex:index] getCol];
                                                         instanceRow = [[sortedRowArray objectAtIndex:index] getRow];
                                                         
                                                         if (instanceCol == currentCol) {
                                                             
                                                             if ([wordToBeTested length] < 1 && [instanceLetter length] > 0) {
                                                                 lastRow = [[sortedRowArray objectAtIndex:index] getRow];
                                                                 [wordToBeTested appendString:instanceLetter];
                                                             }
                                                             
                                                             else if ([wordToBeTested length] > 1 && lastRow + 1 != instanceRow) {
                                                                 
                                                                 if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                                     NSLog(@"Second if, word to add to wordsplayedarray: %@",wordToBeTested);
                                                                     [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                                 }
                                                                 [wordToBeTested setString:@""];
                                                                 
                                                                 if (instanceRow != 0){
                                                                     lastRow = instanceRow;
                                                                     [wordToBeTested appendString:instanceLetter];
                                                                 }
                                                             }
                                                             
                                                             else if ([wordToBeTested length] > 0 && lastRow + 1 == instanceRow) {
                                                                 [wordToBeTested appendString:instanceLetter];
                                                                 lastRow++;
                                                             }
                                                             
                                                             else if (instanceRow != 0){
                                                                 [wordToBeTested setString:@""];
                                                                 lastRow = instanceRow;
                                                                 [wordToBeTested appendString:instanceLetter];
                                                             }
                                                             
                                                             else {
                                                                 [wordToBeTested setString:@""];
                                                             }
                                                         }
                                                         
                                                         if ([wordToBeTested length] > 1 && index + 1 == maxIndex) {
                                                             
                                                             if (![wordsPlayedArray containsObject:wordToBeTested]){
                                                                 NSLog(@"FINAL if, word to add to wordsplayedarray: %@",wordToBeTested);
                                                                 [wordsPlayedArray addObject:[wordToBeTested copy]];
                                                             }
                                                             [wordToBeTested setString:@""];
                                                         }
                                                     }
                                                     [wordToBeTested setString:@""];
                                                 }
                                             }
                                             
                                             NSLog(@"contents of wordsplayedarray: %@", wordsPlayedArray);
                                             [self played];
      }];
    [alertController addAction:continueAction];
    [alertController addAction:challengeAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
//}

    
    //else{
    //    self.programSentButton = YES;
    //    [self played];
    //    [self played];
    //}
}


- (IBAction)recalled:(UIButton *)sender {

    if (whoseTurn == 1) {
        if ([self.tilesPlayedOnBoard count] > 0) {
            
            self.hasBeenSet0 = NO;
            self.hasBeenSet1 = NO;
            self.hasBeenSet2 = NO;
            self.hasBeenSet3 = NO;
            self.hasBeenSet4 = NO;
            self.hasBeenSet5 = NO;
            self.hasBeenSet6 = NO;
            
            
            
            //if (whoseTurn == 1) {
                [playerOneTiles recall:self.tilesPlayedOnBoard];
                NSInteger len = [self.tilesPlayedOnBoard count];
                
                for (int i = 0; i < len; i++)
                {
                    NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                    [self.view addSubview:[playerOneTiles getLetterImg:value]];
                    [self.view addSubview:[playerTwoTiles getLetterImg:value]];
                }
                [self.tilesPlayedOnBoard removeAllObjects];
                //NSLog(@"executed");
            //}
            /*
            else if (whoseTurn == 2) {
                [playerTwoTiles recall:self.tilesPlayedOnBoard];
                NSInteger len = [self.tilesPlayedOnBoard count];
                
                for (int i = 0; i < len; i++)
                {
                    NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                    [self.view addSubview:[playerOneTiles getLetterImg:value]];
                    [self.view addSubview:[playerTwoTiles getLetterImg:value]];
                }
                [self.tilesPlayedOnBoard removeAllObjects];
                NSLog(@"executed");
            }
             */
        }
        
        for (;playerOneTilesPlayed >= 0; playerOneTilesPlayed--) {
            [self->boardTilesArray removeObjectAtIndex:boardTilesArrayIndex];
            [boardTilesArray addObject: [[individualSquares alloc] init]];
            boardTilesArrayIndex--;
        }
        //if (boardTilesArrayIndex < 0) {
            //boardTilesArrayIndex++;
        boardTilesArrayIndex = boardTilesArrayIndex + 1 + [self.tilesPlayedOnBoard count];
        //}
        playerOneTilesPlayed = 0;
        
        
        
        
        
        
        
        
        
        /*
        for (int index = 0; index < 20; index++) {
            NSString *instanceLetter = [[boardTilesArray objectAtIndex:index] getLetter];
            int instanceCol = [[boardTilesArray objectAtIndex:index] getCol];
            int instanceRow = [[boardTilesArray objectAtIndex:index] getRow];
            
            //NSLog(@"in player ONE RECALL button: %@ %i %i", instanceLetter, instanceRow, instanceCol);
        }*/
       
    }
    
    if (whoseTurn == 2) {
        if ([self.tilesPlayedOnBoard count] > 0) {
            
            self.hasBeenSet0 = NO;
            self.hasBeenSet1 = NO;
            self.hasBeenSet2 = NO;
            self.hasBeenSet3 = NO;
            self.hasBeenSet4 = NO;
            self.hasBeenSet5 = NO;
            self.hasBeenSet6 = NO;
            
            
            /*
            if (whoseTurn == 1) {
                [playerOneTiles recall:self.tilesPlayedOnBoard];
                NSInteger len = [self.tilesPlayedOnBoard count];
                
                for (int i = 0; i < len; i++)
                {
                    NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                    [self.view addSubview:[playerOneTiles getLetterImg:value]];
                    [self.view addSubview:[playerTwoTiles getLetterImg:value]];
                }
                [self.tilesPlayedOnBoard removeAllObjects];
                NSLog(@"executed");
            }
             */
            
            //else if (whoseTurn == 2) {
                [playerTwoTiles recall:self.tilesPlayedOnBoard];
                NSInteger len = [self.tilesPlayedOnBoard count];
                
                for (int i = 0; i < len; i++)
                {
                    NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
                    [self.view addSubview:[playerOneTiles getLetterImg:value]];
                    [self.view addSubview:[playerTwoTiles getLetterImg:value]];
                }
                [self.tilesPlayedOnBoard removeAllObjects];
                //NSLog(@"executed");
            //}
        }
        for (;playerTwoTilesPlayed >= 0; playerTwoTilesPlayed--) {
            [self->boardTilesArray removeObjectAtIndex:boardTilesArrayIndex];
            [boardTilesArray addObject: [[individualSquares alloc] init]];
            boardTilesArrayIndex--;
        }
        
        
        
        //if (boardTilesArrayIndex < 0) {
            //boardTilesArrayIndex++;
            boardTilesArrayIndex = boardTilesArrayIndex + 1 + [self.tilesPlayedOnBoard count];
        //}
        playerTwoTilesPlayed = 0;
        
        
        
        
        /*
        for (int index = 0; index < 20; index++) {
            NSString *instanceLetter = [[boardTilesArray objectAtIndex:index] getLetter];
            int instanceCol = [[boardTilesArray objectAtIndex:index] getCol];
            int instanceRow = [[boardTilesArray objectAtIndex:index] getRow];
         
            //NSLog(@"in player TWO RECALL button: %@ %i %i", instanceLetter, instanceRow, instanceCol);
        }*/
    }
    
}

- (IBAction)swap:(id)sender {
    
    if (whoseTurn==1)
    {
        [playerOneTiles emptyArray];
        
        for (int k = 0; k < 7; k++) {
            [self.tilesPlayedOnBoard   addObject:[NSNumber numberWithInt:k]];
            
        }
        [playerOneTiles refillRack:self.tilesPlayedOnBoard];
        
        //NSInteger len = [self.tilesPlayedOnBoard count];
        
        
        for (int i = 0; i < 7; i++)
        {
            NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
            [self.view addSubview:[playerOneTiles getLetterImg:value]];
            //[self.view addSubview:[playerTwoTiles getLetterImg:value]];
        }
        
        self.didSwap = YES;
        [self.tilesPlayedOnBoard removeAllObjects];
        [self played];
    }


    else if (whoseTurn==2)
    {
        [playerTwoTiles emptyArray];
        
        for (int k = 0; k < 7; k++) {
            [self.tilesPlayedOnBoard   addObject:[NSNumber numberWithInt:k]];
            
        }
        [playerTwoTiles refillRack:self.tilesPlayedOnBoard];
        
        //NSInteger len = [self.tilesPlayedOnBoard count];
        
        
        for (int i = 0; i < 7; i++)
        {
            NSInteger value = [[self.tilesPlayedOnBoard objectAtIndex:i] integerValue];
            [self.view addSubview:[playerTwoTiles getLetterImg:value]];
            //[self.view addSubview:[playerTwoTiles getLetterImg:value]];
        }
        
        self.didSwap = YES;
        [self.tilesPlayedOnBoard removeAllObjects];
       [self played];
    }
    
}



@end
