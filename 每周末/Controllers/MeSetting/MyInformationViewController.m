//
//  MyInformationViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "MyInformationViewController.h"
#import "UserSetingViewController.h"
@interface MyInformationViewController ()
@property (strong, nonatomic) UIView *headerView;
@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户资料";
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
-(void)setupUI
{
}
- (void)userIconClicked{
    UserSetingViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"UserSetingViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
