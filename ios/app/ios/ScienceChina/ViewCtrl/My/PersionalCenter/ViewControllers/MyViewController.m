//
//  MyViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyViewController.h"
#import "CustomDownloadManager.h"
#import "WaterView.h"
#import "CollectionReusableHeaderViewOnMy.h"
#import "MyCollectionViewCell.h"
#import "LoginAndRegisterViewController.h"
#import "EStationViewController.h"
#import "MQChatViewManager.h"
#import "MyAlertViewController.h"
#import "RDVTabBarController.h"
#import "ChannelCollectionViewController.h"
#import "BindCellPhoneViewController.h"
#import "ChannelContainerViewController.h"

#import "AppDelegate.h"

#define Title_BrowsingHistory  @"浏览记录"
#define Title_ModifyPW         @"修改密码"
//#define Title_ClearCash        @"清理缓存"
#define Title_Setting          @"设置"
#define Title_About            @"关于"
//#define Title_Share            @"分享"
//#define Title_VolunteerApprove @"科普员补充资料"
#define Title_ChannelCollection @"合作单位"
//#define Title_VolunteerManagent @"科普员管理"
#define Title_MyStation        @"我的基站"
#define Title_StationCertification @"基站认证"
#define Title_GetRewards       @"领取奖励"
#define Title_LogOut           @"退出"
//#define Title_OfflineDownload  @"离线下载"
//#define Title_EStation         @"基站"
#define Title_Service         @"在线客服"

#define Image_BrowsingHistory  @"浏览记录"
#define Image_ModifyPW         @"修改密码"
#define Image_ClearCash        @"清理缓存"
#define Image_Setting          @"设置"
#define Image_About            @"关于"
//#define Image_Share            @"分享给朋友"
#define Image_VolunteerApprove @"icon_my_volunteerVertify"
#define Image_ChannelCollection @"icon_hzdw"
#define Image_MyStation        @"icon_my_myStation"
#define Image_GetRewards       @"icon_my_getRewards"
#define Image_LogOut           @"myIcon_logout"
//#define Image_EStation         @"icon_jizhan"
#define Image_Service          @"icon_kefu"

@interface MyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CollectionReusableHeaderViewOnMyDelegate,MyAlertViewControllerDelegate,BindCellPhoneViewControllerDelegate>
{
    
    UICollectionView *_collectionView;
    CollectionReusableHeaderViewOnMy *_reusableView;
    UISwitch *_testSwitch;//开启测试和正式环境
    UILabel *_testLabel;
}
@property (nonatomic,strong)NSMutableArray *itemArry;
@property (nonatomic,strong)NSMutableArray *imagesArry;
@property (nonatomic,strong)NSString * fontSize;
@property (nonatomic,strong)NSString * Title_VolunteerApproven;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Title_VolunteerApproven =@"科普员认证";
    //self.title = LStr(@"my");
    [self registerNotice];
    [self initData];
    [self setupview];
    
    
    
    //    [[self rdv_tabBarItem] setBadgeValue:@"5"];
    //
    //    if (self.rdv_tabBarController.tabBar.translucent) {
    //        UIEdgeInsets insets = UIEdgeInsetsMake(0,
    //                                               0,
    //                                               CGRectGetHeight(self.rdv_tabBarController.tabBar.frame),
    //                                               0);
    //
    //        self.tableView.contentInset = insets;
    //        self.tableView.scrollIndicatorInsets = insets;
    //    }
    
    // 正式上线需要隐藏，特别注意
    //[self setViewForTest];
}

