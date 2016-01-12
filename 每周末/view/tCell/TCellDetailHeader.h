//
//  TCellDetailHeader.h
//  每周末
//
//  Created by 李赛 on 16/1/9.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCellDetailHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;

@property (weak, nonatomic) IBOutlet UIButton *timeDisplayBtn;

@end
