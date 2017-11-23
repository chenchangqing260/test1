//
//  IntegrationSummaryHeaderView.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "IntegrationSummaryHeaderView.h"
#import "LXCircleAnimationView.h"
#import "UIView+Extensions.h"



@implementation IntegrationSummaryHeaderView
{
    UILabel *_monthIntegralNumLabel;//本月积分数——左上角
    UILabel *_levelNumLabel;//等级数——右上角
    UILabel *_minStarNumLabel;//等级范围——左下角
    UILabel *_maxStarNumLabel;//等级范围——右下角
    UILabel *_minIntegralNumLabel;//积分范围——左下角
    UILabel *_maxIntegralNumLabel;//积分范围——右下角
    LXCircleAnimationView *_circleProgressView;
    UILabel *_upperLimitLabel;//积分上限
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.backgroundColor = RGBCOLOR(105, 220, 221);
    self.clipsToBounds = YES;
    
    UIColor *_textColor = [UIColor whiteColor];
    
    CGFloat _contentWidth = isIpad ? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    CGFloat _left = 15.0;
    CGFloat _up = 15.0;
    CGFloat _labelH = 10.0;
    
    UIView *_monthIntegralView = [[UIView alloc] initWithFrame:CGRectMake(_left, _up, 70, _labelH)];
    
    UILabel *_monthIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _monthIntegralView.frame.size.width, 20)];
    _monthIntegralLabel.font = FONT_16;
    _monthIntegralLabel.text = @"本月积分";
    _monthIntegralLabel.textColor = _textColor;
    _monthIntegralLabel.textAlignment = NSTextAlignmentLeft;
    
    _monthIntegralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _monthIntegralLabel.frame.size.height, _monthIntegralView.frame.size.width, 20)];
    _monthIntegralNumLabel.font = FONT_16;
    _monthIntegralNumLabel.text = @"0";
    _monthIntegralNumLabel.textColor = _textColor;
    _monthIntegralNumLabel.textAlignment = NSTextAlignmentCenter;
    
    _monthIntegralView.backgroundColor     = [UIColor clearColor];
    _monthIntegralLabel.backgroundColor    = [UIColor clearColor];
    _monthIntegralNumLabel.backgroundColor = [UIColor clearColor];
    
    [_monthIntegralView addSubview:_monthIntegralLabel];
    [_monthIntegralView addSubview:_monthIntegralNumLabel];
    
    //圆形进度条
    CGFloat circleProgressW = 161.0;
    _circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake((self.bounds.size.width-circleProgressW)/2.0, 11.f, circleProgressW, circleProgressW) backColor:[UIColor whiteColor] progressColor:[UIColor yellowColor] pointColor:[UIColor whiteColor]];
    //_circleProgressView.bgImage = [UIImage imageNamed:@"circleBakcImage"];
    _circleProgressView.percent = 0.f;
    _circleProgressView.text = @"0";
    
    //等级
    CGFloat _levelViewW = 50.0;
    CGFloat _levelViewH = 20.0;
    UIView *_levelView = [[UIView alloc] initWithFrame:CGRectMake(_contentWidth-_left-_levelViewW, _up, _levelViewW, _levelViewH)];
    
    UIImageView *_levelImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _levelViewH, _levelViewH)];
    _levelImg.image = [UIImage imageNamed:@"星级onMyIntegral"];
    
    _levelNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_levelImg.frame.size.width+5, 0, _levelViewW-_levelImg.frame.size.width-5, _levelViewH)];
    _levelNumLabel.font = FONT_16;
    _levelNumLabel.text = @"0";
    _levelNumLabel.textColor = _textColor;
    _levelNumLabel.textAlignment = NSTextAlignmentLeft;
    
    [_levelView addSubview:_levelImg];
    [_levelView addSubview:_levelNumLabel];
    
    //等级范围，小
    CGFloat _starLabelH = 20.0;
    CGFloat _verticalSpaceOnStarViewH = 10.0;
    CGFloat _horizontalSpaceOnStarViewH = 5.0;
    CGFloat _starViewH = _starLabelH*2+_verticalSpaceOnStarViewH;
    CGFloat _starViewW = _circleProgressView.frame.origin.x-_left+30;//60.0;
    CGFloat _minStarNumW = 10;
    
    UIView *_minStarView = [[UIView alloc] initWithFrame:CGRectMake(_left, IntegrationSummaryHeaderViewHeight-_starViewH, _starViewW, _starViewH)];
    
    UIView *_maxStarView = [[UIView alloc] initWithFrame:CGRectMake(_contentWidth-_left-_starViewW, IntegrationSummaryHeaderViewHeight-_starViewH, _starViewW, _starViewH)];
    
