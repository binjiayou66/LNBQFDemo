//
//  LNBSliderController.m
//  LNBProduct
//
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "LNBSliderController.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define BASE_NUM fabs(_mainView.frame.origin.x) / (SCREEN_SIZE.width * 0.78)

@interface LNBSliderController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LNBSliderController {
    UIView * _leftView;
    UIView * _rightView;
    UIView * _mainView;
    
    BOOL _isShowLeftView;
    BOOL _isShowRightView;
    
    UIView * _topViewLeft;
    UIView * _topViewRight;
    UIView * _topViewMain;
    
    UIView * _leftSideContentView;
    NSMutableArray * _leftSideDataSource;
    UITableView * _leftSideTable;
    
    UIView * _rightSideContentView;
}

+ (LNBSliderController *)shareSliderController {
    static LNBSliderController * slider = nil;
    if (slider == nil) {
        slider = [[LNBSliderController alloc] init];
        slider.canShowRight = YES;
        slider.canShowLeft = YES;
    }
    return slider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftView = self.leftViewController.view;
    _rightView = self.rightViewController.view;
    _mainView = self.mainViewController.view;
    
    //添加左右、主视图
    [self.view addSubview:_leftView];
    [self.view addSubview:_rightView];
    [self.view addSubview:_mainView];
    
    //左视图内容
    _leftSideContentView = [[UIView alloc] initWithFrame:_leftView.bounds];
    [_leftView addSubview:_leftSideContentView];
    //创建表格数据源
    [self createDataSource];
    //添加视图
    [self addSubviews];
    
    //右视图内容
    /* 
        add subviews of right view on _rightSideContentView
     */
    
    //左、右视图添加一个黑色View用于拖动时实现黑 -> 白的视觉效果
    _topViewLeft = [[UIView alloc] initWithFrame:self.view.frame];
    _topViewLeft.backgroundColor = [UIColor blackColor];
    _topViewLeft.userInteractionEnabled = NO;
    [_leftView addSubview:_topViewLeft];
    
    _topViewRight = [[UIView alloc] initWithFrame:self.view.frame];
    _topViewRight.backgroundColor = [UIColor blackColor];
    _topViewRight.userInteractionEnabled = NO;
    [_rightView addSubview:_topViewRight];
    
    //为主视图添加阴影，拖动和点击手势
    _mainView.layer.masksToBounds = NO;
    _mainView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.7].CGColor;
    _mainView.layer.shadowOffset = CGSizeMake(-3, 3);
    _mainView.layer.shadowOpacity = .9f;
    _mainView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_mainView.bounds].CGPath;
    _mainView.layer.shadowRadius = 5.0f;
    
    UIPanGestureRecognizer * mainPgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    [_mainView addGestureRecognizer:mainPgr];

    UIPanGestureRecognizer * topPgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    UITapGestureRecognizer * topTgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainTapped:)];
    _topViewMain = [[UIView alloc] initWithFrame:_mainView.bounds];
    _topViewMain.backgroundColor = [UIColor clearColor];
    [_topViewMain addGestureRecognizer:topPgr];
    [_topViewMain addGestureRecognizer:topTgr];
    _topViewMain.userInteractionEnabled = NO;
    [_mainView addSubview:_topViewMain];
}

