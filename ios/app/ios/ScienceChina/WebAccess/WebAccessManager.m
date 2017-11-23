//
//  WebAccessManager.m
//  hxz
//
//  Created by Ellison Xu on 15/9/17.
//  Copyright (c) 2015年 Sevenplus. All rights reserved.
//

#import "WebAccessManager.h"
#import "NSString+Util.h"
#import "RestClient.h"
#import "NSString+Util.h"
#import<CommonCrypto/CommonDigest.h>

#define kRows 30

@interface WebAccessManager()

@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, strong) NSString *sessionMemberId;

@end

@implementation WebAccessManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (!instance) {
            instance = [WebAccessManager new];
        }
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.restClient = [RestClient new];
    }
    
    return self;
}

- (NSString *)webServiceUrl
{
    //    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //    NSString* changeTest = [settings objectForKey:kUserDefaultKeyChangeTest]; 
    //    if (changeTest && [changeTest isEqualToString:@"test"]) {
    //        // 测试环境
            return @"http://180.76.182.57/zgkp/api/";
    //    }else{
    // 正式环境
//    return @"http://chinaapp.kexuenet.com/api/";
    //    }
//
//         return @"http://192.168.8.28:8080/zgkp/api/";
    
    
    //return @"http://192.168.8.28:8080/zgkp/api/";
    //return @"http://115.29.229.124:8989/zgkp/web/";
    //return @"http://192.168.8.248:7080/zgkp/api/";
    
    //return @"http://112.25.172.205:9080/zgkp/api/";
    //return @"http://180.76.182.57:80/zgkp/api/";
    //return @"http://192.168.8.28:7080/zgkp/api/";
    
}

//活动分享h5
- (NSString *)ActivityServiceUrl
{
    // 测试环境
//    return @"http://kpy.kexuenet.com";

    // 正式环境
    return @"http://api.kepuchina.cn";
    
}

- (NSString *)webWithOutServiceUrl{
    //    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //    NSString* changeTest = [settings objectForKey:kUserDefaultKeyChangeTest];
    //    if (changeTest && [changeTest isEqualToString:@"test"]) {
    // 测试环境
            return @"http://180.76.182.57/zgkp/";
    //    }else{
    //        // 正式环境
//    return @"http://chinaapp.kexuenet.com/";
    //    }
    
//         return @"http://192.168.8.28:8080/zgkp/api/";
    
//        return @"http://192.168.8.28:8080/zgkp/";
    //return @"http://115.29.229.124:8989/zgkp/";
    //return @"http://192.168.8.248:7080/zgkp/api/";
    
    //return @"http://112.25.172.205:9080/zgkp/";
    //    return @"http://180.76.182.57:80/zgkp/";
}

- (NSURL *)buildUrlWithPath:(NSString *)path queryParameters:(NSDictionary *)parameters
{
    NSString *url = [NSString stringWithFormat:@"%@%@",[self webServiceUrl], path];
    return [self buildUrlWithUrl:url queryParameters:parameters];
}

- (NSURL *)buildUrlWithUrl:(NSString *)urlStr queryParameters:(NSDictionary *)parameters
{
    NSMutableString *queryString = [NSMutableString new];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [queryString appendFormat:@"%@=%@&",[key description],[[obj description]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }];
    if (queryString.length > 0) {
        NSRange lastCharacterRange;
        lastCharacterRange.location = queryString.length - 1;
        lastCharacterRange.length = 1;
        [queryString deleteCharactersInRange:lastCharacterRange];
    }
    
    NSMutableString *urlString = [NSMutableString new];
    [urlString appendString:urlStr];
    if (parameters.count > 0) {
        [urlString appendFormat:@"?%@", queryString];
    }
    
    return [NSURL URLWithString:urlString];
}

