//
//  SummaryDetailTableCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SummaryDetailTableCell.h"
#import "TextUtil.h"

@interface SummaryDetailTableCell()

@property (weak, nonatomic) IBOutlet UILabel *uiLabFirst;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView1First;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView2First;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView1Second;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView2Second;
@property (weak, nonatomic) IBOutlet UILabel *uiLabSecond;
@property (weak, nonatomic) IBOutlet UILabel *uiLabTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiLabArtricleCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabOrgCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabRegisterCount;
@property (weak, nonatomic) IBOutlet UIView *uiViewRegisterCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLabFirstTagWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLabSecondTagWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRegisterViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conViewTopHeight;

@end

@implementation SummaryDetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.uiImgView2First.layer setMasksToBounds:YES];
    [self.uiImgView2First.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    
    [self.uiImgView2Second.layer setMasksToBounds:YES];
    [self.uiImgView2Second.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
}

+(SummaryDetailTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SummaryDetailTableCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"SummaryDetailTableCell";
}

-(void)setCellWithSummaryDetail:(SummaryDetail*)detail isTown:(NSString*)isTown{
    if (isTown && [isTown isEqualToString:@"4"]) {
        // 乡镇级，不显示下面的注册人数
        self.conRegisterViewWidth.constant = 0;
    }else{
        self.conRegisterViewWidth.constant = kSCREEN_WIDTH / 3;
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
        
        if (size.height <= 39) {
            self.conViewTopHeight.constant = 39;
        }else if(size.height > 39 && size.height < 60){
            self.conViewTopHeight.constant = 55;
        }else{
            self.conViewTopHeight.constant = 80;
        }
        
        [self layoutIfNeeded];
        
        [self.uiLabTitle setText:textStr];
        
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
                    self.uiLabFirst.hidden = NO;
                    self.uiImgView1Second.hidden = YES;
                    self.uiImgView2Second.hidden = YES;
                    self.uiLabSecond.hidden = YES;
                    
                    // 计算长度
                    CGSize size = [TextUtil boundingRectWithText:tag1 size:CGSizeMake(0, 0) Font:FONT_14];
                    self.conLabFirstTagWidth.constant = size.width + 10;
                    [self.uiLabFirst setText:tag1];
                }else{
                    self.uiImgView1First.hidden = NO;
                    self.uiImgView2First.hidden = NO;
                    self.uiLabFirst.hidden = NO;
                    self.uiImgView1Second.hidden = NO;
                    self.uiImgView2Second.hidden = NO;
                    self.uiLabSecond.hidden = NO;
                    
                    // 计算长度
                    NSString* tag1 = [tagArray objectAtIndex:0];
                    CGSize size = [TextUtil boundingRectWithText:tag1 size:CGSizeMake(0, 0) Font:FONT_14];
                    self.conLabFirstTagWidth.constant = size.width + 10;
                    [self.uiLabFirst setText:tag1];
                    
                    // 计算长度
                    NSString* tag2 = [tagArray objectAtIndex:1];
                    CGSize size1 = [TextUtil boundingRectWithText:tag2 size:CGSizeMake(0, 0) Font:FONT_14];
                    self.conLabSecondTagWidth.constant = size1.width + 10;
                    [self.uiLabSecond setText:tag2];;
                }
            }else{
                self.uiImgView1First.hidden = YES;
                self.uiImgView2First.hidden = YES;
                self.uiLabFirst.hidden = YES;
                self.uiImgView1Second.hidden = YES;
                self.uiImgView2Second.hidden = YES;
                self.uiLabSecond.hidden = YES;
            }
        }else{
            self.uiImgView1First.hidden = YES;
            self.uiImgView2First.hidden = YES;
            self.uiLabFirst.hidden = YES;
            self.uiImgView1Second.hidden = YES;
            self.uiImgView2Second.hidden = YES;
            self.uiLabSecond.hidden = YES;
        }
    }
}

@end
