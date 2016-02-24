//
//  sortMenuCollectionCell.h
//  YYKitDemo
//
//  Created by 李赛 on 15/12/15.
//  Copyright © 2015年 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sortMenuView.h"
@interface sortMenuCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *IconButton;
@property (nonatomic, strong) sortMenuItems *menuItems;
@end
