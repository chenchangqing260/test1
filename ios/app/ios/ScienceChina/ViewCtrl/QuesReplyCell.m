//
//  QuesReplyCell.m
//  ScienceChina
//
//  Created by Ellison on 16/7/1.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesReplyCell.h"
#import "DOFavoriteButton.h"
#import "TextUtil.h"

@interface QuesReplyCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiMemberNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiContentLab;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (weak, nonatomic) IBOutlet UILabel *uiPCountLab;

@property (nonatomic,strong) ReplyQuestion* reply;
@property (nonatomic,strong) DOFavoriteButton     *uiZanBtn;

@end

@implementation QuesReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"QuesReplyCell";
}

+(QuesReplyCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"QuesReplyCell" owner:nil options:nil][0];
}

- (void)initCellDataWithReply:(ReplyQuestion*)reply{
    CGFloat _showW = kSCREEN_WIDTH;
    if (isIpad) {
        _showW = MAIN_SCREEN_WIDTH_ONIpad;
    }
    
    self.reply = reply;
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:reply.r_img_url] placeholderImage:nil];
    [self.uiMemberNameLab setText:reply.r_name];
    [self.uiTimeLab setText:reply.r_push_time];
    [self.uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:reply.r_content]];
    [self.uiPCountLab setText:reply.r_praise_count];
    
    // 计算长度
    CGFloat contentWidth = [TextUtil boundingRectWithText:reply.r_praise_count lineSpace:3 size:CGSizeMake(_showW - 40, 0) Font:self.uiPCountLab.font].width;
    
    // 增加点赞按钮
    _uiZanBtn = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(_showW - 15 - contentWidth - 40, 3 ,30, 30) image:[UIImage imageNamed:@"zan"]];
    //_uiZanBtn.backgroundColor = [UIColor redColor];
    _uiZanBtn.imageColorOff = [UIColor colorWithHex:0xB5B5B5];
    _uiZanBtn.imageColorOn = [UIColor colorWithHex:0x33cfda];
    _uiZanBtn.circleColor = [UIColor colorWithHex:0xFFD700];
    _uiZanBtn.lineColor = [UIColor colorWithHex:0xFFD700];
    _uiZanBtn.duration = 1;
    [_uiZanBtn addTarget:self action:@selector(didZanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //        _uiZanBtn.hidden = YES;
    
    [self.uiContentView addSubview:_uiZanBtn];
    
    if ([self.reply.r_is_praise isEqualToString:@"0"]) {
        _uiZanBtn.selected = NO;
    }else{
        _uiZanBtn.selected = YES;
    }
}

#pragma mark - 点击事件
-(void)didZanBtnAction:(id)sender {
    // 进行点赞，或取消点赞操作
    DOFavoriteButton *button = (DOFavoriteButton *)sender;
    if (button.selected) {
//        [button deselect];
        [SVProgressHUDUtil showInfoWithStatus:@"您已经点过赞了"];
    } else {
        // 点赞
        [[WebAccessManager sharedInstance]addQuestionsReplyPraiseCountWithqr_id:self.reply.r_id completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.reply.r_is_praise = @"1";
                NSInteger pCount = [self.reply.r_praise_count intValue] + 1;
                [self.uiPCountLab setText:[NSString stringWithFormat:@"%ld", (long)pCount]];
                [button select];
                dispatch_main_after(1.0, ^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_QUESTIONREPLY_INFO object:nil];
                });
            }
        }];
    }
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
