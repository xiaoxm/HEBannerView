//
//  HEBannerPageControl.m
//  HEBannerView
//
//  Created by 贺瑞 on 2018/12/31.
//  Copyright © 2018年 herui. All rights reserved.
//

#import "HEBannerPageControl.h"

@implementation HEBannerPageControl

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
    self.indicatorSize = CGSizeMake(5, 2);
    self.indicatorPadding = 1;
    self.indicatorColor = [UIColor lightGrayColor];
    self.currentIndicatorColor = [UIColor whiteColor];

    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if(self.numberOfPages < 2) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat h = self.indicatorSize.height;
    CGFloat w = self.indicatorSize.width;
    CGFloat y = (self.bounds.size.height - h ) * 0.5 + self.offset.y;
    CGFloat width = (self.numberOfPages * (w + self.indicatorPadding)) - self.indicatorPadding;
    CGFloat startX = (self.bounds.size.width - width) * 0.5 + self.offset.x;
    
    for (int i=0; i<self.numberOfPages; i++) {
        
        CGFloat x = i * (w + self.indicatorPadding) + startX;
        CGRect drawRect = CGRectMake(x, y, w, h);
        
        if(self.indicatorImage){
            UIImage *drawImage = (i == self.currentPage) ? self.currentIndicatorImage : self.indicatorImage;
            CGContextDrawImage(context, drawRect, drawImage.CGImage);
        } else{
            UIColor *drawColor = (i == self.currentPage) ? self.currentIndicatorColor : self.indicatorColor;
            CGContextSetLineWidth(context, 0);
            CGContextAddRect(context, drawRect);
            CGContextSetFillColorWithColor(context, drawColor.CGColor);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
    }
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    self.currentPage = 0;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

- (void)setIndicatorImage:(UIImage *)indicatorImage
{
    _indicatorImage = indicatorImage;
    
    //默认取image.size
    self.indicatorSize = indicatorImage.size;
}

@end
