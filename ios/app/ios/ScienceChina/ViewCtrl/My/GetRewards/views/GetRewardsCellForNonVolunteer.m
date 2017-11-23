//
//  GetRewardsCellForNonVolunteer.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GetRewardsCellForNonVolunteer.h"

@implementation GetRewardsCellForNonVolunteer
{
    UIColor *_ableBackColor;
    UIColor *_unableBackColor;
    
    UIView *_contentview;
    UIImageView *_centerlineView;
    UIView *_leftView;
    
    UIImageView *_prizeImageView;
    
    UILabel  *_liuliangLabel;
    UILabel  *_centerIntegralLabel;
    UIButton *_receiveButton; //@"立即领取"
    
    UIView *_leftViewVolunteer;
    UILabel *_liuliangLabelVolunteer;
    
    PrizesInfoModel *_prizeModel;
}
+(NSString *)ID{
    return @"GetRewardsCellForNonVolunteer";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initDefaultData];
        [self setupView];
    }
    return self;
}
-(void)initDefaultData{
    _ableBackColor = [UIColor colorWithHex:0x63d8e1];
    _unableBackColor = [UIColor whiteColor];
    
}
-(void)setupView{
    UIColor *_backColor = RGBCOLOR(244, 244, 244);
    self.contentView.backgroundColor = _backColor;
    
    CGFloat _contentW = isIpad ? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    _contentW = _contentW-15*2;
    _contentview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, _contentW, 88)];
    _contentview.layer.cornerRadius = 10;
    
    CGFloat rightViewW = (MAIN_SCREEN_WIDTH == 320)?90.0:107.0;
    CGFloat leftViewW = 95;
    CGFloat _centerlineW = 7.5 ;

    _centerlineView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentview.frame.size.width-rightViewW-_centerlineW, 0, _centerlineW, _contentview.frame.size.height)];
    
    _prizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_centerlineView.frame.origin.x-8-63, _contentview.frame.size.height-50, 63, 50)];
    _prizeImageView.image = [UIImage imageNamed:@"jiangOnReward"];
     /*---------------------------*/
    //非科普员
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewW, _contentview.frame.size.height)];
    
    UIImageView *_iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(26.0, 14.0, 45.0, 47.0)];
    _iconImageView.image = [UIImage imageNamed:@"iconOnGetRewardsLiuLiang"];
    
    _liuliangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconImageView.frame.origin.y+_iconImageView.frame.size.height+3, leftViewW, 10)];
    _liuliangLabel.font = FONT_12;
    _liuliangLabel.text = @"";
    _liuliangLabel.textColor = [UIColor colorWithHex:0xf34754];
    _liuliangLabel.textAlignment = NSTextAlignmentCenter;
      /*---------------------------*/
    //科普员
    _leftViewVolunteer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewW, _contentview.frame.size.height)];
    
    UIImageView *_iconImageViewVolunteer = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, (_contentview.frame.size.height-66.0)/2.0, 70.0, 66.0)];
    _iconImageViewVolunteer.image = [UIImage imageNamed:@"prizeIconVolunteer"];
    
    _liuliangLabelVolunteer = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageViewVolunteer.frame.origin.x, 56.0, _iconImageViewVolunteer.frame.size.width, 13.5)];
    _liuliangLabelVolunteer.font = FONT_12;
    _liuliangLabelVolunteer.text = @"";
    _liuliangLabelVolunteer.textColor = [UIColor colorWithHex:0xf34754];
    _liuliangLabelVolunteer.textAlignment = NSTextAlignmentCenter;
    _liuliangLabelVolunteer.backgroundColor = [UIColor clearColor];
     /*---------------------------*/
    CGFloat _centerLabelW = (MAIN_SCREEN_WIDTH == 320)?91.0:130;
    UILabel *_centerLabel1  = [[UILabel alloc] initWithFrame:CGRectMake(_centerlineView.frame.origin.x-_centerLabelW, 19, _centerLabelW, 12)];
    _centerLabel1.font = FONT_12;
    _centerLabel1.text = @"需达到积分/月";
    _centerLabel1.textColor = [UIColor colorWithHex:0x777777];
    _centerLabel1.textAlignment = NSTextAlignmentLeft;
    
    _centerIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_centerLabel1.frame.origin.x, _centerLabel1.frame.origin.y+_centerLabel1.frame.size.height+15.0, _centerLabelW, 10)];
    _centerIntegralLabel.font = FONT_12;
    _centerIntegralLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat buttonW = 73.0;
    _receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _receiveButton.frame = CGRectMake(_centerlineView.frame.origin.x+_centerlineView.bounds.size.width+(rightViewW-buttonW)/2.0, (_contentview.bounds.size.height-25.0)/2.0, buttonW, 25.0);
    [_receiveButton setTitle:@"立即领取" forState:UIControlStateNormal];
    [_receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _receiveButton.titleLabel.font = FONT_12;
    _receiveButton.backgroundColor = [UIColor colorWithHex:0xf99e16];
    _receiveButton.layer.cornerRadius = _receiveButton.frame.size.height/2.0;
    [_receiveButton addTarget:self action:@selector(tapGet:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_contentview];
    
    [_leftView addSubview:_iconImageView];
    [_leftView addSubview:_liuliangLabel];
    
    [_leftViewVolunteer addSubview:_iconImageViewVolunteer];
    [_leftViewVolunteer addSubview:_liuliangLabelVolunteer];
    
    [_contentview addSubview:_centerlineView];
    [_contentview addSubview:_prizeImageView];
    
    [_contentview addSubview:_leftView];
    [_contentview addSubview:_leftViewVolunteer];
    
    [_contentview addSubview:_centerLabel1];
    [_contentview addSubview:_centerIntegralLabel];
    
    [_contentview addSubview:_receiveButton];
    
}
-(void)tapGet:(UIButton *)sender{
    if (self.delegate  && [self.delegate respondsToSelector:@selector(getRewardWithModel:)]) {
        [self.delegate getRewardWithModel:_prizeModel];
    }
}
-(void)setCellWithModel:(PrizesInfoModel *)model currentMonthScore:(NSString *)currentMonthScore isVolunteerData:(BOOL)isVolunteerData isVolunteerUser:(BOOL)isVolunteerUser{
    _prizeModel = model;
    NSString *integralNum = model.achieveScore;
    NSString *integralSufix = @"积分";
    NSString *integralText = [NSString stringWithFormat:@"%@%@",integralNum,integralSufix];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:integralText];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xf99e16] range:[integralText rangeOfString:integralNum]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x777777] range:[integralText rangeOfString:integralSufix]];
    
    _centerIntegralLabel.attributedText = attrStr;
    _liuliangLabel.text = [NSString stringWithFormat:@"%@流量包",model.prizeName];
    _liuliangLabelVolunteer.text = [NSString stringWithFormat:@"%@",model.prizeName];
    if (isVolunteerData) {
        _prizeImageView.hidden = NO;
        _leftViewVolunteer.hidden = NO;
        _leftView.hidden = YES;
    } else {
        _prizeImageView.hidden = YES;
        _leftViewVolunteer.hidden = YES;
        _leftView.hidden = NO;
    }
    
    //是否可领取
    BOOL isEnable;
    if (isVolunteerUser == isVolunteerData) {
        isEnable = !model.isReceived;
    }else{
        isEnable = NO;
    }
    
    if (isEnable) {
        
        if ([currentMonthScore integerValue] >= [model.achieveScore integerValue]) {
            _contentview.backgroundColor = _ableBackColor;
            _centerlineView.image = [UIImage imageNamed:@"ableLine"];
            
            _receiveButton.backgroundColor = [UIColor colorWithHex:0xf99e16];
            _receiveButton.enabled = YES;
            return;
        }
    }
    
    _contentview.backgroundColor = _unableBackColor;
    _centerlineView.image = [UIImage imageNamed:@"unableLine"];
    
    _receiveButton.backgroundColor = [UIColor colorWithHex:0x777777 alpha:0.5];
    _receiveButton.enabled = NO;
    
    
    
}
@end
