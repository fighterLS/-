//
//  BaseNavigationController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.

#import "BaseNavigationController.h"
#import "NavigationControllerDelegate.h"
@implementation BaseNavigationController

//- (BOOL)shouldAutorotate{
//    return [self.visibleViewController shouldAutorotate];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [self.visibleViewController supportedInterfaceOrientations];
//}
#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
