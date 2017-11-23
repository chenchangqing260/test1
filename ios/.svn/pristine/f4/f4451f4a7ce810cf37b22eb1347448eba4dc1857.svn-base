//
//  SettingViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "CustomDownloadManager.h"
#import "UMessage.h"

@interface SettingViewController ()

@property (nonatomic, strong)NSMutableArray* dataArray;
@property (nonatomic, strong)NSMutableArray* imgArray;
@property (weak, nonatomic) IBOutlet UITableView *uiSettingTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_table;

@end

@implementation SettingViewController
//@synthesize dataArray = _dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 1、初始化数据
    self.dataArray = [NSMutableArray new];
    self.imgArray = [NSMutableArray new];
    //    [self.dataArray addObject:@"接收消息通知"];
    //    //[self.dataArray addObject:@"每日资讯推荐"];
    //    [self.dataArray addObject:@"开启视频畅享"];
    //    [self.dataArray addObject:@"匿名评论"];
    //    [self.dataArray addObject:@"正文字体"];
    //    [self.dataArray addObject:@"意见反馈"];
    //    [self.dataArray addObject:@"给我评分"];
    //    //[self.dataArray addObject:@"修改密码"];
    //    
    //    
    //    [self.imgArray addObject:@"jieshouxiaoxitongzhi"];
    //    //[self.imgArray addObject:@"meirizixun"];
    //    [self.imgArray addObject:@"视频模式切换"];
    //    [self.imgArray addObject:@"匿名评论"];
    //    [self.imgArray addObject:@"fontctrl"];
    //    [self.imgArray addObject:@"yijianfankui"];
    //    [self.imgArray addObject:@"geiwopingfen"];
    //    //[self.imgArray addObject:@"setting_modifyPW"];
    
    self.leadingEdge_table.constant = self.trailingEdge_table.constant = self.leftEdge;
    
    // 2、刷新数据
    [self.uiSettingTableView reloadData];
    
    // 3、注册通知，刷新界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshSettingTableView:) name:kNOTOICE_REFRESH_SETTING object:nil];
}

