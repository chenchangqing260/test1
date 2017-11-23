//
//  CommentListViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/9.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentTableCell.h"
#import "LayoutContainerView.h"
#import "BlurCommentView.h"

@interface CommentListViewController ()<LayoutContinerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *uiShowInputViewBtn;
@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;

@property (nonatomic, strong)NSMutableArray* commentArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation CommentListViewController

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
    self.commentArray = [NSMutableArray new];
    self.uiDefaultView.hidden = YES;
    self.uiTableView.hidden = NO;
    
    // 2、Btn初始化
    self.uiShowInputViewBtn.layer.borderColor = [UIColor colorWithHex:0xD8D8D8].CGColor;
    self.uiShowInputViewBtn.layer.borderWidth = 0.5;
    self.uiShowInputViewBtn.layer.cornerRadius = 3;
    self.uiShowInputViewBtn.layer.masksToBounds = YES;
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData{
    [[WebAccessManager sharedInstance]getCommentListWithIn_id:self.in_id page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            // 1、将评论数据处理成可加载的数据
            NSMutableArray* tempArrayList = [NSMutableArray new];
            for (int i=0; i<response.data.reviewList.count; i++) {
                Comment* comment = [response.data.reviewList objectAtIndex:i];
                NSMutableArray* commentArray = comment.reList;
                if (!commentArray) {
                    commentArray = [NSMutableArray new];
                }
                comment.r_floor = [NSString stringWithFormat:@"%lu", comment.reList.count + 1];
                [commentArray addObject:comment];
                [tempArrayList addObject:commentArray];
            }
            
            if (self.page == 1) {
                _commentArray = tempArrayList;
                
                if (_commentArray && _commentArray.count > 0) {
                    self.uiDefaultView.hidden = YES;
                    self.uiTableView.hidden = NO;
                    [self.uiTableView reloadData];
                }else{
                    self.uiDefaultView.hidden = NO;
                    self.uiTableView.hidden = YES;
                }
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_commentArray addObjectsFromArray:[tempArrayList copy]];
                    
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
    return _commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[CommentTableCell ID]];
    if (!cell) {
        cell = [CommentTableCell newCell];
    }
    
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_commentArray[indexPath.row]];
    container.delegate = self;
    
    [cell.uiContentView addSubview:container];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_commentArray[indexPath.row]];
    
    return container.frame.size.height + 0.5;
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
        [SVProgressHUDUtil showWithStatus:@"正在评论..."];
        [[WebAccessManager sharedInstance]saveAndReplyCommentWithIn_id:self.in_id commentContent:commentText parentCommentId:nil completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"评论成功"];
                // 刷新新闻数据
                [self.uiTableView.mj_header beginRefreshing];
                // 刷新数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
            }else{
                 [SVProgressHUDUtil showInfoWithStatus:response.errorMsg];
            }
        }];
    } withTitle:nil];
}

#pragma mark - LayoutContainerView Delegate
- (void)commentSuccessCallBack{
    [self loadNetWorkData];
}
@end
