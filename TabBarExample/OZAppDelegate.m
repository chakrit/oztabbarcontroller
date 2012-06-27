//
//  OZAppDelegate.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZAppDelegate.h"
#import "OZMenuViewController.h"


@implementation OZAppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    OZMenuViewController *menuViewController = nil;
    menuViewController = [[OZMenuViewController alloc] init];
    
    UINavigationController *nav = nil;
    nav = [UINavigationController alloc];
    nav = [nav initWithRootViewController:menuViewController];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:nav];
    [_window setBackgroundColor:[UIColor whiteColor]];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application { }
- (void)applicationDidEnterBackground:(UIApplication *)application { }
- (void)applicationWillEnterForeground:(UIApplication *)application { }
- (void)applicationDidBecomeActive:(UIApplication *)application { }
- (void)applicationWillTerminate:(UIApplication *)application { }

@end
