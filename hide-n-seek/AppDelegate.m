//
//  AppDelegate.m
//  hide-n-seek
//
//  Created by Damon Swayn on 6/12/2014.
//  Copyright (c) 2014 shruubi. All rights reserved.
//

#import "AppDelegate.h"

#import <ESTBeaconManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // App ID and App Token should be provided using method below
    // to allow beacons connection and Estimote Cloud requests possible.
    // Both values can be found in Estimote Cloud ( http://cloud.estimote.com )
    // in Account Settings tab.
    
    NSLog(@"ESTAppDelegate: APP ID and APP TOKEN are required to connect to your beacons and make Estimote API calls.");
    [ESTBeaconManager setupAppID:@"app_2p2uxsm1wy" andAppToken:@"4f705f2fe1f6787764bc2abb19bf9235"];
    
    // Estimote Analytics allows you to log activity related to monitoring mechanism.
    // At the current stage it is possible to log all enter/exit events when monitoring
    // Particular beacons (Proximity UUID, Major, Minor values needs to be provided).
    
    NSLog(@"ESTAppDelegate: Analytics are turned OFF by defaults. You can enable them changing flag");
    [ESTBeaconManager enableAnalytics:YES];
    
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
