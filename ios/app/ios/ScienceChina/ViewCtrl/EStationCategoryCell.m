//
//  EStationCategoryCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationCategoryCell.h"

@interface EStationCategoryCell()

@property (weak, nonatomic) IBOutlet UILabel *uiSelectNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiNormalNameLab;

@end

@implementation EStationCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.uiNormalView.hidden = YES;
        self.uiSelectView.hidden = NO;
    }else{
        self.uiNormalView.hidden = NO;
        self.uiSelectView.hidden = YES;
    }
}

+(NSString*)ID{
    return @"EStationCategoryCell";
}

+(EStationCategoryCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationCategoryCell" owner:nil options:nil][0];
}

-(void)initCellData:(EStationCategory*)station{
    self.uiNormalNameLab.text = self.uiSelectNameLab.text = station.st_name;
}

@end
