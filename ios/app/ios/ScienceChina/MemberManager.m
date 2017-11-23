//
//  MemberManager.m
//  passbook
//
//  Created by Ellison on 16/2/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MemberManager.h"

@interface MemberManager()

@property (nonatomic,strong)Member* member;


@end

@implementation MemberManager

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (!instance) {
            instance = [MemberManager new];
        }
    });
    
    return instance;
}

- (void)cacheMemberInfoWithMember:(Member*) member{
    _member = member;
}

- (Member*)getMember{
    return _member;
}
- (Score*)getScore{
    return _score;
}
- (NSString*)memberId{
    if (_member) {
        return _member.member_id;
    }else{
        return @"";
    }
}

- (BOOL)isLogined{
    return _member ? YES : NO;
}

- (void)updateCacheLoginCredentialForUser:(Member *)member
{
    [self updateCacheLoginCredentialWithTelephone:member.member_account password:member.member_password channel:member.channel autocode:member.autocode memberName:member.member_name memberURL:member.img_url];
}

- (void)updateCacheLoginCredentialWithTelephone:(NSString *)telephone password:(NSString *)password channel:(NSString*)channel autocode:(NSString*)autocode memberName:(NSString*)memberName memberURL:(NSString*)memberURL{
    NSDictionary *loginCredential = @{@"account":telephone?telephone:@"",@"password":password?password:@"",@"channel":channel,@"autocode":autocode?autocode:@"",@"memberName":memberName,@"memberURL":memberURL};
    [[NSUserDefaults standardUserDefaults] setObject:loginCredential forKey:kUserDefaultKeyLoginCredential];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)logout
{
    self.member = nil;
    self.score = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyLoginCredential];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 刷新我的页面数据数据
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCollectionData" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
}
@end
