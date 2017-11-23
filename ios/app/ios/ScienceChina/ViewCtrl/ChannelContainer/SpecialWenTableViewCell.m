//
//  SpecialWenTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/15.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialWenTableViewCell.h"

@interface SpecialWenTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UItitle;
@property (weak, nonatomic) IBOutlet UILabel *UIcontent;

@property (weak, nonatomic) IBOutlet UILabel *UIPushDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Topconstraint;

@end

@implementation SpecialWenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialWenTableViewCell";
}

+(SpecialWenTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SpecialWenTableViewCell" owner:nil options:nil][0];
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    
    [self.UItitle setText:sa.ni_title];
    [self.UIPushDate setText:sa.ni_publish_date_str];
    [self.UIcontent setText:sa.ni_desc];
    
    if(showSpace){
        self.Topconstraint.constant = 10;
    }else{
        self.Topconstraint.constant = 0;
    }
    
    [self layoutIfNeeded];
}

@end
