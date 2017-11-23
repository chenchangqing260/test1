//
//  ThirdShareHandler.h
//  ScienceLife
//
//  Created by Ellison on 16/3/23.
//  Copyright © 2016年 WangJensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareModel.h"

typedef enum {ShareQQ=0,ShareQQZone=1,ShareWeiXin=2,ShareWXPengyouquan=3,ShareWeibo=4,ShareFB=5} ShareThirdPart;

@protocol ThirdShareDelegate <NSObject>

@required
- (void)didShareCompleted:(BOOL)succeed;

@end

@interface ThirdShareHandler : NSObject

@property (nonatomic,weak) id<ThirdShareDelegate> delegate;

+ (instancetype)sharedInstance;
- (BOOL)shareTo:(ShareThirdPart)thirdParty ShareModel:(ShareModel*)shareModel;

@end
