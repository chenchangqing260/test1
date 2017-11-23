//
//  PicListCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "PicListCollectionViewCell.h"
#import "HomeModel.h"
#import "TextUtil.h"

@interface PicListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage1;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage2;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage3;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet UILabel *UIPingNum;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIPicconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIPicconstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIPicconstraint2;


@end

@implementation PicListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"PicListCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace   hmType:(NSString*)hmtype{
    
    if([hmtype isEqualToString:@"0"]){
        [self.UITitle setText:sa.ni_title];
        [self.UIDate setText:sa.ni_publish_date_str];
        [self.UIPingNum setText:sa.ni_reviewCount];
        [self.UIImage1 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIImage2 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url2] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIImage3 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url3] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [self.UITitle setText:sa.in_title];
        [self.UIDate setText:sa.in_publish_date_str];
        [self.UIPingNum setText:sa.in_reviewCount];
        [self.UIImage1 sd_setImageWithURL:[NSURL URLWithString:sa.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIImage2 sd_setImageWithURL:[NSURL URLWithString:sa.in_img_url2] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIImage3 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url3] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    
    
    if(showSpace){
        self.UIConstraint.constant = 10;
    }else{
        self.UIConstraint.constant = 0;
    }
    
    UIFont *font = [UIFont systemFontOfSize:18];
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    if (!fontSize) {
        fontSize = @"Normal";
        if ([fontSize isEqualToString:@"Large"]) {
            font = [UIFont systemFontOfSize:18+3];
        } else if ([fontSize isEqualToString:@"Small"]) {
            font = [UIFont systemFontOfSize:18-2];
        }
    }
    
    if([hmtype isEqualToString:@"0"]){
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:font].height;
        
        if(textHeight<30){
            _UIPicconstraint.constant = 68-22;
            _UIPicconstraint1.constant = 68-22;
            _UIPicconstraint2.constant = 68-22;
        }else{
            _UIPicconstraint.constant = 68;
            _UIPicconstraint1.constant = 68;
            _UIPicconstraint2.constant = 68;
            
        }
    }else{
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.in_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:font].height;
        
        if(textHeight<30){
            _UIPicconstraint.constant = 64-23;
            _UIPicconstraint1.constant = 64-23;
            _UIPicconstraint2.constant = 64-23;
        }else{
            _UIPicconstraint.constant = 64;
            _UIPicconstraint1.constant = 64;
            _UIPicconstraint2.constant = 64;
            
        }
    }

    
    [self layoutIfNeeded];
}


@end
