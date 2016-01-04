//
//  LNBScrollView.h
//  Day13-CustomCell
//
//  Created by Naibin on 15/11/11.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNBScrollView : UIView <UIScrollViewDelegate>

- (void)loadDataWithArray:(NSArray *)arr;

/**轮播视图页数*/
@property (nonatomic, assign)NSInteger  advertCount;

/**滚动是否停止*/
@property (nonatomic, assign)   BOOL            stopTimer;

@end