-(void)setViewForTest{
    // 切换正式环境和测试环境
    _testSwitch = [UISwitch new];
    _testSwitch.frame = CGRectMake(kSCREEN_WIDTH - 70, 180, 50, 30);
    [_testSwitch addTarget:self action:@selector(switchValueChangeEvent:) forControlEvents:UIControlEventValueChanged];
    _testLabel = [UILabel new];
    _testLabel.frame = CGRectMake(kSCREEN_WIDTH - 170, 180, 90, 30);
    _testLabel.font = FONT_15;
    _testLabel.backgroundColor = [UIColor blueColor];
    _testLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    _testLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_testSwitch];
    [self.view addSubview:_testLabel];
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* changeTest = [settings objectForKey:kUserDefaultKeyChangeTest];
    if (!changeTest) {
        // 若没有设置过，直接切换测试环境
        [settings setObject:@"test" forKey:kUserDefaultKeyChangeTest];
        [settings synchronize];
        [_testSwitch setOn:YES animated:YES];
        [_testLabel setText:@"测试环境"];
    }else{
        if ([changeTest isEqualToString:@"test"]) {
            // 测试环境
            [_testSwitch setOn:YES animated:YES];
            [_testLabel setText:@"测试环境"];
        }else{
            // 正式环境
            [_testSwitch setOn:NO animated:YES];
            [_testLabel setText:@"正式环境"];
        }
    }
}

