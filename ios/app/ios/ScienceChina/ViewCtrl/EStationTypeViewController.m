//
//  EStationTypeViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationTypeViewController.h"
#import "EStationListCell.h"

@interface EStationTypeViewController ()<EStationListCellDelegate>

@property (nonatomic, strong)NSMutableArray* stationArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation EStationTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitlle;
    
    // 1、初始化界面数据和约束
    [self initViewAndCon];
    
    // 2、加载网络数据
    [self loadEStationList];
    
    // 3、注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTypeStationList) name:@"refreshTypeStationList" object:nil];
}

#pragma mark - 自定义方法(包括通知)
- (void)refreshTypeStationList{
    self.page = 1;
    [self loadEStationList];
}

#pragma mark - 初始化视图和约束
- (void)initViewAndCon{
    // 1、初始化数据
    _stationArray = [NSMutableArray new];
    _page = 1;
}

#pragma mark - 网络数据加载
// 加载E站列表
- (void)loadEStationList{
    [[WebAccessManager sharedInstance]getEStationListOfType:self.type Page:self.page Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _stationArray = response.data.stationList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_stationArray addObjectsFromArray:[response.data.stationList copy]];
                    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _stationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EStationListCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationListCell ID]];
    if (!cell) {
        cell = [EStationListCell newCell];
    }
    
    cell.delegate = self;
    
    [cell initCellData:[_stationArray objectAtIndex:indexPath.row] indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EStation* station = [_stationArray objectAtIndex:indexPath.row];
    [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadEStationList];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadEStationList];
}

#pragma mark - EStationListCell Delegate
-(void)refreshTableViewCellWithIndexPath:(NSIndexPath*)indexPath;{
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:indexPath];
    [self.uiTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
}

@end
