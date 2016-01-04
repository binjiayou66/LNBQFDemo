//
//  LNBBaseViewController.h
//  LNBProduct
//
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBScrollView.h"
#import "PublicDefine.h"
#import "NewsTableViewCell.h"
#import "LNBTableViewRefreshView.h"
#import "LNBTableViewLoadMoreView.h"
#import "LNBTabBarController.h"


@interface LNBBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView * baseTableView;
@property (strong, nonatomic) NSMutableArray * dataSource; //数据源
@property (strong, nonatomic) LNBScrollView * headerScrollView;

@property (strong, nonatomic) NSMutableArray * scrollImageNames;

@property (strong, nonatomic) LNBTableViewRefreshView * refreshHeaderView; //下拉头视图
@property (strong, nonatomic) LNBTableViewLoadMoreView * loadMoreFooterView; //上拉视图

@end
