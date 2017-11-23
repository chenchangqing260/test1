//
//  DownloadVideoViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "DownloadVideoViewController.h"
#import "DownloadInfoCell.h"
#import "TransferModelToData.h"
#import "DownloadInfo.h"
#import "UITableView+LongPressTable.h"
#import "UITableViewDataSource_LongPreeable.h"
#import "CustomDownloadManager.h"
#import "WMPlayer.h"
//#import "QINetReachabilityManager.h"
#import "FGGDownloadManager.h"
#import "CoreStatus.h"

@interface DownloadVideoViewController ()<UITableViewDataSource_LongPreeable, DownloadInfoCellDelegate>
{
    BOOL _gotoLeft;
}
@property (weak, nonatomic) IBOutlet UITableView *uiDownloadInfoTableView;
@property (nonatomic, strong)NSMutableArray* downloadInfoArray;
@property (nonatomic,retain)DownloadInfoCell *currentCell;
@property (nonatomic, strong) UIView *noInfoView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollLeadingEdge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTrallingEdge;

@end

@implementation DownloadVideoViewController
{
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    CGRect     playerFrame;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"离线缓存";
    
    // 2、注册通知用来刷新界面进度条
    [self registerNotice];
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupLeftBatBtnItrem];
    
    // 注册旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeTheVideo:) name:WMPlayerClosedNotification object:nil];
    
    // 1、初始化数据
    [self initViewAndConAttribute];
    
    [self reloadSubviews];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //将要消失，关闭正在播放
    [self closeTheVideo:nil];    
}

#pragma mark - 初始化界面
-(void)setupView{
    
    CGFloat _imageW = 118.0;
    _noInfoView = [[UIView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH-200)/2.0, (MAIN_SCREEN_HEIGHT-64-200)/2.0, 200, 200)];
    UIImageView *_img = [[UIImageView alloc] initWithFrame:CGRectMake((_noInfoView.frame.size.width-_imageW)/2.0, 0, _imageW, _imageW)];
    _img.image = [UIImage imageNamed:@"no_down"];
    UILabel *_label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageW+20, _noInfoView.frame.size.width, 20)];
    _label1.font = [UIFont systemFontOfSize:14.0];
    _label1.text = @"暂无本地缓存的视频";
    _label1.textColor = RGBCOLOR(29,29,29);
    _label1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *_label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _label1.frame.origin.y+_label1.frame.size.height+20, _noInfoView.frame.size.width, 20)];
    _label2.font = [UIFont systemFontOfSize:12.0];
    _label2.text = @"你可以通过视频播放页面添加缓存";
    _label2.textColor = RGBCOLOR(190,190,190);
    _label2.textAlignment = NSTextAlignmentCenter;
    
    [_noInfoView addSubview:_img];
    [_noInfoView addSubview:_label1];
    [_noInfoView addSubview:_label2];
    
    [self.view addSubview:_noInfoView];
    [self.view insertSubview:_noInfoView belowSubview:self.uiDownloadInfoTableView];
    
    if (isIpad) {
        self.scrollLeadingEdge.constant = self.scrollTrallingEdge.constant = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
    } else {
        self.scrollLeadingEdge.constant = self.scrollTrallingEdge.constant = 0;
    }
}
-(void)setupLeftBatBtnItrem{
    if (_gotoLeft) {
        UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
        [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
        [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
        [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}
// 点左侧视图的头像进入的个人信息页-左侧导航点击事件
-(void)leftNavBtn{
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController showLeftController:YES];
}
// 点左侧视图的头像进入的个人信息页-左侧导航按钮
-(void)reSetLeftButton{
    _gotoLeft = YES;
}
-(void)reloadSubviews{
    if (_downloadInfoArray) {
        [self.uiDownloadInfoTableView reloadData];
    }
    if (_downloadInfoArray.count > 0) {
        self.uiDownloadInfoTableView.hidden = NO;
    } else {
        self.uiDownloadInfoTableView.hidden = YES;
    }
}
#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.uiDownloadInfoTableView.longPressTableAble = YES;
    
    _downloadInfoArray = [TransferModelToData getDownloadInfoArray];
    
    isSmallScreen = NO;
}

#pragma mark - 注册通知和通知业务方法
- (void)registerNotice{
    // 1、注册开始下载
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadVideo:) name:kNOTOICE_VIDEO_DOWNLOAD object:nil];
    
    // 2、注册下载完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(completeDownloadVideo:) name:kNOTOICE_VIDEO_COMPLETE object:nil];
}

