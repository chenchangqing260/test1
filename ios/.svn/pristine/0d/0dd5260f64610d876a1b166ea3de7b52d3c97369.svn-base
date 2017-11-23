//
//  EStationViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationViewController.h"
#import "MyEStationCell.h"
#import "MyMoreStation.h"

@interface EStationViewController ()<MyMoreStationDelegate>

@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (weak, nonatomic) IBOutlet UIView *uiDataView;
@property (weak, nonatomic) IBOutlet UIButton *uiAddEStationBtn;

@property (nonatomic, strong)NSMutableArray* myAttentList;
@property (nonatomic, assign)NSInteger page;

@end

@implementation EStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LStr(@"estation");
//    [self setupView];
    
    // 1、初始化
    [self initViewAndCon];
    
    // 2、加载数据
    [self loadNetWorkData:NO];
    
    // 3、注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNoticeData) name:@"refreshMyStation" object:nil];
}
#pragma mark - 初始化界面
-(void)setupView{    
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
// 左侧导航点击事件
// 改版
-(void)leftNavBtn{
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController showLeftController:YES];
}
#pragma mark - 自定义方法(包括通知)
- (void)refreshNoticeData{
    self.page = 1;
    [self loadNetWorkData:YES];
}

#pragma mark - 初始化界面数据和约束
- (void)initViewAndCon{
    // 1、添加关注按钮设置
    self.uiAddEStationBtn.layer.cornerRadius = 3;
    self.uiAddEStationBtn.layer.borderColor = [UIColor colorWithHex:0x33CFDA].CGColor;
    self.uiAddEStationBtn.layer.borderWidth = 0.5;
    
    // 2、初始化变量
    _myAttentList = [NSMutableArray new];
    _page = 1;
}

#pragma mark - 加载网络数据
- (void)loadNetWorkData:(BOOL)isRefresh{
    if (!isRefresh) {
        [self.uiDefaultView setHidden:YES];
        [self.uiDataView setHidden:YES];
    }

    [[WebAccessManager sharedInstance]getMyAttentionStationListPage:_page Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_header endRefreshing];
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            // 加载成功，根据数量现实相应视图tableView视图
            if (self.page == 1) {
                _myAttentList = response.data.stationList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_myAttentList addObjectsFromArray:[response.data.stationList copy]];
                    
                    [self.uiTableView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                }
            }
            
            if (_myAttentList.count == 0) {
                [self.uiDefaultView setHidden:NO];
                [self.uiDataView setHidden:YES];
            }else{
                [self.uiDataView setHidden:NO];
                [self.uiDefaultView setHidden:YES];
            }
        }else{
            self.page -= 1;
            // 加载失败，现实关注视图
            [self.uiDefaultView setHidden:NO];
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myAttentList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyMoreStation *cell = [tableView dequeueReusableCellWithIdentifier:[MyMoreStation ID]];
        if (!cell) {
            cell = [MyMoreStation newCell];
        }
        cell.delegate = self;
        return cell;
    }else{
        MyEStationCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyEStationCell ID]];
        if (!cell) {
            cell = [MyEStationCell newCell];
        }
        
        [cell initCellData:[_myAttentList objectAtIndex:(indexPath.row - 1)]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        EStation* station = [_myAttentList objectAtIndex:(indexPath.row - 1)];
        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
    }
}


#pragma mark - 按钮和手势点击事件
- (IBAction)clickAddEStationBtn:(id)sender {
    [FlowUtil startToEStationListVCNav:self.navigationController];
}

#pragma mark - MyMoreStation Delegate
-(void)clickMoreStation{
    // 跳转更多分类
    //[FlowUtil startToEStationCategoryVCNav:self.navigationController];
    [FlowUtil startToEStationListVCNav:self.navigationController];
}

#pragma mark - MJRefresh
- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadNetWorkData:YES];
}

- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadNetWorkData:YES];
}
@end
