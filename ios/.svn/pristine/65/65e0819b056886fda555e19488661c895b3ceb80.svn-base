//
//  TopicSubItemCycleTableCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicSubItemCycleTableCell.h"
#import "SDCycleScrollView.h"

@interface TopicSubItemCycleTableCell()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

@end

@implementation TopicSubItemCycleTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"TopicSubItemCycleTableCell";
}

+(TopicSubItemCycleTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"TopicSubItemCycleTableCell" owner:nil options:nil][0];
}

- (void)setImageURLs:(NSMutableArray *)imageURLs{
    _imageURLs = imageURLs;
    // 1、将数据处理成需要的URL
    NSMutableArray* urlArray = [NSMutableArray new];
    for(NSString* imgurl in imageURLs){
        [urlArray addObject:imgurl];
    }
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.imageURLStringsGroup = urlArray;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSString* imgURL = [_imageURLs objectAtIndex:index];
    [self.delegate clickCycleWithImageURL:imgURL];
}

@end
