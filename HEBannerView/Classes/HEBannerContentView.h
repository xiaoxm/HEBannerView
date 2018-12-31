//
//  HHBannerContentView.h
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HEBannerContentViewDelegate <NSObject>
@required
- (void)setData:(id)data;
@optional
- (void)setPlaceholder:(UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HEBannerContentView : UICollectionViewCell <HEBannerContentViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) UIImage *placeholder;

@end

NS_ASSUME_NONNULL_END
