//
//  LNBHFLoaderView.h
//  Created by 李洪峰 on 15/12/22.


#import <UIKit/UIKit.h>

@interface LNBHFLoaderView : UIView

//设置颜色
#define LOADERVIEW_COLOR      [PublicMethod colorWithHexString:@"#4b95f2"]

//设置 frame
#define LOADERVIEW_FRAME      CGRectMake(40.0f, 40.0f, 40.0f, 40.0f)

#define LOADERVIEW_IMAGE       CGRectMake(15, 15,30,30)

#define LOADERVIEW_IMAGE       [UIImage imageNamed:@"image"]

//取fmaxf最大值(a.b)
#define LOADERVIEW_LINE_WIDTH  fmaxf(self.frame.size.width*0.025, 1.f)


@property (nonatomic, assign) CGFloat lineWidth;

/**添加动画*/
+ (LNBHFLoaderView *)addShowView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;
/**隐藏动画*/
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;


@end
