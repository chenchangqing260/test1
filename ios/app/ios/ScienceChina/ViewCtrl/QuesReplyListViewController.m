//
//  QuesReplyListViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesReplyListViewController.h"
#import "QuesReplyCell.h"
#import "TextUtil.h"
#import "BlurCommentView.h"

@interface QuesReplyListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *uiShowInputViewBtn;
@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (nonatomic, strong)NSMutableArray* replyArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation QuesReplyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、初始化
    [self initViewAndConstant];
    
    // 2、加载网络数据
    [self loadNetWorkData];
}

#pragma mark - 重写父类方法
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    // 1、数据初始化
    self.page = 1;
    self.replyArray = [NSMutableArray new];
    
    // 2、Btn初始化
    self.uiShowInputViewBtn.layer.borderColor = [UIColor colorWithHex:0xD8D8D8].CGColor;
    self.uiShowInputViewBtn.layer.borderWidth = 0.5;
    self.uiShowInputViewBtn.layer.cornerRadius = 3;
    self.uiShowInputViewBtn.layer.masksToBounds = YES;
    self.uiDefaultView.hidden = YES;
    self.uiTableView.hidden = NO;
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData{
    [[WebAccessManager sharedInstance]getQuestionReplyListWithQuId:self.qu_id memberId:nil page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            // 1、将评论数据处理成可加载的数据
            if (self.page == 1) {
                _replyArray = response.data.questionReplyList;
                [self.uiTableView reloadData];
                
                if (_replyArray && _replyArray.count > 0) {
                    self.uiDefaultView.hidden = YES;
                    self.uiTableView.hidden = NO;
                }else{
                    self.uiDefaultView.hidden = NO;
                    self.uiTableView.hidden = YES;
                }
                
                
            }else{
                if (response.data.questionReplyList.count > 0) {
                    // 还有数据
                    [_replyArray addObjectsFromArray:[response.data.questionReplyList copy]];
                    
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
    return _replyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuesReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuesReplyCell ID]];
    if (!cell) {
        cell = [QuesReplyCell newCell];
    }
    if (indexPath.row < self.replyArray.count) {
        ReplyQuestion* replyQues = [self.replyArray objectAtIndex:indexPath.row];
        [cell initCellDataWithReply:replyQues];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算高度
    ReplyQuestion* replyQues = [self.replyArray objectAtIndex:indexPath.row];
    CGFloat height = 12 + 36 + 20;
    
    CGFloat contentHeight = [TextUtil boundingRectWithText:replyQues.r_content lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 76, 0) Font:FONT_16].height;
    
    height += contentHeight;
    height += 25;
    
    return height;

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

#pragma mark - 按钮手势点击事件
- (IBAction)clickBackBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickShowInputCommentBtnAction:(id)sender {
    [BlurCommentView commentshowSuccess:^(NSString *commentText) {
        [SVProgressHUDUtil showWithStatus:@"正在回答..."];
        [[WebAccessManager sharedInstance]saveQuestionsReplyWithQuId:self.qu_id qr_content:commentText completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"回答成功"];
                
                // 刷新界面
                [self.uiTableView.mj_header beginRefreshing];
                
                // 刷新数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_QUESTIONREPLY_INFO object:nil];
            }else{
                [SVProgressHUDUtil showInfoWithStatus:@"回答失败"];
            }
        }];
    } withTitle:@"回答"];
}

@end
