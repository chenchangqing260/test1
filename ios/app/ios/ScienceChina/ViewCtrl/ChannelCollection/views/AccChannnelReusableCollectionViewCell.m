//
//  AccChannnelReusableCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/15.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "AccChannnelReusableCollectionViewCell.h"

@interface AccChannnelReusableCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation AccChannnelReusableCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"AccChannnelReusableCollectionViewCell" owner:self options:nil].lastObject;
    }
    return self;
}

+(NSString *)ID{
    return @"AccChannnelReusableCollectionViewCell";
}


-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

@end
