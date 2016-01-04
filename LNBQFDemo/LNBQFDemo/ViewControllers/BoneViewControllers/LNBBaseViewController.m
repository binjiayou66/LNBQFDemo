//
//  LNBBaseViewController.m
//  LNBProduct
//  Created by Naibin on 15/11/22.
//  Copyright © 2015年 QianFeng. All rights reserved.


#import "LNBBaseViewController.h"
#import <AFNetworking.h>
#import "LHFViewController.h"
#import "ShowH5ViewController.h"
#import "LHFTwoDimensionalCtrl.h"
#import "AFHTTPRequestOperationManager+LNBHFRequest.h"
#import "UMSocial.h"

#define FALLVIEW_TAG 10000

@interface LNBBaseViewController () <UIScrollViewDelegate, LNBTableViewRefreshViewDelegate, LNBTableViewLoadMoreViewDelegate>

@property (strong,nonatomic)UIView *backView;
@property (strong,nonatomic)UIView *fallView;
@property (strong,nonatomic)NSMutableArray *LHFImgArray;
@property (strong,nonatomic)NSMutableArray *LHFbtnTitleArray;
@property(nonatomic,strong)UIView * temButtonView;

@end

@implementation LNBBaseViewController
{
    NSInteger _pageCount;
}
//创建 item
-(void)createNavItems
{
    //右侧 Item
    UIButton *button = [[UIButton alloc]init];
    button .frame = CGRectMake(0, 0, 40, 20);
    [button setTitle:@"---" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    //左侧 Item
}
-(void)rightItemClick:(UIButton *)button
{
        [self createButtonTileArray];
        [self CreateRightItemButtonView:self.backView FallViewView:self.fallView ButTempView:self.temButtonView ButtonNum:3 ButtonTitle:self.LHFbtnTitleArray buttonImg:self.LHFImgArray ButtonTarget:self Controller:self];
}
-(void)createButtonTileArray
{
    UIView * tembackView=[[UIView alloc]init];
    self.backView=tembackView;
    
    NSMutableArray * btnTitle=[[NSMutableArray alloc]initWithObjects:@"    扫一扫",@"    二维码",@"    分享",nil];
    self.LHFbtnTitleArray=btnTitle;
    
    NSMutableArray * ImgArray=[[NSMutableArray alloc]initWithObjects:@"guanshixin.png",@"erweima.png" ,@"fenxiang.png",nil];
    self.LHFImgArray=ImgArray;
}

-(void)CreateRightItemButtonView:(UIView*)BackView FallViewView:(UIView*)FallView ButTempView:(UIView*)butTempView ButtonNum:(NSInteger)buttonNum ButtonTitle:(NSMutableArray*)buttonTitle buttonImg:(NSMutableArray*)imgNameArray ButtonTarget:(id)target Controller:(UIViewController*)Controller
{
    FallView = [Controller.view viewWithTag:FALLVIEW_TAG];
    
    if (nil == FallView) {
        CGFloat butHeight = 44;
        CGFloat butWidth = 142;
        
        //透明 view = self.view
        FallView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
        FallView.tag = FALLVIEW_TAG;
        FallView.backgroundColor = [UIColor clearColor];
        
        butTempView =[[UIView alloc]init];
        butTempView.backgroundColor = [UIColor blackColor];
        butTempView.layer.cornerRadius=10;
        butTempView.tag = 987;
        butTempView.frame=CGRectMake(FallView.frame.size.width-8-butWidth, 12, butWidth, 25+(buttonNum-1)*butHeight);
        
        CGFloat LABHeight=10;
        UIImageView * topIMGView=[[UIImageView alloc]initWithFrame:CGRectMake(FallView.frame.size.width-8-butWidth, 0, butWidth, 12)];
        topIMGView.backgroundColor = [UIColor clearColor];
        UIImageView * rightTopIMG=[[UIImageView alloc]initWithFrame:CGRectMake(114, 0, 13.5, 7.5)];
        rightTopIMG.backgroundColor=[UIColor clearColor];
        rightTopIMG.image=[UIImage imageNamed:@"jiantou.png"];
        
        [topIMGView addSubview:rightTopIMG];
        [FallView addSubview:topIMGView];
        
        for (int i=0; i<buttonNum; i++) {
            UIButton * temBut=[UIButton buttonWithType:UIButtonTypeCustom];
            
            temBut.layer.cornerRadius=5;
            if (i==0) {
                temBut.frame=CGRectMake(0, -5, butTempView.frame.size.width, 43);
            }else{
                temBut.frame=CGRectMake(0, 38+43*(i-1)+1, butTempView.frame.size.width, 42);
            }
            [temBut setBackgroundColor:[UIColor blackColor]];
            UIImageView * temButIMG=[[UIImageView alloc]initWithFrame:CGRectMake(19, LABHeight, 22, 20)];
            temButIMG.image=[UIImage imageNamed:imgNameArray[i]];
            [temBut addSubview:temButIMG];
            UILabel * temButLAB = [[UILabel alloc]initWithFrame:CGRectMake(47, LABHeight, 90, 20)];
            temButLAB.backgroundColor=[UIColor clearColor];
            temButLAB.backgroundColor = [UIColor clearColor];
            temButLAB.font=[UIFont systemFontOfSize:17.0f];
            temButLAB.textColor=[UIColor whiteColor];
            temButLAB.text=[buttonTitle objectAtIndex:i];
            [temBut addSubview:temButLAB];
            [temBut addTarget:target action:@selector(RightItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            temBut.tag=FALLVIEW_TAG+i+100;
            [butTempView addSubview:temBut];
            //划线
            if (buttonNum>1 &&(i+1)!=buttonNum) {
                UIView * line=[[UIView alloc]initWithFrame:CGRectMake(10, 55+43*i+0.5, butTempView.frame.size.width-20, 0.5)];
                line.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.4];
                [butTempView addSubview:line];
            }
        }
        [FallView addSubview:butTempView];
        [Controller.view addSubview:FallView];
        [Controller.view bringSubviewToFront:FallView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        FallView.userInteractionEnabled = YES;
        [FallView addGestureRecognizer:tap];
        
    }else{
        //移除动画
        [self removeAnimation];
    }
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    UIView * FallView = [self.view viewWithTag:FALLVIEW_TAG];
    if (FallView) {
        [self removeAnimation];
    }
}
-(void)removeAnimation
{
    UIView * FallView = [self.view viewWithTag:FALLVIEW_TAG];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        UIView *view  = (UIView *)[FallView viewWithTag:987];
        
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        view.alpha = 0.2;
        
    } completion:^(BOOL finished) {
        
        [FallView removeFromSuperview];
        
    }];
}
-(void)RightItemButtonClicked:(UIButton *)button//点击关注
{
    if (button.tag == FALLVIEW_TAG +100 ) {
        
        LHFViewController *bar = [[LHFViewController alloc] initWithBlock:^(NSString *str, BOOL isSucceed) {
            if (isSucceed) {
                NSLog(@"%@",str);
            }else{
                NSLog(@"扫描失败");
            }
        }];
        
        [self presentViewController:bar animated:YES completion:nil];
        
    }else if (button.tag == FALLVIEW_TAG + 101){
        
        UIView * fallView3 = [self.view viewWithTag:FALLVIEW_TAG];
        [fallView3 removeFromSuperview];
        
        LHFTwoDimensionalCtrl * TwoDVC = [[LHFTwoDimensionalCtrl alloc]init];
        
        [self.navigationController pushViewController:TwoDVC animated:YES];
        
    }else{
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5654339767e58e12ef004751"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                           delegate:nil];
        
    }
}

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建 Items
    [self createNavItems];
    
    //创建表格视图
    [self createTableView];
    
    //请求数据
    [self requestForData];
    
    //回滚表格
    [self.baseTableView setContentOffset:CGPointMake(0, -69) animated:YES];
    
    [UIView animateKeyframesWithDuration:0.33 delay:0.33 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [self.baseTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    } completion:^(BOOL finished) {
        
    }];
    //添加下拉刷新
    [self pullToRefresh];
}

