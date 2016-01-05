//
//  DetailPageViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "DetailPageViewController.h"
#import "TCellDetailText.h"
#import "TCellDetailImageText.h"
#import "TCellDetailImage.h"
#import "ScrollPageView.h"
#import "OrderPageViewController.h"
#import "OpenAMapURLRequestViewController.h"
const CGFloat BackGroupHeight =375;
@interface DetailPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomHoldView;

@property (weak, nonatomic) IBOutlet UILabel *orderFee;
@property (nonatomic, strong) DetailResult *detailModel;
@property (nonatomic, strong) ScrollPageView *scrollPageView;
@end

@implementation DetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self sendRequest];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)sendRequest{
    
    [self.view beginLoading];
    @weakify(self);
    [HomePageModel getDetailModelBlock:^(DetailResult *detailResult, NSError *error) {
        @strongify(self)
        [self.view endLoading];
        
        _detailModel=detailResult;
        if (detailResult.description.count > 0) {
            _contentTableView.delegate=self;
            _contentTableView.dataSource=self;
            [_contentTableView reloadData];
        }
        [self.view configBlankPage:EaseBlankPageTypeTweet hasData:(detailResult.description.count > 0) hasError:(error != nil) reloadButtonBlock:^(id sender) {
            [self sendRequest];
        }];

    } withLeo_id:[NSString stringWithFormat:@"%@",@(_homePageModel.leo_id)] session_id:@"" v:@"3"];

}
#pragma mark -UITableViewDataSource--UITableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;//标题、地点、时间
    }
    else if(section==1)
    {
        return _detailModel.description.count;//活动描述
    }
    else if(section==2)
    {
        return _detailModel.booking_policy.count;//预定须知
    }
    else if (section==3)
    {
        return _detailModel.lrzm_tips.count;//提示
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
           TCellDetailText *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText"];
            if (vCell==nil) {
             vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText" forIndexPath:indexPath];
            }
            vCell.textLB.text=_detailModel.title;
            return vCell;
        }
        else
        {
            TCellDetailImageText *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImageText"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImageText" forIndexPath:indexPath];
            }
            vCell.textLB.text=_detailModel.address;
            return vCell;
        }

    }
    else if(indexPath.section==1)
    {
        ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.description objectAtIndex:indexPath.row]];
        if ([activityModel.type isEqualToString:@"text"]) {
            TCellDetailText *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText" forIndexPath:indexPath];
            }
             vCell.textLB.text=activityModel.content;
            return vCell;
            
        }
        else
        {
            TCellDetailImage *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage" forIndexPath:indexPath];
            }
            [vCell.detailImage setImageWithURL:[NSURL URLWithString:activityModel.content] placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
             return vCell;   //活动描述
        }
    
       
       
    }
    else if(indexPath.section==2)
    {
        ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.booking_policy objectAtIndex:indexPath.row]];
        if ([activityModel.type isEqualToString:@"text"]) {
            TCellDetailText *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText" forIndexPath:indexPath];
            }
            vCell.textLB.text=activityModel.content;
            return vCell;
            
        }
        else
        {
            TCellDetailImage *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage" forIndexPath:indexPath];
            }
            [vCell.detailImage setImageWithURL:[NSURL URLWithString:activityModel.content] placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            return vCell;
        }
        //预定须知
    }
    else
    {
        ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.lrzm_tips objectAtIndex:indexPath.row]];
        if ([activityModel.type isEqualToString:@"text"]) {
            TCellDetailText *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailText" forIndexPath:indexPath];
            }
            vCell.textLB.text=activityModel.content;
            return vCell;
            
        }
        else
        {
            TCellDetailImage *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage"];
            if (vCell==nil) {
                vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailImage" forIndexPath:indexPath];
            }
            [vCell.detailImage setImageWithURL:[NSURL URLWithString:activityModel.content] placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            return vCell;
        }//提示
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return [self createNormalHeaderView:@"活动详情" withHeight:40];
    }else if (section==2)
    {
        return [self createNormalHeaderView:@"预定须知" withHeight:40];
    }else if (section==3)
    {
        return [self createNormalHeaderView:@"提示" withHeight:40];
    }else if (section==0)
    {
        return self.scrollPageView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {// @"活动详情";
        
         ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.description objectAtIndex:indexPath.row]];
        CGFloat cellHeight=0.0;
        
        if ([activityModel.type isEqualToString:@"text"]) {
            cellHeight=[activityModel.content heightForFont:[UIFont systemFontOfSize:16] width:kScreenWidth-16];
            cellHeight+=10;
        }else
        {
            cellHeight=200;
        }
        return cellHeight;
    }else if (indexPath.section==2)//预定须知
    {
        ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.booking_policy objectAtIndex:indexPath.row]];
        CGFloat cellHeight=0.0;

        if ([activityModel.type isEqualToString:@"text"]) {
            cellHeight=[activityModel.content heightForFont:[UIFont systemFontOfSize:16] width:kScreenWidth-16];
            cellHeight+=10;
        }else
        {
            cellHeight=200;
        }
        return cellHeight;
    }else if (indexPath.section==3)//提示
    {
        ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.lrzm_tips objectAtIndex:indexPath.row]];
        CGFloat cellHeight=0.0;
        
        if ([activityModel.type isEqualToString:@"text"]) {
            cellHeight=[activityModel.content heightForFont:[UIFont systemFontOfSize:16] width:kScreenWidth-16];
            cellHeight+=10;
        }else
        {
            cellHeight=200;
        }
        return cellHeight;
    }
    else if(indexPath.section==0)
    {
        CGFloat cellHeight=0.0;
        if (indexPath.row==0) {
           cellHeight=[_detailModel.title heightForFont:[UIFont systemFontOfSize:17] width:kScreenWidth-16];
            cellHeight+=10;
        }else
        {
            cellHeight=[_detailModel.address heightForFont:[UIFont systemFontOfSize:17] width:kScreenWidth-60];
            cellHeight+=20;
        }
        return cellHeight;
    }
        
        return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return kScaleFrom_iPhone6_Desgin(BackGroupHeight);
    }
    return 40;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==1) {
        OpenAMapURLRequestViewController *subViewController =[[OpenAMapURLRequestViewController alloc] init];

        [self.navigationController pushViewController:subViewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat yOffset  = scrollView.contentOffset.y;
//  
//    CGFloat alpha = (yOffset+BackGroupHeight)/BackGroupHeight;
//    [[self.navigationController.navigationBar valueForKey:@"backgroundView"] setAlpha:alpha];
//    if (alpha>0.7) {
//       _statusBarStyle=UIStatusBarStyleDefault;
//      
//    }else
//    {
//        _statusBarStyle=UIStatusBarStyleLightContent;
//    }
//     [self preferredStatusBarUpdateAnimation];
//}
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --convience method--
-(ScrollPageView *)scrollPageView
{
    if (_scrollPageView==nil) {
        _scrollPageView=[[ScrollPageView alloc]initWithFrame:CGRectMake(0, 0, MIN(kScreenHeight, kScreenWidth), kScaleFrom_iPhone6_Desgin(BackGroupHeight)) views:_homePageModel.front_cover_image_list infos:nil];
    }
    return _scrollPageView;
}
-(UIView *)createNormalHeaderView:(NSString *)title withHeight:(CGFloat)height
{
    UIView *headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    headView.backgroundColor = [UIColor clearColor];
    
    UIView *headViewAlpha =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    headViewAlpha.backgroundColor = [UIColor whiteColor];
    headViewAlpha.alpha = 0.5;
    [headView addSubview:headViewAlpha];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 180, height)];
    titleLabel.text=title;
    titleLabel.backgroundColor=[UIColor clearColor];
    [headView addSubview:titleLabel];
    return headView;
}

- (IBAction)oderDetailButtonAction:(UIButton *)sender {
    OrderPageViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"OrderPageViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
