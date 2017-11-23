//
//  SpecialBannerCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/15.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol SpecialBannerCollectionViewCellCycleDelegate <NSObject>
- (void)clickCycleWithImageURL:(HomeModel*)sa;

@end

@interface SpecialBannerCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)NSMutableArray* cycleSAList;
@property (nonatomic, weak)id<SpecialBannerCollectionViewCellCycleDelegate> delegate;

+(NSString*)ID;
-(void)setCellData;
@end
