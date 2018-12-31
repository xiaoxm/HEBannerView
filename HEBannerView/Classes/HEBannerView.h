//
//  HEBannerView.h
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.

//  基于CollectionView进行自定义的bannerf+(伪)无限滚动
//  自适应横竖屏

#import <UIKit/UIKit.h>
#import "HEBannerContentView.h"
#import "HEBannerPageControl.h"

@class HEBannerView;

NS_ASSUME_NONNULL_BEGIN

@protocol HHBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(HEBannerView *)bannerView DidSelectItemWithIndex:(NSInteger)index;
- (void)bannerView:(HEBannerView *)bannerView WillShowItemWithIndex:(NSInteger)index;
- (void)bannerView:(HEBannerView *)bannerView DidShowItemWithIndex:(NSInteger)index;

@end

@interface HEBannerView : UIView

/** 数据源 */
@property (nonatomic, strong) NSArray *data;
/** 代理 */
@property (nonatomic, weak) id delegate;


@property (nonatomic, weak) HEBannerPageControl *pageControl;

@end

NS_ASSUME_NONNULL_END
