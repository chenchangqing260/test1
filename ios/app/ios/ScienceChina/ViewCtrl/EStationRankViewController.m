//
//  EStationRankViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationRankViewController.h"
#import "EStationListCell.h"

@interface EStationRankViewController ()<EStationListCellDelegate>

@property (nonatomic, strong)NSMutableArray* stationArray;
@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)UIView* headView;
@property (nonatomic, strong)UIImageView* headImgView;
@property (nonatomic, strong)UILabel* descLab;

@end

@implementation EStationRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.rank.sr_name;
    
    // 1、初始表头视图
    [self initTableViewHeader];
    
    // 2、加载网络数据
    self.page = 1;
    [self loadEStationRankList];
    
    // 3、注册刷新通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshStationRankList) name:@"refreshStationRankList" object:nil];
}

#pragma mark - 初始化TableViewHeader
- (void)initTableViewHeader{
    CGFloat imageHeight = 175 * self.showWidth / kWIDTH_375;
    CGFloat textHeight = 70;
    CGFloat headHeight = imageHeight + textHeight;
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, imageHeight)];
    self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImgView.clipsToBounds = YES;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.rank.sr_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    self.descLab = [[UILabel alloc]initWithFrame:CGRectMake(14, imageHeight, self.showWidth - 28, textHeight)];
    self.descLab.font = FONT_15;
    self.descLab.textColor = [UIColor colorWithHex:0x414141];
    self.descLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:self.descLab text:self.rank.sr_desc];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, headHeight)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    [self.headView addSubview:self.headImgView];
    [self.headView addSubview:self.descLab];
    self.uiTableView.tableHeaderView = self.headView;
}

#pragma mark - 自定义方法(包括通知)
- (void)refreshStationRankList{
    self.page = 1;
    [self loadEStationRankList];
}

#pragma mark - 网络数据加载
// 加载E站列表
- (void)loadEStationRankList{
    [[WebAccessManager sharedInstance]getStationByStId:self.rank.st_id page:self.page Completion:^(WebResponse *response, NSError *error) {
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
    [self loadEStationRankList];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadEStationRankList];
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
