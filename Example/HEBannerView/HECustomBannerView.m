//
//  HECustomBannerView.m
//  HEBannerView_Example
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 xiaoxm. All rights reserved.
//
//  不建议在项目中直接使用HHBannerView，一个比较好的使用姿势是继承它，然后自定义UI

#import "HECustomBannerView.h"

@implementation HECustomBannerView


- (void)setupPageControl:(HEBannerPageControl *)pageControl
{
    pageControl.indicatorImage = [UIImage imageNamed:@"灰.jpeg"];
    pageControl.currentIndicatorImage = [UIImage imageNamed:@"黑.jpeg"];
    pageControl.indicatorSize = CGSizeMake(5, 5);
    pageControl.offset = CGPointMake(0, 3);
}

//- (Class<HEBannerContentViewDelegate>)contentViewClass
//{
//    return 如需要自定义contentView，在这里返回你的class;
//}

- (UIImage *)contentPlaceholder
{
    return [UIImage imageNamed:@"placeholder"];
}


@end
