//
//  ChuanBoTableCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ChuanBoTableCell.h"
#import "SummaryData.h"

@interface ChuanBoTableCell()

@property (weak, nonatomic) IBOutlet UIView *uiTitleView;
@property (weak, nonatomic) IBOutlet UIView *uiDataView;
@property (weak, nonatomic) IBOutlet UIView *uiMoreView;
@property (weak, nonatomic) IBOutlet UILabel *uiNomarlIdxLab;
@property (weak, nonatomic) IBOutlet UILabel *uiHightIdxLab;
@property (weak, nonatomic) IBOutlet UILabel *uiHightCityLab;
@property (weak, nonatomic) IBOutlet UILabel *uiNomarlCityLab;
@property (weak, nonatomic) IBOutlet UILabel *uiACountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiJCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;

@end

@implementation ChuanBoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(ChuanBoTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"ChuanBoTableCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"ChuanBoTableCell";
}

-(void)setCellWithSummaryData:(SummaryData*)summaryData  titleContent:(NSString*)titleContent index:(NSInteger)idx showMore:(BOOL)showMore{
    if (idx == 0) {
        // 标题
        self.uiTitleView.hidden = NO;
        self.uiDataView.hidden = YES;
        self.uiMoreView.hidden = YES;
        self.uiTitleLab.text = titleContent;
    }else if(idx == 11 && showMore){
        self.uiTitleView.hidden = YES;
        self.uiDataView.hidden = YES;
        self.uiMoreView.hidden = NO;
    }else{
        self.uiTitleView.hidden = YES;
        self.uiDataView.hidden = NO;
        self.uiMoreView.hidden = YES;
        
        if (idx == 1 || idx == 2 || idx == 3) {
            self.uiNomarlIdxLab.hidden = YES;
            self.uiHightIdxLab.hidden = NO;
            self.uiNomarlCityLab.hidden = YES;
            self.uiHightCityLab.hidden = NO;
            [self.uiHightIdxLab setText:[NSString stringWithFormat:@"%ld", (long)idx]];
            [self.uiHightCityLab setText:summaryData.region_name];
            [self.uiACountLab setText:[NSString stringWithFormat:@"%@ 篇",summaryData.article_share_count]];
            [self.uiJCountLab setText:[NSString stringWithFormat:@"%@ 个",summaryData.org_share_count]];
        }else{
            self.uiNomarlIdxLab.hidden = NO;
            self.uiHightIdxLab.hidden = YES;
            self.uiNomarlCityLab.hidden = NO;
            self.uiHightCityLab.hidden = YES;
            [self.uiNomarlIdxLab setText:[NSString stringWithFormat:@"%ld", (long)idx]];
            [self.uiNomarlCityLab setText:summaryData.region_name];
            [self.uiACountLab setText:[NSString stringWithFormat:@"%@ 篇",summaryData.article_share_count]];
            [self.uiJCountLab setText:[NSString stringWithFormat:@"%@ 个",summaryData.org_share_count]];
        }
    }
}
@end
