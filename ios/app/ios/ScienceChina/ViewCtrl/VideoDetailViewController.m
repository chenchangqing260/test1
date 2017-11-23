//
//  VideoDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "InfoObj.h"
#import "ShareModel.h"
#import "VideoInfoView.h"
#import "VideoRecCollectionViewCell.h"
#import "VideoRecLayout.h"
#import "BlurCommentView.h"
#import "WMPlayer.h"
#import "CustomDownloadManager.h"
#import "TransferModelToData.h"

@interface VideoDetailViewController ()<VideoInfoViewDelegate>

@property (nonatomic, strong)InfoObj* infoObj;
@property (nonatomic, strong)ShareModel* shareModel;
@property (nonatomic, strong)VideoInfoView* videoView;
@property (nonatomic, strong)NSMutableArray* recommendList;
@property (nonatomic, assign)NSInteger page;
@property (weak, nonatomic) IBOutlet VideoRecLayout *uiVideoRecLayout;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;

@property (weak, nonatomic) IBOutlet UIButton *uiBackHomeBtn;

@end

@implementation VideoDetailViewController
{
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    CGRect     playerFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    self.page = 1;
    isSmallScreen = NO; // 是否是缩小的状态
    
    // 6. 根据进入的等级，判断是否显示Home按钮
    NSArray* viewControllers = self.jt_navigationController.viewControllers;
    if (viewControllers.count > 3) {
        self.uiBackHomeBtn.hidden = NO;
    }else{
        self.uiBackHomeBtn.hidden = YES;
    }
    
    [self loadNetWorkData:NO];
    
    // 3、注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshVideoDetail) name:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addInfoViewAndLoadVideoCollectionView) name:@"addInfoViewAndLoadVideoCollectionView" object:nil]; // 将顶部的信息视图加到View上，并且加载CollectionView
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshVideoDetailAttentBtn) name:@"refreshVideoDetailAttentBtn" object:nil]; // E站刷新视图上的关注按钮
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
    
    // 刷新下载状态
    if (_videoView) {
        [_videoView refreshDownloadState];
    }
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

#pragma mark - 自定义方法(包括通知)
- (void)addInfoViewAndLoadVideoCollectionView{
    [SVProgressHUDUtil dismiss];
    // 1、将信息视图加到CollectionView上
    self.videoView.autoresizingMask = UIViewAutoresizingNone;
    self.videoView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, self.videoView.viewHeight);
    
    // 2、刷新CollectionView
    [self initCollectionView];
    self.uiVideoRecLayout.baseHeight = self.videoView.viewHeight;
    self.uiVideoRecLayout.itemList = self.recommendList;
    [self.uiCollectionView reloadData];
    
    // 3、显示collectionView
    self.uiContentView.hidden = NO;
    
    // 5、直接播放视频
    [self playVideo];
    
    
}

// 刷新数据关注按钮
- (void)refreshVideoDetailAttentBtn{
    [[WebAccessManager sharedInstance]getPicTextAndVideoInfoDetailWithIn_id:self.in_id showRows:YES completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 1、获取数据
            self.infoObj = response.data.information;
            
            // 2、刷新关注按钮
            if (self.videoView) {
                [self.videoView refreshAttentBtn:self.infoObj];
            }
        }
    }];
}

// 刷新界面数据
- (void)refreshVideoDetail{
    [self loadNetWorkData:YES];
}

