//
//  sortMenuView.h
//  YYKitDemo
//
//  Created by 李赛 on 15/12/15.
//  Copyright © 2015年 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sortMenuView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UIToolbar *blurWhiteBackgroundView;///<模糊背景
@property (nonatomic, strong) NSMutableArray *menuItemsArray;///<items数组，里面元素是sortMenuItems
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) UIView *maskView;///<遮罩背景图

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
-(void)presentViewFromVisibleView:(UIView *)view;///<推出view
-(void)disMissCurrentView;///删除view
@end

@interface sortMenuItems: NSObject
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger index;
- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName index:(NSInteger)index;
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName index:(NSInteger)index;
@end