-(void)switchValueChangeEvent:(UISwitch*)sender{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    if (sender.on) {
        // 选择，切换test
        [settings setObject:@"test" forKey:kUserDefaultKeyChangeTest];
        DLog(@"切换测试==================");
        [_testLabel setText:@"测试环境"];
    }else{
        // 切换正式
        [settings setObject:@"" forKey:kUserDefaultKeyChangeTest];
        DLog(@"切换正式==================");
        [_testLabel setText:@"正式环境"];
    }
    
    [settings synchronize];
    
    // 做退出操作
    [[MemberManager sharedInstance] logout];
    [_collectionView reloadData];
    [_reusableView refreshHeaderView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* isShowTabbarRed = [settings objectForKey:kUserDefaultKeyIsShowTabbarRed];
    //已注册，第一次为点击科普员补充资料，弹出指引页面
    if([isShowTabbarRed isEqualToString:@"1"]){
        JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:[MyAlertViewController new]];
        navigationController.modalPresentationStyle = UIModalPresentationCustom;
        UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
        [vc presentViewController:navigationController animated:YES
                       completion:nil];
        
        [AppDelegate appdelegate].badgeview1.hidden = YES;
        
        
        [settings setObject:@"2" forKey:kUserDefaultKeyIsShowTabbarRed];
    }
    
    
    //    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //    NSString* isShowTabbarRed = [settings objectForKey:kUserDefaultKeyIsShowTabbarRed];
    //
    //    //已注册，第一次为点击科普员补充资料，弹出指引页面
    ////    if([isShowTabbarRed isEqualToString:@"1"]){
    //
    //        MyAlertViewController * transparentVC = [[MyAlertViewController alloc] initWithNibName:@"MyAlertViewController" bundle:nil];
    //        transparentVC.delegate = self;
    //        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
    //            transparentVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //        }else{
    //            self.modalPresentationStyle=UIModalPresentationOverFullScreen;
    //        }
    //        //        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    //        [self presentViewController:transparentVC animated:YES completion:nil];
    //
    //        [AppDelegate appdelegate].badgeview1.hidden = YES;
    //
    //        [settings setObject:@"2" forKey:kUserDefaultKeyIsShowTabbarRed];
    //    }else{
    //
    //    }
    
    // 1、即时获取界面数据
    if ([[MemberManager sharedInstance] isLogined]) {
        [[WebAccessManager sharedInstance]analyseMemberIsSceBycompletion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                if ([[MemberManager sharedInstance] isLogined]) {
                    //是否是科普员：0-是科普员、1-非科普员
                    [MemberManager sharedInstance].getMember.isKepu = response.data.is_sciencer;
                }
                
                if ([response.data.is_sciencer isEqualToString:@"1"]) {
                    _Title_VolunteerApproven =@"科普员管理";
                }else{
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                
                // 检查是否已申请
                if ([response.data.is_sciencer isEqualToString:@"0"])//待审核
                {
                    _Title_VolunteerApproven =@"科普员认证";
                }
                else if([response.data.is_sciencer isEqualToString:@"1"])//是科普员
                {
                    _Title_VolunteerApproven =@"科普员管理";
                }
                else if ([response.data.is_sciencer isEqualToString:@"2"])//非科普员
                {
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                else if([response.data.is_sciencer isEqualToString:@"3"])//审批永久拒绝
                {
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                [_reusableView refreshHeaderView];
                
                [_collectionView reloadData];
            }
        }];
    }else{
        [_reusableView refreshHeaderView];
        [_collectionView reloadData];
    }
    
    
    [self loadMyScore];
    [self getCommentAndCollectData:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _fontSize = [defaults objectForKey:kUserDefaultKeyPreferedFontSize];
    
}
#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

#pragma mark - 初始化方法
#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCommentAndCollectData:) name:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
}

-(void)initData{
    
}

-(NSArray *)itemArry{
    
    ///    NSString *stationTitle = Title_MyStation;
    //    if ([MemberManager sharedInstance].isLogined) {
    //        // 登录则跳转、判断登录方式是否是第三方登录
    //        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
    //
    //        NSString *channel = [loginCredential objectForKey:@"channel"];
    //
    //        if (![channel isEqualToString:@"4"]) {
    //            stationTitle = Title_MyStation;
    //            // 第三方登录，无需修改密码
    //            _itemArry   = [[NSMutableArray alloc] initWithObjects:Title_BrowsingHistory,Title_ClearCash,Title_Setting,Title_About,Title_Share,Title_VolunteerApprove,Title_LogOut, nil];
    //        }else{
    //            Member *member = [MemberManager sharedInstance].getMember;
    //            DLog(@"是否是基站用户：%@",member.isOrg);
    //            if ([member.isOrg isEqualToString:@"0"]) {
    //                stationTitle = Title_MyStation;
    //            }else{
    //                stationTitle = Title_StationCertification;
    //            }
    //
    //            _itemArry   = [[NSMutableArray alloc] initWithObjects:Title_BrowsingHistory,Title_ClearCash,Title_Setting,Title_About,Title_Share,Title_VolunteerApprove,stationTitle,Title_GetRewards,Title_LogOut, nil];
    //        }
    //    }else{
    //        stationTitle = Title_MyStation;
    //        _itemArry   = [[NSMutableArray alloc] initWithObjects:Title_BrowsingHistory,Title_ClearCash,Title_Setting,Title_About,Title_Share,Title_VolunteerApprove,stationTitle,Title_GetRewards, nil];
    //    }
    
    NSString *stationTitle = Title_MyStation;
    if ([MemberManager sharedInstance].isLogined) {
        // 登录则跳转、判断登录方式是否是第三方登录
        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
        
        NSString *channel = [loginCredential objectForKey:@"channel"];
        Member *member = [MemberManager sharedInstance].getMember;
        
        if (![channel isEqualToString:@"4"]) {
            // 第三方登录
            stationTitle = Title_MyStation;
        }else{
            
            DLog(@"是否是基站用户：%@",member.isOrg);
            if ([member.isOrg isEqualToString:@"0"]) {
                stationTitle = Title_MyStation;
            }else{
                stationTitle = Title_StationCertification;
            }
        }
        
        if ([member.isKepu isEqualToString:@"0"]) {
            // 科普员
            _itemArry   = [[NSMutableArray alloc] initWithObjects:_Title_VolunteerApproven,Title_ChannelCollection,stationTitle,Title_GetRewards,Title_BrowsingHistory,Title_Setting,Title_About, Title_Service,Title_LogOut,nil];
        }else{
            _itemArry   = [[NSMutableArray alloc] initWithObjects:_Title_VolunteerApproven,Title_ChannelCollection,stationTitle,Title_GetRewards,Title_BrowsingHistory,Title_Setting,Title_About, Title_Service,Title_LogOut, nil];
        }
        
    }else{
        stationTitle = Title_MyStation;
        _itemArry   = [[NSMutableArray alloc] initWithObjects:_Title_VolunteerApproven,Title_ChannelCollection,stationTitle,Title_GetRewards,Title_BrowsingHistory,Title_Setting,Title_About,Title_Service, nil];
    }
    
    return _itemArry;
}
-(NSArray *)imagesArry{
    
    //    if ([MemberManager sharedInstance].isLogined) {
    //        // 登录则跳转、判断登录方式是否是第三方登录
    //        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
    //
    //        NSString *channel = [loginCredential objectForKey:@"channel"];
    //
    //        if (![channel isEqualToString:@"4"]) {
    //            // 第三方登录，无需修改密码
    //            _imagesArry = [[NSMutableArray alloc] initWithObjects:Image_BrowsingHistory,Image_ClearCash,Image_Setting,Image_About,Image_Share,Image_VolunteerApprove,Image_LogOut, nil];
    //        }else{
    //            _imagesArry = [[NSMutableArray alloc] initWithObjects:Image_BrowsingHistory,Image_ClearCash,Image_Setting,Image_About,Image_Share,Image_VolunteerApprove,Image_MyStation,Image_GetRewards,Image_LogOut, nil];
    //        }
    //    }else{
    //        _imagesArry = [[NSMutableArray alloc] initWithObjects:Image_BrowsingHistory,Image_ClearCash,Image_Setting,Image_About,Image_Share,Image_VolunteerApprove,Image_MyStation,Image_GetRewards, nil];
    //    }
    
    if ([MemberManager sharedInstance].isLogined) {
        _imagesArry = [[NSMutableArray alloc] initWithObjects:Image_VolunteerApprove,Image_ChannelCollection,Image_MyStation,Image_GetRewards,Image_BrowsingHistory,Image_Setting,Image_About,Image_Service,Image_LogOut, nil];
        
    }else{
        _imagesArry = [[NSMutableArray alloc] initWithObjects:Image_VolunteerApprove,Image_ChannelCollection,Image_MyStation,Image_GetRewards,Image_BrowsingHistory,Image_Setting,Image_About,Image_Service, nil];
    }
    
    return _imagesArry;
}

-(void)setupview{
    self.view.backgroundColor = RGBCOLOR(242.0, 242.0, 242.0);
    
    /*
     CGFloat viewheight = kSCREEN_HEIGHT>kHEIGHT_480 ? kSCREEN_HEIGHT : kHEIGHT_568;
     NSInteger _column = 3;
     NSInteger _rows = self.itemArry.count/_column + (self.itemArry.count%_column?1:0);
     CGFloat cellHeight = (viewheight-CollectionReusableHeaderViewOnMyHeight)/_rows;
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     layout.minimumInteritemSpacing = 0;//横向item间距(最小值)
     layout.minimumLineSpacing = 0;//行间距
     layout.itemSize = CGSizeMake(self.showWidth/_column, cellHeight);//每个UICollectionViewCell 的大小
     layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//每个UICollectionViewCell 的 margin
     layout.headerReferenceSize = CGSizeMake(self.showWidth, CollectionReusableHeaderViewOnMyHeight);//分组头视图的size
     
     //        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, viewheight) collectionViewLayout:layout];
     //        _collectionView.contentInset = UIEdgeInsetsMake(0, self.leftEdge, 0, self.leftEdge);
     _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, viewheight) collectionViewLayout:layout];
     //collectionView.width = 6;
     _collectionView.showsHorizontalScrollIndicator = NO;
     _collectionView.delegate = self;
     _collectionView.dataSource = self;
     _collectionView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:_collectionView];
     
     [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:[MyCollectionViewCell ID]];
     [_collectionView registerClass:[CollectionReusableHeaderViewOnMy class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[CollectionReusableHeaderViewOnMy ID]];
     */
    
    CGFloat headerViewHeight = isIpad ? (466.0/728.0*MAIN_SCREEN_WIDTH) : CollectionReusableHeaderViewOnMyHeight;
    
    _reusableView = [[CollectionReusableHeaderViewOnMy alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, headerViewHeight)];
    _reusableView.delegate = self;
    [_reusableView refreshHeaderView];
    [self.view addSubview:_reusableView];
    
    
    CGFloat spaceHeight = 9.0;//headerview 与 collectionview 之间的间距
    CGFloat viewheight = kSCREEN_HEIGHT>kHEIGHT_480 ? kSCREEN_HEIGHT : kHEIGHT_568;
    NSInteger _column = 4;
    NSInteger _rows = self.itemArry.count/_column + (self.itemArry.count%_column?1:0);
    if (is4InchScreen() || is35InchScreen()) {
        _rows = 3;
    } else {
        _rows = 4;
    }
    CGFloat cellHeight = (viewheight-headerViewHeight-spaceHeight)/_rows;
    
    if (kSCREEN_WIDTH < kWIDTH_375) {
        cellHeight = cellHeight - 20;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;//横向item间距(最小值)
    layout.minimumLineSpacing = 0;//行间距
    layout.itemSize = CGSizeMake(self.showWidth/_column, cellHeight);//每个UICollectionViewCell 的大小
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//每个UICollectionViewCell 的 margin
    //layout.headerReferenceSize = CGSizeMake(self.showWidth, CollectionReusableHeaderViewOnMyHeight);//分组头视图的size
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headerViewHeight+spaceHeight, MAIN_SCREEN_WIDTH, viewheight-headerViewHeight-spaceHeight) collectionViewLayout:layout];
    _collectionView.contentInset = UIEdgeInsetsMake(0, self.leftEdge, 0, self.leftEdge);
    //collectionView.width = 6;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:[MyCollectionViewCell ID]];
    
}
-(void)leftNavBtnAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger sec = self.itemArry.count;
    return sec;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[MyCollectionViewCell ID] forIndexPath:indexPath];
    
    [cell setCellWithTitle:self.itemArry[indexPath.row] image:self.imagesArry[indexPath.row] fontsize:_fontSize];
    
    return cell;
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    _reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[CollectionReusableHeaderViewOnMy ID] forIndexPath:indexPath];
//    _reusableView.delegate = self;
//    [_reusableView refreshHeaderView];
//    return _reusableView;
//}

