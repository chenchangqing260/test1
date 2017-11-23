//
//  RecordTableViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/13.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "RecordTableViewCell.h"


@interface RecordTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeY;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

@end
@implementation RecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"RecordTableViewCell";
}

+(RecordTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil][0];
}
-(void)setCellWithModel:(HomeModel*)model lastModel:(HomeModel*)lastModel{
    self.uiTitleLab.text = model.in_title;
    self.dateLabel.text = [NSString stringWithFormat:@"      %@",model.bh_date];
    self.timeLabel.text = model.bh_time;//@"13:14";
    
    self.dateLabelHeight.constant = 20;
    self.timeY.constant = 40;
    if (lastModel) {
        if ([model.bh_date isEqualToString:lastModel.bh_date]) {
            self.dateLabelHeight.constant = 0;
            self.timeY.constant = -8;
        }
    }
    
    CGSize contentSize = [self.uiTitleLab boundingRectWithSize:CGSizeMake(self.uiTitleLab.frame.size.width, 0)];
    if (contentSize.height > 21) {
        self.contentLabelHeight.constant = 40;
    }else{
        self.contentLabelHeight.constant = 20;
    }
}
@end
