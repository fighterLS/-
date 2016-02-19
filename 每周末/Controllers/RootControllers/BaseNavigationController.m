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
-(void)viewWillAppear:(BOOL)animated
{
//    NSArray *list=self.navigationBar.subviews;
//    for (id obj in list) {
//        if ([obj isKindOfClass:[UIImageView class]]) {
//            UIImageView *imageView=(UIImageView *)obj;
//            NSArray *list2=imageView.subviews;
//            for (id obj2 in list2) {
//                if ([obj2 isKindOfClass:[UIImageView class]]) {
//                    UIImageView *imageView2=(UIImageView *)obj2;
//                    imageView2.alpha=0;
//                    //                    imageView2.hidden=YES;
//                }
//            }
//        }
//    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
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
