//
//  AddChannelCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupListModel.h"
#define AddChannelCollectionCellHeight 123.0

@protocol AddChannelCollectionViewCellDelegate <NSObject>
-(void)didSelectIndex:(NSIndexPath *)index isattention:(BOOL)isattention;
@end
@interface AddChannelCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) id<AddChannelCollectionViewCellDelegate>delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
+(NSString *)ID;
-(void)setcellModel:(GroupListDetailModel *)model;
@end
