//
//  MyCollectTableCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyCollectTableCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface MyCollectTableCell()

@property (nonatomic, strong)UILabel* uiCategoryLab;
@property (nonatomic, strong)UILabel* uiTitleLab;
@property (nonatomic, strong)UILabel* uiContentLab;
@property (nonatomic, strong)UILabel* uiTimeLab;
@property (nonatomic, strong)UILabel* uiCommentLab;
@property (nonatomic, strong)UIButton* uiDelCollectBtn;
@property (nonatomic, strong)UIView* uiBottomLine;

@end

@implementation MyCollectTableCell

+(NSString*)ID{
    return @"MyCollectTableCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 宽高为38;
        self.uiCategoryLab = [UILabel new];
        self.uiCategoryLab.layer.cornerRadius = 4;
        [self.uiCategoryLab setFont:FONT_14];
        [self.uiCategoryLab setTextColor:[UIColor colorWithHex:0x33cfda]];
        [self.uiCategoryLab setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
        [self.uiCategoryLab.layer setBorderColor:[UIColor colorWithHex:0x33cfda].CGColor];
        [self.uiCategoryLab.layer setBorderWidth:0.5];
        [self.uiCategoryLab setTextAlignment:NSTextAlignmentCenter];
        
        self.uiTitleLab = [UILabel new];
        [self.uiTitleLab setFont:FONT_17];
        [self.uiTitleLab setTextColor:[UIColor colorWithHex:0x090909]];
        
        self.uiContentLab = [UILabel new];
        [self.uiContentLab setFont:FONT_14];
        [self.uiContentLab setTextColor:[UIColor colorWithHex:0x656565]];
        
        self.uiTimeLab = [UILabel new];
        [self.uiTimeLab setFont:FONT_13];
        [self.uiTimeLab setTextColor:[UIColor colorWithHex:0xA6A6A6]];
        [self.uiTimeLab setTextAlignment:NSTextAlignmentLeft];
        
        self.uiCommentLab = [UILabel new];
        [self.uiCommentLab setFont:FONT_13];
        [self.uiCommentLab setTextColor:[UIColor colorWithHex:0xA6A6A6]];
        self.uiCommentLab.textAlignment = NSTextAlignmentRight;
        
        self.uiDelCollectBtn = [UIButton new];
        [self.uiDelCollectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.uiDelCollectBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateNormal];
        [self.uiDelCollectBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateHighlighted];
        [self.uiDelCollectBtn.titleLabel setFont:FONT_13];
        [self.uiDelCollectBtn setImage:[UIImage imageNamed:@"mylike"] forState:UIControlStateHighlighted];
        [self.uiDelCollectBtn setImage:[UIImage imageNamed:@"mylike"] forState:UIControlStateNormal];
        self.uiDelCollectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.uiDelCollectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.uiDelCollectBtn addTarget:self action:@selector(delCollect) forControlEvents:UIControlEventTouchUpInside];
        
        self.uiBottomLine = [UIView new];
        [self.uiBottomLine setBackgroundColor:[UIColor colorWithHex:0xEDEDED]];
        
        [self.contentView sd_addSubviews:@[self.uiCategoryLab, self.uiTitleLab, self.uiContentLab, self.uiTimeLab, self.uiCommentLab, self.uiDelCollectBtn, self.uiBottomLine]];
        
        // 布局头像
        self.uiCategoryLab.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 15)
        .widthIs(38)
        .heightIs(23);
        
        self.uiTitleLab.sd_layout
        .leftSpaceToView(self.uiCategoryLab, 5)
        .topSpaceToView(self.contentView,15)
        .rightSpaceToView(self.contentView,15)
        .heightIs(23);
        
        self.uiContentLab.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiTitleLab, 12)
        .autoHeightRatio(0);
        self.uiContentLab.isAttributedContent = YES;
        
        self.uiTimeLab.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiContentLab, 12)
        .heightIs(15)
        .widthIs(80);
        
        self.uiDelCollectBtn.sd_layout
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiContentLab, 0)
        .heightIs(40)
        .widthIs(90);
        
        self.uiCommentLab.sd_layout
        .rightSpaceToView(self.uiDelCollectBtn, 5)
        .topSpaceToView(self.uiContentLab, 12)
        .heightIs(15)
        .widthIs(80);
        
        self.uiBottomLine.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.uiTimeLab, 12)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(1);
        
        //***********************高度自适应cell设置步骤************************
        [self setupAutoHeightWithBottomView:self.uiBottomLine bottomMargin:0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setInfo:(HomeModel *)info{
    _info = info;
    
    if ([info.in_classify isEqualToString:@"0"]){
        // 图文
        self.uiCategoryLab.text = @"图文";
    }else if([info.in_classify isEqualToString:@"4"]) {
        // 文字
        self.uiCategoryLab.text = @"文字";
    }else if([info.in_classify isEqualToString:@"1"]){
        // 图集
        self.uiCategoryLab.text = @"图集";
    }else if([info.in_classify isEqualToString:@"2"]){
        // 视频
        self.uiCategoryLab.text = @"视频";
    }else if([info.in_classify isEqualToString:@"3"]){
        // 专题
        self.uiCategoryLab.text = @"专题";
    }
    
    _uiTitleLab.text = info.in_title;
    _uiContentLab.attributedText= [LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:info.in_desc];
    _uiTimeLab.text = info.in_publish_date_str;
    _uiCommentLab.text = [NSString stringWithFormat:@"评论: %@", info.in_reviewCount];
}

// 取消成功
-(void)delCollect{
    [SVProgressHUDUtil showWithStatus:@"正在取消..." dur:1 completion:^{
        [[WebAccessManager sharedInstance]removeCollectInfo:self.info.in_id completion:^(WebResponse *response, NSError *error) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
            [self.delegate refreshData];
            
            [SVProgressHUDUtil showSuccessWithStatus:@"取消成功"];
        }];
    }];
    
}

@end
