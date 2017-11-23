//
//  PicTextInfoDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/4/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PicTextInfoDetailViewController.h"
#import "LayoutContainerView.h"
#import "CommentTableCell.h"
#import "Comment.h"
#import "IPDashedLineView.h"
#import "RecommendCollectionViewCell.h"
#import "BottomOperationView.h"
#import "ShareModel.h"

typedef enum{Attented = 1, NoAttent = 0} stationAttent;

@interface PicTextInfoDetailViewController ()<BottomOperationViewDelegate, LayoutContinerDelegate,UIWebViewDelegate>
{
    UIImageView *_loadImageView;//加载提示
}
@property (weak, nonatomic) IBOutlet UITableView *uiReviewTableView;
@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;
@property (weak, nonatomic) IBOutlet UIView *uiRecTopView;
@property (weak, nonatomic) IBOutlet UICollectionView *uiRecCollectionView;
@property (weak, nonatomic) IBOutlet UIView *uiOperationView;
@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (weak, nonatomic) IBOutlet UIView *uiEStationView;
@property (weak, nonatomic) IBOutlet UIButton *uiStationAttentBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiStationNameLab;
@property (weak, nonatomic) IBOutlet UIButton *uiBackHomeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWebViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollContentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReviewTableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWebViewAndRecommendViewSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRecommendViewAndReviewTableViewSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCommentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRecommendViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMoreViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conEStationViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conBottomViewBottomSpace; // 默认是0，下去的话是52

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleLabHeight; // 包含在conRecommendViewHeight中，所以不需要再ScrollView中计算高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollLeadingEdge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTrallingEdge;
@property (nonatomic,strong)InfoObj* info;
@property (nonatomic, strong)NSMutableArray* recommendList;
@property (nonatomic, strong)NSMutableArray* reviewList;
@property (nonatomic, strong)BottomOperationView* operationView;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation PicTextInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    [self initViewAndConstant];
    
    // 2、网络加载数据
    [self loadNetWorkData];
    
    // 3、注册通知刷新数据
    [self registerNotice];
}

#pragma mark - 重写父类方法
- (BOOL)showNavBar{
    return NO;
}
#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshInfoData:) name:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
}

- (void)refreshInfoData:(NSNotification*)notification{
    [self loadInfoDetail];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    // 1、存放评论数据的列表
    _reviewList = [NSMutableArray new];
    _recommendList = [NSMutableArray new];
    
    // 2、约束初始化
    self.conEStationViewHeight.constant = 0;
    self.uiEStationView.hidden = YES;
    self.conReviewTableHeight.constant = 0;
    self.conWebViewHeight.constant = 0;
    self.conScrollContentViewWidth.constant = kSCREEN_WIDTH;
    if (isIpad) {
        self.conScrollContentViewWidth.constant = MAIN_SCREEN_WIDTH_ONIpad;
    }
    [self refreshScrollHeightAndConstant];
    
    // 3. WebView设置
    self.uiWebView.scrollView.bounces = NO;
    self.uiWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.uiWebView.scrollView.scrollEnabled = NO;
    [self.uiWebView sizeToFit];
    
    // 4. 视图之间间隔
    self.conWebViewAndRecommendViewSpace.constant = self.conRecommendViewAndReviewTableViewSpace.constant = 20;
    
    // 5. 推荐东西视图高度
    self.conRecommendViewHeight.constant = 265;
    self.conTitleLabHeight.constant = 57; // 高度
    
    // 6. 虚线
    IPDashedLineView *appearance = [IPDashedLineView appearance];
    [appearance setLineColor:[UIColor colorWithHex:0xAFAFAF]];
    [appearance setLengthPattern:@[@4, @2]];
    
    IPDashedLineView *dash = [[IPDashedLineView alloc] initWithFrame:CGRectMake(15, self.conTitleLabHeight.constant - 1, kSCREEN_WIDTH - 30, 1)];
    [self.uiRecTopView addSubview:dash];
    
    // 7. 注册CollectionViewCell
    [self initCollectionView];
    
    // 8. 添加评论界面
    self.operationView = [BottomOperationView newNib];
    self.operationView.delegate = self;
    [self.uiOperationView addSubview:self.operationView];
    [self.uiOperationView layoutIfNeeded];
    
    // 9. 根据进入的等级，判断是否显示Home按钮
    NSArray* viewControllers = self.jt_navigationController.viewControllers;
    if (viewControllers.count > 3) {
        self.uiBackHomeBtn.hidden = NO;
    }else{
        self.uiBackHomeBtn.hidden = YES;
    }
    
    
    self.scrollLeadingEdge.constant = 0;
    self.scrollTrallingEdge.constant = 0;
    
    if (isIpad) {
        CGFloat _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        self.scrollLeadingEdge.constant = _leftEdge;
        self.scrollTrallingEdge.constant = _leftEdge;
        
        //
        //        [self.operationView updateConstraints:^(MASConstraintMaker *make) {
        //
        //            make.height.mas_left(100);
        //
        //        }];
        
    }
    
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    _loadImageView.hidden = NO;
    [self.view addSubview:_loadImageView];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
}

