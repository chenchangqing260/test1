//
//  PieColorCollectionCell.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PieColorCollectionCell.h"

@implementation PieColorCollectionCell
{
    UILabel *_colorView;
    UILabel *_titleLabel;
}

+(NSString *)ID{
    return @"MyCollectionViewCell";
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return  self;
}
-(void)setupView{
    
    CGFloat spaceBetweenColorAndTitle = 6.0;
    CGFloat colorW = 15.0;
    CGFloat colorH = 13.0;
    CGFloat titleW = self.bounds.size.width-colorW-spaceBetweenColorAndTitle;
    
    _colorView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, colorW, colorH)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_colorView.frame.origin.x+_colorView.frame.size.width+spaceBetweenColorAndTitle, _colorView.frame.origin.y, titleW, colorH)];
    
    _titleLabel.font = FONT_12;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 0;
    
    
    
    [self.contentView addSubview:_colorView];
    [self.contentView addSubview:_titleLabel];
}

-(void)setCellWithColor:(UIColor *)color data:(OneMonthIntegralModel *)model{
    
    NSString *integralText = [NSString stringWithFormat:@"%@ 占比:%@",model.itemTitle,model.item_per];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:integralText];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x000000] range:[integralText rangeOfString:model.itemTitle]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x777777] range:[integralText rangeOfString:model.item_per]];
    
    _titleLabel.attributedText = attrStr;
    
    //_titleLabel.text = [NSString stringWithFormat:@"%@ 占比:%@",model.itemTitle,model.item_per];
    _colorView.backgroundColor = color;
    
    CGSize textSize = [_titleLabel boundingRectWithSize:CGSizeMake(_titleLabel.frame.size.width, 0) lineSpace:0];
    if (textSize.height > _titleLabel.frame.size.height) {
        CGRect titleRect = _titleLabel.frame;
        titleRect.size.height = textSize.height;
        _titleLabel.frame = titleRect;
    }
}
@end
