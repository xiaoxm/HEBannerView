//
//  HEBannerContentView.m
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.
//

#import "HEBannerContentView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HEBannerContentView

- (void)setData:(id)data;
{
    if([data isKindOfClass:[NSString class]]){
        NSURL *url = [NSURL URLWithString:data];
        [self.imageView sd_setImageWithURL:url placeholderImage:self.placeholder];
    }
    else if([data isKindOfClass:[UIImage class]]){
        self.imageView.image = (UIImage *)data;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

- (UIImageView *)imageView
{
    if(!_imageView){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

@end