#pragma mark UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取是否需要弹出绑定手机号页面
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* isShowBindCellPhone = [settings objectForKey:kUserDefaultKeyIsShowBindCellPhone];
    
    NSString *title = self.itemArry[indexPath.row];
    if ([title isEqualToString:Title_BrowsingHistory]) {
        [self gotoBrowsingHistoryVC];
    } else if ([title isEqualToString:Title_ChannelCollection]) {
        [self.navigationController pushViewController:[ChannelCollectionViewController new] animated:YES];
    } else if ([title isEqualToString:Title_ModifyPW]) {
        [self gotoModifyPasswordVC];
    } else if ([title isEqualToString:Title_Setting]) {
        [self gotoSettingVC];
    } else if ([title isEqualToString:Title_About]) {
        [self gotoAboutVC];
    } else if ([title isEqualToString:_Title_VolunteerApproven]) {
        
        if([isShowBindCellPhone isEqualToString: @"1"]){
            [self isShowBindCellPhone];
        }else{
            [self identificationAction];
        }
        
    } else if ([title isEqualToString:Title_MyStation] ||
               [title isEqualToString:Title_StationCertification]) {
        [self gotoMyStationVC];
    } else if ([title isEqualToString:Title_GetRewards]) {
        [self gotoGetRewardsVC];
    }
    //    else if ([title isEqualToString:Title_EStation]) {
    //        [self gotoEStation];
    //    }
    else if ([title isEqualToString:Title_Service]) {
        [self gotoKefu];
    } else if ([title isEqualToString:Title_LogOut]) {
        [self logOut];
    }
}

