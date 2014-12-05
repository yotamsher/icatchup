//
//  AppDelegate.m
//  b2cmock
//
//  Created by Yotam Sher on 12/1/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import "AppDelegate.h"
#import "ConnAction.h"
#import "ActionsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSMutableArray * _acions;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _acions = [NSMutableArray arrayWithCapacity:20];
    
    ConnAction *connAction = [[ConnAction alloc] init];
    connAction.title = @"Find a job as CTO";
    connAction.type = @"jobSeek";
    connAction.results = 3;
    connAction.color = 1;
    [_acions addObject:connAction];
    
    connAction = [[ConnAction alloc] init];
    connAction.title = @"Find a job as VP R&D";
    connAction.type = @"jobSeek";
    connAction.results = 2;
    connAction.color = 2;
    [_acions addObject:connAction];
     
    connAction = [[ConnAction alloc] init];
    connAction.title = @"Sell a 2003 Mazda 3";
    connAction.type = @"carSell";
    connAction.results = 17;
    connAction.color = 3;
    [_acions addObject:connAction];

    connAction = [[ConnAction alloc] init];
    connAction.title = @"Buy a job as CTO";
    connAction.type = @"jobSeek";
    connAction.results = 5;
    connAction.color = 4;
    [_acions addObject:connAction];

    connAction = [[ConnAction alloc] init];
    connAction.title = @"Buy a new car";
    connAction.type = @"carBuy";
    connAction.results = 5;
    connAction.color = 5;
    [_acions addObject:connAction];
    
    UIViewController *homeController = (UIViewController *)self.window.rootViewController;
    UIStoryboard *stb = homeController.storyboard;
    ActionsTableViewController *actionsViewController = [stb instantiateViewControllerWithIdentifier:@"ActionsTableViewController"];

    actionsViewController.actions = _acions;

    
    return YES;
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
