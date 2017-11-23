//
//  MyCollectionViewCell.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell{
    UIImageView *_icon;
    UILabel *_titleLabel;
    CGFloat _titleH;
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

    CGFloat _iconW = 23.0;
    _titleH = 15.0;
    CGFloat _spaceBettweenImageAndTitle = 10.0;
    CGFloat _iconY = (self.frame.size.height-(_iconW +_titleH + _spaceBettweenImageAndTitle))/2.0;
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-_iconW)/2.0, _iconY, _iconW, _iconW)];
    _icon.contentMode =  UIViewContentModeScaleAspectFit;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _icon.frame.origin.y+_icon.frame.size.height+_spaceBettweenImageAndTitle, self.frame.size.width, _titleH)];
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    UILabel *rightLine   = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    rightLine.backgroundColor = RGBCOLOR(242.0, 242.0, 242.0);
    bottomLine.backgroundColor = rightLine.backgroundColor ;
    
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:rightLine];
    [self.contentView addSubview:bottomLine];
}
-(void)setCellWithTitle:(NSString *)title image:(NSString *)imageName fontsize:(NSString *)fontsize{
    if (title) {
        if ([fontsize isEqualToString:@"Small"]){
            _titleLabel.font = [UIFont systemFontOfSize:12.0];
        }else if([fontsize isEqualToString:@"Large"]){
            _titleLabel.font = [UIFont systemFontOfSize:16.0];
        }else{
            _titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
        
        _titleLabel.text = title;
        CGSize text = [_titleLabel boundingRectWithSize:CGSizeMake(_titleLabel.frame.size.width, 0)];
        if (text.height > _titleH) {
            _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, text.height);
        }
        
    }
    if (imageName) {
        _icon.image = [UIImage imageNamed:imageName];
    }
}
@end
