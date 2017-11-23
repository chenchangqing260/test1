//
//  ThirdShareHandler.m
//  ScienceLife
//
//  Created by Ellison on 16/3/23.
//  Copyright © 2016年 WangJensen. All rights reserved.
//

#import "ThirdShareHandler.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WXUtil.h"

@interface ThirdShareHandler()<QQApiInterfaceDelegate,WXApiDelegate,WeiboSDKDelegate>

@end

@implementation ThirdShareHandler

+ (instancetype)sharedInstance{
    static ThirdShareHandler *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [ThirdShareHandler new];
    });
    
    return instance;
}

- (BOOL)shareTo:(ShareThirdPart)thirdParty ShareModel:(ShareModel*)shareModel{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (thirdParty == ShareQQ || thirdParty == ShareQQZone) {
        
        if(![QQApiInterface isQQInstalled]){
            [SVProgressHUDUtil showInfoWithStatus:@"请安装QQ客户端"];
            return NO;
        }
        
        appDelegate.qqApiInterfaceDelegate = self;
        [[TencentOAuth alloc] initWithAppId:kQQApiKey andDelegate:self];
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:shareModel.in_share_contentURL]
                                    title:shareModel.in_share_title
                                    description:shareModel.in_share_desc
                                    previewImageURL:[NSURL URLWithString:shareModel.in_share_imageURL]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        if (thirdParty == ShareQQ) {
            //将内容分享到qq
            [QQApiInterface sendReq:req];
        }else{
            //将内容分享到qzone
            [QQApiInterface SendReqToQZone:req];
        }
    }else if(thirdParty == ShareWeiXin || thirdParty ==  ShareWXPengyouquan){
//        if(![WXApi isWXAppInstalled]){
//            [SVProgressHUDUtil showInfoWithStatus:@"请安装微信客户端"];
//            return NO;
//        }
        
        appDelegate.wxDelegate = self;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.bText = NO;
        req.scene = thirdParty == ShareWXPengyouquan ? WXSceneTimeline : WXSceneSession;
        req.message = [WXMediaMessage message];
        req.message.title = shareModel.in_share_title;
        req.message.description = shareModel.in_share_desc;
        if (shareModel.in_share_imageURL) {
            req.message.thumbData = [WXUtil httpSend:shareModel.in_share_imageURL method:@"Get" data:nil];
        }
        
        WXWebpageObject *webPageObj = [WXWebpageObject object];
        webPageObj.webpageUrl = shareModel.in_share_contentURL;
        req.message.mediaObject = webPageObj;
        
        [WXApi sendReq:req];
    }else if(thirdParty ==  ShareWeibo){
        appDelegate.weiboDelegate = self;
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kWeiBoRedirectURL;
        authRequest.scope = @"all";
        
        WBMessageObject *message = [WBMessageObject message];
        message.text = shareModel.in_share_title;
        WBWebpageObject *webpage = [WBWebpageObject new];
        webpage.objectID = @"ThirdShareHandler";
        webpage.title = shareModel.in_share_title;
        if(![WeiboSDK isWeiboAppInstalled]) {
            message.text = [message.text stringByAppendingString:[NSString stringWithFormat:@" %@",shareModel.in_share_contentURL]];
        }
        webpage.description = shareModel.in_share_desc;
        if (shareModel.in_share_imageURL) {
            webpage.thumbnailData = [WXUtil httpSend:shareModel.in_share_imageURL method:@"Get" data:nil];
        }
        webpage.webpageUrl = shareModel.in_share_contentURL;
        message.mediaObject = webpage;
        
//        WBVideoObject *video = [WBVideoObject message];
//        video.videoUrl = @"";
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        return [WeiboSDK sendRequest:request];
    }else{
        [CRToastUtil showAttentionMessageWithText:@"无法分享!"];
    }
    
    return NO;
}

#pragma mark - 处理回调
- (void)onReq:(QQBaseReq *)req{
}

- (void)onResp:(BaseResp *)resp{
    BOOL result = NO;
    if ([resp isKindOfClass:[BaseResp class]]) {
        //Weixin share
        result = (resp.errCode == 0);
    } else if([resp isKindOfClass:[QQBaseResp class]]) {
        //QQ share
        QQBaseResp *qqResp = (QQBaseResp *)resp;
        result = (qqResp.errorDescription == nil);
    }
    
    if (self.delegate) {
        [self.delegate didShareCompleted:result];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
}

// WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if (self.delegate) {
        [self.delegate didShareCompleted:(response.statusCode == WeiboSDKResponseStatusCodeSuccess)];
    }
}

@end
