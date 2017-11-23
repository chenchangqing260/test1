//
//  CompanyTableViewCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "CompanyTableViewCell.h"

@interface CompanyTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *uiCompanyLab;

@end

@implementation CompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(CompanyTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"CompanyTableViewCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"CompanyTableViewCell";
}

-(void)setCellWithTypeModel:(SciencerCompany*)company{
    [self.uiCompanyLab setText:company.cp_name];
}

@end
