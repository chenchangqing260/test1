//
//  MyMoreStationCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyMoreStationCollectionViewCellDelegate <NSObject>

-(void)clickMoreStation;

@end

@interface MyMoreStationCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)id<MyMoreStationCollectionViewCellDelegate> delegate;

+(NSString*)ID;

@end
