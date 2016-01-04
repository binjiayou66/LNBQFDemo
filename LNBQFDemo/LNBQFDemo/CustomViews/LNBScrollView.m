//
//  LNBScrollView.m
//  Day13-CustomCell
//
//  Created by Naibin on 15/11/11.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "LNBScrollView.h"
#import "LNBImageView.h"
#import <UIImageView+WebCache.h>

@implementation LNBScrollView {
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    UILabel * _titleLabel;
    
    NSMutableArray * _imageNames;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        [self addSubViews];
        //分配空间
        _imageNames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addSubViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //添加轮播按钮
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, self.frame.size.height - 24, 120, 24)];
    [_pageControl addTarget:self action:@selector(pagging:) forControlEvents:UIControlEventTouchUpInside];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:1];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 24, self.frame.size.width, 24)];
    _titleLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    _titleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    //隐藏Label
    _titleLabel.hidden = YES;

    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    [self addSubview:_titleLabel];
    //开启广告定时亓
    [self startTheADTimer];
}

- (void)loadDataWithArray:(NSArray *)arr {
    //填充滚动视图
    _scrollView.contentSize = CGSizeMake(arr.count * self.frame.size.width, self.frame.size.height);
    
    //记录下轮播的页数
    self.advertCount = arr.count;
    
    for (int i = 0; i < arr.count; i++) {
        LNBImageView * imageView = [[LNBImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
//        NSArray * nameAndType = [arr[i] componentsSeparatedByString:@"."];
//        NSString * imagePath = [[NSBundle mainBundle] pathForResource:nameAndType[0] ofType:[nameAndType lastObject]];
//        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
//        imageView.image = image;
        
        [imageView sd_setImageWithURL:arr[i]];
        
        [_scrollView addSubview:imageView];
    }
    //设置pageControl
    _pageControl.numberOfPages = arr.count;
    //填充Label
    _titleLabel.text = [NSString stringWithFormat:@"   %@", arr[0]];
    _imageNames.array = arr;
}

/**
 启动广告滚动的定时器
 */
- (void)startTheADTimer
{
    //dispatch source是一个监视某些类型事件的对象
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 3*NSEC_PER_SEC, 1*NSEC_PER_SEC); //每3秒触发timer，误差1秒
    dispatch_source_set_event_handler(timer, ^{
        //定时器处理的内容
        if (_advertCount) {
            
            _pageControl.currentPage = (_pageControl.currentPage+1)%_advertCount;
            [self pagging:_pageControl];
            
        }
        
        if (_stopTimer) { //设置永不停止定时器
            
            dispatch_source_cancel(timer);
            
        }
    });
    //启动定时器
    dispatch_resume(timer);
}

//改变页数
- (void)pagging:(UIPageControl *)pc
{
    NSInteger currentPage = pc.currentPage;
    [_scrollView setContentOffset:CGPointMake(currentPage * self.frame.size.width, 0) animated:YES];
}

//减速结束 改变页数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = currentPage;
    _titleLabel.text = [NSString stringWithFormat:@"   %@", _imageNames[currentPage]];
}

@end















