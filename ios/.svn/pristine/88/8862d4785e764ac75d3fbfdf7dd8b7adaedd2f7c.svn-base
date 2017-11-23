//
//  IndexBannerTableCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "IndexBannerTableCell.h"

#import "IndexBannerCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeModel.h"

@interface IndexBannerTableCell()<SDCycleScrollViewDelegate>


@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleScrollViewHeight;

@end

@implementation IndexBannerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 180 / kWIDTH_375;
}

+(NSString*)ID{
    return @"IndexBannerTableCell";
}

+(IndexBannerTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"IndexBannerTableCell" owner:nil options:nil][0];
}

- (void)setCycleSAList:(NSMutableArray *)cycleSAList{
    _cycleSAList = cycleSAList;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    //    NSMutableArray* titleArray = [NSMutableArray new];
    for(HomeModel* sa in cycleSAList){
        [urlArray addObject:sa.ni_img_url];
        //        if (sa.ni_title) {
        //            [titleArray addObject:sa.ni_title];
        //        }else{
        //            [titleArray addObject:@""];
        //        }
    }
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
    //    _cycleScrollView.titlesGroup = titleArray;
}

// 处理数据
-(void)setCellData{
    if (!_cycleSAList || _cycleSAList.count == 0) {
        // 没有轮播图
        self.cycleScrollView.hidden = YES;
        self.conCycleScrollViewHeight.constant = 0;
    }else{
        self.cycleScrollView.hidden = NO;
        self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 180 / kWIDTH_375;
    }
    [self layoutIfNeeded];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HomeModel* sa = [_cycleSAList objectAtIndex:index];
    [self.delegate clickCycleWithImageURL:sa];
}


@end

