//
//  AppDelegate.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/10.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "AppDelegate.h"
#import "METabBarController.h"
#import <MMDrawerController.h>
#import "MEChannelViewController.h"
#import "MEPlayer.h"
#import <MMDrawerController.h> 

#import "MEPlayMusicController.h"

@interface AppDelegate ()

{
    UIImageView *launchImage;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    METabBarController *centerVC = [[METabBarController alloc] init];
    UIViewController *leftVC = [[UIViewController alloc] init];
    leftVC.view.backgroundColor = [UIColor yellowColor];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
    MMDrawerController *rootVC = [[MMDrawerController alloc] initWithCenterViewController:centerVC leftDrawerViewController:leftNav];
    [rootVC setShowsShadow:NO];
    [rootVC setMaximumLeftDrawerWidth:200.0];
    [rootVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [rootVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    launchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"launchImage"]];
    launchImage.backgroundColor = [UIColor whiteColor];
    launchImage.frame = kScreenBounds;
    [self.window addSubview:launchImage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self launchImageDisappear:launchImage];
    });
    
    
    return YES;
}

-(void)launchImageDisappear:(UIImageView *)launchView
{
    [UIView transitionFromView:launchImage toView:self.window.rootViewController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL]; 
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    // 开始接受远程事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    // 显示图片
    if ([MEPlayer shareMEPlayer].isPlaying) {
        
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 结束接受远程事件
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlStop:{
                NSLog(@"停止事件");
            }
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:{
                // 线控播放, 如果正在播放点击就暂停播放, 如果暂停点击就开始播放
                
                if ([MEPlayer shareMEPlayer].isPlaying) {
                    // 暂停播放
                    
                }else{
                    // 继续播放
                }
            }
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:{
                // 上一曲
                
            }
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:{
                //下一曲 以及耳机点击二次
                
            }
                break;
                
            case UIEventSubtypeRemoteControlPlay:{
                // 后台开始播放
                
            }
                break;
                
            case UIEventSubtypeRemoteControlPause:{
                //后台暂停播放
                
            }
                break;
                
            default:
                break;
        }
    }
}

@end
