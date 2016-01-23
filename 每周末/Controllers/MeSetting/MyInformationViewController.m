//
//  MyInformationViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "MyInformationViewController.h"
#import "UserSetingViewController.h"
#import "PopMenu.h"
@interface MyInformationViewController ()
@property (strong, nonatomic) UIView *headerView;
@property (nonatomic, strong) PopMenu *myPopMenu;//shareView
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

- (void)userIconClicked{
    UserSetingViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"UserSetingViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (IBAction)shareToMyFriendAction:(UIButton *)sender {
    NSArray *menuItems = @[
                           [MenuItem itemWithTitle:@"微信朋友" iconName:@"微信朋友" index:0],
                           [MenuItem itemWithTitle:@"微信朋友圈" iconName:@"微信朋友圈" index:1],
                           [MenuItem itemWithTitle:@"新浪微博" iconName:@"微博" index:2],
                           [MenuItem itemWithTitle:@"QQ" iconName:@"QQ" index:3],
                           ];
    if (!_myPopMenu) {
        _myPopMenu = [[PopMenu alloc] initWithFrame:kScreen_Bounds items:menuItems];
        _myPopMenu.perRowItemCount = 2;
        _myPopMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }
    @weakify(self);
    _myPopMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        @strongify(self);
        switch (selectedItem.index) {
                // NSLog(@"%@",selectedItem.title);
        }
    };
    [_myPopMenu showMenuAtView:[UIApplication sharedApplication].keyWindow startPoint:CGPointMake(0, -100) endPoint:CGPointMake(0, -100)];
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
