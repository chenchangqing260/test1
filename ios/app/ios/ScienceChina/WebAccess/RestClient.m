//
//  RestClient.m
//  RestClient
//
//  Created by Jensen on 15/9/17.
//
//

#import "RestClient.h"
#import "WebResponse.h"
#import "JSONUtil.h"
#import "WebAccessErrorCodes.h"
#import "MJExtension.h"
#import "NSString+Util.h"
#import "GTMBase64Util.h"

#define GET @"GET"
#define POST @"POST"
#define PUT @"PUT"
#define DELETE @"DELETE"

NSString *const ServiceAccessErrorDomain = @"ServiceAccessErrorDomain";

@interface RestClient()<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, atomic,readonly) NSURLSession *httpSession;

@end

@implementation RestClient

@synthesize httpSession = _httpSession;

-(instancetype)init{
    if (self = [super init]) {
        self.requestRetryCount = 1;
        self.requestTimeout = 10;
    }
    
    return self;
}

- (NSURLSession*)httpSession{
    if (_httpSession == nil) {
        NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _httpSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        sessionConfig.allowsCellularAccess = YES;
    }
    
    return _httpSession;
}

#pragma Mark Http Api

-(void)getWithURL:(NSURL*)url headerParam:(NSMutableDictionary*)headerParam responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion
{
    [self sendHttpRequestWithMethod:GET
                                url:url
                               body:nil
                        headerParam:headerParam
                      responseClass:respClass
                         completion:completion];
}

-(void)getWithURL:(NSURL*)url responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion
{
    [self sendHttpRequestWithMethod:GET
                                url:url
                               body:nil
                        headerParam:nil
                      responseClass:respClass
                         completion:completion];
}

-(void)postWithURL:(NSURL*)url headerParam:(NSMutableDictionary*)headerParam body:(id)body responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion
{
    [self sendHttpRequestWithMethod:POST
                                url:url
                               body:body
                        headerParam:headerParam
                      responseClass:respClass
                         completion:completion];
}

-(void)postWithURL:(NSURL*)url body:(id)body responseClass:(Class)respClass completion:(void(^)(id response,NSError* error))completion
{
    [self sendHttpRequestWithMethod:POST
                                url:url
                               body:body
                        headerParam:nil
                      responseClass:respClass
                         completion:completion];
}

- (void)getStreamDataWithUrl:(NSURL *)url completion:(void (^)(NSData *, NSError *))completion
{
    [self sendHttpRequestWithMethod:GET url:url data:nil headerParam:nil retryCount:self.requestRetryCount completion:^(NSData *data, NSHTTPURLResponse *response, NSError *error) {
        if (completion) {
            completion(data,error);
        }
    }];
}

#pragma Mark Helper

-(void)sendHttpRequestWithMethod:(NSString*)method url:(NSURL*)url body:(id)body headerParam:(NSMutableDictionary*)headerParam responseClass:(Class)respClass completion:(void(^)(id response,NSError* error)) completion {
    
    NSData *jsonData = body != nil ? [JSONUtil dataFromObject:body] : nil;
    
    [self sendHttpRequestWithMethod:method url:url data:jsonData headerParam:headerParam retryCount:self.requestRetryCount completion:^(NSData *respData, NSHTTPURLResponse *httpResponse, NSError *error) {
        id respObj = nil;
        if (error == nil && respData != nil) {
            if (respClass == [NSString class]) {
                respObj = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
            } else {
                respObj = [JSONUtil objectFromData:respData class:respClass];
            }
        }
        
        if ([respObj isKindOfClass:[WebResponse class]] && ![respObj success]) {
            error = [NSError errorWithDomain:ServiceAccessErrorDomain code:ServerError userInfo:[NSDictionary dictionaryWithObject:[respObj errorMsg] ? [respObj errorMsg] : @"未知错误" forKey:@"errorMessage"]];
            
        } else if ((httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) && error == nil) {
            // process http protocol errors.
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[@"errorMessage"] = @"服务器错误";
            
            error = [[NSError alloc] initWithDomain:ServiceAccessErrorDomain code:ServerError userInfo:userInfo];
        }
        
        if(completion != nil)
        {
            completion(respObj,error);
        }
    }];
}

