//
//  MyEStationCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyEStationCollectionViewCell : UICollectionViewCell


+(NSString*)ID;

-(void)initCellData:(EStation*)station;

@end
