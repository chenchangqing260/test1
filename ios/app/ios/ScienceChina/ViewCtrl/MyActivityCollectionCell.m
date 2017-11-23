//
//  MyActivityCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/25.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MyActivityCollectionCell.h"
#import "TextUtil.h"

@interface MyActivityCollectionCell()

@property (weak, nonatomic) IBOutlet UIView *uiView;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelType;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelDate;
@property (weak, nonatomic) IBOutlet UIImageView *state01;
@property (weak, nonatomic) IBOutlet UIImageView *state02;
@property (weak, nonatomic) IBOutlet UIImageView *state03;
@property (weak, nonatomic) IBOutlet UIImageView *state04;
@property (weak, nonatomic) IBOutlet UIImageView *state05;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTypeWidth;

@end

@implementation MyActivityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.uiView.layer.cornerRadius = 3;
    self.uiView.layer.borderWidth = 0.5;
    self.uiView.layer.borderColor = [UIColor colorWithHex:0xe5e5e5].CGColor;
}

+(NSString*)ID{
    return @"MyActivityCollectionCell";
}

-(void)setCellDataWithActivity:(ScienceActivity*)sa{
    [self.uiLabelTitle setText:sa.av_title];
    [self.uiLabelType setText:sa.av_type];
    self.conTypeWidth.constant = [self jisuanTextWidth:sa.av_type];
    self.uiLabelType.layer.borderColor = [UIColor colorWithHex:0x36CDE0].CGColor;
    self.uiLabelType.layer.borderWidth = 0.5;
    self.uiLabelType.layer.cornerRadius = 3;
    [self.uiLabelDate setText:sa.create_at];
    
    self.state01.hidden = YES;
    self.state02.hidden = YES;
    self.state03.hidden = YES;
    self.state04.hidden = YES;
    self.state05.hidden = YES;
    
    if ([sa.status isEqualToString:@"0"]) {
        self.state01.hidden = NO;
    }else if ([sa.status isEqualToString:@"1"]) {
        self.state04.hidden = NO;
    }else if ([sa.status isEqualToString:@"2"]) {
        self.state03.hidden = NO;
    }else if ([sa.status isEqualToString:@"3"]) {
        self.state05.hidden = NO;
    }else if ([sa.status isEqualToString:@"4"]) {
        self.state02.hidden = NO;
    }
    [self layoutIfNeeded];
}


#pragma mark 工具类方法
- (CGFloat)jisuanTextWidth:(NSString*)text{
    CGFloat textWidth = 0;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    if (!fontSize) {
        fontSize = @"Normal";
        [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
        [settings synchronize];
    }
    if([fontSize isEqualToString:@"Large"]) {
        textWidth = [TextUtil boundingRectWithText:text size:CGSizeMake(kSCREEN_WIDTH - 26, 0) Font:FONT_13].width;
    }else{
        textWidth = [TextUtil boundingRectWithText:text size:CGSizeMake(kSCREEN_WIDTH - 26, 0) Font:FONT_10].width;
    }
    
    return textWidth + 16;
}

@end
