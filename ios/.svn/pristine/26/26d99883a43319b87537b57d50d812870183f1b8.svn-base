//
//  SpecialPicAndWenCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/31.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialPicAndWenCollectionViewCell.h"
#import "TextUtil.h"

@interface SpecialPicAndWenCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *UIImgView;
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;

@end

@implementation SpecialPicAndWenCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialPicAndWenCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa  hmType:(NSString*)hmtype{
    
    if([hmtype isEqualToString:@"0"]){
        [self.UITitle setText:sa.ni_title];
        [self.UIDate setText:sa.ni_publish_date_str];
        [self.UIImgView sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        
        
    }else{
        [self.UITitle setText:sa.in_title];
        [self.UIDate setText:sa.in_publish_date_str];
        [self.UIImgView sd_setImageWithURL:[NSURL URLWithString:sa.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    
    [self layoutIfNeeded];
}



@end
