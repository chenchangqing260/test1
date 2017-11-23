//
//  VideoInfoDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VideoInfoDetailViewController.h"
#import "IPDashedLineView.h"
#import "BottomOperationView.h"
#import "Comment.h"
#import "CommentTableCell.h"
#import "LayoutContainerView.h"
#import "RecommendCollectionViewCell.h"
#import "WMPlayer.h"
//#import "QINetReachabilityManager.h"
#import "CustomDownloadManager.h"
#import "DownloadInfo.h"
#import "TransferModelToData.h"

#import "CoreStatus.h"

typedef enum{Attented = 1, NoAttent = 0} stationAttent;

@interface VideoInfoDetailViewController ()<BottomOperationViewDelegate,LayoutContinerDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiPlayCountLab;
@property (weak, nonatomic) IBOutlet UICollectionView *uiRecCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *uiCommentTableView;
@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;
@property (weak, nonatomic) IBOutlet UILabel *uiDescTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescSummaryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescTitleLab;
@property (weak, nonatomic) IBOutlet UIView *uiRecTopView;
@property (weak, nonatomic) IBOutlet UIView *uiOperationView;
@property (weak, nonatomic) IBOutlet UIView *uiInfoView;
@property (weak, nonatomic) IBOutlet UILabel *uiDownloadStatusLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiDownloadStatusImgView;
@property (weak, nonatomic) IBOutlet UIButton *uiBackHomeBtn;

// EStation
@property (weak, nonatomic) IBOutlet UIView *uiEStationView;
@property (weak, nonatomic) IBOutlet UIButton *uiStationAttentBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiStationNameLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollContentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImageViewHeightRatio;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conInfoViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReviewTableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCommentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRecommendViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMoreViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conInfoViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRecViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRecTopViewHeight;
// DescView内部约束，用来控制DescView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWebViewHeight;
// EStationView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conEStationViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollLeadingEdge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTrallingEdge;

@property (nonatomic, strong)InfoObj* infoObj;
@property (nonatomic, strong)NSMutableArray* recommendList;
@property (nonatomic, strong)NSMutableArray* reviewList;
@property (nonatomic, strong)BottomOperationView* operationView;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation VideoInfoDetailViewController
{
    WMPlayer  *wmPlayer;
    CGRect     playerFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、初始化数据
    [self initViewAndConstant];
    
    // 2、网络加载数据
    [SVProgressHUDUtil showWithStatus:@"正在加载..."];
    [self loadInfoHtml ];
    [self loadNetWorkData:NO];
    
    // 3、注册通知
    [self registerNotice];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 注册旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeTheVideo:) name:WMPlayerClosedNotification object:nil];
    
    // 判断此资源是否下载完成，并显示相应的界面
    if ([CustomDownloadManager isDownloadInfoWithInId:self.in_id]) {
        // 已经缓存完成
        self.uiDownloadStatusLab.text = @"已缓存";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x33CFDA];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"已缓存"]];
    }else{
        self.uiDownloadStatusLab.text = @"下载";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x636363];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"Video下载"]];
    }
    
//    if ([CustomDownloadManager isDownloadCompleteWithInId:self.in_id]) {
//        // 直接播放
//        [self clickPlayAction:nil];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //将要消失，关闭正在播放
    [self closeTheVideo:nil];
}

#pragma mark - 重写父类方法
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshInfoData:) name:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
}