#pragma mark - 自定义方法
// 刷新约束和界面高度
- (void)refreshScrollHeightAndConstant{
    self.conReviewTableHeight.constant = self.uiReviewTableView.contentSize.height;
    self.conScrollContentViewHeight.constant = self.conWebViewHeight.constant + self.conEStationViewHeight.constant + self.conReviewTableHeight.constant + self.conWebViewAndRecommendViewSpace.constant + self.conRecommendViewAndReviewTableViewSpace.constant + self.conCommentViewHeight.constant + self.conRecommendViewHeight.constant + self.conMoreViewHeight.constant;
}

#pragma mark - 加载网络数据
-(void)loadInfoDetail{
    // 2、加载图文资讯的基本信息
    [[WebAccessManager sharedInstance]getPicTextAndVideoInfoDetailWithIn_id:self.in_id showRows:NO completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 判断是否是E站信息
            self.info = response.data.information;
            if(self.info.in_is_station && [self.info.in_is_station isEqualToString:@"1"]){
                // E站资讯
                self.conEStationViewHeight.constant = 65;
                self.uiEStationView.hidden = NO;
                
                // 根据是否关注进行显示
                self.uiStationNameLab.text = self.info.si_name;
                
                // 根据是否关注显示不同信息
                if ([self.info.si_is_concern integerValue] == Attented) {
                    // 已关注
                    [self.uiStationAttentBtn setBackgroundColor:[UIColor colorWithHex:0x33CFDA alpha:0.15]];
                    [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateNormal];
                    [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateHighlighted];
                    [self.uiStationAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [self.uiStationAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
                }else{
                    // 未关注
                    [self.uiStationAttentBtn setBackgroundColor:[UIColor colorWithHex:0x33CFDA]];
                    [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
                    [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateHighlighted];
                    [self.uiStationAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
                    [self.uiStationAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
                }
            }else{
                self.conEStationViewHeight.constant = 0;
                self.uiEStationView.hidden = YES;
            }
            
            // 将数据处理成可加载的数据
            [_reviewList removeAllObjects];
            for (int i=0; i<response.data.information.reviewList.count; i++) {
                Comment* comment = [response.data.information.reviewList objectAtIndex:i];
                NSMutableArray* commentArray = comment.reList;
                if (!commentArray) {
                    commentArray = [NSMutableArray new];
                }
                comment.r_floor = [NSString stringWithFormat:@"%lu", comment.reList.count + 1];
                [commentArray addObject:comment];
                [_reviewList addObject:commentArray];
            }
            
            [self.uiReviewTableView reloadData];
            
            _recommendList = response.data.recommendList;
            [_uiRecCollectionView reloadData];
            
            // 设置底部操作栏的数据
            [UIView animateWithDuration:0.2 animations:^{
                self.conBottomViewBottomSpace.constant = 0;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
            
            [self.operationView initViewDataWithInfo:response.data.information];
            
            // 设置分享对象
            self.shareModel = [ShareModel new];
            self.shareModel.in_share_contentURL = response.data.information.in_share_contentURL;
            self.shareModel.in_share_imageURL  = response.data.information.in_share_imageURL;
            self.shareModel.in_share_title  = response.data.information.in_share_title;
            self.shareModel.in_share_desc  = response.data.information.in_share_desc;
            self.shareModel.share_type = @"05";
            self.shareModel.ar_id = self.in_id;
            
            // 重新设置ScrollView高度
            [self refreshScrollHeightAndConstant];
        }else{
            // 加载失败，调用默认加载失败页面
        }
    }];
}

#pragma mark –webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL =[request URL];
    if (([[requestURL scheme] isEqualToString: @"http"] || [[requestURL scheme] isEqualToString:@"https"] || [[requestURL scheme] isEqualToString: @"mailto" ])
        && (navigationType == UIWebViewNavigationTypeLinkClicked)) {
        return ![[UIApplication sharedApplication] openURL:requestURL];
    }

    return YES;
}


-(void)loadInfoHtml{
    self.uiScrollView.hidden = YES;
    // 1、加载图文资讯的HTML
    FontSize fontSize = Normal;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* fontSizeData = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    if (fontSizeData) {
        if ([fontSizeData isEqualToString:@"Large"]) {
            fontSize = Large;
        }else if([fontSizeData isEqualToString:@"Small"]){
            fontSize = Small;
        }
    }
    
    [[WebAccessManager sharedInstance]loadHtmlOfPicTextWithIn_id:self.in_id font_size:fontSize completion:^(NSString *html, NSError *error) {
        if (!error && html) {
            NSString *URLStr = [NSString stringWithFormat:@"%@%@",[[WebAccessManager sharedInstance]  webServiceUrl],@"informationMobileController/toInforMationArticleHtml"];
            html = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", html];
            [self.uiWebView loadHTMLString:html baseURL:[NSURL URLWithString:URLStr]];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            _loadImageView.hidden = YES;
        }
    }];
}

-(void)loadNetWorkData{
    //[SVProgressHUDUtil showWithStatus:@"正在加载..."];
    [self loadInfoHtml];
    [self loadInfoDetail];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _reviewList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[CommentTableCell ID]];
    if (!cell) {
        cell = [CommentTableCell newCell];
    }
    
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_reviewList[indexPath.row]];
    container.delegate = self;
    
    [cell.uiContentView addSubview:container];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_reviewList[indexPath.row]];
    
    return container.frame.size.height + 0.5;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        [self refreshScrollHeightAndConstant];
    }
}

