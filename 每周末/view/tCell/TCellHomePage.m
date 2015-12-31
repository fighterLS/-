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
    [_headerImage setImageWithURL:[NSURL URLWithString:[homePage.front_cover_image_list firstObject]] placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    _titleLB.text=homePage.title;
    _subTitleLB.text=[NSString stringWithFormat:@"%@·%@",homePage.poi_name,homePage.category];
}
//- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
//{
//    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
//    
//    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
//    float difference = CGRectGetHeight(self.headerImage.frame) - CGRectGetHeight(self.frame);
//    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
//    
//    CGRect imageRect = self.headerImage.frame;
//    imageRect.origin.y = -(difference/2)+move;
//    self.headerImage.frame = imageRect;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
