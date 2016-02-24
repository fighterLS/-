//

//  TCellDetailHeader.m
//  每周末
//
//  Created by 李赛 on 16/1/9.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import "TCellDetailHeader.h"

@implementation TCellDetailHeader

- (void)awakeFromNib {
    self.timeDisplayBtn.layer.masksToBounds=YES;
    self.timeDisplayBtn.layer.cornerRadius=2;
    self.timeDisplayBtn.layer.borderColor=[UIColor colorWithHexString:@"b39954"].CGColor;
    self.timeDisplayBtn.layer.borderWidth=0.5;
    [self.timeDisplayBtn setBackgroundColor:[UIColor clearColor]];
    [self.timeDisplayBtn setTitleColor:[UIColor colorWithHexString:@"b39954"] forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
