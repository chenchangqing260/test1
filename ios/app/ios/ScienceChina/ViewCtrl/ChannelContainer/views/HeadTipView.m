//
//  HeadTipView.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HeadTipView.h"


typedef void(^ActionBlock)();

@interface HeadTipView (){
    ActionBlock _actionBlock;
}
@property (nonatomic,assign) CGFloat graphicViewWidth;
@property (nonatomic,assign) CGFloat imageW;
@property (nonatomic,strong) UIView *graphicView;
@property (nonatomic,strong) UIButton *icon;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIButton *actionButton;
@end

@implementation HeadTipView


-(id)initWithFrame:(CGRect)frame actionBlock:(void(^)())actionBlock{
    if (self = [super initWithFrame:frame]) {
        _actionBlock = actionBlock;
        [self initDefaultData];
    }
    return self;
}

-(void)initDefaultData{
    self.showActionButton = NO;
    self.backgroundColor = [UIColor colorWithHex:0x33cfda alpha:0.15];
    self.alpha = 1.0;
}

-(void)setShowActionButton:(BOOL)showActionButton{
    _showActionButton = showActionButton;
    [self resetSubview];
    
}
-(CGFloat)graphicViewWidth{
    return 170;
}
-(CGFloat)imageW{
    return self.bounds.size.height;
}
-(UIView *)graphicView{
    if (!_graphicView) {
        _graphicView  =[[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-self.graphicViewWidth)/2.0, 0, self.graphicViewWidth, self.bounds.size.height)];
        _graphicView.backgroundColor = [UIColor clearColor];
        [self addSubview:_graphicView];
        if (self.actionButton) {
            [self bringSubviewToFront:_actionButton];
        }
    }
    return _graphicView;
}
-(UIButton *)icon{
    if (!_icon) {
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _icon.frame = CGRectMake(0, (_graphicView.bounds.size.height-self.imageW)/2.0, self.imageW, self.imageW);
        _icon.userInteractionEnabled = NO;
        [self.graphicView addSubview:_icon];
    }
    return _icon;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageW, 0, self.graphicViewWidth-self.imageW, self.graphicView.bounds.size.height)];
        _textLabel.textColor = [UIColor colorWithHex:0x33cfda];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.font = [UIFont systemFontOfSize:13.0];
        [self.graphicView addSubview:_textLabel];
    }
    return _textLabel;
}
-(UIButton *)actionButton{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.frame = self.bounds;
        _actionButton.backgroundColor = [UIColor clearColor];
        [_actionButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actionButton];
        [self bringSubviewToFront:_actionButton];
    }
    return _actionButton;
}

-(void)resetSubview{
    NSString *_tip;
    NSString *_imageName;
    if (_showActionButton) {
        _tip = @"返回头条首页";
        _imageName = @"homeIcon_tap";
    }else{
        _tip = @"下拉显示您关心的内容";
        _imageName = @"homeIcon_dropdown";
    }
    self.actionButton.hidden = !_showActionButton;
    self.textLabel.text = _tip;
    [self.icon setImage:[UIImage imageNamed:_imageName] forState:UIControlStateNormal];
    
    [self.graphicView bringSubviewToFront:self.actionButton];
}

-(void)action{
    _actionBlock();
}

@end
