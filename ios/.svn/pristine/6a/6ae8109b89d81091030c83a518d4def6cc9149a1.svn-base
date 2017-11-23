//
//  LatestAndHotAcitivityCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "LatestAndHotAcitivityCollectionCell.h"

@interface LatestAndHotAcitivityCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiTypeTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiVisitCount3;
@property (weak, nonatomic) IBOutlet UILabel *uiParCount3;
@property (weak, nonatomic) IBOutlet UILabel *uiDate3;
@property (weak, nonatomic) IBOutlet UIView *uiView3;
@property (weak, nonatomic) IBOutlet UILabel *uiVisitCount2;
@property (weak, nonatomic) IBOutlet UILabel *uiDate2;
@property (weak, nonatomic) IBOutlet UIView *uiView2;

@end

@implementation LatestAndHotAcitivityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"LatestAndHotAcitivityCollectionCell";
}

-(void)setCellWithScienceActivity:(ScienceActivity*)sa{
    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"] || [sa.av_type isEqualToString:@"03"]) {
        // 有参与人数
        self.uiView2.hidden = YES;
        self.uiView3.hidden = NO;
        
        [self.uiVisitCount3 setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
        [self.uiParCount3 setText:[NSString stringWithFormat:@"已参与%@人", sa.participators]];
        [self.uiDate3 setText:sa.shelve_at];
    }else{
        self.uiView2.hidden = NO;
        self.uiView3.hidden = YES;
        
        [self.uiVisitCount2 setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
        [self.uiDate2 setText:sa.shelve_at];

    }
    
    if (sa.image_name && ![sa.image_name isEmptyOrWhitespace]) {
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:sa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:sa.image_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    
    [self.uiTypeTitle setText:sa.av_type_name];
    [self.uiTitle setText:sa.title];
    
}

@end
