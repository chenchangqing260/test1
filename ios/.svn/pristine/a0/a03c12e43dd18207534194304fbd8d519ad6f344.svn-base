//
//  ActivityNormalNewCollectionCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/13.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityNormalNewCollectionCell.h"
#import "TextUtil.h"

@interface ActivityNormalNewCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *UIImageview;
@property (weak, nonatomic) IBOutlet UILabel *UiTitle;
@property (weak, nonatomic) IBOutlet UILabel *IsTuijian;
@property (weak, nonatomic) IBOutlet UIButton *UITypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *UIdate;
@property (weak, nonatomic) IBOutlet UIImageView *UiImageTuiJian;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITypeBtnConstrant;
@property (weak, nonatomic) IBOutlet UIImageView *UIjoin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITitleHeightConstrant;

@end

@implementation ActivityNormalNewCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"ActivityNormalNewCollectionCell";
}

-(void)setCellWithScienceActivity:(ScienceActivity*)sa{
    [self.UIImageview sd_setImageWithURL:[NSURL URLWithString:sa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.UiTitle setText:sa.title];
     if([sa.is_recommend isEqualToString:@"1"]){
        self.IsTuijian.hidden = NO;
        self.UiImageTuiJian.hidden = NO;
        self.UITypeBtnConstrant.constant = 65;
    }else{
        self.IsTuijian.hidden = YES;
        self.UiImageTuiJian.hidden = YES;
        self.UITypeBtnConstrant.constant = 15;
    }
    [self.UIdate setText:sa.shelve_at];
    
    [self.UITypeBtn setTitle:sa.av_type_name forState:UIControlStateNormal];
    
    [self.UITypeBtn.layer setMasksToBounds:YES];
    [self.UITypeBtn.layer setCornerRadius:8.0];
    [self.UITypeBtn.layer setBorderWidth:1.0];
    [self.UITypeBtn.layer  setBorderColor: RGBCOLOR(204.0, 204.0, 204.0).CGColor];
    self.UITypeBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
    self.UITypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"] || [sa.av_type isEqualToString:@"03"]) {
        self.UIjoin.hidden = NO;
    }else{
        self.UIjoin.hidden = YES;
    }
    
    CGFloat textHeight = [TextUtil boundingRectWithText:sa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
    
    if(textHeight<40){
        _UITitleHeightConstrant.constant = 54-23;
    }else{
        _UITitleHeightConstrant.constant = 54;
    }
}

@end
