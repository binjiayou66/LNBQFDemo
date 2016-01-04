//
//  ShowH5ViewController.h
//  LNBQFDemo
//
//  Created by Naibin on 15/12/3.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBHFLoaderView.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

@interface ShowH5ViewController : UIViewController

@property (copy, nonatomic) NSString * newsTitle;
@property (copy, nonatomic) NSString * author;
@property (copy, nonatomic) NSString * loadURL;
@property (strong, nonatomic) UIWebView * baseWebView;
@property (strong, nonatomic) UIView * headerView;

@end
