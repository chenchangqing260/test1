//
//  RecordViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "RecordViewController.h"
#import "PicTextInfoCollectionViewCell.h"
#import "HomeModel.h"
#import "TextUtil.h"
#import "RecordTableViewCell.h"

@interface RecordViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray* infoArray;
@property (nonatomic, assign)NSInteger page;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_view;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浏览记录";
    
    // 1、初始化
    [self initAttributeAndVariable];
    
    // 2、加载数据
    [self loadeData];
}

#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return YES;
}

-(BOOL)showMJHeader{
    return YES;
}

-(BOOL)showMJFooter{
    return YES;
}

#pragma mark - 初始化数据和变量
- (void)initAttributeAndVariable{
    _page = 1;
    _infoArray = [NSMutableArray new];
    self.leadingEdge_view.constant = self.trailingEdge_view.constant = self.leftEdge;
}

#pragma mark - MJRefresh
- (void)tableViewRefreshHeaderData{
    self.page = 1;
    [self loadeData];
}
- (void)tableViewRefreshFooterData{
    self.page += 1;
    [self loadeData];
}

#pragma mark - 网络数据加载
-(void)loadeData{
    self.uiTableView.hidden =YES;
    [[WebAccessManager sharedInstance]getSeeRecordWithPage:_page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_header endRefreshing];
        [self.uiTableView.mj_footer endRefreshing];
        self.uiTableView.hidden = NO;
        
        if (response.success) {
            if (self.page == 1) {
                _infoArray = response.data.browsingHistorytList;
                [self.uiTableView reloadData];
                
            }else{
                if (response.data.browsingHistorytList.count > 0) {
                    // 还有数据
                    [_infoArray addObjectsFromArray:[response.data.browsingHistorytList copy]];
                    
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

- (IBAction)clickClearRecord:(id)sender {
    [SVProgressHUDUtil showWithStatus:@"正在清除..."];
    [[WebAccessManager sharedInstance]cleanSeeRecordWithompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            [self.infoArray removeAllObjects];
            [self.uiTableView reloadData];
            // 返回成功
            [SVProgressHUDUtil showSuccessWithStatus:@"清除成功" completion:^{
                //[self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            // 请求返回失败
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecordTableViewCell ID]];
    if (!cell) {
        cell = [RecordTableViewCell newCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HomeModel* model     = [_infoArray objectAtIndex:[indexPath row]];
    HomeModel* lastModel;
    if (indexPath.row != 0) {
        lastModel = [_infoArray objectAtIndex:[indexPath row]-1];
    }
    if (indexPath.row < _infoArray.count-1) {
        cell.line2.hidden = NO;
    }else{
        cell.line2.hidden = YES;
    }
    [cell setCellWithModel:model lastModel:lastModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _infoArray.count) {
        HomeModel* model = [_infoArray objectAtIndex:[indexPath row]];
        
        if ([model.in_classify isEqualToString:@"0"] || [model.in_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
        }else if([model.in_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
        }else if([model.in_classify isEqualToString:@"2"]){
            // 视频
            [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
        }else if([model.in_classify isEqualToString:@"3"]){
            // 专题
            // TODO ELLISON
            DLog(@"===========专题跳转============");
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:model.in_id];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 40;
    CGFloat cellHeight = RecordCellHeight120;
    HomeModel* model     = [_infoArray objectAtIndex:[indexPath row]];
    HomeModel* lastModel;
    if (indexPath.row != 0) {
        lastModel = [_infoArray objectAtIndex:[indexPath row]-1];
    }
    if (lastModel) {
        if ([model.bh_date isEqualToString:lastModel                                                                                                                                                                                                                                               .bh_date]) {
            cellHeight = RecordCellHeight70;
        }
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    return view;
}


@end
