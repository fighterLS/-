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
    self.stepper.value = 1.0f;
    self.stepper.stepInterval = 1.0f;
   // __weak typeof(self) weakSelf=self;
    self.stepper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        stepper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
    };
    [self.stepper setup];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