//跳转绑定手机号页面
-(void)isShowBindCellPhone{
    BindCellPhoneViewController* lrVC = [BindCellPhoneViewController new];
    lrVC.delegate = self;
    JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:lrVC];
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:navigationController animated:YES
                     completion:nil];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark -点击返回按钮
#pragma mark CollectionReusableHeaderViewOnMyDelegate
//返回按钮
-(void)tapLeftButton{
    // 改版
    //    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    //    [menuController showLeftController:YES];
}
//本月积分
-(void)tapMonthIntegral{
    if ([[MemberManager sharedInstance] isLogined]) {
        [FlowUtil startToMonthIntegralVCNav:self.navigationController completion:nil];
    }else{
        [self gotoLogin];
    }
    
}
//点击头像
-(void)tapUserHeader{
    [self gotoPersonalInfoVC];
}
//点击收藏视图
-(void)tapCollectViewDelegateFun{
    [self gotoCollectVC];
}
//点击积分视图
-(void)tapIntegralViewDelegateFun{
    [self gotointegralVC];
}
//点击评论视图
-(void)tapCommentViewDelegateFun{
    [self gotoCommentVC];
}
#pragma mark - item点击事件
-(void)gotoLogin{
    //[FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController completion:nil];
    
    //    JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:[LoginAndRegisterViewController new]];
    //    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    //    UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
    //    [vc presentViewController:navigationController animated:YES
    //                   completion:nil];
    
    // 跳转登录界面
    [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:YES completion:nil];
}
// 跳转个人信息页
- (void)gotoPersonalInfoVC {
    if ([[MemberManager sharedInstance] isLogined]) {
        [FlowUtil startToMemberInfoVCNav:self.navigationController completion:nil];
    }else{
        [self gotoLogin];
    }
}
// 跳转收藏页
- (void)gotoCollectVC{
    if ([MemberManager sharedInstance].isLogined) {
        [FlowUtil startToMyCollectInfoVCNav:self.navigationController completion:nil];
    }else{
        [self gotoLogin];
    }
}
//跳转至  积分界面
-(void)gotointegralVC{
    if ([MemberManager sharedInstance].isLogined) {
        
        // 登录则跳转、判断登录方式是否是第三方登录
        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
        
        NSString *channel = [loginCredential objectForKey:@"channel"];
        
        if (![channel isEqualToString:@"4"]) {
            // 第三方登录
            return;
        }else{
            [FlowUtil startToIntegrationSummaryVCNav:self.navigationController completion:nil];
        }
        
    }else{
        [self gotoLogin];
    }
}
// 跳转评论页
- (void)gotoCommentVC{
    if ([MemberManager sharedInstance].isLogined) {
        [FlowUtil startToMyCommentInfoVCNav:self.navigationController completion:nil];
    }else{
        [self gotoLogin];
    }
}

