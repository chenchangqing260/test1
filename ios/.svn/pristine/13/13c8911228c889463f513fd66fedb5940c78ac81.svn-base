//
//  ActivityCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol ActivityCollectionViewCellCycleDelegate <NSObject>

- (void)clickBtn:(HomeModel*)sa indexPath:(NSIndexPath*)indexPath;

@end

@interface ActivityCollectionViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithScienceActivity:(HomeModel*)sa indexPath:(NSIndexPath*)indexPath showSpace:(BOOL)showSpace;
@property (nonatomic, weak)id<ActivityCollectionViewCellCycleDelegate> delegate;
@end
