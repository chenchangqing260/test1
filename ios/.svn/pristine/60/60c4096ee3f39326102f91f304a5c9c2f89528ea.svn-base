//
//  LXCircleAnimationView.m
//  LXCircleAnimationView
//
//  Created by Leexin on 15/12/18.
//  Copyright © 2015年 Garden.Lee. All rights reserved.
//

#import "LXCircleAnimationView.h"
#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static const CGFloat kMarkerRadius = 7.f; // 光标直径
static const CGFloat kAnimationTime = 2.f;

@interface LXCircleAnimationView (){
    UILabel *_topLabel;//科普之星
    UILabel *_centerLabel;
}

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UIImageView *markerImageView; // 光标
@property (nonatomic, strong) UIImageView *bgImageView; // 背景图片
@property (nonatomic, strong) UILabel *commentLabel; // 中间文字label

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidthOfBack; // 底部弧线宽度
@property (nonatomic, assign) CGFloat lineWidthOfProgress; // 进度弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@end

@implementation LXCircleAnimationView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initDefaultData];
        
        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(6, 6, self.circelRadius, self.circelRadius * 2 / 3);
        [self addSubview:self.bgImageView];
        
        self.commentLabel.frame = CGRectMake(self.bgImageView.left + self.circelRadius / 4, self.circelRadius / 4, self.circelRadius / 2, self.circelRadius / 2);
        self.commentLabel.backgroundColor = [UIColor yellowColor];
        [self initSubView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)backColor progressColor:(UIColor *)progressColor pointColor:(UIColor *)pointColor{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultData];
        
        if (backColor) {
            self.backColor = backColor;
        }
        if (progressColor) {
            self.progressColor = progressColor;
        }
        if (pointColor) {
            self.pointColor = pointColor;
        }
        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(6, 6, self.circelRadius, self.circelRadius * 2 / 3);
        [self addSubview:self.bgImageView];
        
        self.commentLabel.frame = CGRectMake(self.bgImageView.left + self.circelRadius / 4, self.circelRadius / 4, self.circelRadius / 2, self.circelRadius / 2);
        
        [self initSubView];
    }
    return self;
}
-(void)initDefaultData{
    
    self.circelRadius = self.frame.size.width - 10.f;
    self.lineWidthOfBack = 1.f;
    self.lineWidthOfProgress = 2.0f;
    self.stareAngle = -200.f;
    self.endAngle = 20.f;
    
    self.backColor = [UIColor  colorWithRed:206.f / 256.f green:241.f / 256.f blue:227.f alpha:1.f];
    self.pointColor = [UIColor colorWithHex:0x20B2AA];
}
- (void)initSubView {
    
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                        radius:(self.circelRadius - self.lineWidthOfBack) / 2
                                                    startAngle:degreesToRadians(self.stareAngle)
                                                      endAngle:degreesToRadians(self.endAngle)
                                                     clockwise:YES];
    
    // 底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = self.backColor.CGColor;
    self.bottomLayer.opacity = 0.5;
    self.bottomLayer.lineCap = kCALineCapRound;
    self.bottomLayer.lineWidth = self.lineWidthOfBack;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidthOfProgress;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomLayer setMask:self.progressLayer];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    if (self.progressColor) {
        [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                       (id)[self.progressColor CGColor],
                                       (id)[self.progressColor CGColor],
                                       nil]];
        [self.gradientLayer setLocations:@[@0.0, @1]];
    }else{
        [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                       (id)[[UIColor colorWithHex:0xFF6347] CGColor],
                                       [(id)[UIColor colorWithHex:0xFFEC8B] CGColor],
                                       (id)[[UIColor colorWithHex:0xEEEE00] CGColor],
                                       (id)[[UIColor colorWithHex:0x7FFF00] CGColor],
                                       nil]];
        [self.gradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    }
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.gradientLayer setMask:self.progressLayer];
    
    [self.layer addSublayer:self.gradientLayer];
    
    
    
    CGFloat dashCircelRadius = self.circelRadius-5*2;//虚线直径
    UIBezierPath *dashPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                            radius:dashCircelRadius/2.0
                                                        startAngle:degreesToRadians(self.stareAngle)
                                                          endAngle:degreesToRadians(self.endAngle)
                                                         clockwise:YES];
    CAShapeLayer *dotteLine =  [CAShapeLayer layer];
    dotteLine.lineWidth = self.lineWidthOfBack;
    dotteLine.strokeColor = [UIColor whiteColor].CGColor;
    dotteLine.fillColor = [UIColor clearColor].CGColor;
    dotteLine.path = dashPath.CGPath;
    NSArray *arr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:2], nil];
    dotteLine.lineDashPhase = 1.0;
    dotteLine.lineDashPattern = arr;
    [self.layer addSublayer:dotteLine];
    
    // 240 是用整个弧度的角度之和 |-200| + 20 = 220
    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                               endAngle:degreesToRadians(self.stareAngle + 220 * 0)];
    
    CGFloat h = self.circelRadius/2.0 * cos(self.endAngle) + self.circelRadius/2.0;
    CGFloat labelW = self.circelRadius;
    CGFloat left = (self.frame.size.width-self.circelRadius) /2.0;
    UIColor *textColor = [UIColor whiteColor];
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 25, labelW, 15)];
    _topLabel.font = FONT_16;
    _topLabel.text = @"科普之星";
    _topLabel.textColor = textColor;
    _topLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *_bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, h-15, labelW, 15)];
    _bottomLabel.font = FONT_14;
    _bottomLabel.text = @"积分";
    _bottomLabel.textColor = textColor;
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    
    _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, _topLabel.frame.origin.y + _topLabel.frame.size.height, labelW, h-_topLabel.frame.origin.y-_topLabel.frame.size.height-_bottomLabel.frame.size.height)];
    _centerLabel.font = [UIFont systemFontOfSize:43.0];
    _centerLabel.text = @"0";
    _centerLabel.textColor = textColor;
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_topLabel];
    [self addSubview:_bottomLabel];
    [self addSubview:_centerLabel];

}

