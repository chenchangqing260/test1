//
//  VedioCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "VedioCollectionViewCell.h"
#import "HomeModel.h"
#import "TextUtil.h"

@interface VedioCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageBottonConstarint;
@property (weak, nonatomic) IBOutlet UILabel *UIPingNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UiTitleConstrant;
@end

@implementation VedioCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"VedioCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace   hmType:(NSString*)hmtype{
    
    if([hmtype isEqualToString:@"0"]){
        [self.UITitle setText:sa.ni_title];
        [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIDate setText:sa.ni_publish_date_str];
        [self.UIPingNum setText:sa.ni_reviewCount];
    }else{
        [self.UITitle setText:sa.in_title];
        [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [self.UIDate setText:sa.in_publish_date_str];
        [self.UIPingNum setText:sa.in_reviewCount];
    }
    
    self.userInteractionEnabled = 1;
    
    if(showSpace){
        self.topConstraint.constant = 10;
    }else{
        self.topConstraint.constant = 0;
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
        if(textHeight<40){
            _UIImageConstraint.constant = 60-21;
        }else{
            _UIImageConstraint.constant = 60;
        }
    }else{
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.in_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:font].height;
        if(textHeight<40){
            _UIImageConstraint.constant = 60-21;
        }else{
            _UIImageConstraint.constant = 60;
        }
    }


    [self layoutIfNeeded];
}


@end