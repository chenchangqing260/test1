//
//  MyCommentViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentTableCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface MyCommentViewController ()

@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (nonatomic, strong)NSMutableArray* commentArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评论(回复)";
    
    // 1、初始化数据
    self.page = 1;
    self.commentArray = [NSMutableArray new];
    self.uiDefaultView.hidden = YES;
    self.uiTableView.hidden = NO;
    
    // 2、网络加载数据
    [self loadNetWorkData];
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData{
    [[WebAccessManager sharedInstance]getMyCommentListPage:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                _commentArray = response.data.reviewList;
                if (_commentArray && _commentArray.count > 0) {
                    self.uiDefaultView.hidden = YES;
                    self.uiTableView.hidden = NO;
                    [self.uiTableView reloadData];
                }else{
                    self.uiDefaultView.hidden = NO;
                    self.uiTableView.hidden = YES;
                }
            }else{
                if (response.data.reviewList.count > 0) {
                    // 还有数据
                    [_commentArray addObjectsFromArray:[response.data.reviewList copy]];
                    
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
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyCommentTableCell ID]];
    if (!cell) {
        cell = [[MyCommentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyCommentTableCell ID]];
    }
    cell.comment = [self.commentArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment* commnet = [self.commentArray objectAtIndex:indexPath.row];
    return [self.uiTableView cellHeightForIndexPath:indexPath model:commnet keyPath:@"comment" cellClass:[MyCommentTableCell class] contentViewWidth:[self cellContentViewWith]];
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
    if ([indexPath row] < _commentArray.count) {
        Comment* commnet = [self.commentArray objectAtIndex:indexPath.row];
        
        if ([commnet.in_classify isEqualToString:@"0"] || [commnet.in_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:commnet.in_id completion:nil];
        }else if([commnet.in_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:commnet.in_id completion:nil];
        }else if([commnet.in_classify isEqualToString:@"2"]){
            // 视频
            [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:commnet.in_id completion:nil];
        }else if([commnet.in_classify isEqualToString:@"3"]){
            // 专题
            // TODO ELLISON
            DLog(@"===========专题跳转============");
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:commnet.in_id];
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

@end