- (void)refreshSettingTableView:(NSNotification*)notification{
    [self.uiSettingTableView reloadData];
}
-(NSMutableArray *)dataArray{
    [_dataArray removeAllObjects];
    [_imgArray  removeAllObjects];
    
    if ([MemberManager sharedInstance].isLogined) {
        [_dataArray addObject:@"接收消息通知"];
        //[self.dataArray addObject:@"每日资讯推荐"];
        [_dataArray addObject:@"开启视频畅享"];
        [_dataArray addObject:@"匿名评论"];
        [_dataArray addObject:@"字体设置"];
//        [_dataArray addObject:@"意见反馈"];
        [_dataArray addObject:@"给我评分"];
        [_dataArray addObject:@"修改密码"];
        [_dataArray addObject:@"清理缓存"];
        [_dataArray addObject:@"离线下载"];
        [_dataArray addObject:@"版本更新"];
        
        _imgArray = [NSMutableArray new];
        [_imgArray addObject:@"jieshouxiaoxitongzhi"];
        //[self.imgArray addObject:@"meirizixun"];
        [_imgArray addObject:@"视频模式切换"];
        [_imgArray addObject:@"匿名评论"];
        [_imgArray addObject:@"fontctrl"];
//        [_imgArray addObject:@"yijianfankui"];
        [_imgArray addObject:@"geiwopingfen"];
        [_imgArray addObject:@"setting_modifyPW"];
        [_imgArray addObject:@"icon_clear_cache"];
        [_imgArray addObject:@"icon_download"];
        [_imgArray addObject:@"icon_update"];
    }else{
        [_dataArray addObject:@"接收消息通知"];
        [_dataArray addObject:@"开启视频畅享"];
        [_dataArray addObject:@"匿名评论"];
        [_dataArray addObject:@"字体设置"];
//        [_dataArray addObject:@"意见反馈"];
        [_dataArray addObject:@"给我评分"];
        //[_dataArray addObject:@"修改密码"];
        [_dataArray addObject:@"清理缓存"];
        [_dataArray addObject:@"离线下载"];
        [_dataArray addObject:@"版本更新"];
        
        _imgArray = [NSMutableArray new];
        [_imgArray addObject:@"jieshouxiaoxitongzhi"];
        [_imgArray addObject:@"视频模式切换"];
        [_imgArray addObject:@"匿名评论"];
        [_imgArray addObject:@"fontctrl"];
//        [_imgArray addObject:@"yijianfankui"];
        [_imgArray addObject:@"geiwopingfen"];
        //[_imgArray addObject:@"setting_modifyPW"];
        [_imgArray addObject:@"icon_clear_cache"];
        [_imgArray addObject:@"icon_download"];
        [_imgArray addObject:@"icon_update"];
    }
    return _dataArray;
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([MemberManager sharedInstance].isLogined) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingTableViewCell ID]];
    if (!cell) {
        cell = [SettingTableViewCell newCell];
    }
    
    if (indexPath.section == 0) {
        
        NSString *title =  self.dataArray[indexPath.row];
        
        if ([title isEqualToString:@"字体设置"]) {
            
            cell.uiContentView.hidden = YES;
            cell.uiLogoutView.hidden = YES;
            cell.uiFontSizeView.hidden = NO;
            
            NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
            NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
            
            if (!fontSize) {
                fontSize = @"Normal";
                [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
                [settings synchronize];
            }
            
            if ([fontSize isEqualToString:@"Large"]) {
                cell.uiFontTextLab.text = @"大";
            }else if([fontSize isEqualToString:@"Small"]){
                cell.uiFontTextLab.text = @"小";
            }else{
                cell.uiFontTextLab.text = @"中";
            }
            cell.uiFontImgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
            
        }
        else{
            cell.uiContentView.hidden = NO;
            cell.uiLogoutView.hidden = YES;
            cell.uiFontSizeView.hidden = YES;
            
            cell.uiImgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
            cell.uiNameLab.text = self.dataArray[indexPath.row];
            cell.uiSwitch.userInteractionEnabled = YES;
            
            
            
            
            if ([title isEqualToString:@"接收消息通知"] ||
                [title isEqualToString:@"每日资讯推荐"] ||
                [title isEqualToString:@"开启视频畅享"] ||
                [title isEqualToString:@"匿名评论"]
                ) {
                cell.uiSwitch.hidden = NO;
            }else{
                cell.uiSwitch.hidden = YES;
            }
            
            if ([title isEqualToString:@"接收消息通知"]) {
                cell.flag = SWITCHFlag_message;
                // 先判断系统的消息推送是否开启
                if ([SettingViewController isAllowedNotification]) {
                    // 系统消息推送没有打开
                    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                    NSString* showDaily = [settings objectForKey:kUserDefaultKeyMessagePush];
                    if (showDaily && [showDaily isEqualToString:@"off"]) {
                        [cell.uiSwitch setOn:NO animated:YES];
                    }else{
                        [cell.uiSwitch setOn:YES animated:YES];
                    }
                }else{
                    cell.uiSwitch.userInteractionEnabled = NO;
                    [cell.uiSwitch setOn:NO animated:YES];
                }
            }
            else if ([title isEqualToString:@"每日资讯推荐"]) {
                cell.flag = SWITCHFlag_daliyShow;
                NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                NSString* showDaily = [settings objectForKey:kUserDefaultKeyShowDaily];
                if (showDaily && [showDaily isEqualToString:@"NotShow"]) {
                    [cell.uiSwitch setOn:NO animated:YES];
                }else{
                    [cell.uiSwitch setOn:YES animated:YES];
                }
            }
            else if ([title isEqualToString:@"开启视频畅享"]) {
                cell.flag = SWITCHFlag_video;
                // 视频畅享模式
                NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                NSString* videoShow = [settings objectForKey:kUserDefaultKeyVideoShow];
                if (videoShow && [videoShow isEqualToString:@"YES"]) {
                    [cell.uiSwitch setOn:YES animated:YES];
                }else{
                    [cell.uiSwitch setOn:NO animated:YES];
                }
            }
            else if ([title isEqualToString:@"匿名评论"]) {
                cell.flag = SWITCHFlag_comment;
                // 匿名评论
                NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                NSString* anony = [settings objectForKey:kUserDefaultKeyAnony];
                if (anony && [anony isEqualToString:@"YES"]) {
                    [cell.uiSwitch setOn:YES animated:YES];
                }else{
                    [cell.uiSwitch setOn:NO animated:YES];
                }
            }
            
            else if ([title isEqualToString:@"意见反馈"]) {
                
            }
            else if ([title isEqualToString:@"给我评分"]) {
                
            }
        }
        
        if (indexPath.row == self.dataArray.count -1) {
            cell.uiBottomLine.hidden = YES;
        }else{
            cell.uiBottomLine.hidden = NO;
        }
        
    }else{
        cell.uiContentView.hidden = YES;
        cell.uiLogoutView.hidden = NO;
        cell.uiFontSizeView.hidden = YES;
        cell.uiBottomLine.hidden = YES;
    }
    
    return cell;
}

