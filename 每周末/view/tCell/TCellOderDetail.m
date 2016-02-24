//
//  TCellOderDetail.m
//  每周末
//
//  Created by 李赛 on 15/12/27.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "TCellOderDetail.h"

@implementation TCellOderDetail

- (void)awakeFromNib {
    // Initialization code
}
-(void)setHomePage:(Result *)homePage
{
    [_iconImage setImageWithURL:[NSURL URLWithString:[homePage.front_cover_image_list firstObject]] placeholder:[UIImage imageNamed:@"默认图"]];
    _titleNameLabel.text=homePage.title;

    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元/位",homePage.price_info] ];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"],NSFontAttributeName:[UIFont systemFontOfSize:19]} range:NSMakeRange(0,[homePage.price_info length]+1)];
    //    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc] initWithString:homePage.price_info attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"]}];
    if(homePage.price_info.length>0)
    {
        _OrderFeeLable.attributedText=attributeString;
    }else
    {
        _OrderFeeLable.text=@"免费";
    }
    
    //    _payInfoLB.text=[NSString stringWithFormat:@"%@",@(homePage.price)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
