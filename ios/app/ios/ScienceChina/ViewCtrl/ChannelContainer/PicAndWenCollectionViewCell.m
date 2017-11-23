//
//  PicAndWenCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "PicAndWenCollectionViewCell.h"
#import "TextUtil.h"

@interface PicAndWenCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *UIImgView;
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet UILabel *UIPinNum;
@property (weak, nonatomic) IBOutlet UIImageView *UIZhuanti;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tuwenConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIDateConstraint;

@end

@implementation PicAndWenCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"PicAndWenCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace zhuanti:(BOOL)isZhuanti  hmType:(NSString*)hmtype{
    
    if([hmtype isEqualToString:@"0"]){
        [self.UITitle setText:sa.ni_title];
        [self.UIDate setText:sa.ni_publish_date_str];
        [self.UIPinNum setText:sa.ni_reviewCount];
        [self.UIImgView sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        
    }else{
        [self.UITitle setText:sa.in_title];
        [self.UIDate setText:sa.in_publish_date_str];
        [self.UIPinNum setText:sa.in_reviewCount];
        [self.UIImgView sd_setImageWithURL:[NSURL URLWithString:sa.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    
    if(showSpace){
        self.tuwenConstraint.constant = 10;
    }else{
        self.tuwenConstraint.constant = 0;
    }
    
    if(isZhuanti){
        self.UIZhuanti.hidden = NO;
    }else{
        self.UIZhuanti.hidden = YES;
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
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.ni_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:font].height;
        
        if(textHeight<50){
            _UIDateConstraint.constant = 15+11;
        }else{
            _UIDateConstraint.constant = 15;
        }
    }else{
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.in_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:font].height;
        
        if(textHeight<50){
            _UIDateConstraint.constant = 15+11;
        }else{
            _UIDateConstraint.constant = 15;
        }
    }


    [self layoutIfNeeded];
}


@end
