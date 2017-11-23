//
//  GroupRightListCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GroupRightListCell.h"

@implementation GroupRightListCell
{
    UIImageView *_icon;
    UILabel *_titleLabel;
    UIButton *_attentionButton;
    UIColor *_blueColor;
    
    
    GroupListModel *_mainmodel;
    GroupListDetailModel *_submodel;
    NSInteger _leftSelectIndex;
    NSInteger _rightSelectIndex;
}
+(NSString*)ID{
    return @"GroupRightListCell";
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupview];
    }
    return self;
}
-(void)setupview{
    _blueColor = RGBCOLOR(103,204, 216);
    CGFloat _leftEdge = 10;
    CGFloat cellWidth = MAIN_SCREEN_WIDTH_SHOW-LeftTableWidth;
    if (isIpad) {
        cellWidth = MAIN_SCREEN_WIDTH_ONIpad-LeftTableWidth;
    } else {
        cellWidth = MAIN_SCREEN_WIDTH-LeftTableWidth;
    }
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//    _icon.layer.cornerRadius = _icon.frame.size.width/2.0;
//    _icon.clipsToBounds = YES;
    
    CGFloat buttonW = 45.0;
    CGFloat buttonH = 25.0;
    CGFloat buttonX = cellWidth-_leftEdge-buttonW;
    _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentionButton.frame = CGRectMake(buttonX, (GroupListCellHeight-buttonH)/2.0, buttonW, buttonH);
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionButton setTitleColor:_blueColor forState:UIControlStateNormal];
    [_attentionButton addTarget:self action:@selector(tapAttention:) forControlEvents:UIControlEventTouchUpInside];
    _attentionButton.layer.cornerRadius = 2.0;
    _attentionButton.layer.borderColor = [UIColor colorWithHex:0x33CFDA].CGColor;
    _attentionButton.layer.borderWidth = 0.5;
    
    CGFloat titleX = _icon.frame.origin.x + _icon.frame.size.width +10.0;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, buttonX-titleX-10, GroupListCellHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    _titleLabel.textColor = RGBCOLOR(76,76,76);
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_leftEdge, GroupListCellHeight-0.5, cellWidth-_leftEdge, 0.5)];
    line.backgroundColor = RGBCOLOR(238,238,238);
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_attentionButton];
    [self.contentView addSubview:line];
}
-(void)tapAttention:(UIButton *)sender{
    sender.selected = !sender.selected;
//    if (sender.selected) {
//        [sender setTitle:@"已关注" forState:UIControlStateNormal];
//        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        sender.backgroundColor = _blueColor;
//    } else {
//        [sender setTitle:@"关注" forState:UIControlStateNormal];
//        [sender setTitleColor:_blueColor forState:UIControlStateNormal];
//        sender.backgroundColor = [UIColor whiteColor];
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveDataWithMainMdel:subMdel:leftSelectedIndex: rightSelectedIndex: isAttention:)]) {
        [self.delegate saveDataWithMainMdel:_mainmodel subMdel:_submodel leftSelectedIndex:_leftSelectIndex rightSelectedIndex:_rightSelectIndex isAttention:sender.selected];
    }
}
-(void)setcellWithModel:(GroupListDetailModel *)model{
    _icon.image = [UIImage imageNamed:model.image];
    _titleLabel.text = model.title;
    _attentionButton.selected = model.isattention;
}
-(void)setcellWithMainMdel:(GroupListModel *)mainmodel subMdel:(GroupListDetailModel *)submodel leftSelectedIndex:(NSInteger)leftindex rightSelectedIndex:(NSInteger)rightindex{
    _mainmodel = mainmodel;
    _submodel = submodel;
    _leftSelectIndex = leftindex;
    _rightSelectIndex = rightindex;
    
    _icon.image = [UIImage imageNamed:submodel.image];
    _titleLabel.text = submodel.title;
    //_attentionButton.selected = submodel.isattention;
    
    if (submodel.isattention) {
        [_attentionButton setTitle:@"已关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attentionButton.backgroundColor = _blueColor;
    } else {
        [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:_blueColor forState:UIControlStateNormal];
        _attentionButton.backgroundColor = [UIColor whiteColor];
    }

}

@end
