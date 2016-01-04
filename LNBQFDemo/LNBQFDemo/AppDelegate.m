//
//  AppDelegate.m
//  LNBQFDemo
//
//  Created by Naibin on 15/11/26.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LNBTabBarController.h"
#import "ProfilesViewController.h"
#import "LNBSliderController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSInteger status = [resultDic[@"resultStatus"] integerValue];
            
            if (status == 9000) {
                NSLog(@"支付成功");
            }else {
                NSLog(@"%@",resultDic[@"memo"]);
            }
        }];
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //设置项目 友盟分享 的 key
    [UMSocialData setAppKey:@"5654339767e58e12ef004751"];
    
    //设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    ProfilesViewController * profiles = [[ProfilesViewController alloc] init];
    LNBTabBarController * tab = [[LNBTabBarController alloc] init];
    LNBSliderController * slider = [LNBSliderController shareSliderController];
    
    slider.mainViewController = tab;
    slider.leftViewController = profiles;
    slider.canShowRight = NO;
    
    _window.rootViewController = slider;
    
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
