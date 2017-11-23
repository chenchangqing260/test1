//
//  ChannelCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/24.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ChannelCollectionViewCell.h"

@interface ChannelCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UILabel *UITitle;

@end

@implementation ChannelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ChannelCollectionViewCell" owner:self options:nil].lastObject;
    }
    return self;
}

+(NSString *)ID{
    return @"ChannelCollectionViewCell";
}


-(void)setcellModel:(GroupListDetailModel *)model{
    _UIImage.image = [UIImage imageNamed:model.image];
    self.UITitle.text = model.title;}

@end
