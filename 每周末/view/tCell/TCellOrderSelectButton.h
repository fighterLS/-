//
//  TCellOrderSelectButton.h
//  每周末
//
//  Created by 李赛 on 15/12/27.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCellOrderSelectButton : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *orderFeeLable;
@property (strong, nonatomic) Result *homePage;
@end
