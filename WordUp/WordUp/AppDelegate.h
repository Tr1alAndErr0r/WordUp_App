//
//  AppDelegate.h
//  WordUp
//
//  Created by Duke Le on 4/17/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *words;
@property (strong, nonatomic) NSString *databasePath;

@end