#pragma mark - 用户相关
// 获取验证码
- (void)getVerifyCodeWithTelephone:(NSString*)telephone  type:(NSString*)type completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"telephone":telephone, @"type":type};
    
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/hqyzm" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取验证码 -md5加密
- (void)getVerifyCodeNewWithTelephone:(NSString*)telephone  type:(NSString*)type completion:(void (^)(WebResponse*, NSError *))completion{
    
    long long now_timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    int r = arc4random() % 1000;
    NSString* currentDateStr= [NSString stringWithFormat:@"%lld%u", now_timestamp, r];
    
    NSString* string = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@", @"telephone=",telephone,@"&timestamp=",currentDateStr,@"&type=",type,@"&app_secret=pj34wmse2j1xqq2ogy3mtzuhve3d9ds9"];
    
    NSString *result = [[self md5:string] uppercaseString];
    
    NSDictionary *dict = @{@"telephone":telephone, @"type":type, @"sign":result, @"timestamp":currentDateStr};
    
    NSURL *url = [self buildUrlWithPath:@"baseInfoApi/sendSms" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}


- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
// 登录
- (void)loginWithTelephone:(NSString *)telephone password:(NSString *)password completion:(void (^)(WebResponse*, NSError *))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:telephone forKey:@"telephone"];
    [dict setObject:password forKey:@"member_password"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/toLogin" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 第三方登录 0-QQ、1-微信、2-微博
- (void)loginWithThirdPartyWithChannel:(NSString*)channel authcode:(NSString*)authcode memberName:(NSString*)memberName imageURL:(NSString*)imageURL completion:(void (^)(WebResponse*, NSError *))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:channel forKey:@"channel"];
    [dict setObject:authcode forKey:@"authcode"];
    
    if (memberName && ![memberName isEmptyOrWhitespace]) {
        [dict setObject:memberName forKey:@"member_name"];
    }
    
    if (imageURL && ![imageURL isEmptyOrWhitespace]) {
        [dict setObject:imageURL forKey:@"img_url"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/thirdPartylogin" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//注册
-(void)registerWithTelephone:(NSString *)telephone password:(NSString *)password code:(NSString*)code completion:(void (^)(WebResponse *, NSError *))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:telephone forKey:@"telephone"];
    [dict setObject:password forKey:@"member_password"];
    [dict setObject:code forKey:@"code"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/registerMember" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//忘记密码
- (void)forgetPasswordWithTelephone:(NSString *)telephone pwd:(NSString *)pwd code:(NSString*)code completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"telephone":telephone,
                           @"new_pwd":pwd,
                           @"code":code};
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/retrievePassWord" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//修改密码
- (void)changePasswordWithMemberID:(NSString *)MemberID oldPwd:(NSString *)oldPwd newPaw:(NSString *)newPwd completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"member_id":MemberID,@"new_pwd":newPwd,@"old_pwd":oldPwd};
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/changePassWord" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获得分享APP
- (void)getAppShareModelWithCompletion:(void (^)(WebResponse*, NSError *))completion{
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getAppShareInfo" queryParameters:nil];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 意见反馈
- (void)feedBackWithMemberID:(NSString *)MemberID content:(NSString *)content completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"member_id":MemberID,@"content":content};
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/saveFeedback" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//修改头像
-(void)changeIconWithMemberID:(NSString *)MemberID picName:(NSString *)picName completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"member_id":MemberID,@"picName":picName};
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/updateMemberPicM" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//修改个人信息（如昵称等）
-(void)changeInformationWithMemberID:(NSString *)MemberID memberName:(NSString*)member_name completion:(void (^)(WebResponse*, NSError *))completion{
    NSDictionary *dict = @{@"member_id":MemberID,@"member_name":member_name};
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/updateMemberNameM" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取七牛token
-(void)getQiniuTokenCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"memberMobileController/getToken" queryParameters:nil];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//获取启动图片地址
-(void)getLatestLauncher:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    NSURL *url = [self buildUrlWithPath:@"launcherApi/getLatestLauncher" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark -版本
//获取版本
-(void)getLatestVersion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"uuid"];
    }
    [dict setObject:@"1" forKey:@"type"];
    NSURL *url = [self buildUrlWithPath:@"versionApi/getLatestVersion" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//获取版本
-(void)getNewLatestVersion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"uuid"];
    }
    [dict setObject:@"1" forKey:@"type"];
    NSURL *url = [self buildUrlWithPath:@"versionApi/getNewestVersion" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}



