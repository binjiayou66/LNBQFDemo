//
//  LNBHFLoaderView.m
//  Created by 李洪峰 on 15/12/22.


#import "LNBHFLoaderView.h"

@interface LNBHFLoaderView ()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@property (nonatomic, assign) BOOL isSpinning;

@end

@implementation LNBHFLoaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setLayer];
    }
    return self;
}

/**设置 layer 属性*/
-(void)setLayer
{
    self.backgroundColor = [UIColor clearColor];
     _lineWidth = LOADERVIEW_LINE_WIDTH;
    self.backgroundLayer = [CAShapeLayer layer];//创建一个shapeLayer
    self.backgroundLayer.strokeColor = LOADERVIEW_COLOR.CGColor; // 边缘线的颜色
    _backgroundLayer.fillColor = self.backgroundColor.CGColor;// 闭环填充的颜色
    _backgroundLayer.lineCap = kCALineCapRound;// 边缘线的类型
    _backgroundLayer.lineWidth = _lineWidth;// 线条宽度
    [self.layer addSublayer:_backgroundLayer];
}

+ (LNBHFLoaderView *)addShowView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated
{
    LNBHFLoaderView *activeView = [[LNBHFLoaderView alloc] initWithFrame:LOADERVIEW_FRAME];
    
    //添加加载文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-70.0f, 40.0f, 200.0f, 42.0f)];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    label.textColor = LOADERVIEW_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [activeView addSubview:label];
    
    [activeView start];
    [view addSubview:activeView];
    
    CGPoint center = CGPointMake(screen_w/2, screen_h/2);
    
    activeView.center = center;
    
    return activeView;
}
#pragma mark - Spin
- (void)start
{
    self.isSpinning = YES;
    
    [self drawBackgroundCircle:YES];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0]; //旋转360°
    rotationAnimation.duration = 1; //时间1秒
    rotationAnimation.cumulative = YES; 
    rotationAnimation.repeatCount = HUGE_VALF; //设置无穷大次数,无限循环
    
    //layer 开启执行动画
    [_backgroundLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
// 隐藏动画view
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated
{
    LNBHFLoaderView *hud = [LNBHFLoaderView HUDForView:view];
    [hud stop];
    if (hud) {
        [hud removeFromSuperview];
        return YES;
    }
    return NO;
}
//停止动画
- (void)stop
{
    [self drawBackgroundCircle:NO];
    [_backgroundLayer removeAllAnimations];
    self.isSpinning = NO;
}

// 隐藏动画
+ (LNBHFLoaderView *)HUDForView: (UIView *)view
{
    LNBHFLoaderView *hud = nil;
    NSArray *subViewsArray = view.subviews;
    
    //隐藏 view 上面所有LNBHFLoaderView类的子视图
    for (UIView *aView in subViewsArray) {
        if ([aView isKindOfClass:[LNBHFLoaderView class]]) {
            
            hud = (LNBHFLoaderView *)aView;

        }
    }
    return hud;
}

#pragma mark - Drawing
- (void)drawBackgroundCircle:(BOOL) partial
{
    CGFloat startAngle = - ((float)M_PI / 2); // 90°
    
    CGFloat endAngle = (2 * (float)M_PI) + startAngle; //360+90
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2); //中心点
    
    CGFloat radius = (self.bounds.size.width - _lineWidth)/2;
    
// UIBezierPath-->使用此类可以定义简单的形状,如椭圆或者矩形，或者有多个直线和曲线段组成的形状。
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = _lineWidth;
    
    if (partial) {
        endAngle = (1.8f * (float)M_PI) + startAngle;
    }
    
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    _backgroundLayer.path = processBackgroundPath.CGPath;
    
}

//重绘 layer 的 frame
- (void)drawRect:(CGRect)rect
{
    _backgroundLayer.frame = self.bounds;
}
@end
