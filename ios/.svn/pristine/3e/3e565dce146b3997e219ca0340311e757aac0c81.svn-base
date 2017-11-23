//
//  MyCommentTableCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyCommentTableCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface MyCommentTableCell()

@property (nonatomic, strong)UIImageView* uiHeadImgView;
@property (nonatomic, strong)UILabel* uiNameLab;
@property (nonatomic, strong)UILabel* uiTimeLab;
@property (nonatomic, strong)UILabel* uiContentLab;
@property (nonatomic, strong)UILabel* uiOrgInfoLab;
@property (nonatomic, strong)UIView* uiBottomLine;

@end

@implementation MyCommentTableCell

+(NSString*)ID{
    return @"MyCommentTableCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 宽高为38;
        self.uiHeadImgView = [UIImageView new];
        self.uiHeadImgView.layer.cornerRadius = 19;
        self.uiHeadImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.uiHeadImgView.layer.masksToBounds = YES;
        
        self.uiNameLab = [UILabel new];
        [self.uiNameLab setFont:FONT_15];
        [self.uiNameLab setTextColor:[UIColor colorWithHex:0x33CFDA]];
        
        self.uiTimeLab = [UILabel new];
        [self.uiTimeLab setFont:FONT_13];
        [self.uiTimeLab setTextColor:[UIColor colorWithHex:0x575757]];
        
        self.uiContentLab = [UILabel new];
        [self.uiContentLab setFont:FONT_16];
        [self.uiContentLab setTextColor:[UIColor colorWithHex:0x000000]];
        
        self.uiOrgInfoLab = [UILabel new];
        [self.uiOrgInfoLab setFont:FONT_15];
        [self.uiOrgInfoLab setTextColor:[UIColor colorWithHex:0xB5B5B5]];
        [self.uiOrgInfoLab setBackgroundColor:[UIColor colorWithHex:0xF7F7F7]];
        self.uiOrgInfoLab.layer.cornerRadius = 3;
        self.uiOrgInfoLab.layer.masksToBounds = YES;
        
        self.uiBottomLine = [UIView new];
        [self.uiBottomLine setBackgroundColor:[UIColor colorWithHex:0xEDEDED]];
        
        [self.contentView sd_addSubviews:@[self.uiHeadImgView, self.uiNameLab, self.uiTimeLab, self.uiContentLab, self.uiOrgInfoLab, self.uiBottomLine]];
        
        // 布局头像
        self.uiHeadImgView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 15)
        .widthIs(38)
        .heightIs(38);
        
        // 布局昵称
        self.uiNameLab.sd_layout
        .leftSpaceToView(self.uiHeadImgView, 9)
        .topSpaceToView(self.contentView, 17)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(18);
        
        self.uiTimeLab.sd_layout
        .leftSpaceToView(self.uiHeadImgView, 9)
        .topSpaceToView(self.uiNameLab, -3)
        .rightSpaceToView(self.contentView, 15);
        
        self.uiContentLab.sd_layout
        .leftSpaceToView(self.uiHeadImgView, 9)
        .topSpaceToView(self.uiTimeLab, 15)
        .rightSpaceToView(self.contentView, 15)
        .autoHeightRatio(0);
        self.uiContentLab.isAttributedContent = YES; // 标注lable的text为attributedString
        
        self.uiOrgInfoLab.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiContentLab, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(30);
        
        self.uiBottomLine.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiOrgInfoLab, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(1);
        
        //***********************高度自适应cell设置步骤************************
        [self setupAutoHeightWithBottomView:self.uiBottomLine bottomMargin:0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setComment:(Comment *)comment{
    _comment = comment;
    [self.uiHeadImgView sd_setImageWithURL:[NSURL URLWithString:comment.r_img_url] placeholderImage:nil];
    [self.uiNameLab setText:comment.r_name];
    [self.uiTimeLab setText:comment.r_push_time];
    if ([comment.r_is_reply isEqualToString:@"1"]) {
        // 回复
        NSString* r_content = [NSString stringWithFormat:@"(回复) %@", comment.r_content];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:r_content];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x33CFDA] range:NSMakeRange(0,4)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x000000] range:NSMakeRange(5, r_content.length - 5)];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [str addAttribute:NSFontAttributeName value:self.uiContentLab.font range:NSMakeRange(0, r_content.length)];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, r_content.length)];
        self.uiContentLab.attributedText = str;
    }else{
        // 评论
        [self.uiContentLab setTextColor:[UIColor colorWithHex:0x000000]];
        [self.uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:self.uiContentLab text:comment.r_content]];
    }
    
    [self.uiOrgInfoLab setText:[NSString stringWithFormat:@"%@%@",@"  原文: ",comment.in_title]];
}

@end
