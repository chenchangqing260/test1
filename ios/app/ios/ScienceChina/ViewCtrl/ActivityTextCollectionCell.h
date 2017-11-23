//
//  ActivityTextCollectionCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/7/13.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScienceActivity.h"

@interface ActivityTextCollectionCell : UICollectionViewCell

+(NSString*)ID;
-(void)setCellWithScienceActivity:(ScienceActivity*)sa showSpace:(BOOL)showSpace;

@end
