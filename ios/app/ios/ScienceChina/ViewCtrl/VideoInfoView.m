//
//  VideoInfoView.m
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VideoInfoView.h"
#import "IPDashedLineView.h"
#import "Comment.h"
#import "LayoutContainerView.h"
#import "CommentTableCell.h"
#import "BlurCommentView.h"
#import "AFWaveView.h"
#import "CustomDownloadManager.h"

typedef enum{Attented = 1, NoAttent = 0} stationAttent;

@interface VideoInfoView()<LayoutContinerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conCommentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conReviewTableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conOperationViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMoreTextViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conInfoViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conOperationViewBottomSpace;
// DescView内部约束，用来控制DescView高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescSummaryBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWebViewHeight;
// EStationView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conEStationViewHeight;

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiPlayCountLab;
@property (weak, nonatomic) IBOutlet UITableView *uiCommentTableView;
@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;
@property (weak, nonatomic) IBOutlet UILabel *uiDescTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescSummaryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescTitleLab;
@property (weak, nonatomic) IBOutlet UIView *uiMoreTextView;
@property (weak, nonatomic) IBOutlet UIButton *uiShowInputViewBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;
@property (weak, nonatomic) IBOutlet UIView *uiLikeView;
@property (weak, nonatomic) IBOutlet UIImageView *uiLikeImgView;
// EStation
@property (weak, nonatomic) IBOutlet UIView *uiEStationView;
@property (weak, nonatomic) IBOutlet UIButton *uiStationAttentBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiStationNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiDownloadStatusImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiDownloadStatusLab;

@property (nonatomic, assign)BOOL loadTableSuccess;
@property (nonatomic, assign)BOOL loadInfoSuccess;
@property (nonatomic, assign)BOOL loadWebViewSuccess;

@property (nonatomic, strong)InfoObj* infoObj;
@property (nonatomic, strong)NSMutableArray* reviewList;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation VideoInfoView

- (void)awakeFromNib{
    // 1、初始化数据和约束
    [self initViewAndConstant];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    // 1、存放评论数据的列表
    _reviewList = [NSMutableArray new];
    
    // 2、约束初始化
    self.conEStationViewHeight.constant = 0;
    self.uiEStationView.hidden = YES;
    // 2.1、计算顶部InfoView高度, 50 为底部的距离
    self.conInfoViewHeight.constant = kSCREEN_WIDTH / self.conImageViewHeightRatio.multiplier + 55;
    
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
    
    IPDashedLineView *dash = [[IPDashedLineView alloc] initWithFrame:CGRectMake(15, self.conMoreTextViewHeight.constant - 1, kSCREEN_WIDTH - 30, 1)];
    [self.uiMoreTextView addSubview:dash];
    
    // 4、初始化Btn
    self.uiShowInputViewBtn.layer.borderColor = [UIColor colorWithHex:0xD8D8D8].CGColor;
    self.uiShowInputViewBtn.layer.borderWidth = 0.5;
    self.uiShowInputViewBtn.layer.cornerRadius = 3;
    self.uiShowInputViewBtn.layer.masksToBounds = YES;
}

#pragma mark - 创建视图
+(VideoInfoView *)newView{
    return [[NSBundle mainBundle]loadNibNamed:@"VideoInfoView" owner:nil options:nil][0];
}

