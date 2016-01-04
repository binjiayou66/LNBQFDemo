//
//  LNBHFPlayerViewCtrl.m
//  LNBQFDemo
//
//  Created by 李洪峰 on 15/12/23.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "LNBHFPlayerViewCtrl.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"
#import "PublicDefine.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface LNBHFPlayerViewCtrl ()
/**播放图片*/
@property (strong, nonatomic)UIImageView *videoImageView;

@property (nonatomic, strong) MPMoviePlayerController *videoPlayerController;

@property (strong, nonatomic)UIView *playView;

@end

@implementation LNBHFPlayerViewCtrl

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.videoPlayerController pause];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, screen_w, 220)];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:_img_url]];
    [self.view addSubview:_videoImageView];
    _playView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_w, 220)];
    [self.view addSubview:self.playView];
    
    self.videoPlayerController = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    self.videoPlayerController.view.frame = CGRectMake(0, 64, screen_w, 220);
    self.videoPlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self.videoPlayerController.shouldAutoplay = NO;
    self.videoPlayerController.repeatMode = MPMovieRepeatModeNone;
    self.videoPlayerController.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.view addSubview:self.videoPlayerController.view];
    [self.videoPlayerController play];
    [self.playView bringSubviewToFront:self.view];
    
    //支付按钮
    UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake((screen_w-170)/2, (screen_h-64-220-10),170 , 40)];
    button.backgroundColor = [PublicMethod colorWithHexString:@"#4b95f2"];
    [button setTitle:@"购买该课程" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth =0.8;
    button.layer.borderColor = [PublicMethod colorWithHexString:@"4f5f6d"].CGColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(alipay:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 播放状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStateDidChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    //已经结束播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPlaybackDidEnd:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //准备播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerIsReady:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    //将要进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    //将要退出全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    //已经退出全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidExitFullScreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
}

//点击产生购买跳转支付宝页面,如果有支付宝 APP 会跳转到APP 中进行支付
-(void)alipay:(UIButton *)button
{
    /*
     1.首先配置 pch 文件 添加 UIKit 和 FOndation 框架
     2.将支付宝所需要的 SDK 都添加到一个文件夹里面
     3.点击工程文件 点击--Build settings 里面搜索  header search  添加支付宝 SDK 相对路径
     4.添加相关依赖库文件SystemConfiguration ,CoreGraphics
     5.参照 官方demo 添加相关代码
     */
    NSLog(@"购买该课程");
    
    // 1.本地拼装一个order
    Order *order = [[Order alloc] init];
    order.partner = PARTNER; //合作者ID
    order.seller = SELLER; //收款账号
    
    // 2.购买商品的具体订单信息
    order.productName = @"切糕"; //标题
    order.productDescription = @"10斤"; //内容
    order.amount = [NSString stringWithFormat:@"%.2f", 0.01]; //价格
    //    order.tradeNO = @"147238273821"; //随机生成订单 ID
    order.tradeNO = [self generateTradeNO];
    
    // 3.生成签名
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:[order description]];
    
    // 4.将order信息和签名信息拼装在一起
    NSString *orderSign = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", [order description], signedString, @"RSA"];
    
    //partner="2088611922925773"&seller_id="esok@esok.cn"&out_trade_no="147238273821"&subject="切糕"&body="10斤"&total_fee="0.01"&sign="c4I3%2BTF0v%2FpzRlyJ%2FctNrgkbGls7gOAmO3A%2B4gBEL6ooMkQzgNmQH9ePmTp3hD1cBSiE%2BR9fBFqcNA%2B854%2FFe2qd0tWvN4jJG0jODEBByPT%2BW3fyj2muQXi9VcpWK%2FrPNNY9NHncwUYs9lAQO57btKNPPmq2QdfwGX9P9pVdFOE%3D"&sign_type="RSA"
    
    NSLog(@"order信息和签名信息------%@",orderSign);
    NSString *scheme = @"1529.beike";
    
    // 5.支付
    [[AlipaySDK defaultService] payOrder:orderSign
                              fromScheme:scheme callback:^(NSDictionary *resultDic) {
                                  
                                  NSInteger status = [resultDic[@"resultStatus"] integerValue];
                                  
                                  if (status == 9000) {
                                      NSLog(@"支付成功");
                                  }else {
                                      NSLog(@"%@",resultDic[@"memo"]);
                                  }
                              }];
}
//随机生成订单号
-(NSString *)generateTradeNO
{
    const int count =15;
    NSString * sourceString=@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *re=[[NSMutableString alloc]init];
    for (int i = 0; i < count; i++) {
        unsigned index=rand()%[sourceString length];
        NSString * s=[sourceString substringWithRange:NSMakeRange(index, 1)];
        [re appendString:s];
    }
    return re;
}

-(void)playerPlaybackDidEnd:(NSNotification *)notifacation
{
    //显示菊花视图
}

-(void)playerIsReady:(NSNotification *)notifacation
{
    //菊花视图停止转动
}

-(void)playerWillExitFullScreen:(NSNotification *)notifacation
{
    // 退出播放转成竖屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}

-(void)playerStateDidChanged:(NSNotification *)notifacation
{
    switch (_videoPlayerController.playbackState) {
        case MPMoviePlaybackStatePlaying:{
            NSLog(@"正在播放");
        }
            break;
        case MPMoviePlaybackStatePaused:
        {
            NSLog(@"播放暂停");
//            [self.videoPlayerController play];
        }
            break;
        default:
            break;
    }
}

-(void)playerDidExitFullScreen:(NSNotification *)notifacation
{
    CGRect rect = self.playView.frame;
    rect.size.height = 220;
    self.playView.frame = rect;
}
-(void)playerWillEnterFullScreen:(NSNotification *)notifacation
{
    // 转成橫屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];

    self.playView.frame = self.view.bounds;
}




@end
