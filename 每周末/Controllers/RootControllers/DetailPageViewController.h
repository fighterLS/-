//
//  DetailPageViewController.h
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *oderFeeLable;
@property (weak, nonatomic) IBOutlet UIButton *orderFeeButton;

@property (nonatomic, strong) UIImageView *imageBG;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) Result *homePageModel;///<首页传来的model
@end
