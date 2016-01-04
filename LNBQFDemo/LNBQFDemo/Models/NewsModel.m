//
//  NewsModel.m
//  Created by Naibin on 15/11/30.


#import "NewsModel.h"

@implementation NewsModel

+(NewsModel *)modelWithDic:(NSDictionary *)dic
{
    return [[NewsModel alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }else if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descrip"];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"ID:%@, title:%@, type_id:%@", _ID, _title, _type_id];
}

@end
