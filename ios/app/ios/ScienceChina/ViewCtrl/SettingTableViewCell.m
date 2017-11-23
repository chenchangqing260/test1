//
//  SettingTableViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "UMessage.h"

@interface SettingTableViewCell()

@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _uiSwitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
}

+(SettingTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"SettingTableViewCell";
}

- (IBAction)switchValueChangeEvent:(id)sender {
    if (self.flag == SWITCHFlag_message) {
        // 系统消息推送没有打开
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        if (_uiSwitch.on) {
            //[[UIApplication sharedApplication] registerForRemoteNotifications];
            [UMessage registerForRemoteNotifications];
            [settings setObject:@"on" forKey:kUserDefaultKeyMessagePush];
        }else{
            // [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            [UMessage unregisterForRemoteNotifications];
            [settings setObject:@"off" forKey:kUserDefaultKeyMessagePush];
        }
        [settings synchronize];
    }else if(self.flag == SWITCHFlag_daliyShow){
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        if (_uiSwitch.on) {
            // 开启每日推荐
            [settings setObject:@"show" forKey:kUserDefaultKeyShowDaily];
        }else{
            // 关闭每日推荐
            [settings setObject:@"NotShow" forKey:kUserDefaultKeyShowDaily];
        }
        [settings synchronize];
    }else if(self.flag == SWITCHFlag_video){
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        if (_uiSwitch.on) {
            // 开启视频畅享
            [settings setObject:@"YES" forKey:kUserDefaultKeyVideoShow];
        }else{
            // 开启视频畅享
            [settings setObject:@"NO" forKey:kUserDefaultKeyVideoShow];
        }
        [settings synchronize];
    }else if(self.flag == SWITCHFlag_comment){
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        if (_uiSwitch.on) {
            // 开启匿名评论
            [settings setObject:@"YES" forKey:kUserDefaultKeyAnony];
        }else{
            // 关闭匿名评论
            [settings setObject:@"NO" forKey:kUserDefaultKeyAnony];
        }
        [settings synchronize];
    }
}
@end
