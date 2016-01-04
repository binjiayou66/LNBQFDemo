//
//  PublicMethod.m
//  LHFQFItem
//
//  Created by 李洪峰 on 15/11/25.
//  Copyright (c) 2015年 LHF. All rights reserved.
//

#import "PublicMethod.h"

@implementation PublicMethod

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];

    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
}

//设置有多少个 section
//+(void)initPublicTableSections:(PublicBaseView *)tableView sections:(NSInteger) numSections
//{
//    if (numSections == 0) {
//        return;
//    }
//    PublicTableSection *set = [PublicMethod initPublicTableViewSetting];
//    for (NSInteger i=0; i<numSections; i++) {
//        PublicTableSection *section = [[PublicTableSection alloc] init];
//        [set.sectionArr addObject:section];
//    }
//    tableView.setting = set;
//}
//
////初始化 section 各项属性
//+(PublicTableSection*)initPublicTableViewSetting
//{
//    PublicTableSection *tableSeting = [[PublicTableSection alloc] init];
//    
//    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    
//    tableSeting.sectionArr = arr;
//    
//    return tableSeting;
//
//}
@end
