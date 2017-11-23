//
//  GetRewardsCellForVolunteer.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GetRewardsCellForVolunteer.h"

@implementation GetRewardsCellForVolunteer
{
    UIColor *_ableBackColor;
    UIColor *_unableBackColor;
    
    UIView *_contentview;
    UIImageView *_centerlineView;
    
    UIButton *_selectButton_RMB;
    UIButton *_selectButton_M;
    
    UILabel *_rewardNumLabel_RMB;  //最左——奖励数量
    UILabel *_rewardUnitLabel_RMB; //最左——奖励单位 RMB、M
    UILabel *_rewardTitleLabel_RMB;//最左——奖励名称 现金券、流量包
    UIImageView *_selectImage_RMB;
    
    UILabel *_rewardNumLabel_M;  //最左——奖励数量
    UILabel *_rewardUnitLabel_M; //最左——奖励单位 RMB、M
    UILabel *_rewardTitleLabel_M;//最左——奖励名称 现金券、流量包
    UIImageView *_selectImage_M;
    
    UILabel *_rightIntegralLabel;
    UIButton *_receiveButton; //@"立即领取"
    
}
+(NSString *)ID{
    return @"GetRewardsCellForVolunteer";
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
    _contentW = _contentW-16*2;
    _contentview = [[UIView alloc] initWithFrame:CGRectMake(16, 0, _contentW, 88)];
    _contentview.layer.cornerRadius = 10;
    
    _centerlineView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentview.frame.size.width-107-7.5, 0, 7.5, _contentview.frame.size.height)];
    
    CGFloat _centerLabelW = 91.0;
    UILabel *_centerLabel1  = [[UILabel alloc] initWithFrame:CGRectMake(_centerlineView.frame.origin.x-_centerLabelW, 10, _centerLabelW, 12)];
    UILabel *_centerLabel2  = [[UILabel alloc] initWithFrame:CGRectMake(_centerLabel1.frame.origin.x, _centerLabel1.frame.origin.y+_centerLabel1.frame.size.height+3, _centerLabelW, 13)];
    
    _centerLabel1.font = FONT_12;
    _centerLabel2.font = FONT_12;
    
    _centerLabel1.text = @"需达到积分/月";
    _centerLabel2.text = @"奖励2选1";
    
    _centerLabel1.textColor = [UIColor colorWithHex:0x777777];
    _centerLabel2.textColor = [UIColor colorWithHex:0xf34754];
    
    _centerLabel1.textAlignment = NSTextAlignmentLeft;
    _centerLabel2.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *jiang = [[UIImageView alloc] initWithFrame:CGRectMake(_centerLabel1.frame.origin.x, _contentview.frame.size.height-50, 63, 50)];
    jiang.image = [UIImage imageNamed:@"jiangOnReward"];
    
    [_contentview addSubview:_centerLabel1];
    [_contentview addSubview:_centerLabel2];
    [_contentview addSubview:jiang];
    
    UIColor *_RMBColor = [UIColor colorWithHex:0xfff200]; //人民币的色值
    UIColor *_MColor = [UIColor whiteColor];   //流量的色值

    CGFloat _contentLeft = 12;
    CGFloat _leftButtonW = 104;
    CGFloat _leftButtonH = 35;
    for (int i=0; i<2; i++) {
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(_contentLeft, 7+(_leftButtonH+6)*i, _leftButtonW, _leftButtonH);
        selectButton.backgroundColor = [UIColor colorWithHex:0xf34754];
        selectButton.layer.cornerRadius = 5;
        
        UIImageView *_selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectButton.bounds.size.width-24.0, 0, 24, selectButton.bounds.size.height)];
        _selectImage.image = [UIImage imageNamed:@"unSelectOnGetIntegral"];
        
        CGFloat _rightTitleW = 40;
        
        UILabel *_rewardUnitLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_selectImage.frame.origin.x-_rightTitleW, 8, _rightTitleW, 7)];
        UILabel *_rewardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_rewardUnitLabel.frame.origin.x, _rewardUnitLabel.frame.origin.y+_rewardUnitLabel.frame.size.height+3, _rightTitleW, 12)];
        UILabel *_rewardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _rewardUnitLabel.frame.origin.x, selectButton.frame.size.height)];
        
        _rewardNumLabel.font   = FONT_19;
        _rewardUnitLabel.font  = FONT_8;
        _rewardTitleLabel.font = FONT_12;
        
        _rewardTitleLabel.textColor = [UIColor whiteColor];
        
        _rewardNumLabel.textAlignment = NSTextAlignmentCenter;
        _rewardUnitLabel.textAlignment = NSTextAlignmentLeft;
        _rewardTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        [selectButton addSubview:_selectImage];
        [selectButton addSubview:_rewardNumLabel];
        [selectButton addSubview:_rewardUnitLabel];
        [selectButton addSubview:_rewardTitleLabel];
        
        [_contentview addSubview:selectButton];
        
        [selectButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0) {
            
            _rewardTitleLabel.text = @"现金券";
            _rewardUnitLabel.text  = @"RMB";
            
            _rewardNumLabel.textColor = _RMBColor;
            _rewardUnitLabel.textColor = _RMBColor;
            
            _selectImage_RMB = _selectImage;
            _rewardNumLabel_RMB = _rewardNumLabel;
            _rewardUnitLabel_RMB = _rewardUnitLabel;
            _selectButton_RMB = selectButton;
        }
        else if (i == 1){
            
            _rewardTitleLabel.text = @"流量包";
            _rewardUnitLabel.text  = @"M";
            
            _rewardNumLabel.textColor = _MColor;
            _rewardUnitLabel.textColor = _MColor;
            
            _selectImage_M = _selectImage;
            _rewardNumLabel_M = _rewardNumLabel;
            _rewardUnitLabel_M = _rewardUnitLabel;
            _selectButton_M = selectButton;
        }
    }
    
    CGFloat rightViewW = 73.0;
    CGFloat right = 15.0;
    _rightIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_contentview.bounds.size.width-right-rightViewW, 22.0, rightViewW, 13.0)];
    _rightIntegralLabel.font = FONT_12;
    _rightIntegralLabel.textAlignment = NSTextAlignmentCenter;
    
    _receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _receiveButton.frame = CGRectMake(_contentview.bounds.size.width-right-rightViewW, _rightIntegralLabel.frame.origin.y+_rightIntegralLabel.frame.size.height+14.0, rightViewW, 25.0);
    [_receiveButton setTitle:@"立即领取" forState:UIControlStateNormal];
    [_receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _receiveButton.titleLabel.font = FONT_12;
    _receiveButton.backgroundColor = [UIColor colorWithHex:0xf99e16];
    _receiveButton.layer.cornerRadius = _receiveButton.frame.size.height/2.0;
    
    [_contentview addSubview:_rightIntegralLabel];
    [_contentview addSubview:_receiveButton];
    
    [self.contentView addSubview:_contentview];
    [_contentview addSubview:_centerlineView];
    
}
-(void)selectItem:(UIButton *)sender{
    if (sender == _selectButton_RMB) {
        _selectImage_RMB.image = [UIImage imageNamed:@"selectOnGetIntegral"];
    } else {
        _selectImage_M.image = [UIImage imageNamed:@"selectOnGetIntegral"];
    }
}
-(void)setCellWithModel:(PrizesInfoModel *)model{
    
    NSString *integralNum = model.achieveScore;
    NSString *integralSufix = @"积分";
    NSString *integralText = [NSString stringWithFormat:@"%@%@",integralNum,integralSufix];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:integralText];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xf99e16] range:[integralText rangeOfString:integralNum]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x777777] range:[integralText rangeOfString:integralSufix]];
    
    _rightIntegralLabel.attributedText = attrStr;
    _rewardNumLabel_RMB.text = @"100";
    _rewardNumLabel_M.text   = @"200";
    
    if (model.isReceived) {
        _contentview.backgroundColor = _ableBackColor;
        _centerlineView.image = [UIImage imageNamed:@"ableLine"];
        
        _receiveButton.backgroundColor = [UIColor colorWithHex:0xf99e16];
        _receiveButton.enabled = YES;
    }
    else {
        _contentview.backgroundColor = _unableBackColor;
        _centerlineView.image = [UIImage imageNamed:@"unableLine"];
        
        _receiveButton.backgroundColor = [UIColor colorWithHex:0x777777 alpha:0.5];
        _receiveButton.enabled = NO;
    }
    
}
@end
