//
//  HotAcitivityCollectionCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/13.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "HotAcitivityCollectionCell.h"
#import "TextUtil.h"

@interface HotAcitivityCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIButton *UITypeBtn;

@property (weak, nonatomic) IBOutlet UILabel *uiTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiDate3;

@property (weak, nonatomic) IBOutlet UIImageView *UIjoin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITitleHeightConstrant;
@property (weak, nonatomic) IBOutlet UILabel *UILableTuiJian;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITypeConstrint;
@property (weak, nonatomic) IBOutlet UIImageView *UiImageTuiJian;
@end

@implementation HotAcitivityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"HotAcitivityCollectionCell";
}

-(void)setCellWithScienceActivity:(ScienceActivity*)sa{
//    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"] || [sa.av_type isEqualToString:@"03"]) {
        // 有参与人数
//        self.uiView2.hidden = YES;
//        self.uiView3.hidden = NO;
//
//        [self.uiVisitCount3 setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
//        [self.uiParCount3 setText:[NSString stringWithFormat:@"已参与%@人", sa.participators]];
//        [self.uiDate3 setText:sa.publish_at];
//    }else{
//        self.uiView2.hidden = NO;
//        self.uiView3.hidden = YES;
//
//        [self.uiVisitCount2 setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
//        [self.uiDate2 setText:sa.publish_at];
        
//    }
    
    if([sa.is_recommend isEqualToString:@"1"]){
        self.UILableTuiJian.hidden = NO;
        self.UiImageTuiJian.hidden = NO;
        self.UITypeConstrint.constant = 65;
    }else{
        self.UILableTuiJian.hidden = YES;
        self.UiImageTuiJian.hidden = YES;
        self.UITypeConstrint.constant = 15;
    }
    
    [self.uiDate3 setText:sa.shelve_at];
    
    if (sa.image_name && ![sa.image_name isEmptyOrWhitespace]) {
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:sa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:sa.image_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    
//    [self.uiTypeTitle setText:sa.av_type_name];
    [self.uiTitle setText:sa.title];
    
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
        _UITitleHeightConstrant.constant = 46-23;
    }else{
        _UITitleHeightConstrant.constant = 46;
    }
    
    [self layoutIfNeeded];
    
}

@end
