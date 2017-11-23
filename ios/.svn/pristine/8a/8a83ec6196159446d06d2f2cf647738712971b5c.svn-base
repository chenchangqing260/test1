//
//  QuesMainViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesMainViewController.h"
#import "QuesMainItemCell.h"
#import "QuesMainHeaderCell.h"
#import "Question.h"
#import "TextUtil.h"
#import "ChannelCollectionViewController.h"

@interface QuesMainViewController ()<QuestionMainHeaderDelegate>

@property (nonatomic, strong)NSMutableArray* quesArray; // 资讯列表
@property (nonatomic, strong)NSMutableArray* quesRecList; // 轮播图
@property NSInteger page;

@end

@implementation QuesMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问 答";
    
    [self setupView];
    // 1、初始化界面变量和界面
    [self initViewAndConAttribute];
    
    // 2、加载数据
    [self loadTopRecData];
    [self loadQuesListData];
}
#pragma mark - 初始化界面
-(void)setupView{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 60, 25);
    [leftNavBtn setTitle:@"关注" forState:UIControlStateNormal];
    [leftNavBtn.titleLabel setFont:FONT_14];
    [leftNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (isIpad) {
        self.trailingEdge.constant = self.leadingEdge.constant = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
    } else {
        self.trailingEdge.constant = self.leadingEdge.constant = 0;
    }
}
// 左侧导航点击事件
-(void)leftNavBtn{
    // 改版
    [self.navigationController pushViewController:[ChannelCollectionViewController new] animated:YES];
}
#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.page = 1;
    self.quesArray = [NSMutableArray new];
    self.quesRecList = [NSMutableArray new];
}

#pragma mark - 网络数据加载
- (void)loadTopRecData{
    [[WebAccessManager sharedInstance]getQuestionBannerWtihCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.quesRecList = response.data.recList;
            [self.uiTableView reloadData];
        }
    }];
}

- (void)loadQuesListData{
    [[WebAccessManager sharedInstance]getQuestionListWtihTypeid:nil page:self.page memberId:nil Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_header endRefreshing];
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _quesArray = response.data.questionsList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_quesArray addObjectsFromArray:[response.data.questionsList copy]];
                    
                    [self.uiTableView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                }
            }
        }else{
            self.page -= 1;
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 增加的一个为顶部轮播图的UITableCell
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return _quesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图
        QuesMainHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuesMainHeaderCell ID]];
        if (!cell) {
            cell = [QuesMainHeaderCell newCell];
        }
        cell.delegate = self;
        cell.quesRecList = self.quesRecList;
        
        return cell;
    }else{
        QuesMainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuesMainItemCell ID]];
        if (!cell) {
            cell = [QuesMainItemCell newCell];
        }
        
        [cell initCellDataWithQuestion:[_quesArray objectAtIndex:[indexPath row]]];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        Question* question = [self.quesArray objectAtIndex:indexPath.row];
        [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图在375的高度是235，根据比例计算
        if (self.quesRecList && self.quesRecList.count > 0) {
            CGFloat showWidth = kSCREEN_WIDTH;
            if (isIpad) {
                showWidth = MAIN_SCREEN_WIDTH_ONIpad;
            }
            return 175 * showWidth / kWIDTH_375 + 100;
        }else{
            return 100;
        }
    }else{
        CGFloat showWidth = kSCREEN_WIDTH;
        if (isIpad) {
            showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        }
        
        Question* question = [_quesArray objectAtIndex:[indexPath row]];
        
        CGFloat height = 13;
        height += 36;
        height += 15;
        height += 20;
        height += 13;
        
        CGFloat contentHeight = 0;
        
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
        if (!fontSize) {
            fontSize = @"Normal";
            [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
            [settings synchronize];
        }
        if ([fontSize isEqualToString:@"Small"]) {
            contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_13].height;
        }else if([fontSize isEqualToString:@"Large"]) {
            contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_18].height;
        }else{
            contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_14].height;
        }
        
        // 计算提问内容
        
        height += contentHeight;
        
        if (question.qu_img && ![question.qu_img isEmptyOrWhitespace]) {
            height += 10;
            height += showWidth * 208 / kWIDTH_375;
        }
        
        height += 10;
        height += 45;
        height += 10;
        
        return height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - MJRefresh
- (void)tableViewRefreshFooterData{
    self.page = 1;
    [self loadTopRecData];
    [self loadQuesListData];
}

- (void)tableViewRefreshHeaderData{
    self.page += 1;
    [self loadQuesListData];
}

#pragma mark - QuestionMainHeaderDelegate
- (void)clickAskQuesBtnAction {
    // 跳转提问界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false  isShowAlertYinDao:NO completion:nil];
    }else{
        [FlowUtil startToAskQuestionVCNav:self.navigationController];
    }
}

- (void)clickMyQuesBtnAction {
    // 跳转我的问题界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false isShowAlertYinDao:NO  completion:nil];
    }else{
        // 跳转我的提问界面
        [FlowUtil startToMyQuestionVCNav:self.navigationController];
    }
}

- (void)clickMyAnswerBtnAction {
    // 跳转我的回答界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false  isShowAlertYinDao:NO completion:nil];
    }else{
        // 跳转我的回答界面
        [FlowUtil startToMyAnswerVCNav:self.navigationController];
    }
}

- (void)clickQuestionBainnerAction:(RecList*)ques{
    // 跳转提问详情
    Question* question = [Question new];
    question.qu_id = ques.qu_id;
    question.qu_title = ques.qu_title;
    [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
}
@end
