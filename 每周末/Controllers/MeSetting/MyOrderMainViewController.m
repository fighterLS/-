//
//  MyOrderMainViewController.m
//  每周末
//
//  Created by 李赛 on 15/12/31.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "MyOrderMainViewController.h"
#import "MyOnGoingOrderViewController.h"
#import "MyFinishedOrderViewController.h"
@interface MyOrderMainViewController ()

@end

@implementation MyOrderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    
    [self.containerView setFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-40)];
    [self.buttonBarView setBackgroundColor:[UIColor whiteColor]];
    [self.buttonBarView.selectedBar setBackgroundColor:COLOR(167, 127, 1)];
    self.buttonBarView.selectedBarHeight=2;
    self.buttonBarView.cellWidthFloat=self.view.bounds.size.width/2-7;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:[UIColor blackColor]];
            [newCell.label setTextColor:COLOR(167, 127, 1)];
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                     oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                 }
                                 completion:nil];
            }
            else{
                newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }
        }
    };
    
}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
     MyOnGoingOrderViewController *vc1=[[MyOnGoingOrderViewController alloc]initWithStyle:UITableViewStyleGrouped];
     MyFinishedOrderViewController *vc2=[[MyFinishedOrderViewController alloc]initWithStyle:UITableViewStyleGrouped];
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:vc1,vc2, nil];
    return childViewControllers;
}

-(void)reloadPagerTabStripView
{
    self.isProgressiveIndicator = (rand() % 2 == 0);
    self.isElasticIndicatorLimit = (rand() % 2 == 0);
    [super reloadPagerTabStripView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
