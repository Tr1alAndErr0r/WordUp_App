//
//  AppDelegate.m
//  WordUp
//
//  Created by Duke Le on 4/17/15.
//  Copyright (c) 2015 Duke Le. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.words = @"words.db";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentPaths objectAtIndex:0];
    
    self.databasePath = [documentDir stringByAppendingPathComponent:self.words];
    
    [self createAndCheckDatabase];
    
    // Override point for customization after application launch.
    return YES;
}

-(void) createAndCheckDatabase

{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:_databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.words];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:_databasePath error:nil];
}

-(void) testingDatabase
{
    FMDatabase *database = [FMDatabase databaseWithPath:_databasePath];
    [database open];
    
    FMResultSet *results = [database executeQuery:@"select * words"];
    
    while([results next]) {
    NSString *name = [results stringForColumn:@"word"];
    NSLog(@"The word: %@" ,name);
    }
    
    NSLog(@"got this far");
    
[database close];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
