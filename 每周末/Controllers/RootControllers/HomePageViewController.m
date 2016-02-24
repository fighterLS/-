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
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 忽略掉底部inset
    self.contentTableView.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}
- (void)loadMoreData
{
    @weakify(self);
    [HomePageModel getHomePageModelBlock:^(NSMutableArray *homePageArray, NSError *error) {
        @strongify(self)
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
                           [sortMenuItems itemWithTitle:@"全部" iconName:@"分类1_1全部" selectIconName:@"选中_1全部" index:0],
                           [sortMenuItems itemWithTitle:@"音乐" iconName:@"分类1_2音乐" selectIconName:@"选中_2音乐" index:1],
                            [sortMenuItems itemWithTitle:@"戏剧" iconName:@"分类1_3戏剧" selectIconName:@"选中_3戏剧" index:2],
                           [sortMenuItems itemWithTitle:@"展览" iconName:@"分类1_4展览" selectIconName:@"选中_4展览" index:4],
                           [sortMenuItems itemWithTitle:@"运动" iconName:@"分类1_5运动" selectIconName:@"选中_5运动" index:5],
                           [sortMenuItems itemWithTitle:@"美食" iconName:@"分类1_6美食" selectIconName:@"选中_6美食" index:6],
                           [sortMenuItems itemWithTitle:@"绘画" iconName:@"分类1_7绘画" selectIconName:@"选中_7绘画" index:7],
                           [sortMenuItems itemWithTitle:@"烘培" iconName:@"分类1_8烘培" selectIconName:@"选中_8烘培" index:8],
                           [sortMenuItems itemWithTitle:@"戏剧" iconName:@"分类1_9手工" selectIconName:@"选中_9手工" index:9],
                           [sortMenuItems itemWithTitle:@"娱乐" iconName:@"分类1_10娱乐" selectIconName:@"选中_10娱乐" index:10],
                           [sortMenuItems itemWithTitle:@"讲座" iconName:@"分类1_11讲座" selectIconName:@"选中_11讲座" index:11],
                           [sortMenuItems itemWithTitle:@"周边游" iconName:@"分类1_12周边游" selectIconName:@"选中_12周边游" index:12],
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
