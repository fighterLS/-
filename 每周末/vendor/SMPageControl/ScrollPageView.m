//
//  ScrollPageView.m
//  TVFan
//
//  Created by apple on 12-11-28.
//  Copyright (c) 2012年 apple. All rights reserved.
//

#import "ScrollPageView.h"
#define TURN_PAGE_TIME 3.0f

@interface ScrollPageView(){
    CGRect _frame;
    NSInteger currentPageIndex;
}


@end


@implementation ScrollPageView

@synthesize scroll;
@synthesize pageControl,pages;

- (id)initWithFrame:(CGRect)frame views:(NSArray *)views infos:(NSArray *)infos
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _frame=frame;
       
        self.backgroundColor=[UIColor clearColor];
        
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:views];
        if (views.count) {
            [tempArray insertObject:[views objectAtIndex:([views count]-1)] atIndex:0];
            [tempArray addObject:[views objectAtIndex:0]];
        }
        
        _imageArray=[NSArray arrayWithArray:tempArray];
        _infos=[NSArray arrayWithArray:infos];
        
        pages=_imageArray.count;
        
    

        //创建主滚动视图
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,_frame.size.width, _frame.size.height)];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.userInteractionEnabled = YES;
        scroll.backgroundColor= [UIColor clearColor];
        scroll.bounces = YES;
        scroll.contentSize = CGSizeMake(_frame.size.width*pages, _frame.size.height);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
       // [scroll.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
        [self addSubview:scroll];
       
        for (int i=0;i<pages;i++) {
            
            UIImageView *button = [[UIImageView alloc]init];//[UIButton buttonWithType:UIButtonTypeCustom];
            if (i==0) {
                button.tag =i;
            }else if(i==pages-1)
            {
                button.tag=i-2;
            }else
            {
                button.tag=i-1;
            }
                
            button.clipsToBounds=YES;
            button.contentMode=UIViewContentModeScaleAspectFill;
            [button setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
//            [button setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] forState:UIControlStateNormal placeholder:[UIImage imageWithColor:[UIColor lightGrayColor]]];
////            button.contentMode=UIViewContentModeScaleAspectFit;
//         
//           [button addTarget:self action:@selector(topRecommendContact:) forControlEvents:UIControlEventTouchUpInside];
            button.frame=CGRectMake(_frame.size.width*i, 0, _frame.size.width, _frame.size.height);
            
            [scroll addSubview:button];
        }
        
        UIImageView *noteView=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-30,self.bounds.size.width,30)];
        [noteView setImage:[UIImage imageNamed:@"首页推荐-banner_bg640"]];
        

        pageControl=[[SMPageControl alloc]initWithFrame:CGRectMake(0,18, kScreenWidth-3, 19)];
        pageControl.currentPage=0;
        pageControl.numberOfPages=pages-2;
        pageControl.alignment=SMPageControlAlignmentRight;
        pageControl.indicatorMargin = 3.0f;
        pageControl.indicatorDiameter = 3.0f;
        [noteView addSubview:pageControl];
        
        _infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth, 20)];
        for (int i=0; i<infos.count; i++)
        {
            [_infoLabel setText:[infos objectAtIndex:i]];
        }
        [_infoLabel setTextColor:[UIColor whiteColor]];
        [_infoLabel setBackgroundColor:[UIColor clearColor]];
        [_infoLabel setFont:[UIFont systemFontOfSize:13]];
        [noteView addSubview:_infoLabel];
        [self addSubview:noteView];

        
    
        [self performSelector:@selector(autoTurnPage) withObject:nil afterDelay:TURN_PAGE_TIME];
    }
    return self;
}

-(void)topRecommendContact:(UIButton *)sender
{
    if([_scrollDelegate respondsToSelector:@selector(topRecommendContact:)])
    {
        [_scrollDelegate topRecommendContact:sender ];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    NSInteger page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    pageControl.currentPage=(page-1);
    NSInteger titleIndex=page-1;
    if (titleIndex==[_infos count]) {
        titleIndex=0;
    }
    if (titleIndex<0) {
        titleIndex=[_infos count]-1;
    }
    if (_infos.count) {
         [_infoLabel setText:[_infos objectAtIndex:titleIndex]];
    }
    [self manDidTurnPage];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (currentPageIndex==0) {
        
        [_scrollView setContentOffset:CGPointMake((_imageArray.count-2)*_scrollView.frame.size.width, 0)];
    }
    if (currentPageIndex==_imageArray.count-1) {
        
         [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
        
    }
    
}


#pragma mark turnPage
-(void)autoTurnPage{
    if (currentPageIndex<pageControl.numberOfPages) {
        currentPageIndex=currentPageIndex+1;
    }else
        currentPageIndex=0;
    [self doTurnPage];
    [self manDidTurnPage];
  //  [self performSelector:@selector(autoTurnPage) withObject:nil afterDelay:4.0f];
}


-(void)doTurnPage{
   
    if (currentPageIndex!=0) {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        scroll.contentOffset = CGPointMake(_frame.size.width * currentPageIndex,0.0f);
        [UIView commitAnimations];
    }
    else {
        [scroll setContentOffset:CGPointMake(0,0) animated:NO];
    }

    
}


-(void)manDidTurnPage{
    [ScrollPageView cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoTurnPage) object:nil];
    [self performSelector:@selector(autoTurnPage) withObject:nil afterDelay:TURN_PAGE_TIME];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
