//
//  EStationPicCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationPicCell.h"

@interface EStationPicCell()

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView3;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCounLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiSpecifyLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTimeLabLeftSpace;

@end

@implementation EStationPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"EStationPicCell";
}

+(EStationPicCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationPicCell" owner:nil options:nil][0];
}

-(void)initCellData:(InfoObj*)info{
    [self.uiImageView1 sd_setImageWithURL:[NSURL URLWithString:info.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiImageView2 sd_setImageWithURL:[NSURL URLWithString:info.in_img_url_1] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiImageView3 sd_setImageWithURL:[NSURL URLWithString:info.in_img_url_2] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    self.uiTitleLab.text = info.in_title;
    self.uiTimeLab.text = info.in_publish_date_str;
    self.uiCommentCounLab.text = info.in_reviewCount;
    if ([info.in_is_stick intValue] == 0) {
        // 未置顶，判断是否热门
        if ([info.in_is_hot intValue] == 0) {
            // 不热门
            self.uiSpecifyLab.text = @"";
            self.conTimeLabLeftSpace.constant = 0;
        }else{
            self.uiSpecifyLab.text = @"热门";
            self.conTimeLabLeftSpace.constant = 5;
        }
    }else{
        // 置顶
        self.uiSpecifyLab.text = @"置顶";
        self.conTimeLabLeftSpace.constant = 5;
    }
}
@end
