//
//  MusicCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/11/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MusicCollectionViewCell.h"

@interface MusicCollectionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *UIimageview;

@end

@implementation MusicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"MusicCollectionViewCell";
}

-(void)setCellWithHomeModel:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    [self.UIimageview sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    if(showSpace){
        _UITopConstraint.constant = 10;
    }else{
        _UITopConstraint.constant = 0;
    }
    
}
@end
