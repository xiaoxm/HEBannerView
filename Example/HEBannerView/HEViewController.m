//
//  HEViewController.m
//  HEBannerView
//
//  Created by xiaoxm on 12/31/2018.
//  Copyright (c) 2018 xiaoxm. All rights reserved.
//

#import "HEViewController.h"
#import "HECustomBannerView.h"

@interface HEViewController ()

@end

@implementation HEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat w = UIScreen.mainScreen.bounds.size.width;
    CGFloat y = (UIScreen.mainScreen.bounds.size.height - 200 ) * 0.5;
    
    HECustomBannerView *bannerV = [[HECustomBannerView alloc] init];
    [self.view addSubview:bannerV];
    bannerV.frame = CGRectMake(0, y, w, 200);
    
    bannerV.data = @[
                     [UIImage imageNamed:@"1.jpg"],
                     @"http://www.ouliu.net/uploadfile/2015/0227/thumb_800_1067_20150227114955859.jpg",
                     [UIImage imageNamed:@"2.jpg"],
                     @"http://www.ouliu.net/uploadfile/2017/0804/20170804081300746.jpeg",
                     [UIImage imageNamed:@"3.jpg"],
                     ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
