//
//  MyCollectionViewController.m
//  每周末
//
//  Created by 李赛 on 16/1/22.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "TCellMyCollection.h"
#import "DetailPageViewController.h"
@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *contentListArray;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.delegate=self;
    _contentListArray=[[NSMutableArray alloc]initWithCapacity:0];
      _contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self sendRequest];
    // Do any additional setup after loading the view.
}
- (void)sendRequest
{
    [self.view beginLoading];
    @weakify(self);
    [HomePageModel getHomePageModelBlock:^(NSMutableArray *homePageArray, NSError *error) {
        @strongify(self)
        [self.view endLoading];
        if (homePageArray.count>0) {
            [_contentListArray addObjectsFromArray:homePageArray];
              _contentTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.contentTableView reloadData];
            self.contentTableView.delegate=self;
            self.contentTableView.dataSource=self;
//            [self.contentTableView.mj_header endRefreshing];
//            [self.contentTableView.mj_footer endRefreshing];
        }
        [self.contentTableView configBlankPage:EaseBlankPageTypeTweet hasData:(homePageArray.count > 0) hasError:(error != nil) reloadButtonBlock:^(id sender) {
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
    TCellMyCollection *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellMyCollection" forIndexPath:indexPath];
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
    DetailPageViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailPageViewController"];
    viewController.homePageModel=[_contentListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
