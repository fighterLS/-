//
//  ModifyUserInfoViewController.h
//  每周末
//
//  Created by 李赛 on 15/12/31.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ ModifyUserInfoBlock)(NSString *modifyString);
@interface ModifyUserInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *userInfoChangeTextFile;
@property (nonatomic,copy) ModifyUserInfoBlock modifyUserBlock;
@property (nonatomic, copy) NSString *modifyTextPremery;
@end
