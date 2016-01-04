//
//  ShowH5ViewController.m
//  LNBQFDemo
//
//  Created by Naibin on 15/12/3.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "ShowH5ViewController.h"
#import "UILabel+SizeAbout.h"
#import "LNBTabBarController.h"

#define HEADER_HEIGHT 256

@interface ShowH5ViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIView * indicatorBG;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;

@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation ShowH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //WebView设置
    [self buildWebView];
    
    //加载动画
    [self addIndicatorView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    LNBTabBarController * tab = (LNBTabBarController *)self.tabBarController;
    [tab setTabBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    LNBTabBarController * tab = (LNBTabBarController *)self.tabBarController;
    [tab setTabBarHidden:NO];
}

- (void)buildWebView
{
    _baseWebView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 0, screen_w-10, screen_h)];
    _baseWebView.delegate = self;
    _baseWebView.scrollView.showsVerticalScrollIndicator = NO;
    _baseWebView.backgroundColor = [UIColor clearColor];
    [_baseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loadURL]]];
    [self.view addSubview:_baseWebView];
    
    //头视图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_w, _headerHeight)];
    //新闻标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_SIZE.width - 20, 40)];
    titleLabel.text = self.newsTitle;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize titleSize = [titleLabel calcContentSize];
    titleLabel.frame = CGRectMake(10, 10, titleSize.width, titleSize.height);
    
    _headerView.frame = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, _headerView.frame.size.width, titleSize.height + 35);
    _headerHeight = _headerView.frame.size.height;
    [_headerView addSubview:titleLabel];
    
    //作者标题
    UILabel * authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + titleSize.height, SCREEN_SIZE.width / 2, 12)];
    authorLabel.text = [NSString stringWithFormat:@"作者: %@", self.author];
    authorLabel.textColor = [UIColor grayColor];
    authorLabel.font = [UIFont systemFontOfSize:12];
    [_headerView addSubview:authorLabel];
    
    //分隔线
    UIView * seperator = [[UIView alloc] initWithFrame:CGRectMake(10, _headerHeight - 2, SCREEN_SIZE.width, 1)];
    seperator.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
    [_headerView addSubview:seperator];
    [self.view addSubview:_headerView];
    
    UIScrollView * sc = (UIScrollView *)[_baseWebView subviews][0];
    sc.delegate = self;
    sc.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    sc.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
    
}

- (void)addIndicatorView {
    
    _indicatorBG = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight, SCREEN_SIZE.width, SCREEN_SIZE.height - _headerHeight)];
    _indicatorBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_indicatorBG];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_indicator];
//    [_indicator startAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [_indicatorBG setHidden:NO];
//    [_indicator startAnimating];
    
    //开启动画
    [LNBHFLoaderView addShowView:self.view withTitle:@"loading......" animated:YES];
    //同时开启官方菊花动画
    UIApplication *app =   [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    return YES;
}

//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    
//    [_indicatorBG setHidden:NO];
//    [_indicator startAnimating];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_indicatorBG setHidden:YES];
    
    //关闭官方菊花动画
    UIApplication *app =   [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    //移除动画
    [self performSelector:@selector(stopCircleLoader) withObject:nil afterDelay:0.2f];
    
//    [_indicator stopAnimating];
}

- (void)stopCircleLoader
{
    [LNBHFLoaderView hideFromView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [_indicator stopAnimating];
    NSLog(@"%@", error);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = _headerView.frame;
    frame.origin.y = -scrollView.contentOffset.y - _headerHeight;
    _headerView.frame = frame;
}


@end