//    CGRect minStarViewF = _minStarView.frame;
//    minStarViewF.size.width = _circleProgressView.frame.origin.x-_minStarView.frame.origin.x+30;
//    _minStarView.frame = minStarViewF;
//    
//    CGRect maxStarViewF = _maxStarView.frame;
//    maxStarViewF.origin.x = _circleProgressView.frame.origin.x+_circleProgressView.frame.size.width-30;
//    maxStarViewF.size.width = _minStarView.frame.size.width;
//    _maxStarView.frame = maxStarViewF;
    
    UIImageView *_minStarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _starLabelH, _starLabelH)];
    _minStarImg.image = [UIImage imageNamed:@"baixing"];
    
    _minStarNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_minStarImg.frame.size.width+_horizontalSpaceOnStarViewH, 0, _minStarNumW, _starLabelH)];
    _minStarNumLabel.font = FONT_14;
    _minStarNumLabel.text = @"0";
    _minStarNumLabel.textColor = _textColor;
    _minStarNumLabel.textAlignment = NSTextAlignmentLeft;
    
    _minIntegralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _minStarNumLabel.frame.size.height+_verticalSpaceOnStarViewH, _starViewW, _starLabelH)];
    _minIntegralNumLabel.font = FONT_14;
    _minIntegralNumLabel.text = @"0";
    _minIntegralNumLabel.textColor = _textColor;
    _minIntegralNumLabel.textAlignment = NSTextAlignmentRight;
    
    //[_minStarView addSubview:_minStarImg];
    //[_minStarView addSubview:_minStarNumLabel];
    [_minStarView addSubview:_minIntegralNumLabel];
    
    
    //等级范围，大
    UIImageView *_maxStarImg = [[UIImageView alloc] initWithFrame:CGRectMake(_starViewW-_minStarNumW-_starLabelH-_horizontalSpaceOnStarViewH, 0, _starLabelH, _starLabelH)];
    _maxStarImg.image = [UIImage imageNamed:@"baixing"];
    
    _maxStarNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_starViewW-_minStarNumW, 0, _minStarNumW, _starLabelH)];
    _maxStarNumLabel.font = FONT_14;
    _maxStarNumLabel.text = @"0";
    _maxStarNumLabel.textColor = _textColor;
    _maxStarNumLabel.textAlignment = NSTextAlignmentRight;
    
    _maxIntegralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _maxStarNumLabel.frame.size.height+_verticalSpaceOnStarViewH, _starViewW, _starLabelH)];
    _maxIntegralNumLabel.font = FONT_14;
    _maxIntegralNumLabel.text = @"0";
    _maxIntegralNumLabel.textColor = _textColor;
    _maxIntegralNumLabel.textAlignment = NSTextAlignmentLeft;
    
    //[_maxStarView addSubview:_maxStarImg];
    //[_maxStarView addSubview:_maxStarNumLabel];
    [_maxStarView addSubview:_maxIntegralNumLabel];
    
    UIView *_upperLimit = [[UIView alloc] initWithFrame:CGRectMake(0, IntegrationSummaryHeaderViewHeight, self.bounds.size.width, IntegrationSummaryHeaderViewTipHeight)];
    _upperLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _upperLimit.bounds.size.width, _upperLimit.frame.size.height)];
    _upperLimitLabel.font = FONT_12;
    _upperLimitLabel.text = @"今日积分已达到300上限，请明日继续获得积分哦！";
    _upperLimitLabel.textColor = [UIColor blackColor];
    _upperLimitLabel.textAlignment = NSTextAlignmentCenter;
    _upperLimitLabel.backgroundColor = [UIColor colorWithHex:0xcdedef];
    
    CGSize textsize = [_upperLimitLabel boundingRectWithSize:CGSizeMake(0, IntegrationSummaryHeaderViewTipHeight)];
    UIImageView *upperLimitImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IntegrationSummaryHeaderViewUpperLimitIcon"]];
    upperLimitImage.frame = CGRectMake((_upperLimitLabel.bounds.size.width-textsize.width)/2.0-23.0-5, (IntegrationSummaryHeaderViewTipHeight-19.0)/2.0, 23, 19);

    [_upperLimit addSubview:_upperLimitLabel];
    [_upperLimit addSubview:upperLimitImage];

    [self addSubview:_monthIntegralView];
    [self addSubview:_levelView];
    [self addSubview:_minStarView];
    [self addSubview:_maxStarView];
    [self addSubview:_circleProgressView];
    [self addSubview:_upperLimit];
    
    CGRect minIntegralNumLabelF = _minIntegralNumLabel.frame;
    minIntegralNumLabelF.origin.x = _minStarView.frame.size.width-_minIntegralNumLabel.frame.size.width;
    _minIntegralNumLabel.frame = minIntegralNumLabelF;
    
    CGRect maxIntegralNumLabelF = _maxStarNumLabel.frame;
    maxIntegralNumLabelF.origin.x = _maxStarView.frame.size.width-_maxStarNumLabel.frame.size.width;
    _maxStarNumLabel.frame = maxIntegralNumLabelF;
    
    
}
-(void)setViewWithModel:(MyScoreModel *)model{
    if (!model) {
        return;
    }
    _monthIntegralNumLabel.text = model.currentMonthScore; //本月积分数
    _levelNumLabel.text = model.grade; //等级数
    
    _minStarNumLabel.text = model.grade; //等级范围
    _maxStarNumLabel.text = [NSString stringWithFormat:@"%ld",(long)[model.grade integerValue]+1]; //等级范围
    
    _minIntegralNumLabel.text = model.fromScore; //积分范围
    _maxIntegralNumLabel.text = model.toScore; //积分范围
    
    _circleProgressView.title = model.gradeName;//称谓
    _circleProgressView.text = model.totalScore; //总积分数
    _circleProgressView.percent = ([model.totalScore floatValue]-[model.fromScore floatValue])/([model.toScore floatValue]-[model.fromScore floatValue])*100;//90.f;
    
    if ([model.dayScore integerValue] >= 300) {
         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, IntegrationSummaryHeaderViewHeight+IntegrationSummaryHeaderViewTipHeight);
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, IntegrationSummaryHeaderViewHeight);
    }
}
@end
