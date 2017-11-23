//
//  QuesMainHeaderCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/31.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "QuesMainHeaderCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "RecList.h"

@interface QuesMainHeaderCollectionViewCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleViewHeight;

@end

@implementation QuesMainHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat showWidth = kSCREEN_WIDTH;
    CGFloat leftEdge = 0;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
    }
    self.conCycleViewHeight.constant = showWidth * 170 / kWIDTH_375;
    [self layoutIfNeeded];
    
}

+(NSString*)ID{
    return @"QuesMainHeaderCollectionViewCell";
}

- (void)setQuesRecList:(NSMutableArray *)quesRecList{
    if (quesRecList && quesRecList.count > 0) {
        CGFloat showWidth = kSCREEN_WIDTH;
        CGFloat leftEdge = 0;
        if (isIpad) {
            showWidth = MAIN_SCREEN_WIDTH_ONIpad;
            leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        }
        
        self.conCycleViewHeight.constant = kSCREEN_WIDTH * 170 / kWIDTH_375;
        _quesRecList = quesRecList;
        NSMutableArray* urlArray = [NSMutableArray new];
        NSMutableArray* titleArray = [NSMutableArray new];
        
        for(RecList* rec in quesRecList){
            [urlArray addObject:rec.qu_img];
            
            if (rec.qu_title) {
                [titleArray addObject:rec.qu_title];
            }else{
                [titleArray addObject:@""];
            }
        }
        
        _cycleScrollView.delegate = self;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
        _cycleScrollView.imageURLStringsGroup = urlArray;
        _cycleScrollView.autoScrollTimeInterval  = 5;
        
        if (self.quesRecList && self.quesRecList.count > 0) {
            RecList* rec = [self.quesRecList objectAtIndex:0];
            self.uiTitleLab.text = rec.qu_title;
        }
    }else{
        self.conCycleViewHeight.constant = 0;
        [self layoutIfNeeded];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.delegate clickQuestionBainnerAction:[_quesRecList objectAtIndex:index]];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    RecList* rec = [self.quesRecList objectAtIndex:index];
    self.uiTitleLab.text = rec.qu_title;
}

#pragma mark - 点击事件(手势和按钮)
- (IBAction)clickAskQuesBtnAction:(id)sender {
    [self.delegate clickAskQuesBtnAction];
}

- (IBAction)clickMyQuesBtnAction:(id)sender {
    [self.delegate clickMyQuesBtnAction];
}

- (IBAction)clickMyAnswerBtnAction:(id)sender {
    [self.delegate clickMyAnswerBtnAction];
}


@end
