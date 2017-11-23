//
//  BaseViewController.m
//  passbook
//
//  Created by Ellison on 16/2/16.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "QuesMainViewController.h"
#import "ActivityNewViewController.h"
#import "ShowViewController.h"
#import "MyViewController.h"
#import "RDVTabBarController.h"
#import "MJRefresh.h"
#import "ChannelContainerViewController.h"
#import "ShowViewController.h"
#import "VideoListViewController.h"

///首页
#import "ChoseStationViewController.h"
#import "ChannelListViewController.h"
#import "ChannelCollectionViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、BaseFrame
    // 1.1、布局适配
    [self adapterIOSVersion];
    
    // 1.2、定制化导航栏
    [self customNavigationBar];
    
    // 1.3、设置导航栏字体为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 1.4、右侧导航按钮
    [self initNavRightBtn];
    
    // 1.5、是否允许返回Nav手势
    self.jt_fullScreenPopGestureEnabled = [self PopGestureEnabled];
    
    // 2、集成tabbleView刷新控件
    [self settingMJRefresh];
    
    if (![self isKindOfClass:[ChannelContainerViewController class]] &&
        ![self isKindOfClass:[ShowViewController class]] &&
        ![self isKindOfClass:[ChoseStationViewController class]] &&
        ![self isKindOfClass:[ChannelListViewController class]] &&
        ![self isKindOfClass:[ChannelCollectionViewController class]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.navigationController setNavigationBarHidden:![self showNavBar] animated:NO];
    if (![self isKindOfClass:[ShowViewController class]] && ![self isKindOfClass:[ChannelContainerViewController class]] && ![self isKindOfClass:[VideoListViewController class]] &&![self isKindOfClass:[QuesMainViewController class]] && ![self isKindOfClass:[ActivityNewViewController class]] && ![self isKindOfClass:[MyViewController class]]) {
        // 不显示tabbar
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self.parentViewController isKindOfClass:[ShowViewController class]] || [self.parentViewController isKindOfClass:[ChannelContainerViewController class]] || [self isKindOfClass:[VideoListViewController class]] || [self isKindOfClass:[QuesMainViewController class]] || [self isKindOfClass:[ActivityNewViewController class]] || [self isKindOfClass:[MyViewController class]]) {
        // 不显示tabbar
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }
}

#pragma mark - BaseFrame
// 布局适配
-(void)adapterIOSVersion{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.showWidth = kSCREEN_WIDTH;
    self.leftEdge = 0;
    if (isIpad) {
        self.leftEdge = (kSCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        self.showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    self.trailingEdge.constant = self.leadingEdge.constant = self.leftEdge;
}

// 定制化导航栏
-(void)customNavigationBar{
    //1、设置导航栏字体
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    [dict setObject:[UIColor colorWithHex:0xFFFFFF] forKey:NSForegroundColorAttributeName];
    [dict setObject:FONT_17 forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //2、设置导航栏背景色和去除底部横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x000000] size:CGSizeMake(kSCREEN_WIDTH, 1)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //3、设置导航栏返回
    if (![self isKindOfClass:[ChannelContainerViewController class]] && ![self isKindOfClass:[QuesMainViewController class]] && ![self isKindOfClass:[MyViewController class]] && ![self isKindOfClass:[ActivityNewViewController class]]) {
        [self initNavLeftBtn];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

//导航栏返回
-(void)initNavLeftBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 30, 20);
    if ([self showCloseIcon]) {
        [leftNavBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateHighlighted];
    }else{
        [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateHighlighted];
    }
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)initNavRightBtn{
    if ([self showRightNavItem]) {
        UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightNavBtn.frame = CGRectMake(0, 0, 40, 25);
        [rightNavBtn setImage:[UIImage imageNamed:@"Hamburger"] forState:UIControlStateNormal];
        [rightNavBtn setImage:[UIImage imageNamed:@"Hamburger"] forState:UIControlStateHighlighted];
        [rightNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -20)];
        [rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

#pragma mark - 可重写方法
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return YES;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return YES;
}

// 左侧返回点击事件
-(void)leftNavBtnAction{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

// 显示关闭按钮，默认显示返回按钮
-(BOOL)showCloseIcon{
    return NO;
}

// 以下三个方法连起来使用，显示右侧按钮，则需要显示内容
-(BOOL)showRightNavItem{
    return NO;
}

-(void)rightNavBtnAction{
    DLog(@"右侧点击事件");
}

#pragma mark - TableView 集成刷新控件 初始化MJRefresh

-(BOOL)showMJHeader{
    return YES;
}

-(BOOL)showMJFooter{
    return YES;
}

- (void)settingMJRefresh{
    if (self.uiTableView) {
        [self initTableViewRefresh:self.uiTableView];
    }
    
    if (self.uiCollectionView) {
        [self initCollectionViewRefresh:self.uiCollectionView];
    }
}

- (void)initTableViewRefresh:(UITableView *)tableView{
    // Header
    if ([self showMJHeader]) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewRefreshHeaderData)];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        
        // 设置 Header
        tableView.mj_header = header;
    }
    
    // Footer
    if ([self showMJFooter]) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewRefreshFooterData)];
        
        // 设置文字
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        
        // 设置字体
        footer.stateLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置footer
        tableView.mj_footer = footer;
    }
}

- (void)tableViewRefreshFooterData{
    
}

- (void)tableViewRefreshHeaderData{
    
}

- (void)initCollectionViewRefresh:(UICollectionView *)collectionView{
    // Header
    if ([self showMJHeader]) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(collectionViewRefreshHeaderData)];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        
        // 设置 Header
        collectionView.mj_header = header;
    }
    
    // Footer
    if ([self showMJFooter]) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(collectionViewRefreshFooterData)];
        
        // 设置文字
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        
        // 设置字体
        footer.stateLabel.font = [UIFont systemFontOfSize:14];
        
        footer.automaticallyHidden = YES;
        footer.refreshingTitleHidden = YES;
        
        // 设置footer
        collectionView.mj_footer = footer;
        
    }
}

- (void)collectionViewRefreshHeaderData{
}

- (void)collectionViewRefreshFooterData{
}

@end
