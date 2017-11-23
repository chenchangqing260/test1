//
// 非 科普员
//  GetRewardsCellForNonVolunteer.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrizesInfoModel.h"

@protocol GetRewardsCellForNonVolunteerDelegate <NSObject>
-(void)getRewardWithModel:(PrizesInfoModel *)model;
@end

@interface GetRewardsCellForNonVolunteer : UITableViewCell
@property (nonatomic,assign) id<GetRewardsCellForNonVolunteerDelegate>delegate;
+(NSString *)ID;
-(void)setCellWithModel:(PrizesInfoModel *)model currentMonthScore:(NSString *)currentMonthScore isVolunteerData:(BOOL)isVolunteerData isVolunteerUser:(BOOL)isVolunteerUser;
@end
