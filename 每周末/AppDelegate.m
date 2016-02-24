//
//  AppDelegate.m
//  每周末
//
//  Created by 李赛 on 15/12/1.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <Bugtags/Bugtags.h>
#import "HomePageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self gaoDeMapKitInit];
    [self bugTagsInit];
    [self initMMPopupView];
     self.storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self setupLoginViewController];
//    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    // Override point for customization after application launch.
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


#pragma mark --convenince Method-----
- (void)setupLoginViewController{
    
    LoginViewController *loginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:loginVC]];
}

- (void)setupHomePageController{
    HomePageViewController *rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    
    [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:rootVC]];
}
/**
 MMPopupView 为自定义的alertView  和 ActionSheetView
 */
-(void)initMMPopupView
{
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    
//    MMAlertViewConfig *alertConfig = [MMAlertViewConfig globalConfig];
//    MMSheetViewConfig *sheetConfig = [MMSheetViewConfig globalConfig];
//    
//    alertConfig.defaultTextOK = @"OK";
//    alertConfig.defaultTextCancel = @"Cancel";
//    alertConfig.defaultTextConfirm = @"Confirm";
//    
//    sheetConfig.defaultTextCancel = @"Cancel";
}

#pragma mark---SDK包管理 ---
-(void)bugTagsInit
{
    ///MARK --正式上线请去掉--
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:@"eb1cb276785bcb8a22f8c126e5d19f26" invocationEvent:BTGInvocationEventShake options:options];
}
-(void)gaoDeMapKitInit
{
    //地图
    [MAMapServices sharedServices].apiKey = (NSString *)APIKeyGaoDe;
    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKeyGaoDe;
}
@end
