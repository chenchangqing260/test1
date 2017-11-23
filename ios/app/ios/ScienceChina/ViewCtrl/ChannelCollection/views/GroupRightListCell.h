//
//  GroupRightListCell.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupListModel.h"

@protocol GroupRightListCellDelete <NSObject>
-(void)saveDataWithMainMdel:(GroupListModel *)mainmodel subMdel:(GroupListDetailModel *)submodel leftSelectedIndex:(NSInteger)leftselectindex rightSelectedIndex:(NSInteger)rightselectindex isAttention:(BOOL)isAttention;
@end


@interface GroupRightListCell : UITableViewCell
@property(nonatomic,assign)id<GroupRightListCellDelete>delegate;
+(NSString*)ID;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier screenWidth:(CGFloat)screenWidth;
//-(void)setcellWithModel:(GroupListDetailModel *)model;
-(void)setcellWithMainMdel:(GroupListModel *)mainmodel subMdel:(GroupListDetailModel *)submodel leftSelectedIndex:(NSInteger)index rightSelectedIndex:(NSInteger)rightindex;
@end
