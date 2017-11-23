//
//  QuesDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesDetailViewController.h"
#import "Question.h"
#import "IPDashedLineView.h"
#import "BottomOperationView.h"
#import "ShareModel.h"
#import "TextUtil.h"
#import "QuesReplyCell.h"
#import "BlurCommentView.h"
#import "QuesReplyListViewController.h"

@interface QuesDetailViewController ()
{
    CGFloat _scrollWidth;
}

@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *uiMemberImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiMemberName;
@property (weak, nonatomic) IBOutlet UILabel *uiPublishTime;
@property (weak, nonatomic) IBOutlet UIImageView *uiQuesImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;
@property (weak, nonatomic) IBOutlet UIView *uiOfficialReplyView;

@property (weak, nonatomic) IBOutlet UILabel *uiOfficialReplyLab;
@property (weak, nonatomic) IBOutlet UIView *uiCategoryView;
@property (weak, nonatomic) IBOutlet UILabel *uiCategoryLab;
@property (weak, nonatomic) IBOutlet UITableView *uiReplyTableView;
@property (weak, nonatomic) IBOutlet UILabel *uiReplyCountLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conQuesImgViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conOfficialViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCategoryViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReplyTextViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReplyTableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMoreViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_view;


// BottomView
@property (weak, nonatomic) IBOutlet UIButton *uiReplyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReplyCountWidth;


@property (nonatomic, strong)NSMutableArray* replayArray;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation QuesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化界面
    [self initViewAndConstant];
    
    // 2、加载数据
    [self loadQuestionDetailWithReply:NO];
    
    // 3、注册通知
    [self registerNotice];
}

#pragma mark - 重写父类方法
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}


#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshQuestionReplyData:) name:kNOTOICE_REFRESH_QUESTIONREPLY_INFO object:nil];
}

- (void)refreshQuestionReplyData:(NSNotification*)notification{
    [self loadQuestionDetailWithReply:NO];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    
    CGFloat _leftEdge = 0;
    _scrollWidth = kSCREEN_WIDTH;
    if (isIpad) {
        _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        _scrollWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    self.leadingEdge_view.constant  = self.trailingEdge_view.constant = _leftEdge;
    // 1、存放评论数据的列表
    _replayArray = [NSMutableArray new];
    [self.uiReplyTableView reloadData];
    
    // 2、约束初始化
    self.conScrollViewWidth.constant = _scrollWidth;
    self.uiScrollView.hidden = YES;
    [self refreshScrollHeightAndConstant];
    
    // 3. 虚线
    IPDashedLineView *appearance = [IPDashedLineView appearance];
    [appearance setLineColor:[UIColor colorWithHex:0xAFAFAF]];
    [appearance setLengthPattern:@[@4, @2]];
    
    IPDashedLineView *dash = [[IPDashedLineView alloc] initWithFrame:CGRectMake(15, 0, _scrollWidth - 30, 1)];
    [self.uiCategoryView addSubview:dash];
    
    // 4、回复按钮
    self.uiReplyBtn.layer.borderColor = [UIColor colorWithHex:0xD8D8D8].CGColor;
    self.uiReplyBtn.layer.borderWidth = 0.5;
    self.uiReplyBtn.layer.cornerRadius = 3;
    self.uiReplyBtn.layer.masksToBounds = YES;
}

#pragma mark - 自定义方法
// 刷新约束和界面高度
- (void)refreshScrollHeightAndConstant{
    self.conReplyTableViewHeight.constant = self.uiReplyTableView.contentSize.height;
    self.conScrollViewHeight.constant = self.conTopViewHeight.constant + self.conContentViewHeight.constant + self.conOfficialViewHeight.constant + self.conCategoryViewHeight.constant + self.conReplyTextViewHeight.constant + self.conReplyTableViewHeight.constant + self.conMoreViewHeight.constant + 20;
}

- (void)settingViewConstant{
    // 1、计算内容视图的高度
    // 1.1、判断有无图片，是否要显示
    if (self.question.qu_img && ![self.question.qu_img isEmptyOrWhitespace]) {
        self.conQuesImgViewHeight.constant = _scrollWidth * 212 / kWIDTH_375;
        self.uiQuesImgView.hidden = NO;
    }else{
        self.conQuesImgViewHeight.constant = 0;
        self.uiQuesImgView.hidden = YES;
    }
    
    // 1.2、计算描述内容高度
    CGFloat contentHeight = [TextUtil boundingRectWithText:self.question.qu_content lineSpace:3 size:CGSizeMake(_scrollWidth - 15, 0) Font:self.uiDescLab.font].height;
    
    self.conContentViewHeight.constant = self.conQuesImgViewHeight.constant + 18 + 20 + 14 + contentHeight + 25;
    
    // 2、计算官方回复高度、根据有无官方回复设置
    if (self.question.qu_reply_content && ![self.question.qu_reply_content isEmptyOrWhitespace]) {
        // 有回复
        CGFloat replyHeight = [TextUtil boundingRectWithText:self.question.qu_reply_content lineSpace:3 size:CGSizeMake(_scrollWidth - 15, 0) Font:self.uiDescLab.font].height;
        self.conOfficialViewHeight.constant = 14 + 14 + replyHeight + 25;
        self.uiOfficialReplyView.hidden = NO;
    }else{
        // 没有回复
        self.conOfficialViewHeight.constant = 0;
        self.uiOfficialReplyView.hidden = YES;
    }
    
    // 3、
}

- (void)settingViewDataIsReply:(BOOL)isReply{
    if (!isReply) {
        // 1、设置提问人
        [self.uiMemberImgView sd_setImageWithURL:[NSURL URLWithString:self.question.member_img_url] placeholderImage:nil];
        self.uiMemberName.text = self.question.member_name;
        self.uiPublishTime.text = self.question.qu_push_time;
        
        // 2、提问内容
        [_uiQuesImgView sd_setImageWithURL:[NSURL URLWithString:self.question.qu_img] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        self.uiTitleLab.text = self.question.qu_title;
        self.uiDescLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiDescLab text:self.question.qu_content];
        
        // 3、判断有没有官方回复，有官方回复则显示官方回复，没有官方回复则不显示
        if (self.question.qu_reply_content && ![self.question.qu_reply_content isEmptyOrWhitespace]) {
            // 有回复
            self.uiOfficialReplyLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiOfficialReplyLab text:self.question.qu_reply_content];
        }
        
        // 4、设置分类
        self.uiCategoryLab.text = self.question.te_title;
        
        // 6、设置分享对象
        self.shareModel = [ShareModel new];
        self.shareModel.in_share_contentURL = self.question.qu_share_contentURL;
        self.shareModel.in_share_imageURL  = self.question.qu_share_imageURL;
        self.shareModel.in_share_title  = self.question.qu_share_title;
        self.shareModel.in_share_desc  = self.question.qu_share_desc;
    }
    
    // 5、加载回复
    self.replayArray = self.question.rqList;
    [self.uiReplyTableView reloadData];
    self.uiReplyCountLab.text = self.question.replyCount;
    
    CGFloat contentWidth = [TextUtil boundingRectWithText:self.uiReplyCountLab.text lineSpace:3 size:CGSizeMake(_scrollWidth, 0) Font:self.uiReplyCountLab.font].width;
    self.conReplyCountWidth.constant = 50 + contentWidth;
    
    // 7、重新设置ScrollView高度
    [self settingViewConstant];
    [self refreshScrollHeightAndConstant];
}

