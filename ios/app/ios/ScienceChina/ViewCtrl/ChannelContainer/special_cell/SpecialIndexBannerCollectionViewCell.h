//
//  SpecialIndexBannerCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/30.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol SpecialIndexBannerCollectionViewCellCycleDelegate <NSObject>

- (void)clickCycleWithImageURL:(HomeModel*)sa;

@end

@interface SpecialIndexBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)NSMutableArray* cycleSAList;
@property (nonatomic, weak)id<SpecialIndexBannerCollectionViewCellCycleDelegate> delegate;

+(NSString*)ID;
-(void)setCellData:(NSString*)desc image_url:(NSString*)image_url cycleSAList:(NSMutableArray *)cycleSAList;

@end
