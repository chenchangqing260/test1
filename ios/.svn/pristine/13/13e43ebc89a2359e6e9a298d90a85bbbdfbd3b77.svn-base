//
//  MyAnswerViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyAnswerViewController.h"
#import "MyAnswerCell.h"
#import "MyAnswerDetailViewController.h"

@interface MyAnswerViewController ()

@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (nonatomic, strong)NSMutableArray* anArray; // 我的回答
@property (nonatomic, assign)NSInteger page;

@end

@implementation MyAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的回答";
    
    // 1、初始化
    [self initViewAndConstant];
    
    // 2、加载网络数据
    [self loadNetWorkData];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    // 1、数据初始化
    self.page = 1;
    self.anArray = [NSMutableArray new];
    self.uiTableView.hidden = NO;
    self.uiDefaultView.hidden = YES;
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData{
    [[WebAccessManager sharedInstance]getQuestionReplyListWithQuId:nil memberId:[MemberManager sharedInstance].memberId page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            // 1、将评论数据处理成可加载的数据
            if (self.page == 1) {
                _anArray = response.data.questionReplyList;
                if (_anArray && _anArray.count > 0) {
                    self.uiTableView.hidden = NO;
                    self.uiDefaultView.hidden = YES;
                    [self.uiTableView reloadData];
                }else{
                    self.uiTableView.hidden = YES;
                    self.uiDefaultView.hidden = NO;
                }
            }else{
                if (response.data.questionReplyList.count > 0) {
                    // 还有数据
                    [_anArray addObjectsFromArray:[response.data.questionReplyList copy]];
                    
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
    return _anArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyAnswerCell ID]];
    if (!cell) {
        cell = [MyAnswerCell newCell];
    }
    if (indexPath.row < self.anArray.count) {
        ReplyQuestion* replyQues = [self.anArray objectAtIndex:indexPath.row];
        [cell initCellDataWithReply:replyQues];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyQuestion* replyQues = [self.anArray objectAtIndex:indexPath.row];
    MyAnswerDetailViewController *adVC = [MyAnswerDetailViewController new];
    adVC.reply = replyQues;
    [self.navigationController pushViewController:adVC animated:YES];
}

#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadNetWorkData];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadNetWorkData];
}

@end
