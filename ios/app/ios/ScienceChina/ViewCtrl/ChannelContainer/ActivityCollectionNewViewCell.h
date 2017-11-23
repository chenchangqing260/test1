//
//  ActivityCollectionNewViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"


@interface ActivityCollectionNewViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithScienceActivity:(HomeModel*)sa indexPath:(NSIndexPath*)indexPath showSpace:(BOOL)showSpace;
@end
