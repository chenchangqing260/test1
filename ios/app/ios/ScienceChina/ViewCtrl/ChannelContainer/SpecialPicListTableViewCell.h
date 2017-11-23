//
//  SpecialPicListTableViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "BaseTableViewCell.h"

@interface SpecialPicListTableViewCell : BaseTableViewCell
+(NSString*)ID;
+(SpecialPicListTableViewCell *)newCell;
-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace;
@end
