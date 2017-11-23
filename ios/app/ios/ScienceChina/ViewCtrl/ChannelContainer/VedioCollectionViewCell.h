//
//  VedioCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface VedioCollectionViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace  hmType:(NSString*)hmtype;
@end
