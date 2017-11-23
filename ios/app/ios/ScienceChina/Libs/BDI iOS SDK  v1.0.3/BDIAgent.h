//
//  BDIAgent.h
//  BDIAgent
//
//  Created by dd on 15/5/5.
//  Copyright (c) 2015年 % LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1)
    #import <WebKit/WebKit.h>
#endif

//
//  Public
//
@protocol mobideaRecProtocol


//
/**
 *
 *
 **/
#pragma mark  -- conform / adopt --

@required       //


//
/**
 *
 *
 **/
#pragma mark  -- mobiBRE 2.0 Response --

@optional


/** Called when the request receives some data
 -
 -
 -
 Method is called directly or indirectly
 \error [out] status NSError* that indicates success or failure.
 \returns None
 \author %
 \version 1.0a
 \date 08/15/2012
 \since Available in mobiBRE SDK v1.0a
 \see mobiBRE 2.0 API method calls
 */
-(void) mobidea_Recs:(NSError*) error feedback:(id)feedback;
//
//
//
@end

//
//
#define MB_CALLBACK \
    (id <mobideaRecProtocol>)




//
//  +++
//
typedef void (^response)(NSError* error, id feedback);



//
//  BfdAgent
//
@interface BfdAgent : NSObject {
    
}

//
//  + BRE 1.x IN delegate
//
+ (NSError*) addCart:           MB_CALLBACK delegate lst:(NSArray*)lst options:(NSDictionary*)options;
+ (NSError*) rmCart:            MB_CALLBACK delegate itemId:(NSString*)itemId options:(NSDictionary*)options;
+ (NSError*) addItem:           MB_CALLBACK delegate itemId:(NSString*)itemId options:(NSDictionary*)options;
+ (NSError*) rmItem:            MB_CALLBACK delegate itemId:(NSString*)itemId options:(NSDictionary*)options;
//
+ (NSError*) addUser:           MB_CALLBACK delegate userId:(NSString*)userId options:(NSDictionary*)options;
+ (NSError*) visit:             MB_CALLBACK delegate itemId:(NSString*)itemId options:(NSDictionary*)options;
+ (NSError*) order:             MB_CALLBACK delegate lst:(NSArray*)lst orderId:(NSString*)orderId options:(NSDictionary*)options;
+ (NSError*) pay:               MB_CALLBACK delegate orderId:(NSString*)orderId options:(NSDictionary*)options;
+ (NSError*) position:          MB_CALLBACK delegate latitude:(double)latitude longitude:(double)longitude options:(NSDictionary*)options;
+ (NSError*) search:            MB_CALLBACK delegate queryString:(NSString*)queryString options:(NSDictionary*)options;
//
+ (NSError*) recommend:         MB_CALLBACK delegate recommendId:(NSString*)recommendId options:(NSDictionary*)options;
+ (NSError*) feedback:          MB_CALLBACK delegate recommendId:(NSString*)recommendId itemId:(NSString*)itemId options:(NSDictionary*)options;
+ (NSError*) recommendSearch:   MB_CALLBACK delegate bidlst: (NSString*)bidlst options: (NSDictionary*)options;
@end






//
//  BDIAgent
//
@interface BDIAgent : NSObject {

}

//
//
//
+ (BOOL) bdiInit: (NSDictionary*) configs;

//
+ (void) appWillResignActive;
+ (void) appDidBecomeActive;
+ (void) appDidEnterBackground:(UIApplication *)application;
+ (void) appWillEnterForeground:(UIApplication *)application;
//
+ (void) setSessionContinueMillis: (long) interval;
+ (void) appWillTerminate:(UIApplication *)application;
//
//
+ (void) viewDidAppear: (id) node mark:(NSString*) mark;
+ (void) viewDidDisappear: (id) node mark:(NSString*) mark;
//
//  + BRE 1.x IN block
//
+ (NSError*) addCart: (NSArray*)lst options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) rmCart: (NSString*)itemId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) addItem:(NSString*)itemId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) rmItem: (NSString*)itemId options:(NSDictionary*)options resp: (response) resp;
//
+ (NSError*) addUser: (NSString*)userId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) visit: (NSString*)itemId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) event: (NSDictionary*)options resp: (response) resp;
+ (NSError*) order: (NSArray*)lst orderId:(NSString*)orderId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) pay: (NSString*)orderId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) position: (double)latitude longitude:(double)longitude options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) search: (NSString*)queryString empty:(BOOL) empty options:(NSDictionary*)options resp: (response) resp;

+ (NSError*) registering:(NSString*)uid  options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) login:(NSString*)uid  options:(NSDictionary*)options resp: (response) resp;

//
+ (NSError*) recommend: MB_CALLBACK delegate recommendId:(NSString*)recommendId options:(NSDictionary*)options;
+ (NSError*) recommend: (NSString*)recommendId options:(NSDictionary*)options resp: (response) resp;
+ (NSError*) feedback: (NSString*)recommendId itemId:(NSString*)itemId options:(NSDictionary*)options resp: (response) resp;
//
+ (NSError*) recommendSearch: MB_CALLBACK delegate bidlst: (NSString*)bidlst options: (NSDictionary*)options;
//
//
//
+ (NSError*) event: (NSString*) event_name params:(NSDictionary*)params  resp: (response) resp delegate: MB_CALLBACK delegate;
//
//  Hybrid App Analytics IFs
//
+ (id) listen2js: (UIWebView*) webview webViewDelegate:(NSObject<UIWebViewDelegate>*)webViewDelegate;
+ (NSError*) calljs: (id)bridge data:(id)data;
//
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0)
+ (id) listen2wkjs: (WKWebView*) wkwebview webViewDelegate:(NSObject<WKNavigationDelegate>*)webViewDelegate;
+ (NSError*) callwkjs:(id)bridge data:(id)data;
#endif
@end

//
#define _BDI_FD_RID_NAME_                       (@"rid")
#define _BDI_FD_BID_NAME_                       (@"bid")
#define _BDI_FD_PID_NAME_                       (@"pid")
#define _BDI_FD_RECS_NAME_                      (@"recs")