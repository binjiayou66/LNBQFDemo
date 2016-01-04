//
//  LHFTwoDimensionalCtrl.m
//  LNBQFDemo
//
//  Created by 李洪峰 on 15/12/17.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "LHFTwoDimensionalCtrl.h"
#import "QRCodeGenerator.h"


@interface LHFTwoDimensionalCtrl ()
{
    UIView *_whiteView;
    UILabel *_titleLabel; //标题
    UILabel *_contentLabel; //内容
}
@end

@implementation LHFTwoDimensionalCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //生成二维码
    [self creatDismension];
}
-(void)creatDismension
{
    WS(weakSelf);
    //添加白色 view
    _whiteView = [UIView new];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 10;
    _whiteView.layer.borderWidth = 0.3;
    _whiteView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_whiteView];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(weakSelf.view);
        //设置 size
//        make.size.mas_equalTo(CGSizeMake(300, 450));
        make.top.left.bottom.right.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(77, 10, 69, 10));

    }];
    
    //生成二维码
    UIImageView*imageView=[[UIImageView alloc]init];
    imageView.image = [QRCodeGenerator qrImageForString:@"http://www.mobiletrain.org" imageSize:800];
    [_whiteView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //     make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(50, 20, 50, 20));
        //     让 blackview 的中心和 self.view 一样
        make.center.equalTo(_whiteView);
        //设置 size
//        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.top.left.bottom.right.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(120, 10, 77, 10));

    }];
    
    //标题
    _titleLabel  = [[UILabel alloc]init];
    [_whiteView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //等于白色视图的 centerY
        make.top.equalTo(_whiteView).with.offset(10);
        make.left.equalTo(_whiteView).with.offset (10);
        make.right.equalTo(_whiteView).with.offset(-10);
        // 高位20
        make.height.mas_equalTo(@20);
    }];
    
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:28];
    _titleLabel.text = @"千锋";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];

    _contentLabel = [[UILabel alloc]init];
    [_whiteView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteView).with.offset(38);
        make.left.equalTo(_whiteView).with.offset (10);
        make.right.equalTo(_whiteView).with.offset(-10);
        
        // 高位20
        make.height.mas_equalTo(@20);
        
    }];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.font = [UIFont boldSystemFontOfSize:20];
    _contentLabel.text = @"做真实的自己,用良心做教育";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = [PublicMethod colorWithHexString:@"#4b95f2"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
