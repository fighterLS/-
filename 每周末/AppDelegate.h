//
//  AppDelegate.h
//  每周末
//
//  Created by 李赛 on 15/12/1.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIStoryboard *storyboard;

- (void)setupLoginViewController;
- (void)setupHomePageController;
@end

