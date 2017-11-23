//
//  PicTextInfoCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PicTextInfoCollectionViewCell.h"

@interface PicTextInfoCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *uiCategoryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiClassLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCollectLab;
@property (weak, nonatomic) IBOutlet UILabel *uiReviewLab;
@property (weak, nonatomic) IBOutlet UILabel *uiLookCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTextTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conBottomViewHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing_bottom;

@end

@implementation PicTextInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 5S Title的上下间距变为13，6以上为18，5S以下底部距离为40，6以上为51;
    if (kSCREEN_WIDTH < kWIDTH_375) {
        _conTitleTopSpace.constant =  15;
        _conTitleBottomSpace.constant = 11;
        _conBottomViewHeight.constant = 40;
    }else{
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
        if (!fontSize) {
            fontSize = @"Normal";
            [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
            [settings synchronize];
        }
        if ([fontSize isEqualToString:@"Small"]) {
             _conTitleTopSpace.constant = _conTitleBottomSpace.constant = 18;
        }else if([fontSize isEqualToString:@"Large"]){
             _conTitleTopSpace.constant = _conTitleBottomSpace.constant = 12;
        }else{
             _conTitleTopSpace.constant = _conTitleBottomSpace.constant = 15;
        }
       
        _conBottomViewHeight.constant = 51;
    }
    
    self.uiImageView.clipsToBounds = NO;
    
    if (isIpad) {
        CGFloat _left = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        _leading_top.constant = _trailing_top.constant = _left;
        _leading_bottom.constant = _trailing_bottom.constant = _left;
    }
}

+ (NSString*)ID{
    return @"PicTextInfoCollectionViewCell";
}

-(void)initCellData:(HomeModel*)model{
    [_uiTitleLab setText:model.in_title];
    _uiDescLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiDescLab text:model.in_desc];
    [_uiCollectLab setText:model.in_collectCount];
    [_uiReviewLab setText:model.in_reviewCount];
    [_uiLookCountLab setText:model.in_hits];
    
    if([model.in_classify isEqualToString:@"4"]){
        self.uiTextTimeLab.hidden = NO;
        [self.uiTextTimeLab setText:model.in_publish_date_str];
        
        // 计算约束
        _conTopViewHeight.constant = 0;
    }else{
        self.uiTextTimeLab.hidden = YES;
        [_uiImageView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        [_uiCategoryLab setText:model.in_article_type];
        [_uiTimeLab setText:model.in_publish_date_str];
        
        // 根据类型显示不同的数据
        if ([model.in_classify isEqualToString:@"0"]) {
            [self.uiClassLab setText:@"# 图文"];
        }else if([model.in_classify isEqualToString:@"1"]){
            [self.uiClassLab setText:[NSString stringWithFormat:@"%@%@", @"# 图集 / ", model.in_pic_amount]];
        }else if([model.in_classify isEqualToString:@"2"]){
            [self.uiClassLab setText:[NSString stringWithFormat:@"%@%@", @"# 视频 / ", model.in_video_duration]];
        }else if([model.in_classify isEqualToString:@"3"]){
            [self.uiClassLab setText:@"# 专题"];
        }
        
        // 计算约束
        if (isIpad) {
            _conTopViewHeight.constant = MAIN_SCREEN_WIDTH_ONIpad / kWIDTH_375 * 212;
        }else{
            _conTopViewHeight.constant = kSCREEN_WIDTH / kWIDTH_375 * 212;
        }
    }
    
    [self layoutIfNeeded];
}

//- (void)setImageOffset:(CGPoint)imageOffset
//{
//    // Store padding value
//    _imageOffset = imageOffset;
//
//    // Grow image view
//    CGRect frame = self.uiImageView.bounds;
//    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
//    self.uiImageView.frame = offsetFrame;
//}
@end
