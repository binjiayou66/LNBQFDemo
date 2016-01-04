//
//  LNBNavigationController.m
//  Day9-LNBPhoto
//
//  Created by Naibin on 15/11/5.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "LNBNavigationController.h"

@interface LNBNavigationController ()

@end

@implementation LNBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定制NavigationBar
    [self formulateNavigationBar];
}

- (void)formulateNavigationBar {
    //进行NavigationBar的一切定制，可以在这里实现
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [PublicMethod colorWithHexString:@"4b95f2"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [PublicMethod colorWithHexString:@"#00008B"],NSFontAttributeName:[UIFont systemFontOfSize:21]};
}





@end
