//
//  MyQuesViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyQuesViewController.h"
#import "QuesMainItemCell.h"
#import "QuesMainHeaderCell.h"
#import "Question.h"
#import "TextUtil.h"

@interface MyQuesViewController ()

@property (weak, nonatomic) IBOutlet UIView *uiDefaultView;
@property (weak, nonatomic) IBOutlet UIButton *uiGoAskBtn;
@property (nonatomic, strong)NSMutableArray* quesArray; // 资讯列表
@property NSInteger page;

@end

@implementation MyQuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的提问";
    // 1、初始化界面变量和界面
    [self initViewAndConAttribute];
    
    // 2、加载数据
    [self loadQuesListData];
}

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.page = 1;
    self.quesArray = [NSMutableArray new];
    self.uiTableView.hidden = NO;
    self.uiDefaultView.hidden = YES;
    self.uiGoAskBtn.layer.borderWidth = 0.5;
    self.uiGoAskBtn.layer.borderColor = [UIColor colorWithHex:0x33CFDA].CGColor;
    self.uiGoAskBtn.layer.cornerRadius = 2;
}

#pragma mark - 网络数据加载
- (void)loadQuesListData{
    [[WebAccessManager sharedInstance]getQuestionListWtihTypeid:nil page:self.page memberId:[MemberManager sharedInstance].memberId Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_header endRefreshing];
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _quesArray = response.data.questionsList;
                if (_quesArray && _quesArray.count > 0) {
                    self.uiDefaultView.hidden = YES;
                    self.uiTableView.hidden = NO;
                    [self.uiTableView reloadData];
                }else{
                    self.uiDefaultView.hidden = NO;
                    self.uiTableView.hidden = YES;
                }
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_quesArray addObjectsFromArray:[response.data.questionsList copy]];
                    
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
    return _quesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuesMainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuesMainItemCell ID]];
    if (!cell) {
        cell = [QuesMainItemCell newCell];
    }
    
    [cell initCellDataWithQuestion:[_quesArray objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Question* question = [self.quesArray objectAtIndex:indexPath.row];
    [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Question* question = [_quesArray objectAtIndex:[indexPath row]];
    
    CGFloat height = 13;
    height += 36;
    height += 15;
    height += 20;
    height += 13;
    
    // 计算提问内容
    CGFloat contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 40, 0) Font:FONT_14].height;
    height += contentHeight;
    
    if (question.qu_img && ![question.qu_img isEmptyOrWhitespace]) {
        height += 10;
        height += kSCREEN_WIDTH * 208 / kWIDTH_375;
    }
    
    height += 10;
    height += 45;
    height += 10;
    
    return height;
}

#pragma mark - MJRefresh
- (void)tableViewRefreshFooterData{
    self.page = 1;
    [self loadQuesListData];
}

- (void)tableViewRefreshHeaderData{
    self.page += 1;
    [self loadQuesListData];
}

- (IBAction)clickGoAskBtnAction:(id)sender {
    [FlowUtil startToAskQuestionVCNav:self.navigationController];
}
@end
