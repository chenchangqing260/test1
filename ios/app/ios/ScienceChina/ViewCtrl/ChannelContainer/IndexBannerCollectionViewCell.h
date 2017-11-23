//
//  IndexBannerCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol IndexBannerCollectionViewCellCycleDelegate <NSObject>
- (void)clickCycleWithImageURL:(HomeModel*)sa;

@end

@interface IndexBannerCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)NSMutableArray* cycleSAList;
@property (nonatomic, weak)id<IndexBannerCollectionViewCellCycleDelegate> delegate;

+(NSString*)ID;
-(void)setCellData;
@end
