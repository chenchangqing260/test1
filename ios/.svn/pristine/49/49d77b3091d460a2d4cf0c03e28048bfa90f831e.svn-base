//
//  SpecialFirstCollectionCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScienceActivity.h"

@protocol SpecialFirstCollectionCellDelegate <NSObject>

- (void)clickSBtn:(ScienceActivity*)spsa SA:(ScienceActivity*)sa;
- (void)clickABtn:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath;

@end

@interface SpecialFirstCollectionCell : UICollectionViewCell

+(NSString*)ID;
@property (nonatomic, weak)id<SpecialFirstCollectionCellDelegate> delegate;
-(void)setCellDataWithSpecialActivity:(ScienceActivity*)spsa SpecialActivity:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath showTitle:(BOOL)showTitle;

@end
