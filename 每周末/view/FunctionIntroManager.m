//
//  FunctionIntroManager.m
//  Coding_iOS
//
//  Created by Ease on 15/8/6.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#define kIntroPageKey @"intro_page_version"
#define kIntroPageNum 2

#import "FunctionIntroManager.h"
#import "EAIntroView.h"
#import "SMPageControl.h"
//#import <NYXImagesKit/NYXImagesKit.h>


@implementation FunctionIntroManager
#pragma mark EAIntroPage

+ (void)showIntroPage{
//    if (![self needToShowIntro]) {
//        return;
//    }
    NSMutableArray *pages = [NSMutableArray new];
    for (int index = 0; index < kIntroPageNum; index ++) {
        EAIntroPage *page = [self p_pageWithIndex:index];
        [pages addObject:page];
    }
    if (pages.count <= 0) {
        return;
    }
    EAIntroView *introView = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andPages:pages];
    introView.backgroundColor = [UIColor whiteColor];
    introView.swipeToExit = YES;
    introView.scrollView.bounces = YES;
    
//    introView.skipButton = [self p_skipButton];
//    introView.skipButtonY = 20.f + CGRectGetHeight(introView.skipButton.frame);
//    introView.skipButtonAlignment = EAViewAlignmentCenter;
    
    if (pages.count <= 1) {
        introView.pageControl.hidden = YES;
    }else{
        introView.pageControl = [self p_pageControl];
        introView.pageControlY = 10.f + CGRectGetHeight(introView.pageControl.frame);
    }
    [introView showFullscreen];
    //
//    [self markHasBeenShowed];
}

+ (void)markHasBeenShowed{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:kVersion_XingQu forKey:kIntroPageKey];
    [defaults synchronize];
}

#pragma mark private M
+ (UIPageControl *)p_pageControl{
    UIImage *pageIndicatorImage = [UIImage imageNamed:@"intro_dot_unselected"];
    UIImage *currentPageIndicatorImage = [UIImage imageNamed:@"intro_dot_selected"];
    
    SMPageControl *pageControl = [SMPageControl new];
    pageControl.pageIndicatorImage = pageIndicatorImage;
    pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
    [pageControl sizeToFit];
    return (UIPageControl *)pageControl;
}

+ (UIButton *)p_skipButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.7, 60)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"0x1b9d59"] forState:UIControlStateHighlighted];
    return button;
}

+ (EAIntroPage *)p_pageWithIndex:(NSInteger)index{
    NSString *imageName = [NSString stringWithFormat:@"intro_page%ld", (long)index];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView;
    if (!image) {
        imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor clearColor];
    }else{
        imageView = [[UIImageView alloc] initWithImage:image];
    }
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    EAIntroPage *page = [EAIntroPage pageWithCustomView:imageView];
    return page;
}

@end
