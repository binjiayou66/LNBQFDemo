//
//  UILabel+SizeAbout.m
//  LNBQFDemo
//
//  Created by Naibin on 15/12/3.
//  Copyright © 2015年 QianFeng. All rights reserved.
//

#import "UILabel+SizeAbout.h"

@implementation UILabel (SizeAbout)

- (CGSize)calcContentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

@end
