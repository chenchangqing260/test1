//
//  HomeTabBarController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/18.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HomeTabBarController.h"
#import "LeftListViewController.h"
//首页
#import "ChoseStationViewController.h"
#import "ChannelListViewController.h"
#import "ChannelCollectionViewController.h"

@interface HomeTabBarController ()

@end

@implementation HomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init{
    if (self = [super init]) {
        [self setupControllers];
    }
    return self;
}


-(void)setupControllers{
    ChannelCollectionViewController *channelVC = [[ChannelCollectionViewController alloc] init];
    //ChoseStationViewController *channelVC = [[ChoseStationViewController alloc] init];
    //ChannelListViewController *channelVC = [[ChannelListViewController alloc] init];
    // 改版
//    ChannelContainerViewController *channelContainerVC = [[ChannelContainerViewController alloc] init];
//    
//    JTNavigationController *nav1 = [[JTNavigationController alloc] initWithRootViewController:channelVC];
//    JTNavigationController *nav2 = [[JTNavigationController alloc] initWithRootViewController:channelContainerVC];
    
    UIImage *defaultImg1 = [UIImage imageNamed:@"homeTabItem1"];
    UIImage *defaultImg2 = [UIImage imageNamed:@"homeTabItem2"];
    UIImage *tapImg1     = [UIImage imageNamed:@"homeTabItem1_selected"];
    UIImage *tapImg2     = [UIImage imageNamed:@"homeTabItem2_selected"];
    
    //如果不希望使用系统颜色，需要对图片加上属性UIImageRenderingModeAlwaysOriginal
    defaultImg1 = [defaultImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    defaultImg2 = [defaultImg2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tapImg1     = [tapImg1     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tapImg2     = [tapImg2     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 改版
//    nav1.tabBarItem.image      = defaultImg1;
//    nav2.tabBarItem.image      = defaultImg2;
//    nav1.tabBarItem.selectedImage      = tapImg1;
//    nav2.tabBarItem.selectedImage      = tapImg2;
    
    //    channelVC.tabBarItem.title = @"九宫格";
    //    menuController.tabBarItem.title = @"APP";
    // 改版
//    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2, nil];
}

@end