-(void)loadInfoHtml:(NSString*)in_id{
    self.loadWebViewSuccess = NO;
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
    [[WebAccessManager sharedInstance]loadHtmlOfVideoWithIn_id:in_id font_size:fontSize completion:^(NSString *html, NSError *error) {
        if (!error && html) {
            NSString *URLStr = [NSString stringWithFormat:@"%@%@",[[WebAccessManager sharedInstance]  webServiceUrl],@"informationMobileController/toInforMationArticleContentHtml"];
            html = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", html];
            [self.uiWebView loadHTMLString:html baseURL:[NSURL URLWithString:URLStr]];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark - 初始化界面数据，并计算界面高度
- (void)initViewWithInfoObj:(InfoObj*)info{
    self.infoObj = info;
    self.loadInfoSuccess = NO;
    self.loadTableSuccess = NO;
    
    // 1、顶部基本信息视图
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:self.infoObj.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [_uiPlayCountLab setText:[NSString stringWithFormat:@"%@ 次播放", self.infoObj.in_hits]];
    if ([self.infoObj.in_is_collect integerValue] == Collect) {
        // 已收藏
        [_uiLikeImgView setImage:[UIImage imageNamed:@"已喜欢"]];
    }else{
        // 未收藏
        [_uiLikeImgView setImage:[UIImage imageNamed:@"喜欢"]];
    }
    
    // 判断此资源是否下载完成，并显示相应的界面
    if ([CustomDownloadManager isDownloadInfoWithInId:self.infoObj.in_id]) {
        // 已经缓存完成
        self.uiDownloadStatusLab.text = @"已缓存";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x33CFDA];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"已缓存"]];
    }else{
        self.uiDownloadStatusLab.text = @"下载";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x636363];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"Video下载"]];
    }
    
    // 是否关注
    [self refreshAttentBtn:nil];
    
    // 2、描述内容视图
    [_uiDescTitleLab setText:self.infoObj.in_title];
    [_uiDescSummaryLab setText:[NSString stringWithFormat:@"%@%@%@", self.infoObj.in_article_type, @" / ", self.infoObj.in_video_duration]];
    [_uiDescTimeLab setText:self.infoObj.in_publish_date_str];
    // 2.1 基本数据加载完成
    self.loadInfoSuccess = YES;
    
    // 3、加载评论列表
    [_reviewList removeAllObjects];
    // 3.1、将评论数据处理成可加载的数据
    for (int i=0; i<info.reviewList.count; i++) {
        Comment* comment = [info.reviewList objectAtIndex:i];
        NSMutableArray* commentArray = comment.reList;
        if (!commentArray) {
            commentArray = [NSMutableArray new];
        }
        comment.r_floor = [NSString stringWithFormat:@"%lu", (comment.reList.count + 1)];
        [commentArray addObject:comment];
        [_reviewList addObject:commentArray];
    }
    
    if (_reviewList.count == 0) {
        self.loadTableSuccess = YES;
    }else{
        [self.uiCommentTableView reloadData];
    }
    
    // 2、加载评论数量
    [self.uiCommentCountLab setText:self.infoObj.in_reviewCount];
    
    // 4、刷新数据
    [self refreshViewHeightAndConstant];
}

- (void)refreshAttentBtn:(InfoObj*)info{
    if (info) {
        self.infoObj = info;
    }
    
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
}

- (void)refreshDownloadState{
    // 判断此资源是否下载完成，并显示相应的界面
    if ([CustomDownloadManager isDownloadInfoWithInId:self.infoObj.in_id]) {
        // 已经缓存完成
        self.uiDownloadStatusLab.text = @"已缓存";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x33CFDA];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"已缓存"]];
    }else{
        self.uiDownloadStatusLab.text = @"下载";
        self.uiDownloadStatusLab.textColor = [UIColor colorWithHex:0x636363];
        [self.uiDownloadStatusImgView setImage:[UIImage imageNamed:@"Video下载"]];
    }
}

// 刷新约束和界面高度
- (void)refreshViewHeightAndConstant{
    // 1. 计算描述视图高度
    self.conDescViewHeight.constant = self.conDescTopViewHeight.constant + self.conDescSummaryTopSpace.constant + self.conDescSummaryHeight.constant + self.conDescSummaryBottomSpace.constant + self.conWebViewHeight.constant;
    
    // 2. 计算uiReviewTableView的高度
    self.conReviewTableHeight.constant = self.uiCommentTableView.contentSize.height;
    
    // 3. 计算 View的高度
    self.viewHeight = self.conInfoViewHeight.constant + self.conInfoViewBottomSpace.constant + self.conDescViewHeight.constant + self.conDescViewBottomSpace.constant + self.conEStationViewHeight.constant + self.conCommentViewHeight.constant + self.conReviewTableHeight.constant + self.conOperationViewHeight.constant + self.conOperationViewBottomSpace.constant + self.conMoreTextViewHeight.constant;
    
    // 4、根据加载完成刷新主界面的高度和加载CollectionView
    if (self.loadTableSuccess && self.loadInfoSuccess && self.loadWebViewSuccess) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addInfoViewAndLoadVideoCollectionView" object:nil];
    }
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
        self.loadTableSuccess = YES;
        [self refreshViewHeightAndConstant];
    }
}

