//
//  PicTextInfoCollectionViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

#define IMAGE_OFFSET_SPEED 20

@interface PicTextInfoCollectionViewCell : UICollectionViewCell

///*
// Image will always animate according to the imageOffset provided. Higher the value means higher offset for the image
// */
//@property (nonatomic, assign, readwrite) CGPoint imageOffset;

+(NSString*)ID;

-(void)initCellData:(HomeModel*)model;

@end
