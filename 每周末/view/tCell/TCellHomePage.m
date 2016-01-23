//
//  TCellHomePage.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/9.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "TCellHomePage.h"

@implementation TCellHomePage

- (void)awakeFromNib {
    // Initialization code
}

- (void) setHomePage:(Result *)homePage
{
    [_headerImage setImageWithURL:[NSURL URLWithString:[homePage.front_cover_image_list firstObject]] placeholder:[UIImage imageNamed:@"默认图"]];
    _titleLB.text=homePage.title;
//    NSAttributedString
//    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:homePage.price_info attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"b39954"]}];
//    _payInfoLB.attributedText=attributeString;
    _payInfoLB.text=[NSString stringWithFormat:@"%@",@(homePage.price)];
}
- (IBAction)colloctionBtnAction:(UIButton *)sender {
    sender.selected=!sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
