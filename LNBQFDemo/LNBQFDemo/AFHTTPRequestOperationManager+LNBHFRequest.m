//
//  AFHTTPRequestOperationManager+LNBHFRequest.m
//  LNBQFDemo
//
//  Created by 李洪峰 on 15/12/21.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "AFHTTPRequestOperationManager+LNBHFRequest.h"
#import "PublicDefine.h"

static NSString *hostIP = nil;

@implementation AFHTTPRequestOperationManager (LNBHFRequest)

#pragma mark - newWorking Methods
- (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id resobject ))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = nil;
    
    // 如果没有ip就先去请求ip，如果有ip就拼接成完整的路径
    if (hostIP == nil) {
        
        //先去请求ip，拿到ip之后再去做实际的请求
  
        operation = [self getHostIPCompletion:^{
            
            // 调用AFNetworking原本的请求方法
            NSString *fullURL = [NSString stringWithFormat:@"%@%@", hostIP, URLString];
            
            NSLog(@"fullURL----%@",fullURL);
            
            [self GET:fullURL parameters:parameters success:success failure:failure];
        }];
    }else {  // 如果ip已经存在
        
        // 调用AFNetworking原本的请求方法
        NSString *fullURL = [NSString stringWithFormat:@"%@%@", hostIP, URLString];
        operation = [self GET:fullURL parameters:parameters success:success failure:failure];
        
    }
    return operation;
}

+ (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id resobject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // 下载数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //关闭自动解析功能,打开就是二进制的数据格式
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@",URLString);
    
    return [manager GETRequest:URLString parameters:parameters success:success failure:failure];
    
}

#pragma mark - Helper Methods
- (AFHTTPRequestOperation *)getHostIPCompletion:(void (^)(void))completion
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //HOST 传入获取服务器URL
    return [requestManager GET:HOST parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //把二进制数据转成文本
        NSString *responseText = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //保存IP
//     hostIP = responseText;
        
        //这里没有服务器的 url 直接拼接上去即可
        hostIP = HOST;
        
        completion();
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
          completion();
        
        NSLog(@"get host ip error: %@", error);
    }];
}
@end
