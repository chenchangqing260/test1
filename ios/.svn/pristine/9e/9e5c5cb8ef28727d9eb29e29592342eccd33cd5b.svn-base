//
//  WeixinAccessTokenResponse.h
//  hxz
//
//  Created by WangJensen on 11/8/15.
//  Copyright © 2015 goodswiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeixinAccessTokenResponse : NSObject

@property (nonatomic,strong) NSString *errcode;
@property (nonatomic,strong) NSString *errmsg;
@property (nonatomic,strong) NSString *access_token; //接口调用凭证
@property (nonatomic) int expires_in; //access_token接口调用凭证超时时间，单位（秒）
@property (nonatomic,strong) NSString *refresh_token; //用户刷新access_token
@property (nonatomic,strong) NSString *openid; //授权用户唯一标识
@property (nonatomic,strong) NSString *scope; //用户授权的作用域，使用逗号（,）分隔
@property (nonatomic,strong) NSString *unionid; //只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。

@end
