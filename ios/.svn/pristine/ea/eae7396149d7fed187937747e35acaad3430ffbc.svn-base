//
//  IndexBannerCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "IndexBannerCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeModel.h"

@interface IndexBannerCollectionViewCell()<SDCycleScrollViewDelegate>


@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleScrollViewHeight;

@end

@implementation IndexBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 180 / kWIDTH_375;
    [_cycleScrollView setCurrentPageDotColor:[UIColor whiteColor]];
    [_cycleScrollView setPageDotColor:[UIColor whiteColor]];
    
    _cycleScrollView.pageDotColor =[UIColor whiteColor];
    _cycleScrollView.currentPageDotColor =[UIColor whiteColor];
}

+(NSString*)ID{
    return @"IndexBannerCollectionViewCell";
}

- (void)setCycleSAList:(NSMutableArray *)cycleSAList{
    _cycleSAList = cycleSAList;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    NSMutableArray *_titlesArry = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(HomeModel* sa in cycleSAList){
        [_titlesArry addObject:sa.ni_title];
        [urlArray addObject:sa.ni_img_url];
    }
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"ellipse_white"];
//    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"ellipse_yellow"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"icon_banner_normal"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
//    _cycleScrollView.titlesGroup = _titlesArry;

    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.currentPageDotColor = [UIColor greenColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView.pageControlBottomOffset = 0;
//    _cycleScrollView.pageControlBottomOffset = 25;
    _cycleScrollView.pageControlDotSize = CGSizeMake(15, 3.5);
    _cycleScrollView.autoScrollTimeInterval  = 5;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated; //一定要设置成这个模式
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
