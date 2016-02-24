//
//  OrderPageViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "OrderPageViewController.h"
#import "TCellOderDetail.h"
#import "TCellOrderSteper.h"
#import "TCellOrderSelectButton.h"

@interface OrderPageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLabel;
@property (nonatomic, assign) NSInteger selectFeeType;
@end

@implementation OrderPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTableview.delegate=self;
    self.contentTableview.dataSource=self;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark--<UITableViewDataSource,UITableViewDelegate>------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
// Default is 1 if not implemented
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return [self createNormalHeaderView:@"票务类型" withHeight:46];
    }
    return nil;
}

// fixed font style. use custom view (UILabel) if you want something different

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==1)
    {
        return 3;
    }
    else
    {
        return 2;
    }
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
      TCellOderDetail *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellOderDetail" forIndexPath:indexPath];
        vCell.homePage=_homeModel;
      return vCell;

    }
    else if (indexPath.section==1)
    {
        TCellOrderSelectButton *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellOrderSelectButton" forIndexPath:indexPath];
        if (indexPath.row==0) {
            vCell.titleLB.text=@"大副画";
            vCell.orderFeeLable.text=[NSString stringWithFormat:@"%@",@(_homeModel.price+20)];
        }else if(indexPath.row==1)
        {
            vCell.titleLB.text=@"中副画";
             vCell.orderFeeLable.text=[NSString stringWithFormat:@"%@",@(_homeModel.price+10)];
        }else
        {
            vCell.titleLB.text=@"小副画";
             vCell.orderFeeLable.text=[NSString stringWithFormat:@"%@",@(_homeModel.price)];
        }
        return vCell;
    }
    else
    {
        TCellOrderSteper *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellOrderSteper" forIndexPath:indexPath];
        if (indexPath.row==0) {
            vCell.titleLable.text=@"数量";
            vCell.telephoneNubLB.hidden=YES;
            vCell.stepper.hidden=NO;
             __weak typeof(self) weakSelf=self;
            vCell.stepper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
                stepper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
                weakSelf.totalFeeLabel.text=[NSString stringWithFormat:@"%@元",@(count*_selectFeeType)];
            };
        }else
        {
            vCell.titleLable.text=@"手机号";
            vCell.telephoneNubLB.hidden=NO;
            vCell.stepper.hidden=YES;
        }
        return vCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 89;
    }
    else if (indexPath.section==1)
    {
        return 55;
    }
    else
    {
        return 55;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (section==1)
    {
        return 46;
    }
   return 0.0000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        TCellOrderSelectButton *vCell=[tableView cellForRowAtIndexPath:indexPath];
        [_contentTableview selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        _selectFeeType=[vCell.orderFeeLable.text integerValue];
        vCell.selectButton.selected=vCell.selected;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
     if (indexPath.section==1)
     {
         TCellOrderSelectButton *vCell=[tableView cellForRowAtIndexPath:indexPath];
         [_contentTableview deselectRowAtIndexPath:indexPath animated:NO];
          vCell.selectButton.selected=vCell.selected;
     }
}
//MARK ---convienice Method---
-(UIView *)createNormalHeaderView:(NSString *)title withHeight:(CGFloat)height
{
    UIView *headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    headView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, height-25, 180, 15)];
    titleLabel.text=title;
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    titleLabel.textColor=[UIColor colorWithHexString:@"333333"];
    [headView addSubview:titleLabel];
    return headView;
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
