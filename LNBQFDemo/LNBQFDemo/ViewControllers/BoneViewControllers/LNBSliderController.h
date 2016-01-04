//
//  LNBSliderController.h
//  LNBProduct
//
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNBSliderController : UIViewController

//左、右、主视图控制器
@property (strong, nonatomic) UIViewController * leftViewController;
@property (strong, nonatomic) UIViewController * rightViewController;
@property (strong, nonatomic) UIViewController * mainViewController;

//是否可以显示左视图、右视图
@property (assign, nonatomic) BOOL canShowLeft;
@property (assign, nonatomic) BOOL canShowRight;

//控制器单例对象
+ (LNBSliderController *)shareSliderController;

//调用显示左、右、主视图
- (void)showLeftView;
- (void)showRightView;
- (void)showMainView;

@end