// 刷新tablecell
- (void)downloadVideo:(NSNotification*)notification{
    // 获取tablecell
    NSDictionary* dict = notification.userInfo;
    NSString* in_id = [dict objectForKey:@"in_id"];
    NSIndexPath* indexPath = [dict objectForKey:@"indexPath"];
    
    if (!indexPath) {
        // 根据in_id 取得cell 的idx
        NSInteger idx = -1;
        DownloadInfo* dInfo = nil;
        if (self.downloadInfoArray && self.downloadInfoArray.count > 0) {
            for (int i = 0; i < self.downloadInfoArray.count; i++) {
                DownloadInfo* info = [self.downloadInfoArray objectAtIndex:i];
                if ([info.in_id isEqualToString:in_id]) {
                    dInfo = info;
                    idx = i;
                    break;
                }
            }
        }
        
        if (idx != -1) {
            // 获取cell
            DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            if (cell) {
                // 刷新进度条
                CGFloat progress = [[FGGDownloadManager shredManager] lastProgress:dInfo.in_movie_url];
                
                if (progress < 1) {
                    [cell startDownload];
                }else{
                    // 下载完成
                }
            }
        }
    }else{
        // 刷新进度条
        DownloadInfo* dInfo = [self.downloadInfoArray objectAtIndex:indexPath.row];
        DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            CGFloat progress = [[FGGDownloadManager shredManager] lastProgress:dInfo.in_movie_url];
            
            if (progress < 1) {
                // 下载或者进行中
                [cell startDownload];
            }else{
                // 下载完成
            }
        }
    }
}

// 刷新tablecell
- (void)completeDownloadVideo:(NSNotification*)notification{
    // 获取tablecell
    NSDictionary* dict = notification.userInfo;
    NSString* in_id = [dict objectForKey:@"in_id"];
    NSIndexPath* indexPath = [dict objectForKey:@"indexPath"];
    
    if (!indexPath) {
        // 根据in_id 取得cell 的idx
        NSInteger idx = -1;
        DownloadInfo* dInfo = nil;
        if (self.downloadInfoArray && self.downloadInfoArray.count > 0) {
            for (int i = 0; i < self.downloadInfoArray.count; i++) {
                DownloadInfo* info = [self.downloadInfoArray objectAtIndex:i];
                if ([info.in_id isEqualToString:in_id]) {
                    dInfo = info;
                    idx = i;
                    break;
                }
            }
        }
        
        if (idx != -1) {
            // 获取cell
            DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            // 下载完成
            if (cell) {
                [cell completeDownload];
            }
        }
    }else{
        // 刷新进度条
        DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            // 下载完成
            [cell completeDownload];
        }
    }
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _downloadInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[DownloadInfoCell ID]];
    if (!cell) {
        cell = [DownloadInfoCell newCell];
    }
    
    cell.delegate = self;
    
    if (indexPath.row < self.downloadInfoArray.count) {
        DownloadInfo* downloadInfo = [self.downloadInfoArray objectAtIndex:indexPath.row];
        [cell initCellDataWithReply:downloadInfo withIndex:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    // 计算高度
    return 7 + (showWidth - 14) * 174 / (kWIDTH_375 - 14) + 17 + 20 + 14 + 15 + 9;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (currentIndexPath.row == indexPath.row) {
            [self closeTheVideo:nil];
        }
        
        // 删除数据
        DownloadInfo* downloadInfo = [self.downloadInfoArray objectAtIndex:indexPath.row];
        [CustomDownloadManager deleteDownloadVideoWithInId:downloadInfo.in_id];
        [self.downloadInfoArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self reloadSubviews];
    }
}

#pragma mark - DownloadInfoCellDelegate
- (void)clickStateImgView:(DownloadInfo*) downloadInfo WithIndex:(NSIndexPath *)indexPath{
    if ([CustomDownloadManager isDownloadCompleteWithInId:downloadInfo.in_id]) {
        // 已完成下载，点击直接播放
        [self playVideo:indexPath];
    }else{
        // 获取Cell，根据当前状态，执行下一步操作
        DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:indexPath];
        if ([cell isDownloading]) {
            // 正在下载，执行暂停，进行暂停
            [[FGGDownloadManager shredManager] cancelDownloadTask:downloadInfo.in_movie_url];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell pauseDownload];
            });
        }else{
            // 正在暂停，进行下载
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
                [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell startDownload];
                    });
                } completion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell completeDownload];
                    });
                } failure:^(NSError *error) {
                    
                }];
            }else if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusWWAN){
                MMPopupItemHandler block = ^(NSInteger index){
                    if (index == 0) {
                    }
                    
                    if (index == 1) {
                        [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [cell startDownload];
                            });
                        } completion:^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [cell completeDownload];
                            });
                        } failure:^(NSError *error) {
                            
                        }];
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
            
            
//            QINetReachabilityStatus status = [DownloadVideoViewController netWorkingStatus];
//            if(status == QINetReachabilityStatusNotReachable){
//                MMPopupItemHandler block = ^(NSInteger index){
//                };
//                // 提示
//                NSArray *items =
//                @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
//                [[[MMAlertView alloc] initWithTitle:@"提示"
//                                             detail:@"找啊找！找不到网络，请检查！"
//                                              items:items]
//                 showWithBlock:nil];
//
//            }else if (status == QINetReachabilityStatusWIFI){
//                // 注册播放器
//                [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [cell startDownload];
//                    });
//                } completion:^{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [cell completeDownload];
//                    });
//                } failure:^(NSError *error) {
//
//                }];
//            }else if (status == QINetReachabilityStatusWWAN){
//                MMPopupItemHandler block = ^(NSInteger index){
//                    if (index == 0) {
//                    }
//
//                    if (index == 1) {
//                        [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [cell startDownload];
//                            });
//                        } completion:^{
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [cell completeDownload];
//                            });
//                        } failure:^(NSError *error) {
//
//                        }];
//                    }
//                };
//                // 提示
//                NSArray *items =
//                @[MMItemMake(@"去找WIFI", MMItemTypeNormal, block),
//                  MMItemMake(@"土豪继续", MMItemTypeHighlight, block)];
//                [[[MMAlertView alloc] initWithTitle:@"提示"
//                                             detail:@"网络处于3/4G环境下!"
//                                              items:items]
//                 showWithBlock:nil];
//            }
        }
    }
}

