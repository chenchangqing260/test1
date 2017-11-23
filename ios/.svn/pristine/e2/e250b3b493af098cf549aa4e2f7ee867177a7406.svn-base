//
//  UpdateVersionUtil.m
//  ScienceChina
//
//  Created by Ellison on 16/8/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#define kCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
#define kCheckUpdateTime @"kCheckUpdateTime"

#import "UpdateVersionUtil.h"

@interface UpdateVersionUtil()

+ (void)showAlertWithAppStoreVersion:(NSString*)appStoreVersion;

@end

@implementation UpdateVersionUtil

+ (void)checkVersion{
    // Check lastest check
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDate *date = [userDefaultes objectForKey:kCheckUpdateTime];
    
    if (date && [date timeIntervalSinceDate:[NSDate date]] < 5 * 24 * 60 * 60) {
        return;
    }
    
    // Update Data
    [userDefaultes setObject:[NSDate date] forKey:kCheckUpdateTime];
    [userDefaultes synchronize];
    
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", kAppleId];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ( [data length] > 0 && !error ) { // Success
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                if ( ![versionsInAppStore count] ) {
                    // No versions of app in AppStore
                    return;
                } else {
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    if ([kCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {
                        [UpdateVersionUtil showAlertWithAppStoreVersion:currentAppStoreVersion];
                    }else {
                        // Current installed version is the newest public version or newer
                    }
                }
            });
        }
        
    }];
}

#pragma mark - Private Methods
+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion{
    if (!isForceUpdateVersion ) {
        // Force user to update app
        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 0) {
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kAppleId];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
            }
        };
        // 提示
        NSArray *items =
        @[MMItemMake(@"立即更新", MMItemTypeHighlight, block)];
        [[[MMAlertView alloc] initWithTitle:@"升级更新"
                                     detail:@"新版本发布啦，更优质的体验，快去更新试试看吧！"
                                      items:items]
         showWithBlock:nil];
    } else {
        // Allow user option to update next time user launches your app
        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 0) {
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kAppleId];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
            }
            
            if (index == 1) {
                
            }
        };
        // 提示
        NSArray *items =
        @[MMItemMake(@"下次更新", MMItemTypeHighlight, block),
          MMItemMake(@"立即更新", MMItemTypeHighlight, block)];
        [[[MMAlertView alloc] initWithTitle:@"升级更新"
                                     detail:@"新版本发布啦，更优质的体验，快去更新试试看吧！"
                                      items:items]
         showWithBlock:nil];
    }
}

@end