- (void)cllearCache{
    [SVProgressHUDUtil showWithStatus:@"正在清理..."];
    [[SDImageCache sharedImageCache] clearMemory];
    [CustomDownloadManager deleteAllDownloadVideo];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_main_after(1.5, ^{
            [SVProgressHUDUtil showSuccessWithStatus:@"清理成功!"];
        });
    }];
}

- (void)gotoBrowsingHistoryVC{
    [FlowUtil startToRecordVCNav:self.navigationController completion:nil];
}

- (void)gotoAboutVC{
    [FlowUtil startToAboutNewToFriendVCNav:self.navigationController completion:nil];
}

- (void)gotoSettingVC{
    [FlowUtil startToSettingVCNav:self.navigationController completion:nil];
}

- (void)gotoShareVC{
    [FlowUtil startToShareToFriendVCNav:self.navigationController completion:nil];
}

- (void)gotoModifyPasswordVC{
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
    }else{
        [self gotoLogin];
    }
}

-(void)clickNbvBtn{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

//tabbar跳转
-(void)clickBindCellPhoneBtn{
    [AppDelegate appdelegate].tabBarController.selectedIndex = 0;
    //     [self.navigationController pushViewController:[ChannelContainerViewController new] animated:NO];
}

- (void)identificationAction{
    
    //    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //    NSString* isShowTabbarRed = [settings objectForKey:kUserDefaultKeyIsShowTabbarRed];
    //
    //    //已注册，第一次为点击科普员补充资料，弹出指引页面
    //    if([isShowTabbarRed isEqualToString:@"1"]){
    //
    //        MyAlertViewController * transparentVC = [[MyAlertViewController alloc] initWithNibName:@"MyAlertViewController" bundle:nil];
    //        transparentVC.delegate = self;
    //        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
    //            transparentVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //        }else{
    //            self.modalPresentationStyle=UIModalPresentationOverFullScreen;
    //        }
    //        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    //        [self presentViewController:transparentVC animated:YES completion:nil];
    //
    //        [AppDelegate appdelegate].badgeview1.hidden = YES;
    //
    //        [settings setObject:@"2" forKey:kUserDefaultKeyIsShowTabbarRed];
    //    }else{
    [NBSAppAgent leaveBreadcrumb:@"identificationAction"];//设置面包屑
    //科普员认证
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:YES completion:nil];
    }else{
        
        // 登录则跳转、判断登录方式是否是第三方登录
        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
        
        NSString *channel = [loginCredential objectForKey:@"channel"];
        
        if (![channel isEqualToString:@"4"]) {
            // 第三方登录
            [SVProgressHUDUtil showInfoWithStatus:@"暂不支持第三方认证，请用手机号注册用户！"];
        }else{
            
            [SVProgressHUDUtil show];
            [[WebAccessManager sharedInstance]analyseMemberIsSceBycompletion:^(WebResponse *response, NSError *error) {
                if (response.success)
                {
                    [SVProgressHUDUtil dismiss];
                    
                    if ([response.data.is_sciencer isEqualToString:@"1"]) {
                        [MemberManager sharedInstance].getMember.isKepu =@"0";
                    }else{
                        [MemberManager sharedInstance].getMember.isKepu =@"1";
                    }
                    
                    // 检查是否已申请
                    if ([response.data.is_sciencer isEqualToString:@"0"])//待审核
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else if([response.data.is_sciencer isEqualToString:@"1"])//是科普员
                    {
                        /**
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经是科普员了" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                         [alert show];
                         */
                        // 三期调整
                        Sciencer* sciencer = response.data.sciencer;
                        if (sciencer) {
                            [FlowUtil startToSummaryVCNav:self.navigationController withSciencer:sciencer];
                        }
                    }
                    else if ([response.data.is_sciencer isEqualToString:@"2"])//非科普员
                    {
                        [FlowUtil startToVolunteerApproveVCNav:self.navigationController];
                    }
                    else if([response.data.is_sciencer isEqualToString:@"3"])//审批永久拒绝
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您被系统永久拒绝申请" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else
                {
                    [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
                }
            }];
            
        }
        
        
        
    }
    //    }
    
}
//跳转至  我的基站
-(void)gotoMyStationVC{
    //    [SVProgressHUDUtil showInfoWithStatus:@"维护中"];
    //    return;
    if ([[MemberManager sharedInstance] isLogined]) {
        
        [self handleStation];
        
    }else{
        [self gotoLogin];
    }
}
//跳转至领取奖励
-(void)gotoGetRewardsVC{
    if ([[MemberManager sharedInstance] isLogined]) {
        
        // 登录则跳转、判断登录方式是否是第三方登录
        NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
        NSString *channel = [loginCredential objectForKey:@"channel"];
        if (![channel isEqualToString:@"4"]) {
            // 第三方登录
            [SVProgressHUDUtil showInfoWithStatus:@"暂不支持第三方领取奖励，请用手机号注册用户！"];
        }else{
            [FlowUtil startToGetRewardsVCNav:self.navigationController completion:nil];
        }
        
    }else{
        [self gotoLogin];
    }
    
}

-(void)gotoOfflineDownload{
    // 登录则跳转、判断登录方式是否是第三方登录
    [FlowUtil startToDownloadVideoVCNav:self.navigationController];
}

-(void)gotoEStation{
    [self.navigationController pushViewController:[EStationViewController new] animated:YES];
}

-(void)gotoKefu{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager pushMQChatViewControllerInViewController:self];
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
#pragma mark netWork
//获取收藏数&评论数
- (void)getCommentAndCollectData:(NSNotification*)notification{
    
    if ([[MemberManager sharedInstance] isLogined]) {
        // 2、设置评论数、收藏数量
        [[WebAccessManager sharedInstance]getQuantityStatisticsWithcompletion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                if ([[MemberManager sharedInstance] isLogined]) {
                    //是否是科普员：0-是科普员、1-非科普员
                    [MemberManager sharedInstance].getMember.isKepu = response.data.is_sciencer;
                }
                [_reusableView setNumsWithWebResponse:response];
                [_reusableView refreshHeaderView];
            }
        }];
        
        [[WebAccessManager sharedInstance]analyseMemberIsSceBycompletion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                if ([[MemberManager sharedInstance] isLogined]) {
                    //是否是科普员：0-是科普员、1-非科普员
                    [MemberManager sharedInstance].getMember.isKepu = response.data.is_sciencer;
                }
                
                if ([response.data.is_sciencer isEqualToString:@"1"]) {
                    _Title_VolunteerApproven =@"科普员管理";
                }else{
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                
                // 检查是否已申请
                if ([response.data.is_sciencer isEqualToString:@"0"])//待审核
                {
                    _Title_VolunteerApproven =@"科普员认证";
                }
                else if([response.data.is_sciencer isEqualToString:@"1"])//是科普员
                {
                    _Title_VolunteerApproven =@"科普员管理";
                }
                else if ([response.data.is_sciencer isEqualToString:@"2"])//非科普员
                {
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                else if([response.data.is_sciencer isEqualToString:@"3"])//审批永久拒绝
                {
                    _Title_VolunteerApproven =@"科普员补充资料";
                }
                
                
                [_collectionView reloadData];
            }
        }];
    }
    
}
//获取积分数据
-(void)loadMyScore{
    if ([MemberManager sharedInstance].isLogined) {
        [[WebAccessManager sharedInstance] getMemberScoreWithcompletion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                Score *score =  [MemberManager sharedInstance].score;
                score.currentMonthScore = response.data.currentMonthScore;
                score.fromScore = response.data.fromScore;
                score.toScore = response.data.toScore;
                score.totalScore = response.data.totalScore;
                score.grade = response.data.grade;
                score.gradeName = response.data.gradeName;
                [MemberManager sharedInstance].score = score;
                
                [_collectionView reloadData];
                [_reusableView refreshHeaderView];
                
            }else{
                //[SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}
-(void)handleStation{
    // 登录则跳转、判断登录方式是否是第三方登录
    NSDictionary *loginCredential = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLoginCredential];
    NSString *channel = [loginCredential objectForKey:@"channel"];
    if (![channel isEqualToString:@"4"]) {
        // 第三方登录
        [SVProgressHUDUtil showInfoWithStatus:@"暂不支持第三方查看基站，请用手机号注册用户！"];
    }else{
        [SVProgressHUDUtil show];
        [[WebAccessManager sharedInstance]getMyEstationWithcompletion:^(WebResponse *response, NSError *error) {
            [SVProgressHUDUtil dismiss];
            if (response.success)
            {
                Member *member = [MemberManager sharedInstance].getMember;
                
                //is_org：0-待审批、1-基站用户、2-非基站用户、3-基站用户已被禁用
                if ([response.data.is_org isEqualToString:@"0"])
                {
                    member.isOrg = @"1";
                    //待审批
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([response.data.is_org isEqualToString:@"1"])
                {
                    member.isOrg = @"0";
                    //是基站用户
                    [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:response.data.or_id isShowEditBtn:@"yes"];
                }
                else if ([response.data.is_org isEqualToString:@"2"])
                {
                    member.isOrg = @"1";
                    //不是基站用户
                    [FlowUtil startEstationCertificationVCNav:self.navigationController];
                }
                else if ([response.data.is_org isEqualToString:@"3"])
                {
                    member.isOrg = @"3";
                    //基站用户已被禁用
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"基站用户已被禁用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }];
    }
    
}
-(void)logOut{
    MMPopupItemHandler block = ^(NSInteger index){
        if (index == 0) {
            
        }
        
        if (index == 1) {
            _Title_VolunteerApproven =@"科普员认证";
            [[MemberManager sharedInstance] logout];
            
            [_collectionView reloadData];
            [_reusableView refreshHeaderView];
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
@end

