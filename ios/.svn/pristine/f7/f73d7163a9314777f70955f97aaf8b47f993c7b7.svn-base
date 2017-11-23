//
//  EStationTextCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationTextCell.h"

@interface EStationTextCell()
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiSpecifyLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTimeLabLeftSpace;

@end

@implementation EStationTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"EStationTextCell";
}

+(EStationTextCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationTextCell" owner:nil options:nil][0];
}

-(void)initCellData:(InfoObj*)info{
    NSString *_content = @"";
    if (info.in_desc) {
        _content = info.in_desc;
    }
    self.uiTitleLab.text = info.in_title;
    self.uiDescLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:self.uiDescLab lineSpace:3 text:_content];
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
