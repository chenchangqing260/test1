//
//  SpecialNoneCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialNoneCollectionCell.h"
#import "TextUtil.h"

@interface SpecialNoneCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSpecialSA;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelSpecialSA;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelNotStart;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelBeginning;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelEnding;

@end

@implementation SpecialNoneCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialNoneCollectionCell";
}

-(void)setCellDataWithSpecialActivity:(ScienceActivity*)spsa{
    [self.uiImgViewSpecialSA sd_setImageWithURL:[NSURL URLWithString:spsa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiLabelSpecialSA setText:spsa.title];
}
@end
