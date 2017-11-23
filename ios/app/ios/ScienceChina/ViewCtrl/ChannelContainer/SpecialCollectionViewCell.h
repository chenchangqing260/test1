//
//  SpecialCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface SpecialCollectionViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithScienceSpecial:(HomeModel*)sa showSpace:(BOOL)showSpace;
@end
