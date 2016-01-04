//
//  NBTouchableImageView.m
//  AiShangJianShen
//
//  Created by Naibin on 15/12/2.
//  Copyright © 2015年 Jinyu. All rights reserved.
//

#import "NBTouchableImageView.h"

@implementation NBTouchableImageView {
    id _target;
    SEL _action;
    
    UIImage * _image;
    UIImage * _selectedImage;
}

- (instancetype)init {
    if (self = [super init]) {
        //打开用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.image = selected ? _selectedImage : _image;
}

- (void)setImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage {
    _image = image;
    _selectedImage = selectedImage;
    
    self.image = image;
}

- (void)addTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_target && [_target respondsToSelector:_action]) {
        
        [_target performSelector:_action withObject:self];
        
    }
}

@end