#pragma mark - CollectionView Delegate, DataSource
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiRecCollectionView registerNib:[UINib nibWithNibName:[RecommendCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[RecommendCollectionViewCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _recommendList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecommendCollectionViewCell ID] forIndexPath:indexPath];
    
    if (indexPath.section < _recommendList.count) {
        [cell initCellData:[_recommendList objectAtIndex:indexPath.section]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _recommendList.count) {
        InfoObj* info = [_recommendList objectAtIndex:[indexPath section]];
        
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    // 计算Cell的宽度 30 为左右两边的边距, 9为Cell间隔
    CGFloat cellWidth = ((showWidth - 30) - showWidth / kWIDTH_375 * 9) / 2;
    
    return CGSizeMake(cellWidth, self.conRecommendViewHeight.constant - self.conTitleLabHeight.constant);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    return CGSizeMake(showWidth / kWIDTH_375 * 9, self.conRecommendViewHeight.constant - self.conTitleLabHeight.constant);
}


#pragma mark - WebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUDUtil dismiss];
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    webView.frame = CGRectMake(0, 0, showWidth, clientheight);
    //获取WebView最佳尺寸（点）
    //CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    //height = height * frame.height / clientheight;
    //再次设置WebView高度（点）
    //webView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, height);
    self.conWebViewHeight.constant = height;
    [self refreshScrollHeightAndConstant];
    
    self.uiScrollView.hidden = NO;
    _loadImageView.hidden = YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    _loadImageView.hidden = YES;
}
#pragma mark - BottomOperationViewDelegate
- (void)didBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didToCommentList{
    [self clickMoreCommentBtnAction:nil];
}

- (void)didToLoginView{
    [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:false isShowAlertYinDao:NO  completion:nil];
}

- (void)didShare{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

#pragma mark - 按钮手势点击事件
- (IBAction)clickMoreCommentBtnAction:(id)sender {
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:self.in_id completion:nil];
}

- (IBAction)clickAttentBtnAction:(id)sender {
    // 未关注的点击之后变为已关注，已关注的点击之后为取消关注
    if ([self.info.si_is_concern intValue] == Attented) {
        // 已关注的，取消关注
        [[WebAccessManager sharedInstance]delStationWithSiId:self.info.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.info.si_is_concern = [NSString stringWithFormat:@"%d", NoAttent];
                // 刷新按钮
                [self.uiStationAttentBtn setBackgroundColor:[UIColor colorWithHex:0x33CFDA]];
                [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
                [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateHighlighted];
                [self.uiStationAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
                [self.uiStationAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
                
                // 刷新TableView
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAttentStatusForPersonal" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
            }
        }];
    }else{
        // 未关注的，进行关注操作
        [[WebAccessManager sharedInstance]saveStationWithSiId:self.info.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.info.si_is_concern = [NSString stringWithFormat:@"%d", Attented];
                // 刷新按钮
                [self.uiStationAttentBtn setBackgroundColor:[UIColor colorWithHex:0x33CFDA alpha:0.15]];
                [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateNormal];
                [self.uiStationAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateHighlighted];
                [self.uiStationAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.uiStationAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
                
                // 刷新TableView
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAttentStatusForPersonal" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
            }
        }];
    }
}

- (IBAction)clickToStationBtn:(id)sender {
    [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:self.info.si_id];
}

- (IBAction)clickBackHomeBtnAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - LayoutContainerView Delegate
- (void)commentSuccessCallBack{
    [self loadInfoDetail];
}
@end
