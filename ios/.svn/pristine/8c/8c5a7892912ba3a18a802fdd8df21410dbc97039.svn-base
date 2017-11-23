//
//  ChannelCollectionCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/12/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChannelCollectionCell.h"

@implementation ChannelCollectionCell{
    UIImageView *_icon;
    UILabel *_titleLabel;
    
    CGFloat _titleMinH;
    CGFloat _titleMaxH;
}
+(NSString *)ID{
    return @"ChannelCollectionCell";
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return  self;
}
-(void)setupView{
    _titleMinH = 9.0;
    _titleMaxH = 30.0;
    CGFloat _iconW = 61.0;
    CGFloat _titleLeftSpace = 5.0;
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-_iconW)/2.0, 20, _iconW, _iconW)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLeftSpace, _icon.frame.origin.y+_icon.frame.size.height+7, self.frame.size.width-_titleLeftSpace*2, _titleMaxH)];
    _titleLabel.font = [UIFont systemFontOfSize:11.0];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
}
-(void)setcellModel:(GroupListDetailModel *)model{
    _icon.image = [UIImage imageNamed:model.image];
    _titleLabel.text = model.title;
    
    //CGSize titleSize = [_titleLabel boundingRectWithSize:CGSizeMake(_titleLabel.frame.size.width, 0)];
}
@end