#pragma mark - Animation

- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle { // 光标动画
    
    // 设置动画属性
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationTime;
    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.width/2, self.height/2, self.circelRadius/2, startAngle, endAngle, 0);
    pathAnimation.path = path;
    CGPathRelease(path);
    self.markerImageView.frame = CGRectMake(-100, self.height, kMarkerRadius, kMarkerRadius);
    self.markerImageView.layer.cornerRadius = self.markerImageView.frame.size.height / 2;
    [self addSubview:self.markerImageView];
    
    [self.markerImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
}

- (void)circleAnimation { // 弧形动画
    
    // 复原
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:kAnimationTime];
    self.progressLayer.strokeEnd = _percent / 100.0;
    [CATransaction commit];
}

#pragma mark - Setters / Getters

- (void)setPercent:(CGFloat)percent {
    
    [self setPercent:percent animated:YES];
}

- (void)setPercent:(CGFloat)percent animated:(BOOL)animated {
    
    _percent = percent;
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];
    
    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                               endAngle:degreesToRadians(self.stareAngle + 220 * percent / 100)];
}

- (void)setBgImage:(UIImage *)bgImage {
    
    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _topLabel.text = title;
}
- (void)setText:(NSString *)text {
    
    _text = text;
    self.commentLabel.text = text;
    _centerLabel.text = text;
}
//圆点
- (UIImageView *)markerImageView {
    
    if (nil == _markerImageView) {
        _markerImageView = [[UIImageView alloc] init];
        _markerImageView.image = [UIImage imageNamed:@"markerImage"];
        //_markerImageView.backgroundColor = self.pointColor;
        _markerImageView.alpha = 1.0;
        _markerImageView.layer.shadowColor = [UIColor clearColor].CGColor;//[UIColor colorWithHex:0x20B2AA].CGColor;
        //_markerImageView.layer.shadowOffset = CGSizeMake(0, 0);
        //_markerImageView.layer.shadowRadius = kMarkerRadius/2.0;//3.f;
        //_markerImageView.layer.shadowOpacity = 0;//1;//阴影透明的
    }
    return _markerImageView;
}

- (UIImageView *)bgImageView {
    
    if (nil == _bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}
- (UILabel *)commentLabel {
    
    if (nil == _commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:20.f];
        _commentLabel.textColor = [UIColor colorWithHex:0x20B2AA];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

@end
