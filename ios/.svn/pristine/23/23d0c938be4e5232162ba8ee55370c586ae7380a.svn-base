//
//  SpecialIndexBannerCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/30.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialIndexBannerCollectionViewCell.h"
#import "SDCycleScrollView.h"

@interface SpecialIndexBannerCollectionViewCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCycleScrollViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *UiimageView;
@property (weak, nonatomic) IBOutlet UILabel *UILabel;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation SpecialIndexBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.conCycleScrollViewHeight.constant = kSCREEN_WIDTH * 175 / kWIDTH_375;
    
    
}

+(NSString*)ID{
    return @"SpecialIndexBannerCollectionViewCell";
}

- (void)setCycleSAList:(NSMutableArray *)cycleSAList{
    _cycleSAList = cycleSAList;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    NSMutableArray* titleArray = [NSMutableArray new];
    for(HomeModel* sa in cycleSAList){
        [urlArray addObject:sa.ni_img_url];
        if (sa.ni_title) {
            [titleArray addObject:sa.ni_title];
        }else{
            [titleArray addObject:@""];
        }
    }
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.showPageControl = NO;
    _cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:14.0];
    _cycleScrollView.titleLabelHeight = 30.0;
    _cycleScrollView.titleLabelBackgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRightTop;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.autoScrollTimeInterval = 5;
    
    //创建下方页数标签
    [_cycleScrollView createIndexLabel];
    
//    _pageNum = cycleSAList.count;
//    _cycleScrollView.delegate = self;
//     _cycleScrollView.showPageControl = NO;
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
//    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
//    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
    _cycleScrollView.titlesGroup = titleArray;
//
//    _cycleScrollView.autoScrollTimeInterval = 5;
//
//    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRightTop;
//    //创建下方页数标签
//    [_cycleScrollView createIndexLabel];
}

// 处理数据
-(void)setCellData:(NSString*)desc image_url:(NSString*)image_url cycleSAList:(NSMutableArray *)cycleSAList{

    [self.UiimageView sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    self.UILabel.text = desc;
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
    HomeModel* sa = [_cycleSAList objectAtIndex:index];
    [self.delegate clickCycleWithImageURL:sa];
}


@end
