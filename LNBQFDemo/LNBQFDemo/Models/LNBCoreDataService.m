//
//  LNBCoreDataService.m
//  LNBQFDemo
//  Created by Naibin on 15/12/9.
//  Copyright © 2015年 QianFeng. All rights reserved.


#import "LNBCoreDataService.h"

@implementation LNBCoreDataService

+ (LNBCoreDataService *)shareCoreDataService
{
    static LNBCoreDataService * service = nil;
    static dispatch_once_t my_dispatch_once;
    dispatch_once(&my_dispatch_once, ^{
        if (!service) {
            service = [[LNBCoreDataService alloc] init];
        }
    });
    return service;
}

- (void)openCoreData {
    //1.找到模型文件的完整路径
    
    //2.加载模型文件
    
    //3.把模型文件跟本地持久化文件进行关联
  
    //4.获取操作实体描述的上下文
    
}

@end
