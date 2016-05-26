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
#import "TCellDetailHeader.h"
#import "ScrollPageView.h"
#import "OrderPageViewController.h"
#import "OpenAMapURLRequestViewController.h"
#import "PopMenu.h"
#import "MJPhotoBrowser.h"
const CGFloat BackGroupHeight =280;
@interface DetailPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ScrollPageViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomHoldView;

@property (nonatomic, strong) DetailResult *detailModel;
@property (nonatomic, strong) ScrollPageView *scrollPageView;
@property (nonatomic, strong) PopMenu *myPopMenu;//shareView
@end

@implementation DetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bottomHoldView.hidden=YES;
    _orderFeeButton.layer.masksToBounds=YES;
    _orderFeeButton.layer.cornerRadius=2;
    [self sendRequest];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元/位",_homePageModel.price_info] ];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"],NSFontAttributeName:[UIFont systemFontOfSize:19]} range:NSMakeRange(0,[_homePageModel.price_info length]+1)];
    if(_homePageModel.price_info.length>0)
    {
        _oderFeeLable.attributedText=attributeString;
    }else
    {
        _oderFeeLable.text=@"免费";
    }
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
            _bottomHoldView.hidden=NO;
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
           TCellDetailHeader *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailHeader"];
            if (vCell==nil) {
             vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellDetailHeader" forIndexPath:indexPath];
            }
            vCell.headerTitle.text=_detailModel.title;
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
            [vCell.detailImage setImageWithURL:[NSURL URLWithString:activityModel.content] placeholder:[UIImage imageNamed:@"默认图"]];
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
        return [self createNormalHeaderView:@"活动详情" withHeight:60];
    }else if (section==2)
    {
        return [self createNormalHeaderView:@"预定须知" withHeight:60];
    }else if (section==3)
    {
        return [self createNormalHeaderView:@"提示" withHeight:60];
    }else if (section==0)
    {
        return self.scrollPageView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        CGFloat cellHeight=0.0;
        if (indexPath.row==0) {
        
            cellHeight=[_detailModel.title heightForFont:[UIFont systemFontOfSize:19] width:kScreenWidth-16];
            cellHeight+=180;
        }else
        {
            cellHeight=[_detailModel.address heightForFont:[UIFont systemFontOfSize:17] width:kScreenWidth-60];
            cellHeight+=20;
        }
        return cellHeight;
    }
   else if (indexPath.section==1) {// @"活动详情";
        
         ActivityDescription *activityModel=[ActivityDescription modelWithJSON:[_detailModel.description objectAtIndex:indexPath.row]];
        CGFloat cellHeight=0.0;
        
        if ([activityModel.type isEqualToString:@"text"]) {
            ;
            cellHeight=[activityModel.content heightForFont:[UIFont fontWithName:@"Kailasa" size:13] width:kScreenWidth-46];
            cellHeight+=20;
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
            cellHeight=[activityModel.content heightForFont:[UIFont fontWithName:@"Kailasa" size:13] width:kScreenWidth-46];
            cellHeight+=20;
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
            cellHeight=[activityModel.content heightForFont:[UIFont fontWithName:@"Kailasa" size:13] width:kScreenWidth-46];
            cellHeight+=20;
        }else
        {
            cellHeight=200;
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
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *vCell=[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0&&indexPath.row==1) {
        OpenAMapURLRequestViewController *subViewController =[[OpenAMapURLRequestViewController alloc] init];
        subViewController.location=_detailModel.location;
        subViewController.locationName=_detailModel.poi;
        [self.navigationController pushViewController:subViewController animated:YES];
    }
 
    else if ([vCell isKindOfClass:[TCellDetailImage class]]) {
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image=((TCellDetailImage *)vCell).detailImage.image;
        [photos addObject:photo];
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];
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
#pragma mark ---action----

#pragma mark --convience method--
-(ScrollPageView *)scrollPageView
{
    if (_scrollPageView==nil) {
        _scrollPageView=[[ScrollPageView alloc]initWithFrame:CGRectMake(0, 0, MIN(kScreenHeight, kScreenWidth), kScaleFrom_iPhone6_Desgin(BackGroupHeight)) views:_homePageModel.front_cover_image_list infos:nil];
        _scrollPageView.scrollDelegate=self;
    }
    return _scrollPageView;
}
-(UIView *)createNormalHeaderView:(NSString *)title withHeight:(CGFloat)height
{
    UIView *headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    headView.backgroundColor = [UIColor clearColor];
    
    UIImageView *circleLeftIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"详情圆圈"]];
    circleLeftIcon.left=23;
    circleLeftIcon.bottom=height;
    [headView addSubview:circleLeftIcon];
    
    UIImageView *circleRightIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"详情圆圈"]];
    circleRightIcon.right=kScreenWidth-23;
    circleRightIcon.bottom=height;
    [headView addSubview:circleRightIcon];
    
    UIView *seperateView =  [[UIView alloc]initWithFrame:CGRectMake(circleLeftIcon.right, height-circleLeftIcon.width/2, kScreenWidth-circleLeftIcon.right*2, 0.5)];
    seperateView.backgroundColor =[UIColor colorWithHexString:@"b39954"];
    [headView addSubview:seperateView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, height-35, kScreenWidth-16, 20)];
    titleLabel.text=title;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    titleLabel.textColor=[UIColor colorWithHexString:@"333333"];
    [headView addSubview:titleLabel];
    return headView;
}
-(void)topRecommendContact:(UIButton *)sender
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:_homePageModel.front_cover_image_list.count];
    for (int i = 0; i <_homePageModel.front_cover_image_list.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url=[NSURL URLWithString:[_homePageModel.front_cover_image_list objectAtIndex:i]];
 
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = sender.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (IBAction)oderDetailButtonAction:(UIButton *)sender {
    OrderPageViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"OrderPageViewController"];
    vc.homeModel=_homePageModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shareBtnAction:(UIBarButtonItem *)sender {
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
- (IBAction)collectionBtnAction:(UIButton *)sender {
    sender.selected=!sender.selected;
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
