//
//  VideoRecCollectionViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoObj.h"

@interface VideoRecCollectionViewCell : UICollectionViewCell

+(NSString*)ID;
-(void)initCellData:(InfoObj*)info;

@end
