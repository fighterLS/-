//
//  MyOrderTableViewCell.m
//  每周末
//
//  Created by 李赛 on 15/12/31.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void) setHomePage:(Result *)homePage
{
    [_imageIconView setImageWithURL:[NSURL URLWithString:[homePage.front_cover_image_list firstObject]] placeholder:[UIImage imageNamed:@"默认图"]];
    _nameLB.text=homePage.title;
    _statueLB.text=@"待支付";
    _totalLB.text=[NSString stringWithFormat:@"合计 %@元",@(homePage.price)];
    //    NSAttributedString
    //    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元/位",homePage.price_info] ];
    //    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"],NSFontAttributeName:[UIFont systemFontOfSize:19]} range:NSMakeRange(0,[homePage.price_info length]+1)];
    //    //    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc] initWithString:homePage.price_info attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"]}];
    //    if(homePage.price_info.length>0)
    //    {
    //        _payInfoLB.attributedText=attributeString;
    //    }else
    //    {
    //        _payInfoLB.text=@"免费";
    //    }
    //
    //    _payInfoLB.text=[NSString stringWithFormat:@"%@",@(homePage.price)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
