//
//  SpecialNoneCollectionCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScienceActivity.h"

@interface SpecialNoneCollectionCell : UICollectionViewCell

+(NSString*)ID;
-(void)setCellDataWithSpecialActivity:(ScienceActivity*)spsa;

@end
