//
//  PicAndWenCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface PicAndWenCollectionViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace  zhuanti:(BOOL)isZhuanti hmType:(NSString*)hmtype ;
//- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize;
@end
