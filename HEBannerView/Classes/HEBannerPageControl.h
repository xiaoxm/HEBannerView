//
//  HEBannerPageControl.h
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.

//  默认样式：小色块、居中

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HEBannerPageControl : UIView

/** 最大页码 */
@property(nonatomic, assign) NSInteger numberOfPages;
/** 当前页码 */
@property(nonatomic, assign) NSInteger currentPage;

/** 指示器图标 */
@property (nonatomic, strong) UIImage *indicatorImage;
/** 当前选中指示器图片 */
@property (nonatomic, strong) UIImage *currentIndicatorImage;

/** 指示器图标颜色，与indicatorImage互斥 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 当前选中指示器颜色与currentIndicatorImage互斥 */
@property (nonatomic, strong) UIColor *currentIndicatorColor;

/** 指示器的宽高，默认值{5,2}。如果设置了indicatorImage，则默认取值为image.size */
@property (nonatomic, assign) CGSize indicatorSize;
/** 指示器之间的间距。默认1 */
@property (nonatomic, assign) CGFloat indicatorPadding;

/** 指示器整体偏移量 */
@property (nonatomic, assign) CGPoint offset;

@end

NS_ASSUME_NONNULL_END
