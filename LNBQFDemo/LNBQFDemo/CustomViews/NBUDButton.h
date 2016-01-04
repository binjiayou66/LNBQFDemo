//
//  NBUDButton.h
//  AiShangJianShen
//
//  Created by Naibin on 15/12/2.
//  Copyright © 2015年 Jinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBUDButton : UIView

@property (assign, nonatomic, readonly, getter=isSelected) BOOL selected;

- (void)setSelected:(BOOL)selected;

- (void)setTitle:(NSString *)title withColor:(UIColor *)color andSelectedColor:(UIColor *)selectedColor;
- (void)setImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage;

- (void)addTarget:(id)target withAction:(SEL)action;

@end