-(void)sendHttpRequestWithMethod:(NSString*)method url:(NSURL*)url data:(NSData*)bodyData headerParam:(NSMutableDictionary*)headerParam retryCount:(NSInteger)retryCount completion:(void(^)(NSData* data,NSHTTPURLResponse* response,NSError* error)) completion
{
    [UIApplication sharedApplication ].networkActivityIndicatorVisible = YES;
    NSMutableURLRequest* request = [self createHttpRequestWithMethod:method url:url data:bodyData  headerParam:headerParam];
    //DLog(@"Request Sent: %@\nRequest body: %@\n", request, [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    NSURLSessionDataTask* task = [self.httpSession dataTaskWithRequest:request completionHandler:^(NSData* responseData,NSURLResponse* response,NSError* error)
                                  {
                                      DLog(@"Response received(url:%@): %@\n\tResponseData: %@\n\tError: %@", url, response, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding], error);
                                      [UIApplication sharedApplication ].networkActivityIndicatorVisible = NO;
                                      
                                      NSHTTPURLResponse* httpResp = (NSHTTPURLResponse*)response;
                                      NSError* requestError;
                                      if (error != nil) {
                                          NSString *errorMessage = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                                          switch (error.code) {
                                              case NSURLErrorTimedOut:
                                                  requestError = [[NSError alloc] initWithDomain:ServiceAccessErrorDomain code:NetworkIsTimeout userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:@"errorMessage"]];
                                                  break;
                                              case NSURLErrorNotConnectedToInternet:
                                                  requestError = [[NSError alloc] initWithDomain:ServiceAccessErrorDomain code:NetworkIsOffline userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:@"errorMessage"]];
                                                  break;
                                              case kCFURLErrorCannotConnectToHost:
                                                  requestError = [[NSError alloc] initWithDomain:ServiceAccessErrorDomain code:NetworkIsOffline userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:@"errorMessage"]];
                                                  break;
                                              default:
                                                  requestError = [[NSError alloc] initWithDomain:ServiceAccessErrorDomain code:ServerError userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:@"errorMessage"]];
                                                  break;
                                          }
                                      }
                                      
                                      if (requestError != nil && retryCount > 0 && requestError.code == NetworkIsOffline) {
                                          [self sendHttpRequestWithMethod:method url:url data:bodyData headerParam:headerParam retryCount:retryCount - 1 completion:completion];
                                      }
                                      else{
                                          completion(responseData, httpResp, requestError);
                                      }
                                  }];
    
    [task resume];
}


-(NSMutableURLRequest*)createHttpRequestWithMethod:(NSString*)method url:(NSURL*)url data:(NSData*)bodyData headerParam:(NSMutableDictionary*)headerParam{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",(long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
    // UPDATE BY ELLISON
    // 默认回传的头参数
    NSMutableDictionary* headerDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* imei = [defaults objectForKey:@"identifierForVendor"];
    NSString* systemVersion = [defaults objectForKey:@"osVersion"];
    NSString* clientVersion = [defaults objectForKey:@"clientVersion"];
    
    if (!imei) {
        imei = [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    if (!systemVersion) {
        systemVersion = [[UIDevice currentDevice] systemVersion];
    }
    
    if (!clientVersion) {
        clientVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    
    [headerDict setObject:imei forKey:@"imei"];
    [headerDict setObject:systemVersion forKey:@"osVersion"];
    [headerDict setObject:clientVersion forKey:@"clientVersion"];
    // 传递加密的访问token
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString* currentDateStr = [dateFormat stringFromDate:[NSDate new]];
    [headerDict setObject:[GTMBase64Util encryptUseDES:currentDateStr key:@"#CHINASCIENCE"] forKey:@"timestamp"];
    
    
    // 2代表IOS
    [headerDict setObject:@"2" forKey:@"system_type"];
    
    // 若又特殊的数据需要从header传过来
    if (headerParam != nil && headerParam.count > 0) {
        // 设置头参数
        for (int i=0; i<headerParam.allKeys.count; i++) {
            [headerDict setObject:[headerParam objectForKey:[headerParam.allKeys objectAtIndex:i]] forKey:[headerParam.allKeys objectAtIndex:i]];
        }
    }
    
    if (headerDict != nil && headerDict.count > 0) {
        // 设置头参数
        for (int i=0; i<headerDict.allKeys.count; i++) {
            [request setValue:[headerDict objectForKey:[headerDict.allKeys objectAtIndex:i]] forHTTPHeaderField:[headerDict.allKeys objectAtIndex:i]];
        }
    }
    
    request.timeoutInterval = self.requestTimeout;
    if (bodyData != nil) {
        [request setHTTPBody:bodyData];
    }
    
    return request;
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    if (response) {
        request = nil;
    }
    
    completionHandler(request);
}

//#ifdef DEV
//
//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
//{
//    // trust the server certification for now. need to remove before release.
//    if([challenge.protectionSpace.authenticationMethod isEqualToString: NSURLAuthenticationMethodServerTrust])
//    {
//        SecTrustRef trustRef = [challenge.protectionSpace serverTrust];
//        id trustCredential = [NSURLCredential credentialForTrust:trustRef];
//        completionHandler(NSURLSessionAuthChallengeUseCredential, trustCredential);
//    } else {
//        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
//    }
//}
//
//#endif

@end
