//
//  AccChannnelCollectionReusableView.m
//  ScienceChina
//
//  Created by xuanyj on 16/12/8.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "AccChannnelCollectionReusableView.h"

@implementation AccChannnelCollectionReusableView
{
    UILabel *_titleLabel;
}
+(NSString *)ID{
    return @"AccChannnelCollectionReusableView";
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return  self;
}
-(void)setupView{
    CGFloat _titleLeftSpace = 0;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLeftSpace, 20, self.frame.size.width-_titleLeftSpace*2, 13)];
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
}
-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}
@end
