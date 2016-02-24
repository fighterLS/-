//
//  TCellOrderSteper.h
//  每周末
//
//  Created by 李赛 on 15/12/27.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKYStepper.h"
@interface TCellOrderSteper : UITableViewCell
@property (weak, nonatomic) IBOutlet PKYStepper *stepper;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNubLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end
