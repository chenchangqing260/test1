//
//  ActivityBannerCollectionCell.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityBannerCollectionCell.h"
#import "SDCycleScrollView.h"

@interface ActivityBannerCollectionCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleScrollViewHeight;

@end

@implementation ActivityBannerCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 175 / kWIDTH_375;
}

+(NSString*)ID{
    return @"ActivityBannerCollectionCell";
}

- (void)setCycleSAList:(NSMutableArray *)cycleSAList{
    _cycleSAList = cycleSAList;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    NSMutableArray* titleArray = [NSMutableArray new];
    for(ScienceActivity* sa in cycleSAList){
        [urlArray addObject:sa.image_name];
        if (sa.title) {
            [titleArray addObject:sa.title];
        }else{
            [titleArray addObject:@""];
        }
    }
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
    _cycleScrollView.titlesGroup = titleArray;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentTop;
     _cycleScrollView.autoScrollTimeInterval = 5;
}

// 处理数据
-(void)setCellData{
    if (!_cycleSAList || _cycleSAList.count == 0) {
        // 没有轮播图
        self.cycleScrollView.hidden = YES;
        self.conCycleScrollViewHeight.constant = 0;
    }else{
        self.cycleScrollView.hidden = NO;
        self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 184 / kWIDTH_375;
    }
    [self layoutIfNeeded];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ScienceActivity* sa = [_cycleSAList objectAtIndex:index];
    [self.delegate clickCycleWithImageURL:sa];
}

#pragma mark - 点击事件
- (IBAction)clickLatestBtn:(id)sender {
    [self.delegate clickLatestBtn];
}

- (IBAction)clickHotBtn:(id)sender {
    [self.delegate clickHotBtn];
}

- (IBAction)clickSpecialBtn:(id)sender {
    [self.delegate clickSpecialBtn];
}

@end
