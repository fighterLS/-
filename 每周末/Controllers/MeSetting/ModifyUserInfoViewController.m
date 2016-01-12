//
//  ModifyUserInfoViewController.m
//  每周末
//
//  Created by 李赛 on 15/12/31.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "ModifyUserInfoViewController.h"

@interface ModifyUserInfoViewController ()


@end

@implementation ModifyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userInfoChangeTextFile.text=_modifyTextPremery;
    if ([self.title isEqualToString:@"昵称修改"]) {
        _userInfoChangeTextFile.placeholder=@"请修改您的昵称";
    }else
    {
        _userInfoChangeTextFile.placeholder=@"请修改您的电话号码";
    }
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)saveAndChangeUserInfoAction:(UIBarButtonItem *)sender {
    if (_modifyUserBlock) {
        _modifyUserBlock(_userInfoChangeTextFile.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
