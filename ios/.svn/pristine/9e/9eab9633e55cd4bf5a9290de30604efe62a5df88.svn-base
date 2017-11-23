//
//  LeftListCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/1.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "LeftListCell.h"

@implementation LeftListCell
{
    UIImageView *_icon;
    UILabel *_titleLabel;
    UILabel *_line;
    CGFloat _leftViewWidth;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _leftViewWidth = MAIN_SCREEN_WIDTH-315.0/750.0*MAIN_SCREEN_WIDTH;
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(147.0/750.0*MAIN_SCREEN_WIDTH, 15, 18, 18)];
    
    CGFloat _titleX = _icon.frame.origin.x+_icon.frame.size.width+15;
    CGFloat _titleW = _leftViewWidth-_titleX;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleX, 0, _titleW, LeftListCellHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    _line = [[UILabel alloc] initWithFrame:CGRectMake(15, LeftListCellHeight-0.5, _leftViewWidth-15*2, 0.5)];
    _line.backgroundColor = RGBCOLOR(38, 52, 67);
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_line];
}
-(void)setCellWithTitle:(NSString *)title imageName:(NSString *)imagename lineHidden:(BOOL)lineHidden{
    _icon.image = [UIImage imageNamed:imagename];
    _titleLabel.text = title;
    _line.hidden = lineHidden;
}

@end
