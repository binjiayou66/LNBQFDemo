//
//  LNBTabBarController.m
//  Day9-LNBPhoto
//
//  Created by Naibin on 15/11/5.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "LNBTabBarController.h"
#import "LNBNavigationController.h"
#import "NBUDButton.h"
#import "NBTouchableImageView.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define TABBAR_SIZE self.tabBar.bounds.size

#define TABBAR_BG @"tab_bg"
#define TABBAR_HEIGHT 60
#define TITLE_COLOR_HL [UIColor colorWithRed:123 / 255.0 green:195 / 255.0 blue:0 / 255.0 alpha:1]
#define TITLE_COLOR [UIColor grayColor]

@interface LNBTabBarController ()

@end

@implementation LNBTabBarController
{
    UIImageView * _myTabBar;
    NSMutableArray * _subViewControllersClass;
    NSMutableArray * _titles;
    NSMutableArray * _images;
    NSMutableArray * _selectedImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //参数设置
    _subViewControllersClass = [[NSMutableArray alloc] initWithArray:@[@"ActivitiesViewController", @"VideosViewController", @"HomeViewController", @"JobsViewController", @"ChatsViewController"]];
    _titles = [[NSMutableArray alloc] initWithArray:@[@"生活", @"视频", @"锋迷动态", @"就业", @"吐槽"]];
    _images = [[NSMutableArray alloc] initWithArray:@[@"tab_yinshi", @"tab_zixun", @"tab_home", @"tab_ceshi", @"tab_shequ"]];
    _selectedImages = [[NSMutableArray alloc] initWithArray:@[@"tab_yinshi_hl", @"tab_zixun_hl", @"tab_home_hl", @"tab_ceshi_hl", @"tab_shequ_hl"]];
    
    //添加子视图控制器
    [self addSubViewControllers];
    
    //是否自制定TABBAR
#if 1
    //自定制TabBar部分
    self.tabBar.hidden = YES;
    [self createtabBar];
    //设置默认加载项
    [self buttonClicked:[self.view viewWithTag:9992]];
#else
    //定制系统TabBar
    [self formulateTabBar];
    //定制子视图控制器的TabBarItem
    [self formulateTabBarItems];
#endif
    
}

- (void)formulateTabBar {
    //这里可以定制TabBar
    self.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)addSubViewControllers {
    //这里负责添加子视图控制器
    NSMutableArray * viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < _subViewControllersClass.count; i++) {
        Class class = NSClassFromString(_subViewControllersClass[i]);
        UIViewController * vc = [[class alloc] init];
        vc.title = _titles[i];
        LNBNavigationController * nav = [[LNBNavigationController alloc] initWithRootViewController:vc];
        //形成子视图控制器的数组
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
}

- (void)formulateTabBarItems {
    //定制子视图的标签
    for (int i = 0; i < _titles.count; i++) {
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:_titles[i] image:[[UIImage imageNamed:_images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:_selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UIViewController * vc = self.viewControllers[i];
        //tabBarItem是属于TabBarController的子视图控制器的
        vc.tabBarItem = item;
    }
}

//自定制
-(void)createtabBar{
    
    _myTabBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - TABBAR_HEIGHT, [[UIScreen mainScreen] bounds].size.width, TABBAR_HEIGHT)];
    
    _myTabBar.image = [UIImage imageNamed:TABBAR_BG];
    _myTabBar.userInteractionEnabled = YES;
    
    for (int i = 0; i < _titles.count; i++) {
        id button = nil;
        if (i == 2) {
            button = [[NBTouchableImageView alloc] init];
            NBTouchableImageView * imageView = button;
            imageView.bounds = CGRectMake(0, 0, 35, 35);
            imageView.center = CGPointMake(TABBAR_SIZE.width / 2, TABBAR_SIZE.height / 2 + 3);
            [button setImage:[UIImage imageNamed:_images[i]] andSelectedImage:[UIImage imageNamed:_selectedImages[i]]];
        }else {
            button = [[NBUDButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width / _titles.count * i, 14, SCREEN_SIZE.width / _titles.count, 49)];
            [button setTitle:_titles[i] withColor:TITLE_COLOR andSelectedColor:TITLE_COLOR_HL];
            [button setImage:[UIImage imageNamed:_images[i]] andSelectedImage:[UIImage imageNamed:_selectedImages[i]]];
        }
        
        [(UIView *)button setTag:9990 + i];
        //添加点击事件
        [button addTarget:self withAction:@selector(buttonClicked:)];
        
        [_myTabBar addSubview:button];
    }
    
    [self.view addSubview:_myTabBar];
}

- (void)buttonClicked:(id)button {
    for (int i = 0; i < self.viewControllers.count; i++) {
        id button1 = [self.view viewWithTag:9990 + i];
        if (button != button1) {
            //设置按钮没有被选中
            [button1 setSelected:NO];
        }
    }
    [button setSelected:YES];
    //进行页面切换
    self.selectedIndex = [(UIView *)button tag] - 9990;
}

- (void)setTabBarHidden:(BOOL)isHidden {
    if (isHidden) {
        [UIView animateWithDuration:0.33 animations:^{
            _myTabBar.frame = CGRectMake(0, SCREEN_SIZE.height, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
        }];
    }else {
        [UIView animateWithDuration:0.33 animations:^{
            _myTabBar.frame = CGRectMake(0, SCREEN_SIZE.height - _myTabBar.frame.size.height, _myTabBar.frame.size.width, _myTabBar.frame.size.height);
        }];
    }
}



@end
