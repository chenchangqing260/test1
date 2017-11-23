//
//  SpecialVedioTableViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "HomeModel.h"

@interface SpecialVedioTableViewCell : BaseTableViewCell
+(NSString*)ID;
+(SpecialVedioTableViewCell *)newCell;
-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace;
@end
