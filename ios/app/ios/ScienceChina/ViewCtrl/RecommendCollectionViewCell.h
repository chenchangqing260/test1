//
//  RecommendCollectionViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoObj.h"

@interface RecommendCollectionViewCell : UICollectionViewCell

+(NSString*)ID;

-(void)initCellData:(InfoObj*)model;

@end
