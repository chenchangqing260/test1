//
//  ActivityCollectionNewViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//
#import "ActivityCollectionNewViewCell.h"
#import "HomeModel.h"

@interface ActivityCollectionNewViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIButton *UiBtn;
@property (weak, nonatomic) IBOutlet UILabel *UIPerNum;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UIImageView *UIJoin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Topconstraint;
@property (weak, nonatomic) IBOutlet UIView *UIView;
@property (weak, nonatomic) IBOutlet UIImageView *UIimageTJ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITItileConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIJoinConstraint;

@property (nonatomic, strong)HomeModel* sa;
@property (nonatomic, strong)NSIndexPath* indexPath;

@end

@implementation ActivityCollectionNewViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"ActivityCollectionNewViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa indexPath:(NSIndexPath*)indexPath showSpace:(BOOL)showSpace{
    
    self.sa = sa;
    self.indexPath = indexPath;
    [self.UITitle setText:sa.ni_title];
    [self.UIPerNum setText:sa.ni_publish_date_str];
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    if(![sa.ni_av_type isEqualToString:@"05"]&&![sa.ni_av_type isEqualToString:@"06"]){
        
        self.UiBtn.hidden = NO;
        [self.UiBtn setTitle:sa.ni_av_name forState:UIControlStateNormal];
        
        [self.UiBtn.layer setMasksToBounds:YES];
        [self.UiBtn.layer setCornerRadius:2.0];
        [self.UiBtn.layer setBorderWidth:1.0];
        [self.UiBtn.layer  setBorderColor: RGBCOLOR(54.0, 205.0, 224.0).CGColor];
        self.UiBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
        self.UiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        //        self.UiBtn.layer.cornerRadius = 2.0;//2.0是圆角的弧度
        //        self.UiBtn.layer.borderWidth = 1.0;
        //        self.UiBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);//设置边框颜色
        //        self.UiBtn.layer.borderWidth = 1.0f;//设置边框颜色
        
        //        if([sa.ni_av_type isEqualToString:@"02"]){
        //            self.UIBtnConstraint.constant = 52;
        ////            self.UIJoinConstraint.constant = 42+15+8;
        //        }else if([sa.ni_av_type isEqualToString:@"01"]||[sa.ni_av_type isEqualToString:@"03"]||[sa.ni_av_type isEqualToString:@"04"]){
        //            self.UIBtnConstraint.constant = 30;
        ////            self.UIJoinConstraint.constant = 29+15+8;
        //        }else{
        //            int count = 0;
        //            int count1 =0;
        //            NSString*str = sa.ni_av_name;
        //            for (int i =0; i<str.length;i++)
        //                 {
        //                     unichar c = [str characterAtIndex:i];
        //                     if (c >=0x4E00 && c <=0x9FA5)
        //                     {
        //                         count ++;
        //
        //                     }
        //                     else
        //                     {
        //                         count1 ++;
        //
        //                     }
        //                 }
        //            self.UIBtnConstraint.constant = (count+count1)*13;
        //        }
        
    }else{
        self.UiBtn.hidden = YES;
        //        self.UIJoinConstraint.constant = 15;
    }
    
    self.UiBtn.hidden = YES;
    
    if([sa.ni_av_type isEqualToString:@"01"]||[sa.ni_av_type isEqualToString:@"02"]||[sa.ni_av_type isEqualToString:@"03"]){
        self.UIJoin.hidden = NO;
    }else{
        self.UIJoin.hidden = YES;
    }
    
    [self layoutIfNeeded];
    
    
}

@end