#pragma mark - 点击按钮或手势事件
- (IBAction)clickShowInputCommentBtnAction:(id)sender {
    [BlurCommentView commentshowSuccess:^(NSString *commentText) {
        [SVProgressHUDUtil showWithStatus:@"正在评论..."];
        [[WebAccessManager sharedInstance]saveAndReplyCommentWithIn_id:self.infoObj.in_id commentContent:commentText parentCommentId:nil completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"评论成功"];
                
                // 刷新新闻数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
            }else{
                [SVProgressHUDUtil showInfoWithStatus:response.errorMsg];
            }
        }];
    } withTitle:nil];
}

- (IBAction)clickToCommentListView:(id)sender {
    [self.delegate goToCommentList];
}

//- (IBAction)clickCollectionBtn:(id)sender {
//    if ([MemberManager sharedInstance].isLogined) {
//        if ([self.infoObj.in_is_collect integerValue] == Collect) {
//            self.uiLikeView.userInteractionEnabled = NO;
//            [[WebAccessManager sharedInstance]removeCollectInfo:self.infoObj.in_id completion:^(WebResponse *response, NSError *error) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
//                
//                AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
//                
//                waveView.maxR=30;
//                waveView.duration=1;
//                waveView.waveDelta=4;
//                waveView.waveCount=3;
//                waveView.maxAlpha=1;
//                waveView.minAlpha=0;
//                waveView.waveStyle = Heart;
//                //    waveView.waveStyle = Heart;
//                waveView.mainColor = [UIColor colorWithHex:0xcccccc];
//                //    waveView.boundaryAlpha = 0.8;
//                [self.uiLikeView addSubview:waveView];
//                
//                [_uiLikeImgView setImage:[UIImage imageNamed:@"喜欢"]];
//                self.infoObj.in_is_collect = [NSString stringWithFormat:@"%d", NotCollect];
//                dispatch_main_after(1.2, ^{
//                    [SVProgressHUDUtil showSuccessWithStatus:@"取消成功"];
//                    self.uiLikeView.userInteractionEnabled = YES;
//                });
//            }];
//        }else{
//            self.uiLikeView.userInteractionEnabled = NO;
//            [[WebAccessManager sharedInstance]saveCollectInfo:self.infoObj.in_id completion:^(WebResponse *response, NSError *error) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
//                
//                // 未收藏，进行收藏操作
//                AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
//                
//                waveView.maxR=30;
//                waveView.duration=1;
//                waveView.waveDelta=4;
//                waveView.waveCount=3;
//                waveView.maxAlpha=1;
//                waveView.minAlpha=0;
//                waveView.waveStyle = Heart;
//                //    waveView.waveStyle = Heart;
//                waveView.mainColor = [UIColor colorWithHex:0x33cfda];
//                //[UIColor colorWithRed:0 green:0.7 blue:1 alpha:1];
//                //    waveView.boundaryAlpha = 0.8;
//                
//                [self.uiLikeView addSubview:waveView];
//                [_uiLikeImgView setImage:[UIImage imageNamed:@"已喜欢"]];
//                self.infoObj.in_is_collect = [NSString stringWithFormat:@"%d", Collect];
//                
//                dispatch_main_after(1.2, ^{
//                    [SVProgressHUDUtil showSuccessWithStatus:@"收藏成功"];
//                    self.uiLikeView.userInteractionEnabled = YES;
//                });
//            }];
//        }
//    }else{
//        [self.delegate didToLoginView];
//    }
//}
//
//- (IBAction)clickShareBtn:(id)sender {
//    [self.delegate didShare];
//}

- (IBAction)clickPlayBtn:(id)sender {
    [self.delegate playVideo];
}

- (IBAction)clickDownloadBtn:(id)sender {
    [self.delegate didToDownloadVideo];
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
    [self.delegate didToEStation];
}

#pragma mark - LayoutContainerView Delegate
- (void)commentSuccessCallBack{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

#pragma mark - WebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, clientheight);
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
    
    self.loadWebViewSuccess = YES;
    
    [self refreshViewHeightAndConstant];
}
@end