- (void)refreshInfoData:(NSNotification*)notification{
    [self loadNetWorkData:YES];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    // 1、存放评论数据的列表
    _reviewList = [NSMutableArray new];
    _recommendList = [NSMutableArray new];
    
    // 2、约束初始化
    self.conEStationViewHeight.constant = 0;
    self.uiEStationView.hidden = YES;
    self.conScrollContentViewWidth.constant = kSCREEN_WIDTH;
    
    // 2.1、计算顶部InfoView高度 50 为底部的距离
    self.conInfoViewHeight.constant = kSCREEN_WIDTH / self.conImageViewHeightRatio.multiplier + 50;
    
    // 3. WebView设置
    self.uiWebView.scrollView.bounces = NO;
    self.uiWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.uiWebView.scrollView.scrollEnabled = NO;
    [self.uiWebView sizeToFit];
    self.conWebViewHeight.constant = 0;
    
    // 3. 虚线
    IPDashedLineView *appearance = [IPDashedLineView appearance];
    [appearance setLineColor:[UIColor colorWithHex:0xAFAFAF]];
    [appearance setLengthPattern:@[@4, @2]];
    
    CGFloat w = kSCREEN_WIDTH;
    if (isIpad) {
        w = MAIN_SCREEN_WIDTH_ONIpad;
    }
    IPDashedLineView *dash = [[IPDashedLineView alloc] initWithFrame:CGRectMake(15, self.conRecTopViewHeight.constant - 1, w - 30, 1)];
    [self.uiRecTopView addSubview:dash];
    
    // 4. 注册CollectionViewCell
    [self initCollectionView];
    
    // 5. 添加评论界面
    self.operationView = [BottomOperationView newNib];
    self.operationView.delegate = self;
    [self.uiOperationView addSubview:self.operationView];
    [self.uiOperationView layoutIfNeeded];
    
    // 6. 根据进入的等级，判断是否显示Home按钮
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
        
        self.conScrollContentViewWidth.constant = MAIN_SCREEN_WIDTH_ONIpad;
        // 2.1、计算顶部InfoView高度 50 为底部的距离
        self.conInfoViewHeight.constant = MAIN_SCREEN_WIDTH_ONIpad / self.conImageViewHeightRatio.multiplier + 50;
    }
}

