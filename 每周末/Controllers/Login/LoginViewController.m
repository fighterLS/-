//
//  LoginViewController.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loadBtn;

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordText.layer.masksToBounds=YES;
    self.passwordText.layer.cornerRadius=2;
    self.phoneNumberText.layer.masksToBounds=YES;
    self.phoneNumberText.layer.cornerRadius=2;
    self.loadBtn.layer.masksToBounds=YES;
    self.loadBtn.layer.cornerRadius=2;
    // Do any additional setup after loading the view.
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    [appDelegate setupHomePageController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
    
}
-(BOOL)shouldAutorotate
{
    return NO;
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
