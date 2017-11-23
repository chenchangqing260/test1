//
//  WenCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "WenCollectionViewCell.h"

@interface WenCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UItitle;
@property (weak, nonatomic) IBOutlet UILabel *UIpinNum;
@property (weak, nonatomic) IBOutlet UILabel *UIcontent;

@property (weak, nonatomic) IBOutlet UILabel *UIPushDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Topconstraint;

@end

@implementation WenCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"WenCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace   hmType:(NSString*)hmtype{
    
    if([hmtype isEqualToString:@"0"]){
        [self.UItitle setText:sa.ni_title];
        [self.UIPushDate setText:sa.ni_publish_date_str];
        [self.UIpinNum setText:sa.ni_reviewCount];
        [self.UIcontent setText:sa.ni_desc];
    }else{
        [self.UItitle setText:sa.in_title];
        [self.UIPushDate setText:sa.in_publish_date_str];
        [self.UIpinNum setText:sa.in_reviewCount];
        [self.UIcontent setText:sa.in_desc];
    }
    
    if(showSpace){
        self.Topconstraint.constant = 10;
    }else{
        self.Topconstraint.constant = 0;
    }
    
    [self layoutIfNeeded];
}

@end
