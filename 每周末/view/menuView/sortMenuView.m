//
//  sortMenuView.m
//  YYKitDemo
//
//  Created by 李赛 on 15/12/15.
//  Copyright © 2015年 ibireme. All rights reserved.
//

#import "sortMenuView.h"
#import "sortMenuCollectionCell.h"
@implementation sortMenuItems

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index {
    if (self = [super init]) {
        self.title = title;
        self.iconName = iconName;
        self.index = index;
    }
    return self;
}
+ (instancetype)itemWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index {
    sortMenuItems *item = [[self alloc ] initWithTitle:title iconName:iconName index:index];
    return item;
}
@end

@implementation sortMenuView
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.menuItemsArray =[NSMutableArray arrayWithArray:items];
        [self setup];
    }
    return self;
}

-(void)setup
{
    CGFloat rowNumber=(CGFloat)self.menuItemsArray.count/3;
    rowNumber=  ceil(rowNumber);
   
    CGRect viewFrame=CGRectMake(0, 0, kScreenWidth, 60*rowNumber);
    [self setFrame:viewFrame];
    self.backgroundColor=[UIColor clearColor];
    [self setBottom:0];
    
    _maskView=[[UIView alloc]initWithFrame:kScreen_Bounds];
    _maskView.backgroundColor=[UIColor blackColor];
    _maskView.alpha=0.3;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissCurrentView)];
    [_maskView addGestureRecognizer:tapGesture];
    self.userInteractionEnabled=YES;
    if (!_blurWhiteBackgroundView) {
        _blurWhiteBackgroundView = [[UIToolbar alloc] initWithFrame:viewFrame];
        _blurWhiteBackgroundView.userInteractionEnabled=YES;
        [_blurWhiteBackgroundView setBarStyle:UIBarStyleDefault];
    }

    [self addSubview:self.blurWhiteBackgroundView];

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing =0;
    layout.minimumInteritemSpacing=0;
    layout.itemSize = CGSizeMake(kScreenWidth/3, 60);
    
    _contentCollectionView=[[UICollectionView alloc] initWithFrame:viewFrame collectionViewLayout:layout];
    _contentCollectionView.backgroundColor= [UIColor clearColor];
    [_contentCollectionView registerNib:[UINib nibWithNibName:@"sortMenuCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"sortMenuCollectionCell"];
    _contentCollectionView.scrollEnabled=NO;
    _contentCollectionView.showsVerticalScrollIndicator=NO;
    _contentCollectionView.showsHorizontalScrollIndicator=NO;
    _contentCollectionView.delegate=self;
    _contentCollectionView.dataSource=self;
    [self addSubview:_contentCollectionView];
}
#pragma mark---UICollectionViewDataSource----UICollectionViewDelegate--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuItemsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    sortMenuCollectionCell *vCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"sortMenuCollectionCell" forIndexPath:indexPath];
    sortMenuItems *items=[_menuItemsArray objectAtIndex:indexPath.row];
    [vCell.iconImage setImage:[UIImage imageNamed:items.iconName]];
    vCell.titleLable.text=items.title;
    return vCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)presentViewFromVisibleView:(UIView *)view
{
    [view addSubview:_maskView];
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [self setTop:64];
        _maskView.alpha=0.3;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)disMissCurrentView
{
    [UIView animateWithDuration:0.3 animations:^{
       [self setBottom:0];
        _maskView.alpha=0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
