//
//  SpecialFirstNewCollectionCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/28.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpecialFirstNewCollectionCellDelegate <NSObject>

- (void)clickSBtn:(ScienceActivity*)spsa SA:(ScienceActivity*)sa;
- (void)clickABtn:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath;

@end

@interface SpecialFirstNewCollectionCell : UICollectionViewCell

+(NSString*)ID;
@property (nonatomic, weak)id<SpecialFirstNewCollectionCellDelegate> delegate;
-(void)setCellDataWithSpecialActivity:(ScienceActivity*)spsa SpecialActivity:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath showTitle:(BOOL)showTitle;

@end
