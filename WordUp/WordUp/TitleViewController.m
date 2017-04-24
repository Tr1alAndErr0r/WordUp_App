//
//  TitleViewController.m
//  WordUp
//
//  Created by Duke Le on 4/28/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "TitleViewController.h"
#import "ViewController.h"

@implementation TitleViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    startButton.hidden = YES;
    pTwoPrompt.hidden = YES;
    pTwoName.hidden = YES;
    self.count = 0;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *svc = [segue destinationViewController];
    svc.playerOneNamePassed = self.playerOneName;
    svc.playerTwoNameTwoPassed = self.playerTwoName;
}

-(IBAction)start:(UIButton *)sender
{
    
}

-(IBAction)enter:(UIButton *)sender
{
    if (self.count == 0)
    {
        self.playerOneName = pOneName.text;
        pOneName.hidden = YES;
        pOnePrompt.hidden = YES;
        pTwoPrompt.hidden = NO;
        pTwoName.hidden = NO;
        self.count = 1;
    }
    
   else if (self.count == 1)
   {
       self.playerTwoName = pTwoName.text;
       pTwoPrompt.hidden = YES;
       pTwoName.hidden = YES;
       startButton.hidden = NO;
       self.count = 3;
       enterButton.hidden = YES;
   }
    
   else
   {
        
   }
    
}
@end