-(void)onCheckAppViersion:(NSString*)title detail:(NSString*)detail isFORCIBLY_UPDATE:(NSString*)isFORCIBLY_UPDATE{
    
    MMAlertView *alertView = [[MMAlertView alloc]init];
    
    // 有新版本，直接提示更新
    MMPopupItemHandler block = ^(NSInteger index){
        
        //不强制更新
        if (index == 1) {
            // 跳转APPStore
            NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kAppleId];
            NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
            [[UIApplication sharedApplication] openURL:iTunesURL];
        }
        
        if (index == 0) {
            [alertView hide];
        }
    };
    
    // 提示
    NSArray *items =
    @[MMItemMake(@"暂不升级", MMItemTypeHighlight, block),MMItemMake(@"立即升级", MMItemTypeHighlight, block)];
    
    alertView = [[MMAlertView alloc] initWithTitle:title detail:detail items:items];
    
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    [alertView show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSString *title =  self.dataArray[indexPath.row];
        
        
        if ([title isEqualToString:@"接收消息通知"]) {
            SettingTableViewCell* cell = [self.uiSettingTableView cellForRowAtIndexPath:indexPath];
            
            if (![SettingViewController isAllowedNotification]) {
                cell.uiSwitch.userInteractionEnabled = NO;
                [cell.uiSwitch setOn:NO animated:YES];
                // 系统关闭，则提示
                MMPopupItemHandler block = ^(NSInteger index){
                    if (index == 0) {
                        
                    }
                    
                    if (index == 1) {
                        NSURL*url=[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                };
                // 提示
                NSArray *items =
                @[MMItemMake(@"取消", MMItemTypeNormal, block),
                  MMItemMake(@"去开启", MMItemTypeHighlight, block)];
                [[[MMAlertView alloc] initWithTitle:@"提示"
                                             detail:@"请先在设置中开启[科普中国]消息推送功能！"
                                              items:items]
                 showWithBlock:nil];
            }else{
                cell.uiSwitch.userInteractionEnabled = YES;
                
                // 系统消息推送没有打开
                NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
                if (!cell.uiSwitch.on) {
                    [UMessage registerForRemoteNotifications];
                    [settings setObject:@"on" forKey:kUserDefaultKeyMessagePush];
                    [cell.uiSwitch setOn:YES animated:YES];
                }else{
                    [UMessage unregisterForRemoteNotifications];
                    [settings setObject:@"off" forKey:kUserDefaultKeyMessagePush];
                    
                    [cell.uiSwitch setOn:NO animated:YES];
                }
                [settings synchronize];
            }
        }
        else if ([title isEqualToString:@"每日资讯推荐"]) {
        }
        else if ([title isEqualToString:@"开启视频畅享"]) {
        }
        else if ([title isEqualToString:@"匿名评论"]) {
        }
        else if ([title isEqualToString:@"清理缓存"]) {
            [SVProgressHUDUtil showWithStatus:@"正在清理..."];
            [[SDImageCache sharedImageCache] clearMemory];
            [CustomDownloadManager deleteAllDownloadVideo];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                dispatch_main_after(1.5, ^{
                    [SVProgressHUDUtil showSuccessWithStatus:@"清理成功!"];
                });
            }];
        }
        else if ([title isEqualToString:@"离线下载"]) {
            // 登录则跳转、判断登录方式是否是第三方登录
            [FlowUtil startToDownloadVideoVCNav:self.navigationController];
        }
        else if ([title isEqualToString:@"字体设置"]) {
            NSInteger titleIndex = [self.dataArray indexOfObject:title];
            MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
                SettingTableViewCell* cell = [self.uiSettingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:titleIndex inSection:0]];
                
                NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
                if (!fontSize) {
                    fontSize = @"Normal";
                    [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
                    [settings synchronize];
                }
                
                FontSize fontSizeData = Normal;
                cell.uiFontTextLab.text = @"中";
                if (index == 0) {
                    fontSizeData = Large;
                    cell.uiFontTextLab.text = @"大";
                    [settings setObject:@"Large" forKey:kUserDefaultKeyPreferedFontSize];
                    [settings synchronize];
                }else if(index == 1){
                    fontSizeData = Normal;
                    cell.uiFontTextLab.text = @"中";
                    [settings setObject:@"Normal" forKey:kUserDefaultKeyPreferedFontSize];
                    [settings synchronize];
                }else if(index == 2){
                    fontSizeData = Small;
                    cell.uiFontTextLab.text = @"小";
                    [settings setObject:@"Small" forKey:kUserDefaultKeyPreferedFontSize];
                    [settings synchronize];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PreferedFontSizeChanged" object:nil userInfo:[NSDictionary dictionaryWithObject:@(fontSizeData) forKey:@"fontSize"]];
            };
            
            MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
                
            };
            // 弹出选择字体的框子
            NSArray *items =
            @[MMItemMake(@"大", MMItemTypeHighlight, block),
              MMItemMake(@"中", MMItemTypeHighlight, block),
              MMItemMake(@"小", MMItemTypeHighlight, block)];
            
            MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@""
                                                                  items:items];
            sheetView.attachedView = self.view;
            sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
            [sheetView showWithBlock:completeBlock];
        }
        else if ([title isEqualToString:@"意见反馈"]) {
            // 意见反馈
            [FlowUtil startToFeedBackVCNav:self.navigationController completion:nil];
            
        }
        else if ([title isEqualToString:@"给我评分"]) {
            // Go AppStore
            NSString* str = @"";
            if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
            { str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",kAppleId];
            }else{
                str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",kAppleId];
            }
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        else if ([title isEqualToString:@"修改密码"]) {
            if ([MemberManager sharedInstance].isLogined) {
                // 登录则跳转、判断登录方式是否是第三方登录
                NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
                
                NSString *channel = [loginCredential objectForKey:@"channel"];
                
                if (![channel isEqualToString:@"4"]) {
                    // 第三方登录，无需修改密码
                    [SVProgressHUDUtil showInfoWithStatus:@"第三方凭证登录系统，无需修改密码！"];
                }else{
                    [FlowUtil startToChangePasswordVCNav:self.navigationController completion:nil];
                }
            }
        }
        else if ([title isEqualToString:@"版本更新"]) {
            // 检查版本更新
            [[WebAccessManager sharedInstance]getNewLatestVersion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    
                    if(response.data.version){
                        if ([kCurrentVersion compare:response.data.version.vs_name options:NSNumericSearch] == NSOrderedAscending) {
                            
                            //可以提示
                            [self onCheckAppViersion:response.data.version.vs_title detail:response.data.version.descp isFORCIBLY_UPDATE:response.data.version.is_constraint];
                        }else{
                            [CRToastUtil showAttentionMessageWithText:@"您的版本已是最新版本!"];
                        }
                        
                    }else{
                      [CRToastUtil showAttentionMessageWithText:@"您的版本已是最新版本!"];
                    }
                    
                }else{
                    [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                }
            }];
        }

    }
    else if (indexPath.section == 1) {
        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 0) {
                
            }
            
            if (index == 1) {
                [[MemberManager sharedInstance] logout];
                [self.uiSettingTableView reloadData];
            }
        };
        // 提示
        NSArray *items =
        @[MMItemMake(@"取消", MMItemTypeNormal, block),
          MMItemMake(@"退出", MMItemTypeHighlight, block)];
        [[[MMAlertView alloc] initWithTitle:@"确认"
                                     detail:@"确认要退出吗?"
                                      items:items]
         showWithBlock:nil];
    }
    
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (kSCREEN_WIDTH < kWIDTH_375) {
        return 55;
    }
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (kSCREEN_WIDTH < kWIDTH_375) {
        if (section == 1) {
            return 20;
        }
        return 10;
    }else{
        if (section == 1) {
            return 50;
        }
        return 20;
    }
}

#pragma mark - 判断系统是否开启消息通知
+ (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if ([SettingViewController isSystemVersioniOS8]) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemVersioniOS8 {
    //check systemVerson of device
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    
    if (sysVersion >= 8.0f) {
        return YES;
    }
    return NO;
}
@end
