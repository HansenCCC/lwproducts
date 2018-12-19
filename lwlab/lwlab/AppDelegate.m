//
//  AppDelegate.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/14.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "AppDelegate.h"
#import "LWLabRootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    LWLabRootViewController *controller = [[LWLabRootViewController alloc] init];
    LWLabNavigationController_Basic *navigationContolloer = [[LWLabNavigationController_Basic alloc] initWithRootViewController:controller];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationContolloer;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
