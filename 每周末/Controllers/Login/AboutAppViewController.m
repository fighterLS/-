//
//  AboutAppViewController.m
//  每周末
//
//  Created by 李赛 on 16/2/24.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import "AboutAppViewController.h"

@interface AboutAppViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleDiscriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleDiscriptionLabel.text=@"是一款生活休闲指南应用\n为年轻人提供精神品质活动\n一站式预定体验\n打造属于你的快乐周末";
    self.versionLabel.text=@"V1.0\n\n微信公众号：每周末\n合作联系：zhoumo@com";
    // Do any additional setup after loading the view.
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
