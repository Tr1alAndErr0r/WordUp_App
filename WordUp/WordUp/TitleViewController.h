//
//  TitleViewController.h
//  WordUp
//
//  Created by Duke Le on 4/28/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface TitleViewController : UIViewController
{
    IBOutlet UITextField *pOneName;
    IBOutlet UITextField *pTwoName;
    IBOutlet UILabel *pOnePrompt;
    IBOutlet UILabel *pTwoPrompt;
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *enterButton;
    
}
@property(nonatomic, strong) NSString *playerOneName;
@property(nonatomic, strong) NSString *playerTwoName;
@property(nonatomic) int count;

-(IBAction)start:(id)sender;
-(IBAction)enter:(id)sender;

@end
