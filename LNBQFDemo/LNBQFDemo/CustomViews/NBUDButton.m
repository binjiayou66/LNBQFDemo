//
//  NBUDButton.m
//  AiShangJianShen
//
//  Created by Naibin on 15/12/2.
//  Copyright © 2015年 Jinyu. All rights reserved.
//

#import "NBUDButton.h"

#define BUTTON_SIZE self.bounds.size
#define LABEL_HEIGHT 20

@implementation NBUDButton {
    UIImageView * _upImageView;
    UILabel * _downLabel;
    
    NSString * _title;
    UIColor * _color;
    UIColor * _selectedColor;
    
    UIImage * _image;
    UIImage * _selectedImage;
    
    id _target;
    SEL _action;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _upImageView = [[UIImageView alloc] init];
        _upImageView.bounds = CGRectMake(0, 0, BUTTON_SIZE.height - LABEL_HEIGHT - 5, BUTTON_SIZE.height - LABEL_HEIGHT - 5);
        _upImageView.center = CGPointMake(BUTTON_SIZE.width / 2, (BUTTON_SIZE.height - LABEL_HEIGHT) / 2);
        _downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, BUTTON_SIZE.height - LABEL_HEIGHT + 3, BUTTON_SIZE.width, LABEL_HEIGHT - 8)];
        _downLabel.textAlignment = NSTextAlignmentCenter;
        _downLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_upImageView];
        [self addSubview:_downLabel];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    _upImageView.image = _selected ? _selectedImage : _image;
    _downLabel.textColor = _selected ? _selectedColor : _color;
}

- (void)setTitle:(NSString *)title withColor:(UIColor *)color andSelectedColor:(UIColor *)selectedColor {
    _title = title;
    _color = color;
    _selectedColor = selectedColor;
    
    _downLabel.text = title;
    _downLabel.textColor = color;
}

- (void)setImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage {
    _image = image;
    _selectedImage = selectedImage;
    
    _upImageView.image = image;
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








