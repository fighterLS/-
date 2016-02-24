//
//  TCellOderDetail.h
//  每周末
//
//  Created by 李赛 on 15/12/27.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCellOderDetail : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *OrderFeeLable;

@property (strong, nonatomic) Result *homePage;

@end