- (void)panning:(UIPanGestureRecognizer *)pgr {

    //当导航栏控制器显示的不是根视图控制器的视图时，不能进行滑动
    if ([_mainViewController isKindOfClass:[UINavigationController class]]) {
        if ([[(UINavigationController *)_mainViewController viewControllers] count] > 1) {
            return;
        }
    }
    if([_mainViewController isKindOfClass:[UITabBarController class]]) {
        BOOL canShowMain = YES;
        NSArray * array = [(UITabBarController *)_mainViewController viewControllers];
        for (UIViewController * vc in array) {
            if ([vc isKindOfClass:[UINavigationController class]]) {
                if ([[(UINavigationController *)vc viewControllers] count] > 1) {
                    canShowMain = NO;
                }
            }
        }
        if (!canShowMain) {
            return;
        }
    }
    
    //进行滑动
    static CGFloat srcCenterX;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        srcCenterX = _mainView.center.x;
    }
    CGPoint delPoint = [pgr translationInView:_mainView];
    CGFloat div = (delPoint.x / SCREEN_SIZE.width * 0.78) > 0 ? (delPoint.x / SCREEN_SIZE.width * 0.78) : (-delPoint.x / SCREEN_SIZE.width * 0.78);
    
    CGFloat dstX = 0;
    CGFloat scale = 1;
    CGFloat alph = 1;
    if (_isShowLeftView) {
        if (delPoint.x > 0) {
            return;
        }
        //显示左视图，滑回主视图
        dstX = srcCenterX + delPoint.x > SCREEN_SIZE.width / 2 ? srcCenterX + delPoint.x : SCREEN_SIZE.width / 2;
        scale = (1 - 0.22 * BASE_NUM) > 0.78 ? (1 - 0.22 * BASE_NUM) : 0.78;
        
        CGFloat alph = 1 - (fabs(_mainView.frame.origin.x) / SCREEN_SIZE.width) / 0.78;
        _topViewLeft.alpha = alph;
        
        //左视图联动
        [self slideWithLeft];
    }else if (_isShowRightView) {
        if (delPoint.x < 0) {
            return;
        }
    }else {
        if (delPoint.x > 0) {
            //显示主界面向右滑动
            if (self.canShowLeft == NO) {
                if (_mainView.frame.origin.x < 0) {
                    [self showMainView];
                }
                return;
            }
            [self.view insertSubview:_leftView aboveSubview:_rightView];
            
            //左侧视图联动
            [self slideWithLeft];
            
            dstX = srcCenterX + delPoint.x < SCREEN_SIZE.width * 1.17 ? srcCenterX + delPoint.x : SCREEN_SIZE.width * 1.17;
            scale = (1 - 0.22 * BASE_NUM) > 0.78 ? (1 - 0.22 * BASE_NUM) : 0.78;
            alph = 1 - (fabs(_mainView.frame.origin.x) / SCREEN_SIZE.width) / 0.78;
            _topViewLeft.alpha = alph;
            
        }else {
            //显示主界面向左滑动
            if (self.canShowRight == NO) {
                if (_mainView.frame.origin.x > 0) {
                    [self showMainView];
                }
                return;
            }
            [self.view insertSubview:_rightView aboveSubview:_leftView];
        }
    }

    _mainView.center = CGPointMake(dstX, SCREEN_SIZE.height / 2);
    _mainView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (pgr.state == UIGestureRecognizerStateEnded && (_isShowLeftView || _isShowRightView)) {
        [self showMainView];
    }
    if (pgr.state == UIGestureRecognizerStateEnded && div > 0.22) {
        if (delPoint.x > 0) {
            if (_canShowLeft)
                [self showLeftView];
        }else if (delPoint.x < 0) {
            if (_canShowRight)
                [self showRightView];
        }
    }else if (pgr.state == UIGestureRecognizerStateEnded) {
        [self showMainView];
    }
}

- (void)showLeftView
{
    _isShowLeftView = YES;
    _isShowRightView = NO;
    _topViewMain.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.26 animations:^{
        _mainView.center = CGPointMake(SCREEN_SIZE.width * 1.17, SCREEN_SIZE.height / 2);
        _mainView.transform = CGAffineTransformMakeScale(0.78, 0.78);
        _topViewLeft.alpha = 0;
        _leftSideContentView.transform = CGAffineTransformMakeScale(1, 1);
        [self slideWithLeft];
    }];
}

- (void)showRightView {
    _isShowLeftView = NO;
    _isShowRightView = YES;
    _topViewMain.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.26 animations:^{
        _mainView.center = CGPointMake(SCREEN_SIZE.width * (-0.17), SCREEN_SIZE.height / 2);
        _mainView.transform = CGAffineTransformMakeScale(0.78, 0.78);
        _topViewRight.alpha = 0;
    }];
}

