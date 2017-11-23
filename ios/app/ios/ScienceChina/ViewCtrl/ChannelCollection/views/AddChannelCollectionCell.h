//
//  AddChannelCollectionCell.h
//  ScienceChina
//
//  Created by xuanyj on 16/12/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupListModel.h"
#define AddChannelCollectionCellHeight 180.0


@protocol AddChannelCollectionCellDelegate <NSObject>
-(void)didSelectIndex:(NSIndexPath *)index isattention:(BOOL)isattention;
@end
@interface AddChannelCollectionCell : UICollectionViewCell
@property (nonatomic,assign) id<AddChannelCollectionCellDelegate>delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
+(NSString *)ID;
-(void)setcellModel:(GroupListDetailModel *)model;
@end
