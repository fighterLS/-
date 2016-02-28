//
//  MyOnGoingOrderViewController.m
//  每周末
//
//  Created by 李赛 on 15/12/31.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "MyOnGoingOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderDetailViewController.h"
@interface MyOnGoingOrderViewController ()
@property (nonatomic, strong) NSMutableArray *contentListArray;
@end

@implementation MyOnGoingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
     self.tableView.delegate=self;
        _contentListArray=[[NSMutableArray alloc]initWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyOrderTableViewCell"];
    [self sendRequest];
    // Do any additional setup after loading the view.
}
- (void)sendRequest
{
    [[UIApplication sharedApplication].keyWindow beginLoading];
    @weakify(self);
    [HomePageModel getHomePageModelBlock:^(NSMutableArray *homePageArray, NSError *error) {
        @strongify(self)
         [[UIApplication sharedApplication].keyWindow endLoading];
        if (homePageArray.count>0) {
            [_contentListArray addObjectsFromArray:homePageArray];
            [self.tableView reloadData];
//            self.contentTableView.delegate=self;
//            self.contentTableView.dataSource=self;
            //            [self.contentTableView.mj_header endRefreshing];
            //            [self.contentTableView.mj_footer endRefreshing];
        }
        [self.tableView configBlankPage:EaseBlankPageTypeTweet hasData:(homePageArray.count > 0) hasError:(error != nil) reloadButtonBlock:^(id sender) {
            [self sendRequest];
        }];
    } withPage:0];
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell *vCell=[tableView dequeueReusableCellWithIdentifier:@"MyOrderTableViewCell" forIndexPath:indexPath];
    vCell.homePage=[_contentListArray objectAtIndex:indexPath.row];
    return vCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MyOrderDetailViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"MyOrderDetailViewController"];
    vc.homePage=[_contentListArray objectAtIndex:indexPath.row];
    [[self presentingVC].navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"进行中";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor blackColor];
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
