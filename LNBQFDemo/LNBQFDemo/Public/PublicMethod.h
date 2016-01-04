//
//  PublicMethod.h
//  LHFQFItem
//
//  Created by 李洪峰 on 15/11/25.
//  Copyright (c) 2015年 LHF. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PublicMethod : NSObject


//通过这个网站http://www.114la.com/other/rgb.htm可以查找对应颜色的代码;
//传入方法中即可得到相应的颜色;
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;



@end
