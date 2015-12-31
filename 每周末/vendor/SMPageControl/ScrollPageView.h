//
//  ScrollPageView.h
//  TVFan
//
//  Created by apple on 12-11-28.
//  Copyright (c) 2012年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
@protocol ScrollPageViewDelegate <NSObject>
-(void)topRecommendContact:(UIButton *)sender;
@end
@interface ScrollPageView : UIView<UIScrollViewDelegate>
{
 
}


@property(nonatomic,retain)UIScrollView *scroll;
@property(nonatomic,retain)SMPageControl *pageControl;
@property(nonatomic,assign)NSInteger pages;
@property(nonatomic,retain)UILabel *infoLabel;
@property(nonatomic,retain)NSArray *infos;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) id<ScrollPageViewDelegate>scrollDelegate;

- (id)initWithFrame:(CGRect)frame views:(NSArray *)views infos:(NSArray *)infos;

@end
