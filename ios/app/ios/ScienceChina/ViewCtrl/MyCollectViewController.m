//
//  MyCollectViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyCollectViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MyCollectTableCell.h"
#import "HomeModel.h"

@interface MyCollectViewController ()<MyCollectionDelegate>

@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (nonatomic, strong)NSMutableArray* infoArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    // 1、初始化数据
    self.page = 1;
    self.infoArray = [NSMutableArray new];
    self.uiDefaultView.hidden = YES;
    self.uiTableView.hidden = NO;
    
    // 2、网络加载数据
    [self loadNetWorkData];
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData{
    [[WebAccessManager sharedInstance]getCollectInfoListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                _infoArray = response.data.list;
                
                if (_infoArray && _infoArray.count > 0) {
                    [self.uiTableView reloadData];
                    self.uiDefaultView.hidden = YES;
                    self.uiTableView.hidden = NO;
                }else{
                    self.uiDefaultView.hidden = NO;
                    self.uiTableView.hidden = YES;
                }
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_infoArray addObjectsFromArray:[response.data.list copy]];
                    
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

#pragma mark - TableViewDelegate, DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyCollectTableCell ID]];
    if (!cell) {
        cell = [[MyCollectTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyCollectTableCell ID]];
    }
    cell.delegate = self;
    cell.info = [self.infoArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel* info = [self.infoArray objectAtIndex:indexPath.row];
    return [self.uiTableView cellHeightForIndexPath:indexPath model:info keyPath:@"info" cellClass:[MyCollectTableCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] < _infoArray.count) {
        HomeModel* info = [_infoArray objectAtIndex:indexPath.row];
        
        if ([info.in_classify isEqualToString:@"0"] || [info.in_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
        }else if([info.in_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
        }else if([info.in_classify isEqualToString:@"2"]){
            // 视频
            [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
        }else if([info.in_classify isEqualToString:@"3"]){
            // 专题
            // TODO ELLISON
            DLog(@"===========专题跳转============");
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:info.in_id];
        }
    }
    
}

#pragma mark - MJRefresh
- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadNetWorkData];
}

- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadNetWorkData];
}

#pragma mark - MyCollectionDelegate
- (void)refreshData{
    [self.uiTableView.mj_header beginRefreshing];
}
@end
