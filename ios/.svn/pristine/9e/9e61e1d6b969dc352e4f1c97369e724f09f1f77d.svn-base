//
//  ActivityBannerCollectionCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/7/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScienceActivity.h"

@protocol ActivityBannerCellCycleDelegate <NSObject>

- (void)clickCycleWithImageURL:(ScienceActivity*)sa;
- (void)clickHotBtn;
- (void)clickLatestBtn;
- (void)clickSpecialBtn;

@end

@interface ActivityBannerCollectionCell : UICollectionViewCell

@property (nonatomic, strong)NSMutableArray* cycleSAList;
@property (nonatomic, weak)id<ActivityBannerCellCycleDelegate> delegate;

+(NSString*)ID;
-(void)setCellData;

@end
