//
//  EStationPicTextCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationPicTextCell.h"

@interface EStationPicTextCell()

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiSpecifyLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIView *uiLayerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTimeLabLeftSpace;

@end

@implementation EStationPicTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"EStationPicTextCell";
}

+(EStationPicTextCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationPicTextCell" owner:nil options:nil][0];
}

-(void)initCellData:(InfoObj*)info isMovie:(BOOL)isMovie{
    if (isMovie) {
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:info.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        self.uiLayerView.hidden = NO;
    }else{
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:info.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        self.uiLayerView.hidden = YES;
    }
    self.uiTitleLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:self.uiTitleLab lineSpace:5 text:info.in_title];
    self.uiTimeLab.text = info.in_publish_date_str;
    self.uiCommentCountLab.text = info.in_reviewCount;
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
