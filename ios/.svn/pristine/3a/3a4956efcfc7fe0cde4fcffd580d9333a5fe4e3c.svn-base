//
//  SummaryPersonDetailTableCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SummaryPersonDetailTableCell.h"
#import "TextUtil.h"
#import "SummaryDetail.h"

@interface SummaryPersonDetailTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImgView1First;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView2First;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView1Second;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView2Second;

@property (weak, nonatomic) IBOutlet UILabel *uiLabTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiLabArtricleCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabOrgCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabRegisterCount;
@property (weak, nonatomic) IBOutlet UIView *uiViewRegisterCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIIViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIBottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *UIlabelfirst;

@property (weak, nonatomic) IBOutlet UILabel *UISecond;

@end

@implementation SummaryPersonDetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.uiImgView2First.layer setMasksToBounds:YES];
    [self.uiImgView2First.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    
    [self.uiImgView2Second.layer setMasksToBounds:YES];
    [self.uiImgView2Second.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
}

+(SummaryPersonDetailTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SummaryPersonDetailTableCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"SummaryPersonDetailTableCell";
}

-(void)setCellWithSummaryDetail:(SummaryDetail*)detail isTown:(NSString*)isTown isShowTop:(BOOL) isShowTop{
//    if (isTown && [isTown isEqualToString:@"4"]) {
//        // 乡镇级，不显示下面的注册人数
//        self.conRegisterViewWidth.constant = 0;
//    }else{
//        self.conRegisterViewWidth.constant = kSCREEN_WIDTH / 3;
//    }
    if(!isShowTop){
        self.UIIViewConstraint.constant = 0;
    }
    
    if (detail) {
        NSString* textStr = @"";
        if (isTown && [isTown isEqualToString:@"4"]) {
            // 乡镇级，不显示下面的注册人数
            textStr = [NSString stringWithFormat:@"%@ %@", detail.sc_name, detail.region_name];
            self.uiViewRegisterCount.hidden = YES;
        }else{
            textStr = detail.region_name;
            self.uiViewRegisterCount.hidden = NO;
        }
        
        CGSize size = [TextUtil boundingRectWithText:textStr lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 39, 0) Font:FONT_17];
        
//        if (size.height <= 39) {
//            self.conViewTopHeight.constant = 39;
//        }else if(size.height > 39 && size.height < 60){
//            self.conViewTopHeight.constant = 55;
//        }else{
//            self.conViewTopHeight.constant = 80;
//        }
//        
        [self layoutIfNeeded];
        
        [self.uiLabTitle setText:detail.sc_name];
        
        [self.uiLabArtricleCount setText:detail.article_share_count];
        [self.uiLabOrgCount setText:detail.org_share_count];
        [self.uiLabRegisterCount setText:detail.sciencer_count];
        if (![detail.channels isEmptyOrWhitespace]){
            NSArray* tagArray = nil;
            if (detail.channels) {
                tagArray = [detail.channels componentsSeparatedByString:@","];
            }
            
            if (tagArray) {
                if (tagArray.count == 1) {
                    NSString* tag1 = [tagArray objectAtIndex:0];
                    self.uiImgView1First.hidden = NO;
                    self.uiImgView2First.hidden = NO;
                    self.UIlabelfirst.hidden = NO;
                    self.uiImgView1Second.hidden = YES;
                    self.uiImgView2Second.hidden = YES;
                    self.UISecond.hidden = YES;
                    
                    // 计算长度
                    CGSize size = [TextUtil boundingRectWithText:tag1 size:CGSizeMake(0, 0) Font:FONT_14];
//                    self.conLabFirstTagWidth.constant = size.width + 10;
                    [self.UIlabelfirst setText:tag1];
                }else{
                    self.uiImgView1First.hidden = NO;
                    self.uiImgView2First.hidden = NO;
                    self.UIlabelfirst.hidden = NO;
                    self.uiImgView1Second.hidden = NO;
                    self.uiImgView2Second.hidden = NO;
                    self.UISecond.hidden = NO;
                    
                    // 计算长度
                    NSString* tag1 = [tagArray objectAtIndex:0];
                    CGSize size = [TextUtil boundingRectWithText:tag1 size:CGSizeMake(0, 0) Font:FONT_14];
//                    self.conLabFirstTagWidth.constant = size.width + 10;
                    [self.UIlabelfirst setText:tag1];
                    
                    // 计算长度
                    NSString* tag2 = [tagArray objectAtIndex:1];
                    CGSize size1 = [TextUtil boundingRectWithText:tag2 size:CGSizeMake(0, 0) Font:FONT_14];
//                    self.conLabSecondTagWidth.constant = size1.width + 10;
                    [self.UISecond setText:tag2];;
                }
            }else{
                self.uiImgView1First.hidden = YES;
                self.uiImgView2First.hidden = YES;
                self.UIlabelfirst.hidden = YES;
                self.uiImgView1Second.hidden = YES;
                self.uiImgView2Second.hidden = YES;
                self.UISecond.hidden = YES;
                self.UIBottomConstraint.constant = 0;
            }
        }else{
            self.uiImgView1First.hidden = YES;
            self.uiImgView2First.hidden = YES;
            self.UIlabelfirst.hidden = YES;
            self.uiImgView1Second.hidden = YES;
            self.uiImgView2Second.hidden = YES;
            self.UISecond.hidden = YES;
            self.UIBottomConstraint.constant = 0;
        }
    }
}


@end
