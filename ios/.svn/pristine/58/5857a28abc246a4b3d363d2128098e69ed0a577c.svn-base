//
//  WeChatPublicNumberHeaderView.m
//  ScienceChina
//
//  Created by xuanyj on 2017/1/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "WeChatPublicNumberHeaderView.h"

@implementation WeChatPublicNumberHeaderView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    UIColor *_textColor = RGBCOLOR(157, 157, 157);
    UIFont *_bigTextFont = FONT_16;
    UIFont *_smallTextFont = FONT_15;
    
    CGFloat _contentWidth = MAIN_SCREEN_WIDTH;
    CGFloat _up = 28.0;
    CGFloat _left = 15.0;
    if (isIpad) {
        _left = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0+15.0;
    }
    
    CGFloat _iconW = 68.0;
    CGFloat _iconH = 42.0;
    
    CGFloat _iconAndLabelSpace = 30.0;
    CGFloat _labelVerticalSpace1 = 10.0;
    CGFloat _labelVerticalSpace2 = 6.0;
    CGFloat _labelX = _left+_iconW+_iconAndLabelSpace;
    CGFloat _labelH = 13.0;
    CGFloat _labelW = _contentWidth-_left-_labelX-_iconAndLabelSpace;
    
    UIImageView *_iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_left, 50, _iconW, _iconH)];
    _iconImageView.image = [UIImage imageNamed:@"WeChatPublicNumberHeaderImage"];
    
    UILabel *_label1 = [[UILabel alloc] initWithFrame:CGRectMake(_labelX, _up, _labelW, _labelH)];
    _label1.font = _bigTextFont;
    _label1.text = @"科普中国";
    _label1.textColor = [UIColor blackColor];
    _label1.textAlignment = NSTextAlignmentLeft;
    
    UILabel *_label2 = [[UILabel alloc] initWithFrame:CGRectMake(_labelX, _label1.frame.origin.y+_label1.frame.size.height + _labelVerticalSpace2, _labelW, _labelH)];
    _label2.font = _smallTextFont;
    _label2.text = @"微信号：Science_China";
    _label2.textColor = _textColor;
    _label2.textAlignment = NSTextAlignmentLeft;
    
    UILabel *_label3 = [[UILabel alloc] initWithFrame:CGRectMake(_labelX, _label2.frame.origin.y+_label2.frame.size.height + _labelVerticalSpace1, _labelW, _labelH)];
    _label3.font = _smallTextFont;
    _label3.text = @"功能介绍公众科普，科学传播 ";
    _label3.textColor = _textColor;
    _label3.textAlignment = NSTextAlignmentLeft;
    
    UILabel *_label4 = [[UILabel alloc] initWithFrame:CGRectMake(_labelX, _label3.frame.origin.y+_label3.frame.size.height + _labelVerticalSpace2, _labelW, _labelH)];
    _label4.font = _smallTextFont;
    _label4.text = @"帐号主体      中国科学技术协会";
    _label4.textColor = _textColor;
    _label4.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *_trueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, _labelH, _labelH)];
    _trueImageView.image = [UIImage imageNamed:@"WeChatPublicNumberHeaderImageTrue"];
    [_label4 addSubview:_trueImageView];
    
    UIView *_line = [[UIView alloc] initWithFrame:CGRectMake(_left, WeChatPublicNumberHeaderViewHeight-1.0, _contentWidth, 1.0)];
    _line.backgroundColor = RGBCOLOR(229, 229, 231);
    
    
    [self addSubview:_iconImageView];
    [self addSubview:_label1];
    [self addSubview:_label2];
    [self addSubview:_label3];
    [self addSubview:_label4];
    //[self addSubview:_line];
    
}

@end
