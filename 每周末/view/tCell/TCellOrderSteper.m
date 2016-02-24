//
//  TCellOrderSteper.m
//  每周末
//
//  Created by 李赛 on 15/12/27.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "TCellOrderSteper.h"

@implementation TCellOrderSteper

- (void)awakeFromNib {
    self.stepper.value = 0.0f;
    self.stepper.stepInterval = 1.0f;
    self.stepper.countLabel.text = [NSString stringWithFormat:@"0"];
    [self.stepper setup];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
