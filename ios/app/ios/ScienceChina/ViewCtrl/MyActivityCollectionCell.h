//
//  MyActivityCollectionCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/7/25.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActivityCollectionCell : UICollectionViewCell

+(NSString*)ID;
-(void)setCellDataWithActivity:(ScienceActivity*)sa;

@end
