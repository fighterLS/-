//
//  UserSetingViewController.m
//  兴趣周末
//
//  Created by 李赛 on 15/10/30.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "UserSetingViewController.h"
#import "ModifyUserInfoViewController.h"
@interface UserSetingViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickName;
@property (weak, nonatomic) IBOutlet UILabel *telephoneNumLB;
@property (weak, nonatomic) IBOutlet UIButton *quiteButton;

@end

@implementation UserSetingViewController
#pragma mark --life cycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"个人中心";
    self.quiteButton.layer.masksToBounds=YES;
    self.quiteButton.layer.cornerRadius=2;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark ---action----
- (IBAction)userInoLogoutAction:(UIButton *)sender {
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    [appDelegate setupLoginViewController];
}

- (IBAction)changeUserPicAction:(UIButton *)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.tintColor=COLOR(167, 127, 1);
    picker.delegate =self;
    picker.allowsEditing=YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)changeUserNickNameAction:(UIButton *)sender {
    ModifyUserInfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ModifyUserInfoViewController"];
    vc.title=@"昵称修改";
    vc.modifyUserBlock=^(NSString *modifyString){
        _userNickName.text=modifyString;
    };
    vc.userInfoChangeTextFile.placeholder=@"请修改您的昵称";
     vc.modifyTextPremery=_userNickName.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)changeUserTelephoneNumber:(UIButton *)sender {
    ModifyUserInfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ModifyUserInfoViewController"];
    vc.title=@"电话修改";
    vc.modifyUserBlock=^(NSString *modifyString){
        _telephoneNumLB.text=modifyString;
    };
    vc.userInfoChangeTextFile.placeholder=@"请修改您的电话号码";
     vc.modifyTextPremery=_telephoneNumLB.text;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark-- delegate---
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:^{
//        NSData *imageData = UIImageJPEGRepresentation(image,0.5);
//        
//        NSString *string = [imageData base64EncodedString];
        _userPicImageView.image=image;
    }];

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
