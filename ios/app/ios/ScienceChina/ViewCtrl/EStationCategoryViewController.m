//
//  EStationCategoryViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationCategoryViewController.h"
#import "EStationCell.h"
#import "EStationCategoryCell.h"

@interface EStationCategoryViewController ()<EStationCellDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_leftView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_rightView;

@property (weak, nonatomic) IBOutlet UITableView *uiCategoryTableView;
@property (nonatomic, strong)NSMutableArray* categoryArray;
@property (nonatomic, strong)NSMutableArray* stationArray;

@property (nonatomic, strong)NSIndexPath* selectIndexPath;
@property (nonatomic, assign)NSInteger page;

@end

@implementation EStationCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LStr(@"estation");
    
    // 1、初始化数据
    [self initViewAndCon];
    
    // 2、加载分类
    [self loadCategoryList];
    
    // 3、注册通知刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCategoryStationList) name:@"refreshCategoryStationList" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_categoryArray.count > self.selectIndexPath.row) {
        [self.uiCategoryTableView selectRowAtIndexPath:self.selectIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}
#pragma mark - 重写父类方法
-(BOOL)showRightNavItem{
    return YES;
}

-(void)initNavRightBtn{
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 40, 25);
    [rightNavBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [rightNavBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateHighlighted];
    [rightNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -20)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 自定义方法(包括通知)
- (void)refreshCategoryStationList{
    self.page = 1;
    EStationCategory* category = [_categoryArray objectAtIndex:self.selectIndexPath.row];
    [self loadStationByStId:category.st_id];
}

// 搜索点击 
-(void)rightNavBtnAction{
    [FlowUtil startToEStationSearchVCNav:self.navigationController];
}

#pragma mark - 初始化界面数据和约束
- (void)initViewAndCon{
    // 1、初始化变量
    _categoryArray = [NSMutableArray new];
    _stationArray = [NSMutableArray new];
    _page = 1;
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.leadingEdge_leftView.constant = self.trailingEdge_rightView.constant = self.leftEdge;
}

#pragma mark - 加载网络数据
// 查询所有分类
- (void)loadCategoryList{
    [[WebAccessManager sharedInstance]getEStationCategoryWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _categoryArray = response.data.stationTypeList;
            [self.uiCategoryTableView reloadData];
            
//            if (_categoryArray.count > 0) {
//                [self.uiCategoryTableView selectRowAtIndexPath:self.selectIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
//            }
            // 获取第一个数据
            if (_categoryArray.count > 0) {
                EStationCategory* category = [_categoryArray objectAtIndex:0];
                [self loadStationByStId:category.st_id];
                
                
            }
        }
    }];
}

// 根据分类查询E站
- (void)loadStationByStId:(NSString*)st_id{
    [[WebAccessManager sharedInstance]getStationByStId:st_id page:self.page Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _stationArray =  response.data.stationList;
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
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.uiCategoryTableView) {
        // 左侧分类数据
        return _categoryArray.count;
    }else{
        // 右侧E站数据
        return _stationArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.uiCategoryTableView) {
        EStationCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationCategoryCell ID]];
        if (!cell) {
            cell = [EStationCategoryCell newCell];
        }
        
        [cell initCellData:[_categoryArray objectAtIndex:indexPath.row]];
        return cell;
    }else{
        EStationCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationCell ID]];
        if (!cell) {
            cell = [EStationCell newCell];
        }
        cell.delegate = self;
        [cell initCellData:[_stationArray objectAtIndex:indexPath.row] indexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.uiCategoryTableView) {
        if (indexPath.row != self.selectIndexPath.row) {
            // 执行选择操作
            self.page = 1;
            
            // 得到相应分类
            EStationCategory* category = [_categoryArray objectAtIndex:indexPath.row];
            [self loadStationByStId:category.st_id];
            self.selectIndexPath = indexPath;
        }
    }else{
        EStation* station = [_stationArray objectAtIndex:indexPath.row];
        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
    }
}

#pragma mark - EStationListCell Delegate
-(void)refreshStationTableViewCellWithIndexPath:(NSIndexPath*)indexPath{
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:indexPath];
    [self.uiTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
}

#pragma mark - MJRefresh
- (void)tableViewRefreshFooterData{
    // 获取当前Table选择的cell
    NSIndexPath* indexPath = [self.uiCategoryTableView indexPathForSelectedRow];
    EStationCategory* category = [_categoryArray objectAtIndex:indexPath.row];
    _page += 1;
    [self loadStationByStId:category.st_id];
}

- (void)tableViewRefreshHeaderData{
    // 获取当前Table选择的cell
    NSIndexPath* indexPath = [self.uiCategoryTableView indexPathForSelectedRow];
    EStationCategory* category = [_categoryArray objectAtIndex:indexPath.row];
    _page = 1;
    [self loadStationByStId:category.st_id];
    
}
@end
