//
//  TCellMyCollection.h
//  每周末
//
//  Created by 李赛 on 16/1/23.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCellMyCollection : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UILabel *timeBtn;
@property (weak, nonatomic) IBOutlet UILabel *payInfoLB;
@property (weak, nonatomic) IBOutlet UILabel *locationLB;

@property (strong, nonatomic) Result *homePage;
@end
