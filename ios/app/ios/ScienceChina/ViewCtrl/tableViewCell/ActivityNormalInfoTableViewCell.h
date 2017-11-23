//
//  ActivityNormalInfoTableViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/12.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ActivityNormalInfoTableViewCell : BaseTableViewCell
+(NSString*)ID;
+(ActivityNormalInfoTableViewCell *)newCell;
-(void)setCellWithScienceActivityData:(ScienceActivity*)sa;
@end