#pragma mark - WMPlayer
// 播放视频
- (void)playVideo:(NSIndexPath*)indexPath{
    NSIndexPath* orgIndexPath = currentIndexPath;
    
    currentIndexPath = indexPath;
    self.currentCell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:indexPath];
    DownloadInfo *downloadInfo = [self.downloadInfoArray objectAtIndex:indexPath.row];
    
    if (isSmallScreen) {
        [self releaseWMPlayer];
        isSmallScreen = NO;
    }
    
    if (!wmPlayer) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:WMPlayerFullScreenButtonClickedNotification object:nil];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.uiImageView.bounds videoURLStr:downloadInfo.destinationPath];
    }else{
        [self releaseWMPlayer];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.uiImageView.bounds videoURLStr:downloadInfo.destinationPath];
        
        // 将原来Cell的内容展示
        if (orgIndexPath) {
            DownloadInfoCell* cell = [self.uiDownloadInfoTableView cellForRowAtIndexPath:orgIndexPath];
            cell.uiBlackLayer.hidden = NO;
            cell.uiStateImgView.hidden = NO;
            [cell.uiConView sendSubviewToBack:cell.uiImageView];
            [cell.uiConView bringSubviewToFront:cell.uiBlackLayer];
            [cell.uiConView bringSubviewToFront:cell.uiStateImgView];
        }
    }
    
    [wmPlayer play];
    [self.currentCell.uiImageView addSubview:wmPlayer];
    //    [self.currentCell bringSubviewToFront:wmPlayer];
    [self.currentCell.uiImageView bringSubviewToFront:wmPlayer];
    [self.currentCell.uiConView bringSubviewToFront:self.currentCell.uiImageView];
    self.currentCell.uiBlackLayer.hidden = NO;
    self.currentCell.uiStateImgView.hidden = NO;
    [self.uiDownloadInfoTableView layoutIfNeeded];
}


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

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.uiDownloadInfoTableView){
        if (wmPlayer==nil) {
            return;
        }
        
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.uiDownloadInfoTableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.uiDownloadInfoTableView convertRect:rectInTableView toView:[self.uiDownloadInfoTableView superview]];
            if (rectInSuperview.origin.y<-self.currentCell.uiImageView.frame.size.height||rectInSuperview.origin.y>kSCREEN_HEIGHT-kNAV_HEIGHT-49) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.uiImageView.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}

-(void)toCell{
    DownloadInfoCell *currentCell = (DownloadInfoCell *)[self.uiDownloadInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [wmPlayer removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.uiImageView.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [currentCell.uiImageView addSubview:wmPlayer];
        [currentCell.uiImageView bringSubviewToFront:wmPlayer];
        
        [currentCell.uiConView bringSubviewToFront:currentCell.uiImageView];
        currentCell.uiBlackLayer.hidden = NO;
        currentCell.uiStateImgView.hidden = NO;
         [self.uiDownloadInfoTableView layoutIfNeeded];
        
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
        isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
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
        [self.uiDownloadInfoTableView addSubview:wmPlayer];
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
            [self toCell];
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
                    [self toCell];
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
    if (self.currentCell) {
        self.currentCell.uiBlackLayer.hidden = NO;
        self.currentCell.uiStateImgView.hidden = NO;
        [self.currentCell.uiConView sendSubviewToBack:self.currentCell.uiImageView];
        [self.currentCell.uiConView bringSubviewToFront:self.currentCell.uiBlackLayer];
        [self.currentCell.uiConView bringSubviewToFront:self.currentCell.uiStateImgView];
        [self.uiDownloadInfoTableView layoutIfNeeded];
    }
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

//+ (QINetReachabilityStatus)netWorkingStatus{
//    QINetReachabilityManager *manager = [QINetReachabilityManager sharedInstance];
//
//    QINetReachabilityStatus status = (QINetReachabilityStatus)[manager currentNetReachabilityStatus];
//
//    return status;
//}

@end
