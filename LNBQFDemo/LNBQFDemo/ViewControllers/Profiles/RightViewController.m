//
//  RightViewController.m
//  LNBProduct
//
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad
{

    [super viewDidLoad];

    [self addBackgroundView];
    
}

- (void)addBackgroundView
{
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage * bgImage = [UIImage imageNamed:@"slide_right_bg"];
    bgImageView.image = bgImage;
    [self.view addSubview:bgImageView];
}



@end
