//
//  PicDetailCollectionViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PicDetailCollectDelegate <NSObject>

- (void)showPhotoBrowserIndex:(NSInteger)index;

@end

@interface PicDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<PicDetailCollectDelegate> delegate;

+(NSString*)ID;

-(void)initCellData:(InfoObj*)model index:(NSInteger)index totalCount:(NSInteger)totalCount;

@end
