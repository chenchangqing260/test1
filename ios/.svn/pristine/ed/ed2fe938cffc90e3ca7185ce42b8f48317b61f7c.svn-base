//
//  SpecialBannerCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/15.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialBannerCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeModel.h"

@interface SpecialBannerCollectionViewCell()<SDCycleScrollViewDelegate>


@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleScrollViewHeight;

@end

@implementation SpecialBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_cycleScrollView setCurrentPageDotColor:[UIColor whiteColor]];
    [_cycleScrollView setPageDotColor:[UIColor whiteColor]];
    
    _cycleScrollView.pageDotColor =[UIColor whiteColor];
    _cycleScrollView.currentPageDotColor =[UIColor whiteColor];
}

+(NSString*)ID{
    return @"SpecialBannerCollectionViewCell";
}

- (void)setCycleSAList:(NSMutableArray *)cycleSAList{
    _cycleSAList = cycleSAList;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    NSMutableArray *_titlesArry = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(HomeModel* sa in cycleSAList){
        [urlArray addObject:sa.ni_img_url];
        [_titlesArry addObject:sa.ni_title];
    }
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
    _cycleScrollView.titlesGroup = _titlesArry;
    _cycleScrollView.showPageControl = YES;
     _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}

// 处理数据
-(void)setCellData{
    if (!_cycleSAList || _cycleSAList.count == 0) {
        // 没有轮播图
        self.cycleScrollView.hidden = YES;
    }else{
        self.cycleScrollView.hidden = NO;
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
