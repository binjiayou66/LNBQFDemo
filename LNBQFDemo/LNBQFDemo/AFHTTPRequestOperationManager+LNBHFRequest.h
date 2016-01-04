//
//  AFHTTPRequestOperationManager+LNBHFRequest.h
//  LNBQFDemo
//
//  Created by 李洪峰 on 15/12/21.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface AFHTTPRequestOperationManager (LNBHFRequest)


/** 请求之前通过这个方法 拿到服务器 IP 地址,拼接出完整的接口地址*/
- (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id resobject ))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 对AF请求操作的进一步封装，是的代码更简洁
 */
+ (AFHTTPRequestOperation *)GETRequest:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id resobject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
