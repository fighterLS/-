//
//  HomePageViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "HomePageViewController.h"
#import "TCellHomePage.h"
#import "sortMenuView.h"
#import "DetailPageViewController.h"
#import "NavigationControllerDelegate.h"
#import "HomePageModel.h"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNumber;
}
@property (nonatomic, strong) sortMenuView *myPopMenu;
@property (nonatomic, strong) NSMutableArray *contentListArray;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self headerView];
    _contentListArray=[[NSMutableArray alloc]initWithCapacity:0];
    pageNumber=1;
    [self sendRequest];
    [self footerView];
    _contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     
}
#pragma mark ---refresh---
- (void)headerView
{
    __weak __typeof(self) weakSelf = self;
    _contentListArray=[[NSMutableArray alloc]initWithCapacity:0];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      pageNumber=1;
      [weakSelf sendRequest];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.contentTableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.contentTableView.mj_header beginRefreshing];
}

- (void)footerView
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    // 设置了底部inset
    self.contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 忽略掉底部inset
    self.contentTableView.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

- (void)sendRequest
{
    [self.view beginLoading];
   @weakify(self);
    [HomePageModel getHomePageModelBlock:^(NSMutableArray *homePageArray, NSError *error) {
        @strongify(self)
        [self.view endLoading];
        if (homePageArray.count>0) {
             _contentTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [_contentListArray addObjectsFromArray:homePageArray];
            _contentTableView.delegate=self;
            _contentTableView.dataSource=self;
            [_contentTableView reloadData];
            [self.contentTableView.mj_header endRefreshing];
            [self.contentTableView.mj_footer endRefreshing];
            pageNumber++;
        }
        [self.view configBlankPage:EaseBlankPageTypeTweet hasData:(homePageArray.count > 0) hasError:(error != nil) reloadButtonBlock:^(id sender) {
            [self sendRequest];
        }];
    } withPage:pageNumber];
    
}

- (IBAction)itemTagSelection:(UIBarButtonItem *)sender {
    
    
    NSArray *menuItems = @[
                           [sortMenuItems itemWithTitle:@"分类1_1" iconName:@"分类1_1" index:0],
                           [sortMenuItems itemWithTitle:@"分类1_2" iconName:@"分类1_2" index:1],
                           [sortMenuItems itemWithTitle:@"分类1_3" iconName:@"分类1_3" index:2],
                           [sortMenuItems itemWithTitle:@"分类1_4" iconName:@"分类1_4" index:3],
                           [sortMenuItems itemWithTitle:@"分类1_5" iconName:@"分类1_5" index:4],
                           [sortMenuItems itemWithTitle:@"分类1_6" iconName:@"分类1_6" index:5],
                           [sortMenuItems itemWithTitle:@"分类1_7" iconName:@"分类1_7" index:7],
                           [sortMenuItems itemWithTitle:@"分类1_2" iconName:@"分类1_2" index:8],
                           [sortMenuItems itemWithTitle:@"分类1_3" iconName:@"分类1_3" index:9],
                           [sortMenuItems itemWithTitle:@"分类1_4" iconName:@"分类1_4" index:10],
                           [sortMenuItems itemWithTitle:@"分类1_5" iconName:@"分类1_5" index:11],
                           [sortMenuItems itemWithTitle:@"分类1_6" iconName:@"分类1_6" index:12],
                           ];
    if (!_myPopMenu) {
        _myPopMenu = [[sortMenuView alloc] initWithFrame:kScreen_Bounds items:menuItems];
       }
    if ([_myPopMenu isDescendantOfView:self.view]) {
        [_myPopMenu disMissCurrentView];
    }else
    {
         [_myPopMenu presentViewFromVisibleView:self.view];
    }
   
////    @weakify(self);
//      _myPopMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
//
////        @strongify(self);
//        NSLog(@"%@",selectedItem.title);
//
//    };
//    [_myPopMenu showMenuAtView:[UIApplication sharedApplication].keyWindow startPoint:CGPointMake(0, -100) endPoint:CGPointMake(0, -100)];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCellHomePage *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellHomePage" forIndexPath:indexPath];
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
    Result *model=[_contentListArray objectAtIndex:indexPath.row];
    CGFloat titleHeight=[model.title heightForFont:[UIFont systemFontOfSize:16] width:kScreenWidth-20];
    return kScaleFrom_iPhone6_Desgin(265)+90+titleHeight;
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
    DetailPageViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailPageViewController"];
    viewController.homePageModel=[_contentListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark --UIScrollViewDelegate--
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // Get visible cells on table view.
//    NSArray *visibleCells = [self.contentTableView visibleCells];
//    
//    for (TCellHomePage *cell in visibleCells) {
//        [cell cellOnTableView:self.contentTableView didScrollOnView:self.view];
//    }
//}

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
