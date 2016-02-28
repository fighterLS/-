//
//  MyOrderDetailViewController.m
//  每周末
//
//  Created by 李赛 on 16/1/23.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import "MyOrderDetailViewController.h"

@interface MyOrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleVIew;
@property (weak, nonatomic) IBOutlet UILabel *priceInfoLabel;

@end

@implementation MyOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_headerImageView setImageWithURL:[NSURL URLWithString:[self.homePage.front_cover_image_list firstObject]] placeholder:[UIImage imageNamed:@"默认图"]];
    _headerTitleVIew.text=self.homePage.title;
    //    NSAttributedString
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元/位",self.homePage.price_info] ];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"],NSFontAttributeName:[UIFont systemFontOfSize:19]} range:NSMakeRange(0,[self.homePage.price_info length]+1)];
    if(self.homePage.price_info.length>0)
    {
        _priceInfoLabel.attributedText=attributeString;
    }else
    {
        _priceInfoLabel.text=@"免费";
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
