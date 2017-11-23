//
//  MemberManager.h
//  passbook
//
//  Created by Ellison on 16/2/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"
#import "CommonTypes.h"
#import "Score.h"

@interface MemberManager : NSObject
@property (nonatomic,strong)Score * score;

//@property (nonatomic) FontSize preferedFontSize;

+ (instancetype)sharedInstance;

- (void)cacheMemberInfoWithMember:(Member*) member;

- (Member*)getMember;
- (Score *)getScore;

- (NSString*)memberId;

- (BOOL)isLogined;

- (void)updateCacheLoginCredentialForUser:(Member *)member;

- (void)logout;

@end