// 点击重新加载另外一个视频
- (void)loadOtherVideo:(NSString*)in_id{
    self.in_id = in_id;
    // 若有视频在播放删除
    if (wmPlayer) {
        [self closeTheVideo:nil];
    }
    
    // 删除原来的界面视图
    [self.videoView removeFromSuperview];
    
    // 回到顶部
    [self.uiCollectionView setContentOffset:CGPointMake(0, 0)animated:NO];
    
    [self loadNetWorkData:NO];
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData:(BOOL)isRefresh{
    if (!isRefresh){
        self.uiContentView.hidden = YES;
        [SVProgressHUDUtil showWithStatus:@"正在加载..."];
    }
    // 1、加载视频资讯的基本信息
    [[WebAccessManager sharedInstance]getPicTextAndVideoInfoDetailWithIn_id:self.in_id showRows:YES completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 1、获取数据
            self.infoObj = response.data.information;
            
            if (!isRefresh) {
                // 2、处理推荐资讯列表
                [_recommendList removeAllObjects];
                _recommendList = response.data.recommendList;
            }
            
            // 3、加载View
            self.videoView = [VideoInfoView newView];
            self.videoView.delegate = self;
            [self.uiCollectionView addSubview:self.videoView];
            
            // 2、网络加载数据
            [self.videoView loadInfoHtml:self.in_id];
            [self.videoView initViewWithInfoObj:self.infoObj];
            
            // 4、设置分享对象
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

// 加载更多的推荐视频资讯
- (void)loadMoreRecVideoInfo{
    [[WebAccessManager sharedInstance]getVideoForRecWithInId:self.in_id page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiCollectionView.mj_footer endRefreshing];
        if (response.success) {
            if (response.data.recommendList.count > 0) {
                // 还有数据
                [_recommendList addObjectsFromArray:[response.data.recommendList copy]];
                
                self.uiVideoRecLayout.itemList = _recommendList;
                [self.uiCollectionView reloadData];
            }else{
                // 没有数据了
                self.page -= 1;
            }
        }else{
            self.page -= 1;
        }
        
    }];
}

#pragma mark - CollectionView Delegate, DataSource
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[VideoRecCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[VideoRecCollectionViewCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _recommendList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoRecCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[VideoRecCollectionViewCell ID] forIndexPath:indexPath];
    
    if (indexPath.section < _recommendList.count) {
        [cell initCellData:[_recommendList objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] < _recommendList.count) {
        InfoObj* info = [_recommendList objectAtIndex:[indexPath row]];
        
        if ([info.in_classify isEqualToString:@"0"] || [info.in_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
        }else if([info.in_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
        }else if([info.in_classify isEqualToString:@"2"]){
            // 视频，刷新当前页面视频，并且重新刷新界面数据
            [self loadOtherVideo:info.in_id ];
        }else if([info.in_classify isEqualToString:@"3"]){
            // 专题
            // TODO ELLISON
            DLog(@"===========专题跳转============");
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:info.in_id];
        }
    }
}

#pragma mark - 点击按钮和手势事件
- (IBAction)clickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickBackHomeBtnAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - MJRefresh
-(BOOL)showMJHeader{
    return NO;
}

- (void)collectionViewRefreshFooterData{
    self.page += 1;
    [self loadMoreRecVideoInfo];
}

#pragma mark - VideoInfoViewDelegate
- (void)goToCommentList{
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:self.in_id completion:nil];
}

- (void)didToLoginView{
    [self closeTheVideo:nil];
    [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:false  isShowAlertYinDao:NO completion:nil];
}

- (void)didShare{
    [self closeTheVideo:nil];
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

- (void)didToEStation{
    [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:self.infoObj.si_id];
}

// 播放视频
- (void)playVideo{
    if (wmPlayer && wmPlayer.isPlaying) {
        return;
    }
    
    // 注册播放器
    [self regsiterWMPlayer];
    [self.uiContentView bringSubviewToFront:wmPlayer];
    [wmPlayer play];
}

- (void)didToDownloadVideo{
    
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
    
    playerFrame = CGRectMake(0, 0, kSCREEN_WIDTH, self.videoView.conInfoViewHeight.constant - 50);
    
    // 根据是否缓存调用相应的数据播放
    if ([CustomDownloadManager isDownloadCompleteWithInId:self.in_id]) {
        // 已经缓存
        DownloadInfo* downloadInfo = [TransferModelToData getDownloadInfoWithInId:self.in_id];
        wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:downloadInfo.destinationPath];
    }else{
        if (self.infoObj && self.infoObj.in_movie_url && ![self.infoObj.in_movie_url isEqualToString:@""]) {
            wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:self.infoObj.in_movie_url];
        }else{
            DLog(@"VideoDetailViewController-视频播放地址为空：%@",self.infoObj.in_movie_url);
            return;
        }
    }
    
    wmPlayer.closeBtn.hidden = YES;
    [self.uiContentView addSubview:wmPlayer];
    [self.uiContentView sendSubviewToBack:wmPlayer];
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

// 变小放在View上
-(void)toSmallScreen{
    //放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(kSCREEN_WIDTH/2,kSCREEN_HEIGHT-49-(kSCREEN_WIDTH/2)*0.75, kSCREEN_WIDTH/2, (kSCREEN_WIDTH/2)*0.75);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
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
        isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
        // 禁用原来的播放按钮
    }];
    
}

-(void)toNormal{
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame =CGRectMake(playerFrame.origin.x, playerFrame.origin.y, playerFrame.size.width, playerFrame.size.height);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.uiContentView addSubview:wmPlayer];
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
        isSmallScreen = NO;
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
        if (isSmallScreen) {
            [self toSmallScreen];
        }else{
            [self toNormal];
        }
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
                if (isSmallScreen) {
                    [self toSmallScreen];
                }else{
                    [self toNormal];
                }
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
    if (wmPlayer==nil) {
        return;
    }
    
    if (self.uiCollectionView.contentOffset.y > self.videoView.viewHeight) {
        if (isSmallScreen) {
            return;
        }
        [self toSmallScreen];
    }else{
        if (isSmallScreen) {
            [self toNormal];
        }
    }
}

#pragma mark - LayoutContainerView Delegate
- (void)commentSuccessCallBack{
    [self loadNetWorkData:YES];
}

@end
