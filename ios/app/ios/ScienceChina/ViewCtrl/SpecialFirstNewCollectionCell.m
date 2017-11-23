//
//  SpecialFirstNewCollectionCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/28.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialFirstNewCollectionCell.h"
#import "TextUtil.h"

@interface SpecialFirstNewCollectionCell()

@property (weak, nonatomic) IBOutlet UIView *uiFirstView;

@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSpecialSA;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelSpecialSA;

@property (weak, nonatomic) IBOutlet UILabel *uiLabelSATitle;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSA;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelVisitCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelParCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelDate;
@property (weak, nonatomic) IBOutlet UIView *uiViewDateLine;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgViewSACanyu;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelNotStart;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelBeginning;
@property (weak, nonatomic) IBOutlet UIImageView *uiLabelEnding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITitleHeightConstrant;

@property (nonatomic, strong)ScienceActivity* spsa;
@property (nonatomic, strong)ScienceActivity* sa;
@property (nonatomic, strong)NSIndexPath* indexPath;

@end

@implementation SpecialFirstNewCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialFirstNewCollectionCell";
}

-(void)setCellDataWithSpecialActivity:(ScienceActivity*)spsa SpecialActivity:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath showTitle:(BOOL)showTitle{
    self.sa = spsa;
    self.spsa = spsa;
    self.indexPath = indexPath;
    
    [self.uiImgViewSpecialSA sd_setImageWithURL:[NSURL URLWithString:spsa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiLabelSpecialSA setText:spsa.title];
    
    if (showTitle) {
        self.uiLabelSpecialSA.hidden = NO;
    }else{
        self.uiLabelSpecialSA.hidden = YES;
    }
    
    if ([spsa.special_status isEqualToString:@"01"]) {
        self.uiLabelNotStart.hidden = NO;
        self.uiLabelBeginning.hidden = YES;
        self.uiLabelEnding.hidden = YES;
    }else if ([spsa.special_status isEqualToString:@"02"]){
        self.uiLabelNotStart.hidden = YES;
        self.uiLabelBeginning.hidden = NO;
        self.uiLabelEnding.hidden = YES;
    }else if ([spsa.special_status isEqualToString:@"03"]){
        self.uiLabelNotStart.hidden = YES;
        self.uiLabelBeginning.hidden = YES;
        self.uiLabelEnding.hidden = NO;
    }else{
        self.uiLabelNotStart.hidden = YES;
        self.uiLabelBeginning.hidden = YES;
        self.uiLabelEnding.hidden = YES;
    }
    
    if ([spsa.av_type isEqualToString:@"01"] || [spsa.av_type isEqualToString:@"02"] || [spsa.av_type isEqualToString:@"03"]) {
        self.uiImgViewSACanyu.hidden = NO;
        self.uiViewDateLine.hidden = NO;
        [self.uiLabelParCount setText:[NSString stringWithFormat:@"已参与%@人", spsa.participators]];
    }else{
        self.uiImgViewSACanyu.hidden = YES;
        self.uiViewDateLine.hidden = YES;
    }
    [self.uiLabelDate setText:spsa.shelve_at];
//    [self.uiLabelDate setBackgroundColor:[UIColor colorWithHex:0x33CFDA alpha:0.15]];
    
    if (spsa.image_name && ![spsa.image_name isEmptyOrWhitespace]) {
        [self.uiImgViewSA sd_setImageWithURL:[NSURL URLWithString:sa.image_name] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [self.uiImgViewSA sd_setImageWithURL:[NSURL URLWithString:sa.image_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    [self.uiLabelSATitle setText:spsa.title];
    [self.uiLabelVisitCount setText:[NSString stringWithFormat:@"%@次",sa.visitors]];
    
    CGFloat textHeight = [TextUtil boundingRectWithText:sa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
    
    if(textHeight<40){
        _UITitleHeightConstrant.constant = 45-23;
    }else{
        _UITitleHeightConstrant.constant = 45;
    }
}

#pragma mark - 按钮事件
- (IBAction)clickSBtn:(id)sender {
    [self.delegate clickSBtn:self.spsa SA:self.sa];
}

- (IBAction)clickABtn:(id)sender {
    [self.delegate clickABtn:self.sa indexPath:_indexPath];
}

@end
