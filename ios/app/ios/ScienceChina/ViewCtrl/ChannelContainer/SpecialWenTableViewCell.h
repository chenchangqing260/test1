//
//  SpecialWenTableViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/15.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface SpecialWenTableViewCell : UITableViewCell
+(NSString*)ID;
+(SpecialWenTableViewCell *)newCell;
-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace;
@end
