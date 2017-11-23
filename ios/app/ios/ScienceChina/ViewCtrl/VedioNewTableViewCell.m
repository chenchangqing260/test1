//
//  VedioNewTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/29.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "VedioNewTableViewCell.h"

@interface VedioNewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageConstraint;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@end


@implementation VedioNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"VedioNewTableViewCell";
}

+(VedioNewTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"VedioNewTableViewCell" owner:nil options:nil][0];
}


-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    [self.UITitle setText:sa.ni_title];
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.UIDate setText:sa.ni_publish_date_str];
    self.userInteractionEnabled = 1;
    
//    CGSize strSize = [sa.ni_title boundingRectWithSize:CGSizeMake(345, 47) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
//    
//    if(strSize.height<30){
//        _UIImageConstraint.constant = 61-21;
//    }else{
//        _UIImageConstraint.constant = 61;
//    }
    
    [self layoutIfNeeded];
}
@end
