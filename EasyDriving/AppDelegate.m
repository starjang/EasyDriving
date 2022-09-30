//
//  AppDelegate.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingVC.h"
#import "ZYNetworkAccessibity.h"
#import <AMapFoundationKit/AMapServices.h>
#import "BaseHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nvc = [[UINavigationController alloc]init];
    self.window.rootViewController = nvc;
    [nvc pushViewController:[[LoadingVC alloc]init] animated:NO];
    
    [self.window makeKeyAndVisible];

    [AMapServices sharedServices].apiKey = aMapKey;

    return YES;
}

- (void)checkNetworkAvailable {
    [ZYNetworkAccessibity start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];
}

- (void)networkChanged:(NSNotification *)notification {
    
    ZYNetworkAccessibleState state = ZYNetworkAccessibity.currentState;
    
    if (state == ZYNetworkRestricted) {
        NSLog(@"网络权限被关闭");
        [ZYNetworkAccessibity setAlertEnable:YES];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