- (void)showMainView
{
    _isShowRightView = NO;
    _isShowLeftView = NO;
    _topViewMain.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.26 animations:^{
        _mainView.center = CGPointMake(SCREEN_SIZE.width / 2, SCREEN_SIZE.height / 2);
        _mainView.transform = CGAffineTransformMakeScale(1, 1);
        _topViewLeft.alpha = 1;
        _topViewRight.alpha = 1;
        //左侧视图联动
        [self slideWithLeft];
    }];

}

- (void)slideWithLeft {
    //左侧视图联动
    CGFloat leftSideScale = (0.22 / 0.78) * (fabs(_mainView.frame.origin.x) / SCREEN_SIZE.width) + 0.78;
    _leftSideContentView.transform = CGAffineTransformMakeScale(leftSideScale, leftSideScale);
    CGFloat leftSideOriginX = 80 * BASE_NUM - 80;
    _leftSideContentView.frame = CGRectMake(leftSideOriginX, -leftSideOriginX, _leftSideContentView.frame.size.width, _leftSideContentView.frame.size.height);
}

- (void)mainTapped:(UITapGestureRecognizer *)tgr {
    [self showMainView];
}

#pragma mark - Side Bar
- (void)createDataSource {
    if (_leftSideDataSource == nil) {
        _leftSideDataSource = [[NSMutableArray alloc] init];
    }
    NSArray * arr = @[
                      @[
                          @{@"title" : @"最近浏览", @"icon" : @"sidebar_business@3x"},
                          @{@"title" : @"我的设置", @"icon" : @"sidebar_purse@3x"}
                          ],
                      @[
                          @{@"title" : @"最近浏览", @"icon" : @"sidebar_favorit@3x"},
                          @{@"title" : @"通知中心", @"icon" : @"sidebar_album@3x"},
                          @{@"title" : @"我的投票", @"icon" : @"sidebar_file@3x"}
                          ]
                      ];
    _leftSideDataSource.array = arr;
}

- (void)addSubviews {
    //头像
    UIImageView * headView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 80, 60, 60)];
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 30;
    UIImage * image = [UIImage imageNamed:@"my_head"];
    headView.image = image;
    [_leftSideContentView addSubview:headView];
    //昵称
    UILabel * nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 85, 200, 30)];
    nickLabel.textColor = [UIColor whiteColor];
    nickLabel.font = [UIFont boldSystemFontOfSize:20];
    nickLabel.adjustsFontSizeToFitWidth = YES;
    nickLabel.text = @"洪峰同学";
    [_leftSideContentView addSubview:nickLabel];
    
    //个性签名
    UILabel * whatsUp = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 300, 30)];
    whatsUp.text = @"编辑个性签名";
    whatsUp.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    whatsUp.font = [UIFont systemFontOfSize:16];
    [_leftSideContentView addSubview:whatsUp];
    
    //添加表格视图
    _leftSideTable = [[UITableView alloc] initWithFrame:CGRectMake(25, 180, 0.78 * SCREEN_SIZE.width - 40, SCREEN_SIZE.height - 80) style:UITableViewStyleGrouped];
    _leftSideTable.backgroundColor = [UIColor clearColor];
    _leftSideTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftSideTable.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    _leftSideTable.dataSource = self;
    _leftSideTable.delegate = self;
    [_leftSideTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"profilesCell"];
    [_leftSideTable registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"profilesHeader"];
    [_leftSideContentView addSubview:_leftSideTable];
    
    //设置按钮
    UIButton * settings = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_SIZE.height - 60, 100, 30)];
    [settings setImage:[UIImage imageNamed:@"sidebar_setting@3x"] forState:UIControlStateNormal];
    [settings setTitle:@"设置" forState:UIControlStateNormal];
    [settings setTitleColor:[UIColor colorWithWhite:0.9 alpha:0.9] forState:UIControlStateNormal];
    [settings setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.7] forState:UIControlStateHighlighted];
    settings.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [_leftSideContentView addSubview:settings];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _leftSideDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_leftSideDataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profilesCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor whiteColor];
    UIView * selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
    cell.selectedBackgroundView = selectedView;
    cell.textLabel.text = _leftSideDataSource[indexPath.section][indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:_leftSideDataSource[indexPath.section][indexPath.row][@"icon"]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"profilesHeader"];
    header.contentView.backgroundColor = [UIColor clearColor];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end







