//
//  VideosViewController.m
//  LNBQFDemo
//
//  Created by Naibin on 15/12/2.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "VideosViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "LNBHFPlayerViewCtrl.h"

@interface VideosViewController ()

@property (strong, nonatomic) MPMoviePlayerViewController * moviePlayerVC;

@property (strong,nonatomic)NSString *img_url;
@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[[NSBundle mainBundle]bundleIdentifier]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelected:NO animated:YES];
    
    NewsModel * model = self.dataSource[indexPath.section][indexPath.row];
    
    NSString * videoInfo = [NSString stringWithFormat:STUDY_URL, model.ID];
    
    [AFHTTPRequestOperationManager GETRequest:videoInfo parameters:nil success:^(AFHTTPRequestOperation *operation, id resobject) {
        
        NSString * videoURL = resobject[@"data"][@"video"];
        NSArray *arr  = resobject[@"data"][@"thumb"];
        NSDictionary *dic  = arr[0];
        
        _img_url  = dic[@"img_url"];
    
        //加载视频
        [self loadplayerUrl:videoURL];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error.localizedDescription);

    }];
}
//根据地址来加载视频
-(void)loadplayerUrl:(NSString *)path
{
    NSURL * url = nil;
    if ([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"]) {
        
        url = [NSURL URLWithString:path]; //网络 URL 地址
        
    }else{
        url =  [NSURL fileURLWithPath:path]; //本地资源 URL 地址
    }
    //用播放地址初始化播放器
    _moviePlayerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    [_moviePlayerVC.moviePlayer play] ;//开始播放
    
    
    LNBHFPlayerViewCtrl *hf  = [[LNBHFPlayerViewCtrl alloc]init];
    hf.videoURL = url;
    hf.img_url = _img_url;
    [self.navigationController pushViewController:hf animated:YES];
    
    //用导航栏 push 过去
//    [self.navigationController pushViewController:_moviePlayerVC animated:YES];
    
    
//     [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:_moviePlayerVC animated:YES completion:nil];
    
}
@end








