//
//  IntegrationSummaryViewController.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "IntegrationSummaryViewController.h"
#import "IntegralRulesViewController.h"
#import "IntegrationSummaryHeaderView.h"
#import "IntegrationSummaryCell.h"

@interface IntegrationSummaryViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableData;
    UIColor *_backColor;
    MyScoreModel *_myscore;
    
    IntegrationSummaryHeaderView *_tableHeader;
    UITableView * _tableView;
}
@end

@implementation IntegrationSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
    [self loadData];
}
-(void)initData{
    _tableData = [[NSMutableArray alloc] initWithCapacity:0];
    _backColor = RGBCOLOR(244, 244, 244);
}
-(void)setupView{
    self.title = @"我的积分";
    self.view.backgroundColor = _backColor;
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightNavBtn setImage:[UIImage imageNamed:@"问号积分规则"] forState:UIControlStateNormal];
    [rightNavBtn setImage:[UIImage imageNamed:@"问号积分规则"] forState:UIControlStateHighlighted];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableHeader= [[IntegrationSummaryHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, IntegrationSummaryHeaderViewHeight)];
    [_tableHeader setViewWithModel:nil];
    
     _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64)];
     _tableView.dataSource = self;
     _tableView.delegate = self;
     _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
     _tableView.tableHeaderView = _tableHeader;
    _tableView.backgroundColor = _backColor;
    [self.view addSubview: _tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置 Header
    _tableView.mj_header = header;

}

#pragma mark - TableView MJRefresh
-(void)rightNavBtnAction{
    IntegralRulesViewController *vc = [[IntegralRulesViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadData{
    [[WebAccessManager sharedInstance] getMemberScoreWithcompletion:^(WebResponse *response, NSError *error) {
        
        [_tableView.mj_header endRefreshing];
        
        if (response.success) {
            [_tableData removeAllObjects];
            
            _myscore = [[MyScoreModel alloc] init];
            _myscore.currentMonthScore = response.data.currentMonthScore;
            _myscore.fromScore = response.data.fromScore;
            _myscore.toScore = response.data.toScore;
            _myscore.totalScore = response.data.totalScore;
            _myscore.dayScore = response.data.dayScore;
            _myscore.grade = response.data.grade;
            _myscore.gradeName = response.data.gradeName;
            
            [_tableHeader setViewWithModel:_myscore];
            
            if ([_myscore.dayScore integerValue] >= 300) {
                _tableHeader.frame = CGRectMake(_tableHeader.frame.origin.x, _tableHeader.frame.origin.y, _tableHeader.frame.size.width, IntegrationSummaryHeaderViewHeight+IntegrationSummaryHeaderViewTipHeight);
            }else{
                _tableHeader.frame = CGRectMake(_tableHeader.frame.origin.x, _tableHeader.frame.origin.y, _tableHeader.frame.size.width, IntegrationSummaryHeaderViewHeight);
            }

            _tableView.tableHeaderView = _tableHeader;
            NSMutableArray* subArray = response.data.scoreLog;
            [_tableData addObjectsFromArray:subArray];
            [ _tableView reloadData];
            
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntegrationSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:[IntegrationSummaryCell ID]];
    if (!cell) {
        cell = [[IntegrationSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[IntegrationSummaryCell ID]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setCellWithModel:_tableData[indexPath.section]];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableData.count;;
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return IntegrationSummaryCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 2;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 2)];
    view.backgroundColor = _backColor;
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