//保存用户忽略版本更新日志
-(void)saveVersionLog:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"uuid"];
    }
     [dict setObject:@"1" forKey:@"type"];
    NSURL *url = [self buildUrlWithPath:@"versionApi/saveVersionLog" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 新闻
-(void)getHomeInfoListWithPage:(NSInteger)page usePage:(NSString*)usePage completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    if (usePage && ![usePage isEmptyOrWhitespace]) {
        [dict setObject:usePage forKey:@"use_pages"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/homeInformationMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//  每日推荐三个数据
-(void)getDailyInfoListWithCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getRecommendInforMations" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据分类ID查询数据,获取频道下资讯列表
-(void)getInfoListByCategoryId:(NSString*)at_id page:(NSInteger)page showSlide:(NSString *)showSlide completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    [dict setObject:at_id forKey:@"at_id"];
    [dict setObject:showSlide forKey:@"showSlide"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getInformationMListByAtId" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}


//第四版 首页 根据分类ID查询数据,获取频道下资讯列表
-(void)getNewInfoListByCategoryId:(NSString*)at_id page:(NSInteger)page showSlide:(NSString *)showSlide rows:(long)rows completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",rows] forKey:@"rows"];
    [dict setObject:at_id forKey:@"at_id"];
    [dict setObject:showSlide forKey:@"showSlide"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSURL *url = [self buildUrlWithPath:@"newHomePage/getNewInformation" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取微信公众号频道下资讯列表
-(void)getWeiChatPublicNOListWithPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    //[dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"startIndex"];
    NSURL *url = [self buildUrlWithPath:@"weChatArticleController/queryList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}
// 获取微信公众号频道下资讯详情
-(void)getWeiChatPublicNODetailWithId:(NSString *)articleId Completion:(void(^)(WebResponse *response, NSError *error))completion{
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%@",articleId] forKey:@"id"];
    NSURL *url = [self buildUrlWithPath:@"weChatArticleController/loadHtmlById" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}


// 定制分类
-(void)collectCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:at_id forKey:@"at_id"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/saveAtCollect" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 删除定制分类
-(void)delCollectCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:at_id forKey:@"at_id"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/delAtCollect" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取分类收藏列表
-(void)getCollectCategoryListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/getAtCollectList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取分类列表
-(void)getInfoCategoryWithCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"informationTypeMobileController/informationTypeMList" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据大分类获取子分类
-(void)getSubCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSDictionary *dict = @{@"at_id":at_id};
    NSURL *url = [self buildUrlWithPath:@"informationTypeMobileController/getPullDownInforSubTypeList" queryParameters:dict];
    
    [self.restClient getWithURL:url responseClass:[WebResponse class] completion:completion];
}

-(void)getPicTextAndVideoInfoDetailWithIn_id:(NSString*)in_id showRows:(BOOL)showRows completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:in_id forKey:@"in_id"];
    if (showRows) {
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getInforMationInfos" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取更多推荐视频资讯
-(void)getVideoForRecWithInId:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:in_id forKey:@"in_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getVideoInforMationList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)loadHtmlOfPicTextWithIn_id:(NSString*)in_id font_size:(FontSize)fontSize completion:(void (^)(NSString *, NSError *))completion{
    if (fontSize == None) {
        fontSize = Normal;
    }
    NSDictionary *dict = @{@"ar_id":in_id,@"font_size":@(fontSize-1)};
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/toInforMationArticleHtml" queryParameters:dict];
    
    [self.restClient getWithURL:url responseClass:[NSString class] completion:completion];
}

-(void)loadHtmlOfVideoWithIn_id:(NSString*)in_id font_size:(FontSize)fontSize completion:(void (^)(NSString *, NSError *))completion{
    if (fontSize == None) {
        fontSize = Normal;
    }
    NSDictionary *dict = @{@"in_id":in_id,@"font_size":@(fontSize-1)};
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/toInforMationArticleContentHtml" queryParameters:dict];
    
    [self.restClient getWithURL:url responseClass:[NSString class] completion:completion];
}

// 获取图集资讯详情
-(void)getPicInfoDetailWithIn_id:(NSString*)in_id completion:(void (^)(WebResponse *, NSError *))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:in_id forKey:@"in_id"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getInforMationImgsInfo" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取我的评论列表
-(void)getMyCommentListPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"reviewMobileController/getMyReviewMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取新闻评论列表
-(void)getCommentListWithIn_id:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    if (in_id) {
        [dict setObject:in_id forKey:@"in_id"];
    }else{
        if ([MemberManager sharedInstance].isLogined) {
            [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
        }
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString* uuid = [defaults objectForKey:@"unique_identifier"];
        if (uuid) {
            [dict setObject:uuid forKey:@"unique_identifier"];
        }
    }
    NSURL *url = [self buildUrlWithPath:@"reviewMobileController/reviewMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 保存和回复评论
-(void)saveAndReplyCommentWithIn_id:(NSString*)in_id commentContent:(NSString*)commentContent parentCommentId:(NSString*)re_pid completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:commentContent forKey:@"review_content"];
    
    if (in_id) {
        [dict setObject:in_id forKey:@"in_id"];
    }
    
    if (re_pid) {
        [dict setObject:re_pid forKey:@"re_pid"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        // 登录或者匿名评论
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
        // 匿名评论
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        NSString* anony = [settings objectForKey:kUserDefaultKeyAnony];
        if (anony && [anony isEqualToString:@"YES"]) {
            // 匿名评论
            [dict setObject:@"1" forKey:@"review_type"];
        }else{
            [dict setObject:@"2" forKey:@"review_type"];
        }
    }else{
        // 游客评论
        [dict setObject:@"0" forKey:@"review_type"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"reviewMobileController/saveMReview" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 资讯点赞
-(void)saveWithR_id:(NSString*)r_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:r_id forKey:@"r_id"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"reviewMobileController/addMReviewPraiseCount" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取评论，收藏，提问数量
-(void)getQuantityStatisticsWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSDictionary *dict = @{@"member_id":[MemberManager sharedInstance].memberId};
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getQuantityStatistics" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getCollectInfoListWithPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"collectMController/informatCollectMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 收藏
-(void)saveCollectInfo:(NSString*)info_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    if (info_id) {
        [dict setObject:info_id forKey:@"in_id"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"collectMController/saveMCollect" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 取消成功
-(void)removeCollectInfo:(NSString*)info_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if (info_id) {
        [dict setObject:info_id forKey:@"ar_ids"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"collectMController/removeAllCollect" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取浏览记录
-(void)getSeeRecordWithPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    //    if ([MemberManager sharedInstance].isLogined) {
    //        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    //    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"browsingHistoryController/getBrowsingHistorytList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 清空浏览记录
-(void)cleanSeeRecordWithompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    //    if ([MemberManager sharedInstance].isLogined) {
    //        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    //    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"browsingHistoryController/delBrowsingHistory" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 专题
// 获取专题子列表
-(void)getTopicSubListWithInId:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    [dict setObject:in_id forKey:@"in_id"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getSpecialInforMationList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - E站
// 根据ID获取E站详情
-(void)getEStationById:(NSString*) si_id Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    if (si_id) {
        [dict setObject:si_id forKey:@"si_id"];
    }
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getStationInfo" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取E站分类轮播图
-(void)getEStationOfRecommendListWtihCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getHomeRecommend" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取E站列表
-(void)getEStationListWtihPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getHomeStation" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取最热，最有趣等EStation列表首页固定分类 type：0-最热门、1-最有趣、2-最新鲜E站
-(void)getEStationListOfType:(NSString*)type Page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:type forKey:@"type"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getStationListByType" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 取消关注E站
-(void)delStationWithSiId:(NSString*)si_id  Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:si_id forKey:@"si_id"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"concernController/delConcern" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    
}

// 关注E站
-(void)saveStationWithSiId:(NSString*)si_id  Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:si_id forKey:@"si_id"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"concernController/saveConcern" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取我关注的E站
-(void)getMyAttentionStationListPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getMyAttentionStationList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取E站分类列表
-(void)getEStationCategoryWithCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"stationTypeEController/stationTypeMList" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据分类ID获取E站列表
-(void)getStationByStId:(NSString*)st_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:st_id forKey:@"st_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getStationListByStId" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据分类ID获取E站排行列表
-(void)getStationRankByStId:(NSString*)st_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:st_id forKey:@"st_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/getStationListByRankListStId" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getStationInfoBySiId:(NSString*)si_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:si_id forKey:@"si_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationInformationEController/getStationInfomationList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取基站热门搜索
-(void)getHotSearchForStationWithCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"stationEController/getHotSearchList" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取资讯热门搜索
-(void)getHotSearchForInfoWithCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getHotSearchList" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据关键字搜索资讯
-(void)searchInfoByKeywork:(NSString*)query_content page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:query_content forKey:@"search_text"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"informationMobileController/getSearchInformationMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 根据关键字获取E站列表
-(void)searchStationInfoBykeyWork:(NSString*)query_content page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:query_content forKey:@"query_content"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"stationEController/queryStation" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 提问

// 获取提问轮播图
-(void)getQuestionBannerWtihCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/getRrecList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取提问列表
-(void)getQuestionListWtihTypeid:(NSString *)te_id page:(NSInteger)page memberId:(NSString*)memberId Completion:(void(^)(WebResponse *response, NSError *error))completion{
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    if (te_id) {
        [dict setObject:te_id forKey:@"te_id"];
    }
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    // 基本信息存储
    if (memberId) {
        [dict setObject:memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/getQuestionsList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//获取提问详情
-(void)getQuestionInfoWithqu_id:(NSString *)qu_id andCompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:qu_id forKey:@"qu_id"];
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/getQuestionsInfo" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    
}

-(void)saveQuestionsWithQu_title:(NSString*)qu_title qu_content:(NSString*)qu_content qu_img:(NSString*)qu_img te_id:(NSString*)te_id completion:(void(^)(WebResponse *response, NSError *error))completion;{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:qu_title forKey:@"qu_title"];
    [dict setObject:qu_content forKey:@"qu_content"];
    if (qu_img) {
        [dict setObject:qu_img forKey:@"qu_img"];
    }
    [dict setObject:te_id forKey:@"te_id"];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/saveQuestions" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    
}

// 获取提问分类列表
-(void)getQuesCategoryListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    
    // 基本信息存储
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/getTerritoryList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}


// 保存问题回复
-(void)saveQuestionsReplyWithQuId:(NSString*)qu_id qr_content:(NSString*)qr_content completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:qr_content forKey:@"qr_content"];
    
    if (qu_id) {
        [dict setObject:qu_id forKey:@"qu_id"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        // 登录或者匿名评论
        [dict setValue:[MemberManager sharedInstance].memberId forKey:@"member_id"];
        // 匿名评论
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        NSString* anony = [settings objectForKey:kUserDefaultKeyAnony];
        if (anony && [anony isEqualToString:@"YES"]) {
            // 匿名评论
            [dict setObject:@"1" forKey:@"qr_type"];
        }else{
            [dict setObject:@"2" forKey:@"qr_type"];
        }
    }else{
        // 游客评论
        [dict setObject:@"0" forKey:@"qr_type"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/saveMQuestionReply" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 点赞
-(void)addQuestionsReplyPraiseCountWithqr_id:(NSString*)qr_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:qr_id forKey:@"qr_id"];
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/addQuestionsReplyPraiseCount" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取提问列表
-(void)getQuestionReplyListWithQuId:(NSString*)qu_id memberId:(NSString*)memberId page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    if (qu_id) {
        [dict setObject:qu_id forKey:@"qu_id"];
    }else{
        [dict setValue:memberId forKey:@"member_id"];
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString* uuid = [defaults objectForKey:@"unique_identifier"];
        if (uuid) {
            [dict setObject:uuid forKey:@"unique_identifier"];
        }
    }
    
    NSURL *url = [self buildUrlWithPath:@"questionsMobileController/getRuestionReplyMList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark -  频道相关
//获取我的频道列表
-(void)getMyCategoryWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    //    if ([MemberManager sharedInstance].isLogined) {
    //        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    //    }
    
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/getMyCategory" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    
}
//获取所有的频道信息
-(void)getAllChannelListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSURL *url = [self buildUrlWithPath:@"informationTypeMobileController/informationTypeMList" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//删除一个我的频道
-(void)delAtCollectWithChannelId:(NSString *)at_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    //    if ([MemberManager sharedInstance].isLogined) {
    //        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    //    }
    [dict setObject:at_id forKey:@"at_id"];
    
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/delAtCollect" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//添加一个我的频道
-(void)saveAtCollectWithChannelId:(NSString *)at_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    //    if ([MemberManager sharedInstance].isLogined) {
    //        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    //    }
    [dict setObject:at_id forKey:@"at_id"];
    
    NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/saveAtCollect" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}
//保存我的所有频道
-(void)resetAtCollectNoWithChannelIdS:(NSArray *)atids completion:(void(^)(WebResponse *response, NSError *error))completion{
    if (atids && atids.count > 0) {
        NSString *ids = @"";
        NSString *separator = @",";
        for (int i=0; i<atids.count; i++) {
            if ([ids isEqualToString:@""]) {
                separator = @"";
            }else{
                separator = @",";
            }
            NSString *atid = atids[i];
            ids = [NSString stringWithFormat:@"%@%@%@",ids,separator,atid];
        }
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString* uuid = [defaults objectForKey:@"unique_identifier"];
        if (uuid) {
            [dict setObject:uuid forKey:@"unique_identifier"];
        }
        [dict setObject:ids forKey:@"atIdStr"];
        
        NSURL *url = [self buildUrlWithPath:@"atCollectMobileController/resetAtCollect" queryParameters:dict];
        
        [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    }
}


#pragma mark - 科普员
//提交科普员认证信息
-(void)submitSceAuthInfoWithOperator_name:(NSString *)operator_name province:(NSString *)province city:(NSString *)city area:(NSString *)area detialAddress:(NSString *)detialAddress operator_email:(NSString *)operator_email operator_tel:(NSString *)operator_tel operator_card_imag:(NSString *)operator_card_imag operator_card_imag_back:(NSString *)operator_card_imag_back referrer_tel:(NSString *)referrer_tel code:(NSString *)code completion:(void (^)(WebResponse *, NSError *))completion{
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:operator_name forKey:@"operator_name"];
    [dict setObject:province forKey:@"province"];
    [dict setObject:city forKey:@"city"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:detialAddress forKey:@"detailAddress"];
    [dict setObject:operator_email forKey:@"operator_email"];
    [dict setObject:operator_tel forKey:@"operator_tel"];
    [dict setObject:operator_card_imag forKey:@"operator_card_imag"];
    [dict setObject:operator_card_imag_back forKey:@"operator_card_imag_back"];
    if ([referrer_tel isEmptyOrWhitespace])
    {
        [dict setObject:@"" forKey:@"referrer_tel"];
    }
    else
    {
        [dict setObject:referrer_tel forKey:@"referrer_tel"];
    }
    [dict setObject:code forKey:@"code"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerApi/submitSceAuthInfo" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    
}

//提交科普员认证信息V2
-(void)submitSceAuthInfoWithOperatorV2:(NSString *)operator_name
                              province:(NSString *)province
                                  city:(NSString *)city
                                county:(NSString *)county
                                  town:(NSString *)town
                         province_code:(NSString *)province_code
                             city_code:(NSString *)city_code
                           county_code:(NSString *)county_code
                             town_code:(NSString *)town_code
                               company:(NSString *)company
                                 it_id:(NSString *)it_id
                               sc_type:(NSString *)sc_type
                        operator_email:(NSString *)operator_email
                      operator_card_no:(NSString *)operator_card_no
                    operator_telephone:(NSString *)operator_telephone
                          referrer_tel:(NSString *)referrer_tel
                                  code:(NSString *)code
                            completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:operator_name forKey:@"operator_name"];
    [dict setObject:province forKey:@"province"];
    [dict setObject:city forKey:@"city"];
    [dict setObject:county forKey:@"county"];
    [dict setObject:town forKey:@"town"];
    [dict setObject:province_code forKey:@"province_code"];
    [dict setObject:city_code forKey:@"city_code"];
    [dict setObject:county_code forKey:@"county_code"];
    [dict setObject:town_code forKey:@"town_code"];
    [dict setObject:operator_telephone forKey:@"operator_telephone"];
    
    if (!it_id || [it_id isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"it_id"];
    }else{
        [dict setObject:it_id forKey:@"it_id"];
    }
    
//    if (!address || [address isEmptyOrWhitespace]){
//        [dict setObject:@"" forKey:@"address"];
//    }else{
//        [dict setObject:address forKey:@"address"];
//    }
    
    if (!company || [company isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"company"];
    }else{
        [dict setObject:company forKey:@"company"];
    }
    
    if (!operator_email || [operator_email isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"operator_email"];
    }else{
        [dict setObject:operator_email forKey:@"operator_email"];
    }
    
    if (!sc_type || [sc_type isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"sc_type"];
    }else{
        [dict setObject:sc_type forKey:@"sc_type"];
    }
    
    if (!operator_card_no || [operator_card_no isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"operator_card_no"];
    }else{
        [dict setObject:operator_card_no forKey:@"operator_card_no"];
    }
    
    if (!referrer_tel || [referrer_tel isEmptyOrWhitespace]){
        [dict setObject:@"" forKey:@"referrer_tel"];
    }else{
        [dict setObject:referrer_tel forKey:@"referrer_tel"];
    }
    
    [dict setObject:code forKey:@"code"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/submitSciencerApply" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//根据会员ID分析用户是否是科普员
-(void)analyseMemberIsSceBycompletion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    NSURL *url = [self buildUrlWithPath:@"memberV2Api/analyseIsSciencer" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 积分相关
//获取我的积分页面数据
-(void)getMemberScoreWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    
    // 登录则跳转、判断登录方式是否是第三方登录
    NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
    NSString *channel = [loginCredential objectForKey:@"channel"];
    if (![channel isEqualToString:@"4"]) {
        // 第三方登录
        return;
    }else{
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
        
        NSURL *url = [self buildUrlWithPath:@"memberScore/getMemberScore" queryParameters:dict];
        
        [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
    }
}
//获取某年12个月的积分变化折线图数据
-(void)getScoreByYear:(NSString *)year completion:(void(^)(NSDictionary *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
    [dict setObject:year forKey:@"year"];
    
    NSURL *url = [self buildUrlWithPath:@"memberScore/getScoreByYear" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[NSDictionary class] completion:completion];
}
//获取某月积分分类饼图数据
-(void)getScoreByMonth:(NSString *)month completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
    [dict setObject:month forKey:@"month"];
    
    NSURL *url = [self buildUrlWithPath:@"memberScore/getScoreByMonth" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}
//增加积分接口
-(void)addScoreWithInfo:(ShareModel*)shareModel completion:(void(^)(WebResponse *response, NSError *error))completion{
    
    if ([MemberManager sharedInstance].isLogined) {
        // 登录则跳转、判断登录方式是否是第三方登录
        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
        NSString *channel = [loginCredential objectForKey:@"channel"];
        if (![channel isEqualToString:@"4"]) {
            // 第三方登录
            return;
        }else{
            
            if (shareModel && shareModel.share_type!=nil && ![shareModel.share_type isEqualToString:@""]) {
                
                NSString *type = shareModel.share_type;
                NSString *shareTitle = shareModel.in_share_title?shareModel.in_share_title:@"";
                
                NSMutableDictionary *dict = [NSMutableDictionary new];
                [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
                [dict setObject:type forKey:@"type"];//积分类型,增加积分的类型(01:每日登录积分 02:科普员认证 03:基站被关注 04:分享基站 05:分享文章 06:分享文章被浏览)
                [dict setObject:shareTitle forKey:@"info"];//描述信息,用于填写备注信息（如：分享文章的文章标题，可用于我的积分详情页面展示）
                
                NSURL *url = [self buildUrlWithPath:@"memberScore/addScore" queryParameters:dict];
                
                [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
            }
            
        }
        
    }
    
}

//增加分享次数
-(void)addShareCountWithInfo:(ShareModel*)shareModel completion:(void(^)(WebResponse *response, NSError *error))completion{
    if (shareModel && shareModel.share_type!=nil && ![shareModel.share_type isEqualToString:@""]) {
        
        // ===== 公共传入数据 ========
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString* uuid = [defaults objectForKey:@"unique_identifier"];
        if (uuid) {
            [dict setObject:uuid forKey:@"unique_identifier"];
        }
        
        if ([MemberManager sharedInstance].isLogined) {
            [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
        }
        // ===== 公共传入End ========
        NSString* urlStr = nil;
        if ([shareModel.share_type isEqualToString:@"04"]) {
            // 分享基站
            [dict setObject:shareModel.or_id forKey:@"or_id"];
            urlStr = @"sciencerShareApi/saveOrgShare";
        }else{
            // 分享其他
            [dict setObject:shareModel.ar_id forKey:@"ar_id"];
            urlStr = @"sciencerShareApi/saveArticleShare";
        }
        
        NSURL *url = [self buildUrlWithPath:urlStr queryParameters:dict];
        
        [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
    }
    
}

#define 领取奖励
//获取领奖页面数据
-(void)getRewardWithMonth:(NSString *)month Completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
    [dict setObject:month forKey:@"month"];
    
    NSURL *url = [self buildUrlWithPath:@"memberScore/getReward" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}

//点击领取奖品
-(void)exchangeRewardWithMonth:(NSString *)month PrizeId:(NSString *)prizeId completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[MemberManager sharedInstance].getMember.uni_code forKey:@"uni_code"];
    [dict setObject:prizeId forKey:@"prize_id"];
    [dict setObject:month forKey:@"month"];
    
    NSURL *url = [self buildUrlWithPath:@"memberScore/exchangeReward" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}

#pragma mark 我的-我的基站
//获取所有频道
-(void)getallChannelsWithCompletion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSURL *url = [self buildUrlWithPath:@"baseInfoApi/getAllChannels" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}

//获取所有基站分类
-(void)getAllOrganizationTypesWithCompletion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSURL *url = [self buildUrlWithPath:@"baseInfoApi/getAllOrganizationTypes" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}

//提交基站认证信息
-(void)submitOrgAuthInfoWithor_name:(NSString *)or_name or_desc:(NSString *)or_desc or_image_url:(NSString *)or_image_url ot_id:(NSString *)ot_id at_ids:(NSString *)at_ids Completion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    [dict setObject:or_name forKey:@"or_name"];
    [dict setObject:or_desc forKey:@"or_desc"];
    [dict setObject:or_image_url forKey:@"or_image_url"];
    [dict setObject:ot_id forKey:@"ot_id"];
    [dict setObject:at_ids forKey:@"at_ids"];
    //[dict setObject:@"ME201612261353441000" forKey:@"member_id"];
    NSURL *url = [self buildUrlWithPath:@"organizationApi/submitOrgAuthInfo" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取自己的基站id
-(void)getMyEstationWithcompletion:(void(^)(WebResponse *response, NSError *error))completion{
    NSDictionary *dict = @{@"member_id":[MemberManager sharedInstance].memberId};
    NSURL *url = [self buildUrlWithPath:@"memberApi/analyseMemberIsOrgByMemberId" queryParameters:dict];
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion];
}

// 获取基站的已选择频道
-(void)getOrgChannelsWithor_id:(NSString *)or_id completion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:or_id forKey:@"or_id"];
    
    NSURL *url = [self buildUrlWithPath:@"organizationApi/getOrgChannels" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

//修改基站频道
-(void)updateOrgChannelsWithor_id:(NSString *)or_id at_ids:(NSString *)at_ids Completion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    [dict setObject:or_id forKey:@"or_id"];
    [dict setObject:at_ids forKey:@"at_ids"];
    //[dict setObject:@"ME201612261353441000" forKey:@"member_id"];
    NSURL *url = [self buildUrlWithPath:@"organizationApi/updateOrgChannels" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取机构用户-暂停使用

-(void)getAllOrgFromYunWithCompletion:(void(^)(WebResponse* response, NSError* error)) completion{
    NSURL *url = [self buildUrlWithPath:@"institutionApi/getAllInstitutions" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取科普员类型-/baseInfoApi/getAllSciencerTypes
-(void)getAllSciencerTypesWithCompletion:(void(^)(WebResponse* response, NSError* error)) completion{
    NSURL *url = [self buildUrlWithPath:@"baseInfoApi/getAllSciencerTypes" queryParameters:nil];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取科普员所在城市的公司GET /companyApi/getCompanyListByTown
-(void)getCompanyListByTownWithTownCode:(NSString *)town_code completion:(void(^)(WebResponse *response, NSError *error))completion
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:town_code forKey:@"town_code"];
    
    NSURL *url = [self buildUrlWithPath:@"companyApi/getCompanyListByTown" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSummaryDataForSciencerByScId:(NSString*) sc_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:sc_id forKey:@"sc_id"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getSciencerSummary" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSummaryDetailDataForSciencerByScId:(NSString*) sc_id
                                  completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:sc_id forKey:@"sc_id"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getSciencerDetailHead" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSciencerStsListForSciencerByScId:(NSString*) sc_id page:(NSInteger)page
                                completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:sc_id forKey:@"sc_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getSciencerStsList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getShareStsListForSciencerByScId:(NSString*) sc_id page:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    
    [dict setObject:sc_id forKey:@"sc_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getShareStsList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSpecialItemListForSciencerBySpId:(NSString*) sp_id page:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    if([MemberManager sharedInstance].getMember.member_id){
        [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    }
    
    [dict setObject:sp_id forKey:@"sp_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"specialItemApiController/getSpecialDetail" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSpecialItemDetailListForSciencerBySpId:(NSString*) sp_id page:(NSInteger)page classify:(NSString*)classify
                             completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if([MemberManager sharedInstance].getMember.member_id){
        [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    }
    [dict setObject:sp_id forKey:@"sp_id"];
    [dict setObject:classify forKey:@"classify"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"specialItemApiController/getSpecialDetailByType" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getSummaryDetailListForSciencerByScId:(NSString*) sc_id
                                        page:(NSInteger)page
                               province_code:(NSString*)province_code
                                   city_code:(NSString*)city_code
                                 county_code:(NSString*)county_code
                                   town_code:(NSString*)town_code
                                       month:(NSString*)month
                                   sort_type:(NSString*)sort_type
                              sort_direction:(NSString*)sort_direction
                                  completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    [dict setObject:[MemberManager sharedInstance].getMember.member_id forKey:@"member_id"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    if (sc_id && ![sc_id isEmptyOrWhitespace]) {
        [dict setObject:sc_id forKey:@"sc_id"];
    }
    
    if (province_code && ![province_code isEmptyOrWhitespace]) {
        [dict setObject:province_code forKey:@"province_code"];
    }
    
    if (city_code && ![city_code isEmptyOrWhitespace]) {
        [dict setObject:city_code forKey:@"city_code"];
    }
    
    if (county_code && ![county_code isEmptyOrWhitespace]) {
        [dict setObject:county_code forKey:@"county_code"];
    }
    
    if (town_code && ![town_code isEmptyOrWhitespace]) {
        [dict setObject:town_code forKey:@"town_code"];
    }
    
    if (month && ![month isEmptyOrWhitespace]) {
        [dict setObject:month forKey:@"month"];
    }
    
    if (sort_type && ![sort_type isEmptyOrWhitespace]) {
        [dict setObject:sort_type forKey:@"sort_type"];
    }
    
    if (sort_direction && ![sort_direction isEmptyOrWhitespace]) {
        [dict setObject:sort_direction forKey:@"sort_direction"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getSciencerDetailBody" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}


-(void)getRegisterSummaryHead:(NSString*)town_code
                                  completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    if (town_code && ![town_code isEmptyOrWhitespace]) {
        [dict setObject:town_code forKey:@"town_code"];
    }

    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getRegisterSummaryHead" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

-(void)getRegisterSummaryBody:(NSString*)town_code
                   page:(NSInteger)page
                   completion:(void(^)(WebResponse *response, NSError *error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    if (town_code && ![town_code isEmptyOrWhitespace]) {
        [dict setObject:town_code forKey:@"town_code"];
    }
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"sciencerV3Api/getRegisterSummaryBody" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 四期改版
// 获取活动首页数据
-(void)fourthGetActivityHomeListWithPage:(NSInteger)page
                              completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getActivityHomePage" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取最热的活动列表
-(void)fourthGetActivityHotListWithPage:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getHotActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取最新的活动列表
-(void)fourthGetActivityLatestWithPage:(NSInteger)page
                            completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getLatestActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取专题活动列表
-(void)getRegionActivityListWithPage:(NSInteger)page region_code:(NSString*)region_code
                                 completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    [dict setObject:region_code forKey:@"region_code"];
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityV2Api/getRegionActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取热门活动列表
-(void)getInteractiveActivityListWithPage:(NSInteger)page
                          completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityV2Api/getInteractiveActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取活动区域列表
-(void)getActivityRegionList:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
   
    NSURL *url = [self buildUrlWithPath:@"activityRegionApi/getActivityRegionList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取专题活动列表
-(void)fourthGetActivitySpecialListWithPage:(NSInteger)page
                                 completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getSpecialActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取专题活动详情列表
-(void)fourthGetActivitySpecialDetailListWithPage:(NSInteger)page
                                            av_id:(NSString*)av_id
                                       completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    
    if (av_id && ![av_id isEmptyOrWhitespace]) {
        [dict setObject:av_id forKey:@"av_id"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getSpecialActivityDetail" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取活动详情
-(void)fourthGetActivityDetailWithAv_id:(NSString*)av_id
                             completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    if (av_id && ![av_id isEmptyOrWhitespace]) {
        [dict setObject:av_id forKey:@"av_id"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"activityApi/getActivityDetail" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

#pragma mark - 四期中间我的活动0725
// 获取活动详情
-(void)fourthV2GetActivityDetailWithAv_id:(NSString*)av_id
                               completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    if (av_id && ![av_id isEmptyOrWhitespace]) {
        [dict setObject:av_id forKey:@"av_id"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"activityV2Api/getActivityDetail" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取我的活动列表
-(void)fourthV2MyActivityListWithPage:(NSInteger)page ompletion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)kRows] forKey:@"rows"];
    NSURL *url = [self buildUrlWithPath:@"activityV2Api/getMyActivityList" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}

// 获取我的活动详情
-(void)fourthV2MyActivityDetailWithAv_id:(NSString*)av_id completion:(void(^)(WebResponse *response, NSError *error))completion{
    // ===== 公共传入数据 ========
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* uuid = [defaults objectForKey:@"unique_identifier"];
    if (uuid) {
        [dict setObject:uuid forKey:@"unique_identifier"];
    }
    
    if ([MemberManager sharedInstance].isLogined) {
        [dict setObject:[MemberManager sharedInstance].memberId forKey:@"member_id"];
    }
    // ===== 公共传入End ========
    
    if (av_id && ![av_id isEmptyOrWhitespace]) {
        [dict setObject:av_id forKey:@"av_id"];
    }
    
    NSURL *url = [self buildUrlWithPath:@"activityV2Api/getApplyActivityDetail" queryParameters:dict];
    
    [self.restClient postWithURL:url body:nil responseClass:[WebResponse class] completion:completion ];
}
@end
