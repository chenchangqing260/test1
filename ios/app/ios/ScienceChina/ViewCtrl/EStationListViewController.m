//
//  EStationListViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationListViewController.h"
#import "EStationListCell.h"
#import "EStationListHeaderCell.h"

@interface EStationListViewController ()<EStationListHeaderDelegate,EStationListCellDelegate>

@property (nonatomic, strong)NSMutableArray* recStationCategoryArray;
@property (nonatomic, strong)NSMutableArray* eStationArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation EStationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LStr(@"estation");
    
    // 1、初始化界面数据和约束
    [self initViewAndCon];
    
    // 2、加载网络数据
    [self loadNetWorkData];
    
    // 3、注册通知刷新分类列表
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCategoryStation) name:@"refreshCategoryStation" object:nil];
}

#pragma mark - 初始化视图和约束
- (void)initViewAndCon{
    // 1、初始化数据
    _eStationArray = [NSMutableArray new];
    _recStationCategoryArray = [NSMutableArray new];
    _page = 1;
}

#pragma mark - 重写父类方法
-(BOOL)showRightNavItem{
    return YES;
}

-(void)initNavRightBtn{
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 40, 25);
    [rightNavBtn setImage:[UIImage imageNamed:@"searchnew"] forState:UIControlStateNormal];
    [rightNavBtn setImage:[UIImage imageNamed:@"searchnew"] forState:UIControlStateHighlighted];
    [rightNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -20)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 网络数据加载
- (void)loadNetWorkData{
    // 1、加载E站的顶部轮播
    [self loadRecommendData];
    
    // 2、加载E站列表
    [self loadEStationList];
}

// 加载顶部推荐数据
- (void)loadRecommendData{
    [[WebAccessManager sharedInstance]getEStationOfRecommendListWtihCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _recStationCategoryArray = response.data.stationRankList;
            // 刷新TableView
            [self.uiTableView reloadData];
        }
    }];
}

// 加载E站列表
- (void)loadEStationList{
    [[WebAccessManager sharedInstance]getEStationListWtihPage:_page Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _eStationArray = response.data.stationList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_eStationArray addObjectsFromArray:[response.data.stationList copy]];
                    
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

#pragma mark - 自定义方法，包含通知
-(void)rightNavBtnAction{
     [FlowUtil startToEStationSearchVCNav:self.navigationController];
}

// 刷新通知
- (void)refreshCategoryStation{
    self.page = 1;
    [self loadEStationList];
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
        return _eStationArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图
        EStationListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationListHeaderCell ID]];
        if (!cell) {
            cell = [EStationListHeaderCell newCell];
        }
        cell.delegate = self;
        cell.imageURLs = _recStationCategoryArray;
        
        return cell;
    }else{
        EStationListCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationListCell ID]];
        if (!cell) {
            cell = [EStationListCell newCell];
        }
        
        cell.delegate = self;
        
        [cell initCellData:[_eStationArray objectAtIndex:indexPath.row] indexPath:indexPath];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        EStation* station = [_eStationArray objectAtIndex:indexPath.row];
        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图在375的高度是175，根据比例计算
        return 175 * self.showWidth / kWIDTH_375 + 90;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - TableView MJRefresh
-(BOOL)showMJHeader{
    return NO;
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadEStationList];
}

#pragma mark - EStationListHeaderCell Delegate
- (void)selectEStationListWithType:(EStationListType)type{
    if (type == Fenlei) {
        [FlowUtil startToEStationCategoryVCNav:self.navigationController];
    }else if(type == Remen){
        [FlowUtil startToEStationTypeVCNav:self.navigationController navTitle:@"最热门" type:@"0"];
    }else if(type == Youqu){
        [FlowUtil startToEStationTypeVCNav:self.navigationController navTitle:@"最有趣" type:@"1"];
    }else if(type == Xinxian){
        [FlowUtil startToEStationTypeVCNav:self.navigationController navTitle:@"最新鲜" type:@"2"];
    }
}

#pragma mark - EStationListCell Delegate
-(void)refreshTableViewCellWithIndexPath:(NSIndexPath*)indexPath;{
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:indexPath];
    [self.uiTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
}

- (void)clickStationRank:(EStationRank*)rank{
    [FlowUtil startToEStationRankVCNav:self.navigationController rank:rank];
}

@end
