//
//  OrderPageViewController.h
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *contentTableview;
@property (nonatomic, strong) Result *homeModel;///<临时
@end
