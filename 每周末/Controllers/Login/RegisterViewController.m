//
//  RegisterViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/5.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (weak, nonatomic) IBOutlet UITextField *registerCode;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendCode;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumberText.layer.masksToBounds=YES;
    self.phoneNumberText.layer.cornerRadius=2;
    self.registerCode.layer.masksToBounds=YES;
    self.registerCode.layer.cornerRadius=2;
    self.passwordText.layer.masksToBounds=YES;
    self.passwordText.layer.cornerRadius=2;
    self.registerBtn.layer.masksToBounds=YES;
    self.registerBtn.layer.cornerRadius=2;
    self.sendCode.layer.masksToBounds=YES;
    self.sendCode.layer.cornerRadius=2;
    // Do any additional setup after loading the view.
}

- (IBAction)registerBtnAction:(UIButton *)sender
{
//    [[AVUser user] setMobilePhoneNumber:_phoneNumberText.text];
//    [[AVUser user] setPassword:_passwordText.text];
//    [AVUser verifyMobilePhone:_registerCode.text withBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            
//            [[AVUser user] signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if(succeeded)
//                {
//                    [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
//                }
//                
//            }];
//        }else
//        {
//            [MBProgressHUD showError:@"验证码无效,请重新发送" toView:self.view];
//        }
//    }];
}

///请求验证码
- (IBAction)registerMobilePhoneVerifyCode:(UIButton *)sender
{
//    if ([self checkPhoneNumber:_phoneNumberText.text])
//    {
//        [AVUser requestMobilePhoneVerify:_phoneNumberText.text withBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//                [MBProgressHUD showSuccess:@"发送验证码成功" toView:self.view];
//                [self sendCodeButtonTitleTime];
//            }else
//            {
//                 [MBProgressHUD showError:[error.userInfo objectForKey:@"error"] toView:self.view];
//            }
//        }];
//    }
}

- (void)sendCodeButtonTitleTime

{
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [_sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
                _sendCode.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
        
                [_sendCode setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                
                _sendCode.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
            
            
        }
        
    });
    
    dispatch_resume(_timer);
}
- (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [phoneNumber length]);
    NSArray *matches = [detector matchesInString:phoneNumber options:0 range:inputRange];
    
    BOOL verified = NO;
    
    if ([matches count] != 0) {
        // found match but we need to check if it matched the whole string
        NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
        
        if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length) {
            // it matched the whole string
            verified = YES;
        }
        else {
            // it only matched partial string
            verified = NO;;
        }
    }
    
    return verified;
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
