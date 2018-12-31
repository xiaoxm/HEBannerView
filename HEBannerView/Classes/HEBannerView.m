//
//  HEBannerView.m
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.
//

#import "HEBannerView.h"
#import "HEBannerPageControl.h"
#import "HEBannerContentView.h"

static const NSInteger kMaxCount = 99999;
static const NSInteger kMidCount = 50000;
static const NSInteger kPageControlHeight = 20;
static NSString * const kIdentifier = @"identifier";


@interface HEBannerView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 翻页动画时长 */
@property (nonatomic, assign) CGFloat flapDuration;
/** 翻页间隔时长 */
@property (nonatomic, assign) CGFloat flapWaitingTime;

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSTimer *timer;



@end



@implementation HEBannerView

- (void)dealloc
{
    NSLog(@"dealloc - HHBannerView");
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.flapDuration = 0.3;
    self.flapWaitingTime = 2;

    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumLineSpacing = 0;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[self contentViewClass] forCellWithReuseIdentifier:kIdentifier];
    [self addSubview:collectionView];
    self.collectionView = collectionView;

    HEBannerPageControl *pageControl = [[HEBannerPageControl alloc] initWithFrame:CGRectZero];
    [self setupPageControl:pageControl];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.layout.itemSize = self.bounds.size;
    
    CGFloat pageControlY = self.bounds.size.height - kPageControlHeight;
    self.pageControl.frame = CGRectMake(0, pageControlY, self.bounds.size.width, kPageControlHeight);
}

- (void)setData:(NSArray *)data
{
    _data = data;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = data.count;

    //开启定时器
    [self startTimer];
    
    //默认移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kMidCount inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
}

- (void)startTimer
{
    [self.timer invalidate];
    
    if(self.data.count < 2) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.flapWaitingTime target:self selector:@selector(autoFlip) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

- (void)autoFlip
{
    UICollectionViewCell *cell = [self.collectionView visibleCells].firstObject;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSInteger row = MIN(indexPath.row + 1, kMaxCount);
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [UIView animateWithDuration:self.flapDuration animations:^{
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self.timer invalidate];
}

#pragma mark - UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.data.count) return 0;
    return kMaxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell<HEBannerContentViewDelegate> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    if([cell respondsToSelector:@selector(setPlaceholder:)]){
        [cell setPlaceholder:[self contentPlaceholder]];
    }
    [cell setData:self.data[indexPath.row % self.data.count]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(bannerView:DidSelectItemWithIndex:)]){
        NSInteger index = indexPath.row % self.data.count;
        [self.delegate bannerView:self DidSelectItemWithIndex:index];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(bannerView:WillShowItemWithIndex:)]){
        NSInteger index = indexPath.row % self.data.count;
        [self.delegate bannerView:self WillShowItemWithIndex:index];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(bannerView:DidShowItemWithIndex:)]){
        NSInteger index = indexPath.row % self.data.count;
        [self.delegate bannerView:self DidShowItemWithIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前页码
    NSInteger page = round(scrollView.contentOffset.x / self.bounds.size.width);
    page %= self.data.count;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //防止用户手动拖拽时定时器触发翻页
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}


//需要自定义控件UI时，可以选择覆写以下任意方法
#pragma mark - overwrite methods

- (void)setupPageControl:(HEBannerPageControl *)pageControl
{
    
}

- (Class<HEBannerContentViewDelegate>)contentViewClass
{
/**
    如果这里的HEBannerContentView不满足你的需求，可以遵守HEBannerContentViewDelegate协议，并继承UICollectionViewCell自定义类
 */
    return [HEBannerContentView class];
}

- (UIImage *)contentPlaceholder
{
    return nil;
}

@end