#pragma mark - 网络请求方法，获取提问详情
- (void)loadQuestionDetailWithReply:(BOOL)isReply{
    [[WebAccessManager sharedInstance]getQuestionInfoWithqu_id:self.question.qu_id andCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.uiScrollView.hidden = NO;
            self.question = response.data.questions;
            [self settingViewDataIsReply:isReply];
        }else{
           // 加载失败
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _replayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuesReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuesReplyCell ID]];
    if (!cell) {
        cell = [QuesReplyCell newCell];
    }
    if (indexPath.row < self.replayArray.count) {
        ReplyQuestion* replyQues = [self.replayArray objectAtIndex:indexPath.row];
        [cell initCellDataWithReply:replyQues];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算高度
    ReplyQuestion* replyQues = [self.replayArray objectAtIndex:indexPath.row];
    CGFloat height = 12 + 36 + 20;
    
    CGFloat contentHeight = [TextUtil boundingRectWithText:replyQues.r_content lineSpace:3 size:CGSizeMake(_scrollWidth - 76, 0) Font:FONT_16].height;
    
    height += contentHeight;
    height += 25;
    
    return height;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        [self refreshScrollHeightAndConstant];
    }
}

#pragma mark - 点击事件、手势和按钮 
- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickReplyBtnAction:(id)sender {
    [BlurCommentView commentshowSuccess:^(NSString *commentText) {
        [SVProgressHUDUtil showWithStatus:@"正在回答..."];
        [[WebAccessManager sharedInstance]saveQuestionsReplyWithQuId:self.question.qu_id qr_content:commentText completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"回答成功"];
                
                // 刷新界面
                [self loadQuestionDetailWithReply:YES];
            }else{
                [SVProgressHUDUtil showInfoWithStatus:response.errorMsg];
            }
        }];
    } withTitle:@"回答"];

}

- (IBAction)clickShareBtnAction:(id)sender {
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

- (IBAction)clickReplyCountBtnAction:(id)sender {
    QuesReplyListViewController* qrListVC = [QuesReplyListViewController new];
    qrListVC.qu_id = self.question.qu_id;
    [self.navigationController pushViewController:qrListVC animated:YES];
}

@end
