//
//  HomePagerViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HomePagerViewController.h"
#import "HomePageViewController.h"
#import "DailyInfoView.h"
#import "AppDelegate.h"

@interface HomePagerViewController ()<DailyInfoViewDelegate>

@property (nonatomic, strong)DailyInfoView* dailyInfoView;
@property (nonatomic, strong)UIButton *questionBtn;
@property (nonatomic, strong)UIButton *downloadBtn;

@end

@implementation HomePagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、加载每日推荐
    self.dailyInfoView = [[NSBundle mainBundle]loadNibNamed:@"DailyInfoView" owner:nil options:nil][0];
    self.dailyInfoView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    self.dailyInfoView.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAdvertImgView) name:@"showAdvertImgView" object:nil];
    
    // 2、判断是否要显示，若引导页没有完成，则先不显示
//    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
//    if ([settings objectForKey:kAppCurVersion]) {
        // 引导页已经显示，则判断是否显示广告页
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"showAdvertImgView" object:nil];//不显示引导页
//    }
}

#pragma mark - 重写父类方法
-(void)initNavLeftBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
        [leftNavBtn setImage:[UIImage imageNamed:@"查询"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"查询"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

// 左侧返回点击事件
-(void)leftNavBtnAction{
    [FlowUtil startToMainSearchVCNav:self.navigationController];
}

-(BOOL)showRightNavItem{
    return YES;
}

-(void)initNavRightBtn{
    if ([self showRightNavItem]) {
        // 疑问按钮
        self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.downloadBtn.frame = CGRectMake(kSCREEN_WIDTH - 40, 0, 40, 44);
        [self.downloadBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [self.downloadBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateHighlighted];
        [self.downloadBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.downloadBtn addTarget:self action:@selector(clickDownloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:self.downloadBtn];
        
        // 下载按钮
        self.questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.questionBtn.frame = CGRectMake(kSCREEN_WIDTH - 80, 0, 40, 44);
        [self.questionBtn setImage:[UIImage imageNamed:@"疑问"] forState:UIControlStateNormal];
        [self.questionBtn setImage:[UIImage imageNamed:@"疑问"] forState:UIControlStateHighlighted];
        [self.questionBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [self.questionBtn addTarget:self action:@selector(clickQuestionBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:self.questionBtn];
    }
}

-(void)clickDownloadBtnAction{
    [FlowUtil startToDownloadVideoVCNav:self.navigationController];
}

-(void)clickQuestionBtnAction{
    [FlowUtil startToQuestionHomeVCNav:self.navigationController];
}

- (void)showAdvertImgView{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* showDaily = [settings objectForKey:kUserDefaultKeyShowDaily];
    if (!showDaily || ![showDaily isEqualToString:@"NotShow"]) {
        NSString* advertShow = [settings objectForKey:@"advertImgView"];
        if ([advertShow isEqualToString:@"show"]) {
            // 2、加载每日推荐数据
            [[WebAccessManager sharedInstance]getDailyInfoListWithCompletion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    self.dailyInfoView.dailyInfoArray = response.data.dailyRecommendList;
                    // 打开每日推荐
                    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                    [appDelegate.window addSubview:self.dailyInfoView];
                }
            }];
        }
    }
}

#pragma mark - DailyViewDelegate
- (void)clickDailyInfoWithHomeModel:(HomeModel *)model{
    if ([model.in_classify isEqualToString:@"0"] || [model.in_classify isEqualToString:@"4"]) {
        // 图文、文字
        [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"1"]){
        // 图集
        [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"2"]){
        // 视频
        [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"3"]){
        // 专题
        // TODO ELLISON
        DLog(@"===========专题跳转============");
        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:model.in_id];
    }
    
    [self.dailyInfoView removeFromSuperview];
}

- (void)closeDailyInfoView{
    [self.dailyInfoView removeFromSuperview];
}

@end
