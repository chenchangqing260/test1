//
//  IntegrationSummaryCell.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "IntegrationSummaryCell.h"

@implementation IntegrationSummaryCell{
    UIImageView *_icon;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UILabel *_timeLabel;
    UILabel *_integralLabel;
}
+(NSString *)ID{
    return @"IntegrationSummaryCell";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    
    CGFloat _contentWidth = isIpad? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    CGFloat _horizontalSpaceBetweenLabels = 10;
    CGFloat _labelH = 14;
    
    CGFloat _left = 15.0;
    CGFloat _iconW = 26;
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(_left, (IntegrationSummaryCellHeight-_iconW)/2.0, _iconW, _iconW)];
    _icon.contentMode =  UIViewContentModeScaleAspectFit;
    
    CGFloat _timeW = 120;
    CGFloat _timeX = _contentWidth-_left-_timeW;
    CGFloat _timeY = 11;
    
    CGFloat _integralLabelW = 60;
    CGFloat _integralX = _contentWidth-_left-_integralLabelW;
    
    CGFloat _titleX = _icon.frame.origin.x + _icon.frame.size.width + 15.0;
    CGFloat _titleW = _timeX-_titleX-_horizontalSpaceBetweenLabels;
    CGFloat _subTitleW = _integralX-_titleX-_horizontalSpaceBetweenLabels;
    
    CGFloat _titleY = 14.0;
    _titleLabel    = [[UILabel alloc] initWithFrame:CGRectMake(_titleX, _titleY, _titleW, _labelH)];
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleX, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+7, _subTitleW, _labelH)];
    
    _timeLabel     = [[UILabel alloc] initWithFrame:CGRectMake(_timeX, _timeY, _timeW, 15)];
    _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_integralX, _timeLabel.frame.origin.y+_timeLabel.frame.size.height, _integralLabelW, 30)];
    
    _titleLabel.font    = FONT_15;
    _subTitleLabel.font = FONT_12;
    _timeLabel.font     = FONT_9;
    _integralLabel.font = FONT_20;
    
    _titleLabel.textColor    = [UIColor blackColor];
    _subTitleLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
    _timeLabel.textColor     = [UIColor colorWithHex:0xa0a0a0];
    _integralLabel.textColor = [UIColor colorWithHex:0xeb6100];
    
    _timeLabel.textAlignment     = NSTextAlignmentRight;
    _integralLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_subTitleLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_integralLabel];
    
}
-(void)setCellWithModel:(ScoreModel *)model{
    _titleLabel.text    = model.type_info;
    _subTitleLabel.text = model.info;
    _timeLabel.text     = model.create_time;
    _integralLabel.text = [NSString stringWithFormat:@"+%@",model.score_add];
    _icon.image = [UIImage imageNamed:model.scoreImageName];
    
}
@end
