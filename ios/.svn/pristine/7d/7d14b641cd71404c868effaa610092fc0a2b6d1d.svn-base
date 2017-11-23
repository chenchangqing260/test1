//
//  AddChannelCollectionCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/12/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "AddChannelCollectionCell.h"

@implementation AddChannelCollectionCell
{
    UIImageView *_icon;
    UILabel *_titleLabel;
    UIButton *_actionButton;
    
    CGFloat _titleMinH;
    CGFloat _titleMaxH;
    GroupListDetailModel *_model;
}
+(NSString *)ID{
    return @"AddChannelCollectionCell";
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
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
    
    CGFloat _btnW = 38.0;
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.frame = CGRectMake((self.frame.size.width-_btnW)/2.0, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+7, _btnW, 19.0);
    [_actionButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_actionButton];
}
-(void)setcellModel:(GroupListDetailModel *)model{
    _model = model;
    _icon.image = [UIImage imageNamed:model.image];
    _titleLabel.text = model.title;
    if (model.isattention) {
        [_actionButton setImage:[UIImage imageNamed:@"addchannel_duihao"] forState:UIControlStateNormal];
    } else {
        [_actionButton setImage:[UIImage imageNamed:@"addchannel_add"] forState:UIControlStateNormal];
    }
    
    //CGSize titleSize = [_titleLabel boundingRectWithSize:CGSizeMake(_titleLabel.frame.size.width, 0)];
}
-(void)action{
    _actionButton.selected = !_model.isattention;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectIndex:isattention:)]) {
        [self.delegate didSelectIndex:self.indexPath isattention:!_model.isattention];
    }
}
@end
