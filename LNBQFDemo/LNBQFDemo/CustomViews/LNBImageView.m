//
//  LNBImageView.m
//  Day9-PhotosWall
//
//  Created by Naibin on 15/11/5.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#import "LNBImageView.h"

@implementation LNBImageView {
    id _target;
    SEL _action;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //打开用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //当当前图片视图被触摸的时候，如果被绑定事件的对象能够响应该消息，就执行该方法，传参为当前图片视图
    if ([_target respondsToSelector:_action] == YES) {
        [_target performSelector:_action withObject:self];
    }
}

@end










