//
//  ActivityTextCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/13.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityTextCollectionCell.h"

@interface ActivityTextCollectionCell()


@property (weak, nonatomic) IBOutlet UILabel *uiLabelTypeTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewRec;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelVisitCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelPar;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelDate;
@property (weak, nonatomic) IBOutlet UIView *uiCenterLine;
@property (weak, nonatomic) IBOutlet UIButton *uiBtnPar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiTopSpace;

@end

@implementation ActivityTextCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"ActivityTextCollectionCell";
}

-(void)setCellWithScienceActivity:(ScienceActivity*)sa showSpace:(BOOL)showSpace{
    if (sa.isRec == 1) {
        self.uiImgViewRec.hidden = NO;
    }else{
        self.uiImgViewRec.hidden = YES;
    }
    
    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"] || [sa.av_type isEqualToString:@"03"]) {
        self.uiBtnPar.hidden = NO;
//        self.uiCenterLine.hidden = NO;
//        self.uiLabelDate.hidden = NO;
        [self.uiLabelPar setText:[NSString stringWithFormat:@"已参与%@人", sa.participators]];
        [self.uiLabelDate setText:sa.shelve_at];
    }else{
//        self.uiCenterLine.hidden = YES;
//        self.uiLabelDate.hidden = YES;
        self.uiBtnPar.hidden = YES;
        [self.uiLabelPar setText:sa.shelve_at];
    }
    
    self.uiLabelDate.hidden = NO;
    
    [self.uiLabelTypeTitle setText:sa.av_type_name];
    self.uiLabelTitle.attributedText = [LabelUtil getNSAttributedStringWithLabel:self.uiLabelTitle text:sa.title];
    [self.uiLabelVisitCount setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
    
    if (showSpace) {
        self.uiTopSpace.constant = 10;
    }else{
        self.uiTopSpace.constant = 0;
    }
    
    [self layoutIfNeeded];
}

@end
