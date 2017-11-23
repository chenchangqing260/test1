//
//  AppDelegate.h
//  ScienceChina
//
//  Created by Ellison on 16/4/28.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "QQApi2.9.5/TencentOpenAPI.framework/Headers/QQApiInterface.h"
#import "RDVTabBarController.h"

/**
 *  播放远程事件block
 */
typedef void (^playerRemoteEventBlock)(UIEvent *event);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak,nonatomic) id<WXApiDelegate> wxDelegate;
@property (weak,nonatomic) id<WeiboSDKDelegate> weiboDelegate;
@property (weak,nonatomic) id<QQApiInterfaceDelegate> qqApiInterfaceDelegate;
@property (strong, nonatomic) UIView *badgeview1;

@property (strong, nonatomic) RDVTabBarController *tabBarController;
@property (nonatomic, copy) playerRemoteEventBlock myRemoteEventBlock;

-(void)closeNotiNetwork;

+(AppDelegate *)appdelegate;
////水波纹
//- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view;
////左右翻转
//- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition;
@end

