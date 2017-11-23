//
//  SpecialActivityCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialActivityCollectionCell.h"

@interface SpecialActivityCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *uiLabelSATitle;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSA;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelVisitCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelParCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelDate;
@property (weak, nonatomic) IBOutlet UIView *uiViewDateLine;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSACanyu;

@end

@implementation SpecialActivityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialActivityCollectionCell";
}

-(void)setCellDataWithActivity:(ScienceActivity*)sa{
    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"] || [sa.av_type isEqualToString:@"03"]) {
        self.uiImgViewSACanyu.hidden = NO;
        self.uiViewDateLine.hidden = NO;
        self.uiLabelDate.hidden = NO;
        [self.uiLabelParCount setText:[NSString stringWithFormat:@"已参与%@人", sa.participators]];
        [self.uiLabelDate setText:sa.shelve_at];
    }else{
        self.uiImgViewSACanyu.hidden = YES;
        self.uiViewDateLine.hidden = YES;
        self.uiLabelDate.hidden = YES;
        [self.uiLabelParCount setText:sa.shelve_at];
    }
    
    self.uiLabelDate.hidden = NO;
    NSLog(@"%@",sa.av_title);
    NSLog(@"%@",sa.image_url);
    if (sa.image_name && ![sa.image_name isEmptyOrWhitespace]) {
        [self.uiImgViewSA sd_setImageWithURL:[NSURL URLWithString:sa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [self.uiImgViewSA sd_setImageWithURL:[NSURL URLWithString:sa.image_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    [self.uiLabelSATitle setText:sa.title];
    [self.uiLabelVisitCount setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
}
@end
