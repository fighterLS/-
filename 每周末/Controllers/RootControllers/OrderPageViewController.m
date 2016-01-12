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

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else if (section==1)
    {
        return @"票务类型";
    }
    else
    {
        return 0;
    }

   
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
            return vCell;

    }
    else if (indexPath.section==1)
    {
        TCellOrderSelectButton *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellOrderSelectButton" forIndexPath:indexPath];
    
        return vCell;
    }
    else
    {
        TCellOrderSteper *vCell=[tableView dequeueReusableCellWithIdentifier:@"TCellOrderSteper" forIndexPath:indexPath];
        if (indexPath.row==0) {
            vCell.telephoneNubLB.hidden=YES;
            vCell.stepper.hidden=NO;
        }else
        {
            vCell.telephoneNubLB.hidden=NO;
            vCell.stepper.hidden=YES;
        }
        return vCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 110;
    }
    else if (indexPath.section==1)
    {
        return 44;
    }
    else
    {
        return 44;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (section==1)
    {
        return 30;
    }
   return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        TCellOrderSelectButton *vCell=[tableView cellForRowAtIndexPath:indexPath];
        [_contentTableview selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
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
