//
//  TCellHomePage.h
//  兴趣周末
//
//  Created by 李赛 on 15/10/9.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCellHomePage : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (strong, nonatomic) Result *homePage;
//- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;
@end
