//
//  GetRewardsCellReceived.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GetRewardsCellReceived.h"

@implementation GetRewardsCellReceived
{
    UIView *_contentview;
    
    UILabel *_rewardNumLabel;  //最左——奖励数量
    UILabel *_rewardTitleLabel; //最左——奖励单位 RMB、M
    
    UILabel *_rightIntegralLabel;
    
}
+(NSString *)ID{
    return @"GetRewardsCellReceived";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initDefaultData];
        [self setupView];
    }
    return self;
}
-(void)initDefaultData{
    
}
-(void)setupView{
    UIColor *_backColor = RGBCOLOR(244, 244, 244);
    self.contentView.backgroundColor = _backColor;
    
    CGFloat _contentW = isIpad ? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    _contentW = _contentW-15*2;
    _contentview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, _contentW, 88)];
    _contentview.layer.cornerRadius = 10;
    _contentview.backgroundColor = [UIColor whiteColor];
    
    CGFloat rightViewW = (MAIN_SCREEN_WIDTH == 320)?90.0:107.0;
    CGFloat _centerlineW = 7.5 ;
    CGFloat _centerlineX = _contentview.frame.size.width-rightViewW-_centerlineW;
    UIImageView *_centerlineView = [[UIImageView alloc] initWithFrame:CGRectMake(_centerlineX, 0, _centerlineW, _contentview.frame.size.height)];
    _centerlineView.image = [UIImage imageNamed:@"unableLine"];
    
    CGFloat _centerLabelW = (MAIN_SCREEN_WIDTH == 320)?91.0:130;
    UILabel *_centerLabel1  = [[UILabel alloc] initWithFrame:CGRectMake(_centerlineView.frame.origin.x-_centerLabelW, 10, _centerLabelW, 12)];
    _centerLabel1.font = FONT_12;
    _centerLabel1.text = @"需达到积分/月";
    _centerLabel1.textColor = [UIColor colorWithHex:0x777777];
    _centerLabel1.textAlignment = NSTextAlignmentLeft;
    
    _rightIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_centerLabel1.frame.origin.x, _centerLabel1.frame.origin.y+_centerLabel1.frame.size.height+10, _centerLabelW, 13.0)];
    _rightIntegralLabel.font = FONT_12;
    _rightIntegralLabel.textAlignment = NSTextAlignmentLeft;
    
    
    UIImageView *jiang = [[UIImageView alloc] initWithFrame:CGRectMake(_centerlineView.frame.origin.x-8-63, _contentview.frame.size.height-50, 63, 50)];
    jiang.image = [UIImage imageNamed:@"jiangOnReward"];
    
    
    UIImageView *_leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 93, _contentview.frame.size.height-20)];
    _leftView.image = [UIImage imageNamed:@"已领流量或现金"];
    
    _rewardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.5, 4.0, 44.5, 23.5)];
    _rewardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.5, 28.5, 44.5, 14.5)];
    
    _rewardTitleLabel.text = @"流量";
    
    _rewardNumLabel.font  = FONT_14;
    _rewardTitleLabel.font  = FONT_12;
    
    _rewardNumLabel.textColor = [UIColor colorWithHex:0xf34754];
    _rewardTitleLabel.textColor = [UIColor colorWithHex:0xf34754];
    
    _rewardNumLabel.textAlignment = NSTextAlignmentCenter;
    _rewardTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _rewardNumLabel.backgroundColor = [UIColor clearColor];
    _rewardTitleLabel.backgroundColor = [UIColor clearColor];
        
    CGFloat buttonW = 73.0;
    UIButton *_receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _receiveButton.frame = CGRectMake(_centerlineView.frame.origin.x+_centerlineView.bounds.size.width+(rightViewW-buttonW)/2.0, (_contentview.bounds.size.height-25.0)/2.0, buttonW, 25.0);
    [_receiveButton setTitle:@"已领取" forState:UIControlStateNormal];
    [_receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _receiveButton.titleLabel.font = FONT_12;
    _receiveButton.backgroundColor = [UIColor colorWithHex:0xf99e16];
    _receiveButton.layer.cornerRadius = _receiveButton.frame.size.height/2.0;
    _receiveButton.backgroundColor = [UIColor colorWithHex:0x777777 alpha:0.5];
    _receiveButton.enabled = NO;
    
    
    [_leftView addSubview:_rewardNumLabel];
    [_leftView addSubview:_rewardTitleLabel];
    
    [self.contentView addSubview:_contentview];
    
    [_contentview addSubview:_centerlineView];
    
    [_contentview addSubview:_leftView];
    
    [_contentview addSubview:_centerLabel1];
    [_contentview addSubview:jiang];
    
    [_contentview addSubview:_rightIntegralLabel];
    [_contentview addSubview:_receiveButton];
    
}

-(void)setCellWithModel:(PrizesInfoModel *)model{
    
    NSString *integralNum = model.achieveScore;
    NSString *integralSufix = @"积分";
    NSString *integralText = [NSString stringWithFormat:@"%@%@",integralNum,integralSufix];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:integralText];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xf99e16] range:[integralText rangeOfString:integralNum]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x777777] range:[integralText rangeOfString:integralSufix]];
    
    _rightIntegralLabel.attributedText = attrStr;
    NSMutableString *prizeName = [NSMutableString stringWithFormat:@"%@",model.prizeName];
    _rewardNumLabel.text = [NSString stringWithFormat:@"%@",prizeName];
}
@end
