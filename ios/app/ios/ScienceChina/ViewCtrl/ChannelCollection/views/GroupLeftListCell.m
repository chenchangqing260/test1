//
//  GroupLeftListCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GroupLeftListCell.h"

@implementation GroupLeftListCell
{
    UILabel *_titleLabel;
}
+(NSString*)ID{
    return @"GroupLeftListCell";
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupview];
    }
    return self;
}
-(void)setupview{
    
    UIColor *backcolor = RGBCOLOR(245, 245, 245);
    self.contentView.backgroundColor = backcolor;
    
    CGFloat lineW = 3;
    
    UIView *selectBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftTableWidth, GroupListCellHeight)];
    selectBackView.backgroundColor = [UIColor whiteColor];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lineW, GroupListCellHeight)];
    [selectBackView addSubview:line];
    line.backgroundColor = RGBCOLOR(103,204, 216);
    [selectBackView addSubview:line];
    
    self.selectedBackgroundView = selectBackView;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineW, 0, selectBackView.frame.size.width-lineW, GroupListCellHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:17.0];
    _titleLabel.textColor = line.backgroundColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];    
}

-(void)setcellWithModel:(GroupListModel *)model{
    _titleLabel.text = model.title;
}
@end
