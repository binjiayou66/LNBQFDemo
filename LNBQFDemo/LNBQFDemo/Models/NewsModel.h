//
//  NewsModel.h
//  
//
//  Created by Naibin on 15/11/30.
//
//

//#import <JSONModel.h>
#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (copy, nonatomic) NSString * is_up;
@property (copy, nonatomic) NSString * is_collect;
@property (copy, nonatomic) NSString * status;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * up;
@property (copy, nonatomic) NSString * keyword;
@property (copy, nonatomic) NSString * course_id;
@property (copy, nonatomic) NSString * user_id;
@property (copy, nonatomic) NSString * type_id;
@property (copy, nonatomic) NSString * video;
@property (copy, nonatomic) NSString * is_push;
@property (copy, nonatomic) NSString * lesson_id;
@property (copy, nonatomic) NSString * ID;
@property (copy, nonatomic) NSString * tag_id;
@property (copy, nonatomic) NSArray * thumb;
@property (copy, nonatomic) NSString * add_time;
@property (copy, nonatomic) NSString * view;
@property (copy, nonatomic) NSString * collect;
@property (copy, nonatomic) NSString * update_time;
@property (copy, nonatomic) NSString * category_id;
@property (copy, nonatomic) NSString * comment;
@property (copy, nonatomic) NSString * author;
@property (copy, nonatomic) NSString * descrip;

+(NewsModel *)modelWithDic:(NSDictionary *)dic;

@end
