//
//  OrderConfirmViewController.m
//  每周末
//
//  Created by 李赛 on 16/1/24.
//  Copyright © 2016年 李赛. All rights reserved.
//

#import "OrderConfirmViewController.h"

@interface OrderConfirmViewController ()<UIActionSheetDelegate>

@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    
//    if (kiOS8Later) {
//        UIAlertController *actionSheetVC=[UIAlertController alertControllerWithTitle:@"支付方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *aliPayAction=[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            _payInfo.text=@"支付宝";
//        }];
//        [actionSheetVC addAction:aliPayAction];
//        
//        UIAlertAction *weiChatAction=[UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            _payInfo.text=@"支付宝";
//        }];
//        [actionSheetVC addAction:weiChatAction];
//        
//        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [actionSheetVC addAction:cancelAction];
//    }
//    else
//    {
//        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付宝",@"微信", nil];
//        [actionSheet showInView:self.view];
//    }
    NSArray *itemTitleArray=[NSArray arrayWithObjects:@"支付宝",@"微信", nil];
    __weak typeof(self) weakSelf=self;
    MMPopupItemHandler block = ^(NSInteger index){
        weakSelf.payInfo.text=[itemTitleArray objectAtIndex:index];
       // NSLog(@"clickd %@ button",@(index));
    };
    NSArray *items =
    @[MMItemMake([itemTitleArray objectAtIndex:0], MMItemTypeNormal, block),
      MMItemMake([itemTitleArray objectAtIndex:1], MMItemTypeNormal, block)];
    MMSheetView *sheetView=[[MMSheetView alloc]initWithTitle:@"支付方式" items:items];
    [sheetView show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)action:(NSUInteger)index;
{
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
    };
    
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finish){
        NSLog(@"animation complete");
    };
    
    switch ( index ) {
        case 0:
        {
            NSArray *items =
            @[MMItemMake(@"Done", MMItemTypeNormal, block),
              MMItemMake(@"Save", MMItemTypeHighlight, block),
              MMItemMake(@"Cancel", MMItemTypeNormal, block)];
            
            MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"AlertView"
                                                                 detail:@"each button take one row if there are more than 2 items"
                                                                  items:items];
            alertView.attachedView = self.tableView.superview;
            
            [alertView show];
            
            break;
        }
        case 1:
        {
            [[[MMAlertView alloc] initWithConfirmTitle:@"AlertView" detail:@"Confirm Dialog"] showWithBlock:completeBlock];
            break;
        }
        case 2:
        {
            [[[MMAlertView alloc] initWithInputTitle:@"AlertView" detail:@"Input Dialog" placeholder:@"Your placeholder" handler:^(NSString *text) {
                NSLog(@"input:%@",text);
            }] showWithBlock:completeBlock];
            break;
        }
        case 3:
        {
            NSArray *items =
            @[MMItemMake(@"Normal", MMItemTypeNormal, block),
              MMItemMake(@"Highlight", MMItemTypeHighlight, block),
              MMItemMake(@"Disabled", MMItemTypeDisabled, block)];
            
            [[[MMSheetView alloc] initWithTitle:@"SheetView"
                                          items:items] showWithBlock:completeBlock];
            break;
        }
        default:
            break;
    }
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==2) {
//        return;
//    }
//    _payInfo.text=[actionSheet buttonTitleAtIndex:buttonIndex];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
