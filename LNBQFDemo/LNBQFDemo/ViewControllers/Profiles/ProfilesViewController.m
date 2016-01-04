//
//  ProfilesViewController.m
//  LNBProduct
//
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.

#import "ProfilesViewController.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

@interface ProfilesViewController ()

@end

@implementation ProfilesViewController {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加背景图片
    [self addBackgroundView];
}

- (void)addBackgroundView
{
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage * bgImage = [UIImage imageNamed:@"slide_left_bg"];
    bgImageView.image = bgImage;
    [self.view addSubview:bgImageView];
}


@end
