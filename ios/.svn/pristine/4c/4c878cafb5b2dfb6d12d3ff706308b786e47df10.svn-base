//
//  DDMenuController.h
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 toaast. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#import "MemberInfoViewController.h"
#import "ChannelContainerViewController.h"
#import "EStationViewController.h"
#import "QuesMainViewController.h"
#import "DownloadVideoViewController.h"
#import "MyViewController.h"
#import "CategoryViewController.h"
#import "JTNavigationController.h"
#import "BaseWebViewController.h"
#import "HomeTabBarController.h"
#import "ChannelCollectionViewController.h"
#import "WeChatPublicNumberViewController.h"
typedef enum {
    DDMenuPanDirectionLeft = 0,
    DDMenuPanDirectionRight,
} DDMenuPanDirection;

typedef enum {
    DDMenuPanCompletionLeft = 0,
    DDMenuPanCompletionRight,
    DDMenuPanCompletionRoot,
} DDMenuPanCompletion;

@protocol DDMenuControllerDelegate;
@interface DDMenuController : UIViewController <UIGestureRecognizerDelegate>{
    
    id _tap;
    id _pan;
    
    CGFloat _panOriginX;
    CGPoint _panVelocity;
    DDMenuPanDirection _panDirection;

    struct {
        unsigned int respondsToWillShowViewController:1;
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } _menuFlags;
    
}

- (id)initWithRootViewController:(UIViewController*)controller;

@property(nonatomic,assign) id <DDMenuControllerDelegate> delegate;

@property(nonatomic,strong) UIViewController *leftViewController;
@property(nonatomic,strong) UIViewController *rightViewController;
@property(nonatomic,strong) UIViewController *rootViewController;

@property(nonatomic,strong) MemberInfoViewController *memberInfoVC;
@property(nonatomic,strong) ChannelContainerViewController *mainVC;
@property(nonatomic,strong) EStationViewController *estationVC;
@property(nonatomic,strong) QuesMainViewController *questionVC;
@property(nonatomic,strong) DownloadVideoViewController *catchVC;
@property(nonatomic,strong) ChannelCollectionViewController *myAttentionVC;
@property(nonatomic,strong) MyViewController *myVC;
@property(nonatomic,strong) CategoryViewController *categoryVC;
@property(nonatomic,strong) BaseWebViewController *weichatWebVC;
@property(nonatomic,strong) BaseWebViewController *weiboVC;
@property(nonatomic,strong) WeChatPublicNumberViewController *weiChatPublicNumberVC;


@property(nonatomic,strong) JTNavigationController *memberInfoNav;
@property(nonatomic,strong) JTNavigationController *mainNav;
@property(nonatomic,strong) JTNavigationController *estationNav;
@property(nonatomic,strong) JTNavigationController *questionNav;
@property(nonatomic,strong) JTNavigationController *catchNav;
@property(nonatomic,strong) JTNavigationController *myAttentionNav;
@property(nonatomic,strong) JTNavigationController *myNav;
@property(nonatomic,strong) JTNavigationController *categoryNav;
@property(nonatomic,strong) JTNavigationController *weichatNav;
@property(nonatomic,strong) JTNavigationController *weiboNav;
@property(nonatomic,strong) JTNavigationController *weiChatPublicNumberNav;
//@property(nonatomic,strong) UINavigationController *weichatNav;
//@property(nonatomic,strong) UINavigationController *weiboNav;

@property(nonatomic,strong) HomeTabBarController *homeTab;

@property(nonatomic,readonly) UITapGestureRecognizer *tap;
@property(nonatomic,readonly) UIPanGestureRecognizer *pan;

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated; // used to push a new controller on the stack
- (void)showRootController:(BOOL)animated; // reset to "home" view controller
- (void)showRightController:(BOOL)animated;  // show right
- (void)showLeftController:(BOOL)animated;  // show left
- (void)setEnableGesture:(BOOL)isEnable;

@end

@protocol DDMenuControllerDelegate 
- (void)menuController:(DDMenuController*)controller willShowViewController:(UIViewController*)controller;
@end