#pragma mark - 加载网络数据
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
    
    [[WebAccessManager sharedInstance]loadHtmlOfVideoWithIn_id:self.in_id font_size:fontSize completion:^(NSString *html, NSError *error) {
        if (!error && html) {
            NSString *URLStr = [NSString stringWithFormat:@"%@%@",[[WebAccessManager sharedInstance]  webServiceUrl],@"informationMobileController/toInforMationArticleContentHtml"];
            html = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", html];
            [self.uiWebView loadHTMLString:html baseURL:[NSURL URLWithString:URLStr]];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
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

-(void)loadNetWorkData:(BOOL)isRefresh{
    if (!isRefresh) {
        self.uiScrollView.hidden = YES;
    }
    
    // 1、加载视频资讯的基本信息
    [[WebAccessManager sharedInstance]getPicTextAndVideoInfoDetailWithIn_id:self.in_id showRows:NO completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 1.0 获取数据
            self.infoObj = response.data.information;
            
            if(self.infoObj.in_is_station && [self.infoObj.in_is_station isEqualToString:@"1"]){
                // E站资讯
                self.conEStationViewHeight.constant = 65;
                self.uiEStationView.hidden = NO;
                
                // 根据是否关注进行显示
                self.uiStationNameLab.text = self.infoObj.si_name;
                
                // 根据是否关注显示不同信息
                if ([self.infoObj.si_is_concern integerValue] == Attented) {
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
            
            // 1.1、 初始化界面数据
            if (!isRefresh) {
                [_uiImageView sd_setImageWithURL:[NSURL URLWithString:self.infoObj.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
            }
            [_uiPlayCountLab setText:[NSString stringWithFormat:@"%@ 次播放", self.infoObj.in_hits]];
            if (!isRefresh) {
                [_uiDescTitleLab setText:self.infoObj.in_title];
                [_uiDescSummaryLab setText:[NSString stringWithFormat:@"%@%@%@", self.infoObj.in_article_type, @" / ", self.infoObj.in_video_duration]];
                [_uiDescTimeLab setText:self.infoObj.in_publish_date_str];
            }
            
            // 1.2、处理推荐资讯列表
            _recommendList = response.data.recommendList;
            [_uiRecCollectionView reloadData];
            
            
            [_reviewList removeAllObjects];
            // 1.3、将评论数据处理成可加载的数据
            for (int i=0; i<response.data.information.reviewList.count; i++) {
                Comment* comment = [response.data.information.reviewList objectAtIndex:i];
                NSMutableArray* commentArray = comment.reList;
                if (!commentArray) {
                    commentArray = [NSMutableArray new];
                }
                comment.r_floor = [NSString stringWithFormat:@"%lu", (comment.reList.count + 1)];
                [commentArray addObject:comment];
                [_reviewList addObject:commentArray];
            }
            
            [self.uiCommentTableView reloadData];
            
            // 1.4、 刷新ScrollView 高度并显示数据
            [self refreshScrollHeightAndConstant];
//            [self.uiScrollView setHidden:NO];
            
            // 设置底部操作栏的数据
            [self.operationView initViewDataWithInfo:response.data.information];
            
            // 设置分享对象
            self.shareModel = [ShareModel new];
            self.shareModel.in_share_contentURL = response.data.information.in_share_contentURL;
            self.shareModel.in_share_imageURL  = response.data.information.in_share_imageURL;
            self.shareModel.in_share_title  = response.data.information.in_share_title;
            self.shareModel.in_share_desc  = response.data.information.in_share_desc;
            self.shareModel.share_type = @"05";
            self.shareModel.ar_id = self.in_id;
            
        }else{
            // 加载失败，调用默认加载失败页面
        }
    }];
}

#pragma mark - 自定义方法
// 刷新约束和界面高度
- (void)refreshScrollHeightAndConstant{
    // 1. 计算描述视图高度
     self.conDescViewHeight.constant = self.conDescTopViewHeight.constant + self.conDescSummaryTopSpace.constant + self.conDescSummaryHeight.constant + self.conDescSummaryBottomSpace.constant + self.conWebViewHeight.constant;
    
    // 2. 计算uiReviewTableView的高度
    self.conReviewTableHeight.constant = self.uiCommentTableView.contentSize.height;
    
    // 3. 计算 ScrollView的高度
    self.conScrollContentViewHeight.constant = self.conInfoViewHeight.constant + self.conInfoViewBottomSpace.constant + self.conDescViewHeight.constant + self.conDescViewBottomSpace.constant + self.conEStationViewHeight.constant + self.conRecommendViewHeight.constant + self.conRecViewBottomSpace.constant + self.conCommentViewHeight.constant + self.conReviewTableHeight.constant + self.conMoreViewHeight.constant;
}

//- (QINetReachabilityStatus)netWorkingStatus{
//    QINetReachabilityManager *manager = [QINetReachabilityManager sharedInstance];
//
//    QINetReachabilityStatus status = (QINetReachabilityStatus)[manager currentNetReachabilityStatus];
//
//    return status;
//}

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
    // 计算Cell的宽度 30 为左右两边的边距, 9为Cell间隔
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    CGFloat cellWidth = ((showWidth - 30) - showWidth / kWIDTH_375 * 9) / 2;
    
    return CGSizeMake(cellWidth, self.conRecommendViewHeight.constant - self.conRecTopViewHeight.constant);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    return CGSizeMake(showWidth / kWIDTH_375 * 9, self.conRecommendViewHeight.constant - self.conRecTopViewHeight.constant);
}

#pragma mark - BottomOperationViewDelegate
- (void)didBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didToCommentList{
    [self clickMoreCommentBtnAction:nil];
}

- (void)didToLoginView{
    [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false  isShowAlertYinDao:NO completion:nil];
}

- (void)didShare{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

#pragma mark - 按钮手势点击事件
- (IBAction)clickPlayAction:(id)sender {
    // 1、判断是否缓存，若没有缓存，则通过网络播放，若已经缓存，则直接播放
    if ([CustomDownloadManager isDownloadCompleteWithInId:self.in_id]) {
        // 直接播放
        [self regsiterWMPlayer];
        [self.uiInfoView bringSubviewToFront:wmPlayer];
        [wmPlayer play];
    }else{
        // 判断网络状态
        if([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusNone){
            MMPopupItemHandler block = ^(NSInteger index){
            };
            // 提示
            NSArray *items =
            @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
            [[[MMAlertView alloc] initWithTitle:@"提示"
                                         detail:@"找啊找！找不到网络，请检查！"
                                          items:items]
             showWithBlock:nil];
            
         }else if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusWifi){
            // 注册播放器
            [self regsiterWMPlayer];
            [self.uiInfoView bringSubviewToFront:wmPlayer];
            [wmPlayer play];
        }else if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusWWAN){
            MMPopupItemHandler block = ^(NSInteger index){
                if (index == 0) {
                    
                }
                
                if (index == 1) {
                    [self regsiterWMPlayer];
                    [self.uiInfoView bringSubviewToFront:wmPlayer];
                    [wmPlayer play];
                }
            };
            // 提示
            NSArray *items =
            @[MMItemMake(@"去找WIFI", MMItemTypeNormal, block),
              MMItemMake(@"土豪继续", MMItemTypeHighlight, block)];
            [[[MMAlertView alloc] initWithTitle:@"提示"
                                         detail:@"网络处于3/4G环境下!"
                                          items:items]
             showWithBlock:nil];
        }
        
//        QINetReachabilityStatus status = [self netWorkingStatus];
//        if(status == QINetReachabilityStatusNotReachable){
//            MMPopupItemHandler block = ^(NSInteger index){
//            };
//            // 提示
//            NSArray *items =
//            @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
//            [[[MMAlertView alloc] initWithTitle:@"提示"
//                                         detail:@"找啊找！找不到网络，请检查！"
//                                          items:items]
//             showWithBlock:nil];
//
//        }else if (status == QINetReachabilityStatusWIFI){
//            // 注册播放器
//            [self regsiterWMPlayer];
//            [self.uiInfoView bringSubviewToFront:wmPlayer];
//            [wmPlayer play];
//        }else if (status == QINetReachabilityStatusWWAN){
//            MMPopupItemHandler block = ^(NSInteger index){
//                if (index == 0) {
//
//                }
//
//                if (index == 1) {
//                    [self regsiterWMPlayer];
//                    [self.uiInfoView bringSubviewToFront:wmPlayer];
//                    [wmPlayer play];
//                }
//            };
//            // 提示
//            NSArray *items =
//            @[MMItemMake(@"去找WIFI", MMItemTypeNormal, block),
//              MMItemMake(@"土豪继续", MMItemTypeHighlight, block)];
//            [[[MMAlertView alloc] initWithTitle:@"提示"
//                                         detail:@"网络处于3/4G环境下!"
//                                          items:items]
//             showWithBlock:nil];
//        }
    }
}


// 下载视频
- (IBAction)clickDownloadBtnAction:(id)sender {
    if (self.infoObj && self.infoObj.in_movie_url && ![self.infoObj.in_movie_url isEqualToString:@""]) {
        DownloadInfo* downloadInfo = [DownloadInfo new];
        downloadInfo.in_id = self.infoObj.in_id;
        downloadInfo.in_title = self.infoObj.in_title;
        downloadInfo.in_img_url = self.infoObj.in_img_url;
        downloadInfo.in_movie_url = self.infoObj.in_movie_url;
        downloadInfo.in_article_type = self.infoObj.in_article_type;
        downloadInfo.in_video_duration = self.infoObj.in_video_duration;
        downloadInfo.in_publish_date_str = self.infoObj.in_publish_date_str;
        downloadInfo.name = [[self.infoObj.in_movie_url componentsSeparatedByString:@"/"] lastObject];
        downloadInfo.destinationPath = [kCachePath stringByAppendingPathComponent:downloadInfo.name];
        
        // 缓存
        [CustomDownloadManager downloadVideoWithDownloadInfo:downloadInfo doDownload:YES byWIFI:YES];
        
        // 跳转
        [FlowUtil startToDownloadVideoVCNav:self.navigationController];
    }
    else{
        [SVProgressHUDUtil showInfoWithStatus:@"正在加载数据"];
        DLog(@"VideoInfoDetailViewController-视频信息infoObj为空：%@",self.infoObj);
        return;
    }
    
}

- (IBAction)clickMoreCommentBtnAction:(id)sender {
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:self.in_id completion:nil];
}

- (IBAction)clickAttentBtnAction:(id)sender {
    // 未关注的点击之后变为已关注，已关注的点击之后为取消关注
    if ([self.infoObj.si_is_concern intValue] == Attented) {
        // 已关注的，取消关注
        [[WebAccessManager sharedInstance]delStationWithSiId:self.infoObj.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.infoObj.si_is_concern = [NSString stringWithFormat:@"%d", NoAttent];
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
        [[WebAccessManager sharedInstance]saveStationWithSiId:self.infoObj.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.infoObj.si_is_concern = [NSString stringWithFormat:@"%d", Attented];
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
    [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:self.infoObj.si_id];
}

- (IBAction)clickBackHomeBtnAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - WMPlayer
-(void)statusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            [UIApplication sharedApplication].statusBarHidden = YES;
        }else{
            [UIApplication sharedApplication].statusBarHidden = NO;
        }
    }else{
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
}

- (void)regsiterWMPlayer{
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:WMPlayerFullScreenButtonClickedNotification object:nil];
    
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    playerFrame = CGRectMake(0, 0, showWidth, self.conInfoViewHeight.constant - 50);
    
    // 根据是否缓存调用相应的数据播放
    if ([CustomDownloadManager isDownloadCompleteWithInId:self.in_id]) {
        // 已经缓存
        DownloadInfo* downloadInfo = [TransferModelToData getDownloadInfoWithInId:self.in_id];
        wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:downloadInfo.destinationPath];
    }else{
        
        if (self.infoObj && self.infoObj.in_movie_url && ![self.infoObj.in_movie_url isEqualToString:@""]) {
            wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:self.infoObj.in_movie_url];
        }else{
            DLog(@"VideoInfoDetailViewController-视频播放地址为空：%@",self.infoObj.in_movie_url);
            return;
        }
    }
    
    wmPlayer.closeBtn.hidden = YES;
    [self.uiInfoView addSubview:wmPlayer];
    [self.uiInfoView sendSubviewToBack:wmPlayer];
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kSCREEN_WIDTH-40);
        make.width.mas_equalTo(kSCREEN_HEIGHT);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kSCREEN_HEIGHT/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    [self statusBarHidden];
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}

-(void)toNormal{
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame =CGRectMake(playerFrame.origin.x, playerFrame.origin.y, playerFrame.size.width, playerFrame.size.height);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.uiInfoView addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self statusBarHidden];
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self statusBarHidden];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self toNormal];
    }
}

//  旋转屏幕通知
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                [self toNormal];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.isFullscreen = YES;
                [self statusBarHidden];
                
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.isFullscreen = YES;
                [self statusBarHidden];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}

-(void)closeTheVideo:(NSNotification *)obj{
    [self releaseWMPlayer];
    [self statusBarHidden];
}

- (void)releaseWMPlayer
{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
    
    [wmPlayer.player pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer = nil;
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
}

- (void)dealloc
{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.uiScrollView.contentOffset.y > kSCREEN_WIDTH / self.conImageViewHeightRatio.multiplier) {
        if (wmPlayer.isPlaying) {
            [wmPlayer pause];
        }
    }
}

#pragma mark - LayoutContainerView Delegate
- (void)commentSuccessCallBack{
    [self loadNetWorkData:YES];
}

#pragma mark - WebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }

    [SVProgressHUDUtil dismiss];
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
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
}

@end
