//
//  AddChannelViewController.h
//  ScienceChina
//
//  Created by touf on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "estationDataModel.h"

@protocol returnDataDelegate <NSObject>
- (void)returnWithArr:(NSMutableArray *)arr;
@end

@interface AddChannelViewController : BaseViewController
@property (strong, nonatomic) NSMutableArray *HadSelectChannel;
@property (strong, nonatomic) NSMutableArray *AllChannel;
@property (strong, nonatomic) estationDataModel *estationmodel;
@property (strong, nonatomic) id<returnDataDelegate> delegate;
@property (strong, nonatomic) NSString *or_id;

@property (assign, nonatomic) int saveDataTag;//1:保存基站申请，2:保存频道修改

@end
