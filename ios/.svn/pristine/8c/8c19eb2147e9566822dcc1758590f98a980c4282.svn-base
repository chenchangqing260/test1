//
//  EStationListHeaderCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationListHeaderCell.h"
#import "SDCycleScrollView.h"
#import "EStationRank.h"

@interface EStationListHeaderCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

@end

@implementation EStationListHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"EStationListHeaderCell";
}

+(EStationListHeaderCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationListHeaderCell" owner:nil options:nil][0];
    
}

- (void)setImageURLs:(NSMutableArray *)imageURLs{
    _imageURLs = imageURLs;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    for(EStationRank* rank in imageURLs){
        [urlArray addObject:rank.sr_img_url];
    }
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
}

#pragma mark - 点击事件
- (IBAction)clickRemenBtn:(id)sender {
    [self.delegate selectEStationListWithType:Remen];
}

- (IBAction)clickYouquBtn:(id)sender {
    [self.delegate selectEStationListWithType:Youqu];
}

- (IBAction)ClickXinxianBtn:(id)sender {
    [self.delegate selectEStationListWithType:Xinxian];
}

- (IBAction)clickFenleiBtn:(id)sender {
    [self.delegate selectEStationListWithType:Fenlei];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    EStationRank* rank = [_imageURLs objectAtIndex:index];
    [self.delegate clickStationRank:rank];
}

@end