#pragma mark - Data
- (void)requestForData {
    
    NSString * vcName = NSStringFromClass([self class]);
    
    NSArray * nameArray = @[@"HomeViewController", @"ActivitiesViewController", @"VideosViewController", @"JobsViewController", @"ChatsViewController"];
    
    NSInteger index = [nameArray indexOfObject:vcName];
    
    NSString * url = [NSString stringWithFormat:MAIN_URL_FIRST_PAGE, index + 1];
    
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:nil success:^void(AFHTTPRequestOperation * operation, id object) {
//        
//        self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        
//        [self parseData:object];
//        
//    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
//        
//        NSLog(@"%@", error);
//        
//    }];
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    [AFHTTPRequestOperationManager GETRequest:url parameters:nil success:^(AFHTTPRequestOperation *operation, id resobject) {
        
        [self parseData:resobject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)parseData:(id)object
{
    //code
    //count
    //message
    //news : array : dictionary
    //add_time author category_id collect comment course_id description id is_collect is_push is_up keyword lesson_id status tag_id title type_id up update_time user_id video view  //thumb : array : dictionary  img_url
    
    NSArray * newsArray = object[@"news"];
    
    NSMutableArray * firstSection = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in newsArray) {
        NewsModel * model = [[NewsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [firstSection addObject:model];
    }
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObject:firstSection];
    
    [self.baseTableView reloadData];
    
    //设置头视图内容
    [self loadHeaderView];
    [self pullToLoadMore];
    _pageCount = 1;
    [self.refreshHeaderView aceRefreshScrollViewFinishRefreshData:self.baseTableView];
    [self.loadMoreFooterView aceLoadMoreScrollViewFinishLoadData:self.baseTableView];
}

- (void)requestForMoreData {
    
    NSString * vcName = NSStringFromClass([self class]);
    NSArray * nameArray = @[@"HomeViewController", @"ActivitiesViewController", @"VideosViewController", @"JobsViewController", @"ChatsViewController"];
    
    NSInteger index = [nameArray indexOfObject:vcName];
    //解析不同页面数据
    NSString * url = [NSString stringWithFormat:MAIN_URL, index + 1, ++_pageCount];
    
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:nil success:^void(AFHTTPRequestOperation * operation, id object) {
//        
//        //解析数据
//        [self parseMoreData:object];
//        
//    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
//        NSLog(@"%@", error);
//    }];

     [AFHTTPRequestOperationManager GETRequest:url parameters:nil success:^(AFHTTPRequestOperation *operation, id resobject) {
         
         //解析数据
        [self parseMoreData:resobject];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
          NSLog(@"%@", error.localizedDescription);
         
     }];
}

- (void)parseMoreData:(id)object
{
    NSArray * newsArray = object[@"news"];
    NSMutableArray * firstSection = _dataSource[0];
    
    for (NSDictionary * dic in newsArray) {
        
        //解析数据
        NewsModel * model = [NewsModel modelWithDic:dic];
        [firstSection addObject:model];
        
    }
    [self.baseTableView reloadData];
    [self.refreshHeaderView aceRefreshScrollViewFinishRefreshData:self.baseTableView];
    [self.loadMoreFooterView aceLoadMoreScrollViewFinishLoadData:self.baseTableView];
}

- (void)loadHeaderView {
    
    NSArray * arr = _dataSource[0];
    self.scrollImageNames.array = @[
                                    [(NewsModel *)arr[arc4random() % arr.count] thumb][0][@"img_url"],
                                    [(NewsModel *)arr[arc4random() % arr.count] thumb][0][@"img_url"],
                                    [(NewsModel *)arr[arc4random() % arr.count] thumb][0][@"img_url"],
                                    [(NewsModel *)arr[arc4random() % arr.count] thumb][0][@"img_url"]
                                    ];
    [self.headerScrollView loadDataWithArray:self.scrollImageNames];
}

#pragma mark - TableView
- (void)createTableView
{
    _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_w, screen_h - 64 - 49) style:UITableViewStylePlain];
    _baseTableView.dataSource = self;
    _baseTableView.delegate = self;
    
    self.baseTableView.rowHeight = 90;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册Cell
    [_baseTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    //数据源开辟空间
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    if (!_scrollImageNames) {
        _scrollImageNames = [[NSMutableArray alloc] init];
    }
    //滚动头视图
    _headerScrollView = [[LNBScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 180)];
    _baseTableView.tableHeaderView = _headerScrollView;
    
    [self.view addSubview:_baseTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *array = _dataSource[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    NewsModel * model = self.dataSource[indexPath.section][indexPath.row];
    
    [cell loadDataWithNewsModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    NewsModel * model = _dataSource[indexPath.section][indexPath.row];
    
    ShowH5ViewController * showH5VC = [[ShowH5ViewController alloc] init];
    
    showH5VC.loadURL = [NSString stringWithFormat:H5_URL, model.ID];
    
    showH5VC.newsTitle = model.title;
    
    showH5VC.author = model.author;
    
    [self.navigationController pushViewController:showH5VC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView aceRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView aceLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView aceRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView aceLoadMoreScrollViewDidEndDragging:scrollView];
}


#pragma mark - REFRESH
- (void)pullToRefresh {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化刷新头视图
    _refreshHeaderView = [[LNBTableViewRefreshView alloc] initWithFrame:CGRectMake(0, - self.baseTableView.bounds.size.height, self.baseTableView.bounds.size.width, self.baseTableView.bounds.size.height)withDelegate:self];
    
    [self.baseTableView addSubview:_refreshHeaderView];
    
}

- (void)pullToLoadMore {
    
    if(_loadMoreFooterView)
        return;
    
    _loadMoreFooterView = [[LNBTableViewLoadMoreView alloc] initWithFrame:CGRectMake(0, self.baseTableView.contentSize.height, self.baseTableView.bounds.size.width, self.baseTableView.bounds.size.height)];
    _loadMoreFooterView.delegate = self;
    [self.baseTableView addSubview:_loadMoreFooterView];
    
}

#pragma mark - Refresh
- (void)aceRefreshDidBeginRefresh:(LNBTableViewRefreshView *)refreshView
{
    [self requestForData];
}

- (void)aceLoadMoreDidBeginLoadMore:(LNBTableViewLoadMoreView *)loadMoreView
{
    [self requestForMoreData];
}


@end





