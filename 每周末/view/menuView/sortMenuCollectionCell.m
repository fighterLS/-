//
//  sortMenuCollectionCell.m
//  YYKitDemo
//
//  Created by 李赛 on 15/12/15.
//  Copyright © 2015年 ibireme. All rights reserved.
//

#import "sortMenuCollectionCell.h"

@implementation sortMenuCollectionCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setMenuItems:(sortMenuItems *)menuItems
{
    [_IconButton setImage:[UIImage imageNamed:menuItems.iconName] forState:UIControlStateNormal];
    [_IconButton setImage:[UIImage imageNamed:menuItems.selectIconName] forState:UIControlStateSelected];
    [_IconButton setTitle:[NSString stringWithFormat:@"  %@",menuItems.title] forState:UIControlStateNormal];
    [_IconButton setTitle:[NSString stringWithFormat:@"  %@",menuItems.title]  forState:UIControlStateSelected];
    [_IconButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [_IconButton setTitleColor:[UIColor colorWithHexString:@"b39954"] forState:UIControlStateSelected];
}
@end
