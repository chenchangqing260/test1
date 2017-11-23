//
//  ShowViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ShowViewController.h"
#import "ChannelListCell.h"
#import "SDCycleScrollView.h"
#import "HeadTipView.h"
#import "HomeModel.h"
#import "WeChatPublicNumberHeaderView.h"

#define MainCacheData_list @"MainCacheData_list"
#define MainCacheData_slide @"MainCacheData_slide"

//static BOOL _showingHeadlines = YES; //是否正在展示头条
static BOOL _showingBDIData = NO; //是否正在精准推送

@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ChannelListCellDelegate>
{
    
    CGFloat _scrollHeight;
    CGFloat _headerViewHeight_showScroll;
    CGFloat _headerViewHeight_notShowScroll;
    
    
    NSInteger _page;
    NSMutableArray *_cycleSlideDataArry;//轮播图数据
    NSMutableArray *_dataArry;//表格数据
    NSMutableArray *_normalInfoArry; //一般的咨询
    NSMutableArray *_accuratePushArry;//精准推送数据
    
    //WeChatPublicNumberHeaderView *_weChatHeaderView;
    UIView *_headView;
    HeadTipView *_headActionView;
    SDCycleScrollView *_cycleScroll;
    
    BOOL callDFeedBack;
    NSString *_requestId;//精准推送使用的字段
    
    UIImageView *_defaultImageView;
    
    UIImageView *_loadImageView;//加载提示
    
}
@property (nonatomic, assign)NSInteger page;
@end

@implementation ShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self inidata];
    
    [self setupDefaultImageView];
    [self setupView];
    
    
    [self loadNetWorkDataForSetUpView];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _loadImageView.hidden = YES;
}
-(void)setupDefaultImageView{
    
    NSString *backImage;
    if (is35InchScreen()) {
        backImage = @"LaunchImage-700.png";
    } else if (is4InchScreen()) {
        backImage = @"LaunchImage-700-568h@2x.png";
    } else if (is47InchScreen()) {
        backImage = @"LaunchImage-800-667h@2x.png";
    } else if (is55InchScreen()) {
        backImage = @"LaunchImage-800-Portrait-736h@3x.png";
    }
    _defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backImage]];
    _defaultImageView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:_defaultImageView];
    _defaultImageView.hidden = YES;
}
-(void)inidata{
    
    _scrollHeight = 422.0/750.0*MAIN_SCREEN_WIDTH;
    if (isIpad) {
        _scrollHeight = 422.0/750.0*MAIN_SCREEN_WIDTH_ONIpad;
    }
    _headerViewHeight_notShowScroll = 32.0;
    _headerViewHeight_showScroll    = _scrollHeight + _headerViewHeight_notShowScroll;
    _page = 1;
    _dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    _normalInfoArry = [[NSMutableArray alloc] initWithCapacity:0];
    _accuratePushArry = [[NSMutableArray alloc] initWithCapacity:0];
    _cycleSlideDataArry = [[NSMutableArray alloc] initWithCapacity:0];
}
-(void)setupView{
    self.view.backgroundColor = RGBCOLOR(242.0, 242.0, 242.0);
    
    self.uiTableView.backgroundColor = self.view.backgroundColor;
    self.uiTableView.hidden = NO;
    self.uiTableView.mj_header.hidden = NO;
    self.uiTableView.mj_footer.hidden = NO;
    self.uiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.index == 0) {
        CGFloat _leftEdge = 0;
        CGFloat _scrollW = MAIN_SCREEN_WIDTH;
        if (isIpad) {
            _scrollW = MAIN_SCREEN_WIDTH_ONIpad;
            _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        }
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(_leftEdge, 0, _scrollW, _scrollHeight) delegate:self placeholderImage:[UIImage imageNamed:@"close"]];
        _cycleScroll.showPageControl = NO;
        _cycleScroll.titleLabelTextFont = [UIFont systemFontOfSize:15.0];
        _cycleScroll.titleLabelHeight = 32.0;
        _cycleScroll.titleLabelBackgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
        _cycleScroll.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
        _cycleScroll.bannerImageViewContentMode =  UIViewContentModeScaleAspectFill;//UIViewContentModeScaleAspectFit
        _cycleScroll.backgroundColor = [UIColor whiteColor];
        
        _headActionView = [[HeadTipView alloc] initWithFrame:CGRectMake(_leftEdge, _scrollHeight, MAIN_SCREEN_WIDTH_SHOW, _headerViewHeight_notShowScroll) actionBlock:^{
            _showingBDIData = NO;
            [self resetTableHeader];
            [self loadNetWorkData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetHomeTitleView" object:nil userInfo:@{@"showBDIData":@"0"}];
        }];
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, _headerViewHeight_showScroll)];
        _headView.clipsToBounds = YES;
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:_cycleScroll];
        [_headView addSubview:_headActionView];
        self.uiTableView.tableHeaderView = _headView;
    }else{
        self.uiTableView.tableHeaderView = nil;
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
    
    //    _weChatHeaderView= [[WeChatPublicNumberHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, WeChatPublicNumberHeaderViewHeight)];
    
    //缓存
    if (self.index == 0) {
        NSArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:MainCacheData_list];
        NSArray *slide = [[NSUserDefaults standardUserDefaults] objectForKey:MainCacheData_slide];
        
        if (list.count < 1) {
            _defaultImageView.hidden = NO;
        }else{
            _defaultImageView.hidden = YES;
            for (NSDictionary *dic in list) {
                HomeModel *model = [[HomeModel alloc] initWithDic:dic];
                [_dataArry addObject:model];
            }
            for (NSDictionary *dic in slide) {
                HomeModel *model = [[HomeModel alloc] initWithDic:dic];
                [_cycleSlideDataArry addObject:model];
            }
            
            if (_cycleSlideDataArry.count > 0) {
                //轮播图的数据
                NSMutableArray *_titlesArry = [[NSMutableArray alloc]initWithCapacity:0];
                NSMutableArray *_imagesArry = [[NSMutableArray alloc]initWithCapacity:0];
                for (HomeModel *model in _cycleSlideDataArry) {
                    [_titlesArry addObject:model.in_title];
                    [_imagesArry addObject:model.in_img_url];
                    //[_imagesArry addObject:[NSString stringWithFormat:@"%@?%@",model.in_img_url,@"imageView2/1/w/230/h/131/interlace/1/q/100"]];
                }
                
                _cycleScroll.imageURLStringsGroup = _imagesArry;
                _cycleScroll.titlesGroup = _titlesArry;
            }
            [self.uiTableView reloadData];
        }
        
    }else{
        _defaultImageView.hidden = YES;
    }
    
}
-(void)resetTableHeader{
    if (self.index == 0) {
        CGRect _headViewFrame = _headView.frame;
        CGRect _headActionViewFrame = _headActionView.frame;
        //正在展示精准推送
        if (_showingBDIData) {
            _headActionViewFrame.origin.y = 0;
            _headViewFrame.size.height = _headerViewHeight_notShowScroll;
            _headActionView.showActionButton = YES;
            _cycleScroll.hidden = YES;
        }
        //正在展示头条
        else {
            
            _headActionViewFrame.origin.y = _scrollHeight;
            _headViewFrame.size.height = _headerViewHeight_showScroll;
            _headActionView.showActionButton = NO;
            _cycleScroll.hidden = NO;
        }
        _headView.frame = _headViewFrame;
        _headActionView.frame = _headActionViewFrame;
        self.uiTableView.tableHeaderView = _headView;//iOS9需要重置下头视图，不然头视图的高度不变
        [self.uiTableView reloadData];
    }
}

////获取轮播图数据
//-(void)loadCycleSlideData{
//    //加载每日推荐数据
//    [[WebAccessManager sharedInstance]getDailyInfoListWithCompletion:^(WebResponse *response, NSError *error) {
//        if (response.success) {
//            _cycleSlideDataArry = response.data.dailyRecommendList;
//            NSMutableArray *_titlesArry = [[NSMutableArray alloc]initWithCapacity:0];
//            NSMutableArray *_imagesArry = [[NSMutableArray alloc]initWithCapacity:0];
//            for (HomeModel *model in _cycleSlideDataArry) {
//                [_titlesArry addObject:model.in_title];
//                //[_imagesArry addObject:model.in_img_url];
//                [_imagesArry addObject:[NSString stringWithFormat:@"%@?%@",model.in_img_url,@"imageView2/1/w/230/h/131/interlace/1/q/100"]];
//            }
//            
//            _cycleScroll.imageURLStringsGroup = _imagesArry;
//            _cycleScroll.titlesGroup = _titlesArry;
//        }
//    }];
//    
//}

//获取精准推送数据
-(void)loadAccuratePushData{
    _loadImageView.hidden = YES;
    [BDIDataStatistics getRecommendDataWithSuccess:^(NSMutableArray *feedback,NSString *requestId) {
        
        _dataArry = feedback;
        _requestId = requestId;
        [self BDIShowAccuratePushDataWithequestId:requestId];
        dispatch_async(dispatch_get_main_queue(), ^{
            callDFeedBack = YES;
            _loadImageView.hidden = YES;
            [self.uiTableView.mj_footer endRefreshing];
            [self.uiTableView.mj_header endRefreshing];
            [self.uiTableView reloadData];
        });
    } error:^(NSString *errorMessage) {
        _loadImageView.hidden = YES;
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
    }];
}

-(void)resetTableWithArry:(NSMutableArray *)arry{
    _dataArry = arry;
    [self.uiTableView reloadData];
}

//下拉
-(void)loadNetWorkData{
    //[SVProgressHUDUtil showWithStatus:@"正在加载..."];
    if (_dataArry.count < 1) {
        _loadImageView.hidden = NO;
    } else {
        _loadImageView.hidden = YES;
    }
    
    callDFeedBack = NO;
    NSString *_id = _category.at_id;
    NSString *showSlide = @"0";
    if (self.index == 0) {
        showSlide = @"1";
    }
    [[WebAccessManager sharedInstance]getInfoListByCategoryId:_id page:_page showSlide:showSlide completion:^(WebResponse *response, NSError *error) {
        //[SVProgressHUDUtil dismiss];
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        self.uiTableView.hidden = NO;
        
        if (response.success) {
            
            [_defaultImageView removeFromSuperview];
            
            if (self.page == 1) {
                _dataArry = response.data.list;
                [self.uiTableView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_dataArry addObjectsFromArray:[response.data.list copy]];
                    
                    [self.uiTableView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                    [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
                }
            }
            
            if (self.index == 0) {
                //轮播图的数据
                if (response.data.infoRrecList) {
                    _cycleSlideDataArry = response.data.infoRrecList;
                    NSMutableArray *_titlesArry = [[NSMutableArray alloc]initWithCapacity:0];
                    NSMutableArray *_imagesArry = [[NSMutableArray alloc]initWithCapacity:0];
                    for (HomeModel *model in _cycleSlideDataArry) {
                        [_titlesArry addObject:model.in_title];
                        [_imagesArry addObject:model.in_img_url];
                       // [_imagesArry addObject:[NSString stringWithFormat:@"%@?%@",model.in_img_url,@"imageView2/1/w/230/h/131/interlace/1/q/100"]];
                    }
                    
                    _cycleScroll.imageURLStringsGroup = _imagesArry;
                    _cycleScroll.titlesGroup = _titlesArry;
                    
                }
                
            }
            //            else{
            //                if ([self.category.at_name_ch isEqualToString:@"微信"]) {
            //                    self.uiTableView.tableHeaderView = _weChatHeaderView;
            //                }else{
            //                    self.uiTableView.tableHeaderView = nil;
            //                }
            //            }
            
            
            if (self.index == 0 && self.page == 1) {
                
                if (response.data.infoRrecList) {
                    NSArray *savedata = [HomeModel mj_keyValuesArrayWithObjectArray:response.data.infoRrecList];//将模型数组转为字典数组
                    [[NSUserDefaults standardUserDefaults] setObject:savedata forKey:MainCacheData_slide];
                }
                if (response.data.list) {
                    NSArray *savedata = [HomeModel mj_keyValuesArrayWithObjectArray:response.data.list];//将模型数组转为字典数组
                    [[NSUserDefaults standardUserDefaults] setObject:savedata forKey:MainCacheData_list];
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

        }else{
            [_defaultImageView removeFromSuperview];
            self.page -= 1;
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
        
        _loadImageView.hidden = YES;
        
    }];
}

- (void)loadNetWorkDataForSetUpView{
    callDFeedBack = NO;
    _page = 1;
    if (self.index == 0) {
        [self resetTableHeader];
        if (_showingBDIData) {
            [self loadAccuratePushData];
        }else{
            //[self loadCycleSlideData];//获取轮播图数据
            [self loadNetWorkData];//获取头条数据
            
        }
        
    }else{
        [self loadNetWorkData];
    }
}

#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    if (self.index == 0) {
        _showingBDIData = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetHomeTitleView" object:nil userInfo:@{@"showBDIData":@"1"}];
        [self resetTableHeader];
        if (_showingBDIData) {
            [self loadAccuratePushData];
        }else{
            //[self loadCycleSlideData];//获取轮播图数据
            [self loadNetWorkData];//获取头条数据
            
        }
        
    }else{
        [self loadNetWorkData];
    }
}

- (void)tableViewRefreshFooterData{

    _page += 1;
    if (self.index == 0) {
        if (_showingBDIData) {
            _page -= 1;
            //精准推送，不做任何操作
            [self.uiTableView.mj_footer endRefreshing];
            [self.uiTableView.mj_header endRefreshing];
            
        }else{
            //头条
            [self loadNetWorkData];
            
        }
    }else{
        [self loadNetWorkData];
    }
}

#pragma mark SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HomeModel *model = _cycleSlideDataArry[index];
    if ([model.in_classify isEqualToString:@"0"] || [model.in_classify isEqualToString:@"4"]) {
        // 图文、文字
        [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"1"]){
        // 图集
        [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"2"]){
        // 视频
        [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:model.in_id completion:^{
        }];
    }else if([model.in_classify isEqualToString:@"3"]){
        // 专题
        // TODO ELLISON
        DLog(@"===========专题跳转============");
        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:model.in_id];
    }
    
    //浏览文章时进行数据统计
    [self BDIDataStatisticsWithModel:model];
}
#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 这样写，当数据量大时，会导致图片不显示，so暂时改成下面的
    //    ChannelListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChannelListCell ID]];
    //    if (!cell) {
    //        cell = [[ChannelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChannelListCell ID]];
    //    }
    ChannelListCell *cell = [[ChannelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChannelListCell ID]];
    if (indexPath.section < _dataArry.count) {
        HomeModel* model = [_dataArry objectAtIndex:[indexPath section]];
        [cell setCellWithModel:model];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel* model = [_dataArry objectAtIndex:[indexPath section]];
    
    if ([model.in_classify isEqualToString:@"0"] || [model.in_classify isEqualToString:@"4"]) {
        // 图文、文字
        [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
    }else if([model.in_classify isEqualToString:@"1"]){
        // 图集
        [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
    }else if([model.in_classify isEqualToString:@"2"]){
        // 视频
        [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:model.in_id completion:nil];
    }else if([model.in_classify isEqualToString:@"3"]){
        // 专题
        // TODO ELLISON
        DLog(@"===========专题跳转============");
        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:model.in_id];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //浏览文章时进行数据统计
    [self BDIDataStatisticsWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if (indexPath.section < _dataArry.count) {
        
        HomeModel* model = [_dataArry objectAtIndex:[indexPath section]];
        if ([model.in_classify isEqualToString:@"0"]) {
            cellHeight = ChannelListCellHeight_graphic;
        }
        else if ([model.in_classify isEqualToString:@"1"]) {
            if (model.in_img_url2 && ![model.in_img_url2 isEqualToString:@""]) {
                
                cellHeight = ChannelListCellHeight_graphic_MultiplePictures;
            }else{
                cellHeight = ChannelListCellHeight_graphic;
            }
        }
        else if ([model.in_classify isEqualToString:@"2"]) {
            cellHeight = ChannelListCellHeight_video;
        }
        else if ([model.in_classify isEqualToString:@"4"]) {
            cellHeight = ChannelListCellHeight_text;
        }
    }
    
    return cellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat sectionHeight = 4.0;
    if (self.index == 0 && section == 0) {
        sectionHeight = 0;
    }
    
    CGFloat _leftEdge = 0;
    CGFloat _contentViewWidth = MAIN_SCREEN_WIDTH;
    if (isIpad) {
        _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        _contentViewWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, sectionHeight)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(_leftEdge, 0, _contentViewWidth, sectionHeight)];
    contentview.backgroundColor = self.view.backgroundColor;
    
    [view addSubview:contentview];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat sectionHeight = 4.0;
    if (self.index == 0 &&section == 0) {
        sectionHeight = 0;
    }
    return sectionHeight;
}
#pragma mark 精准推送数据统计
-(void)BDIDataStatisticsWithModel:(HomeModel *)model{
    //浏览文章时进行数据统计
    [BDIDataStatistics onVisitWithModel:model];
    if (callDFeedBack) {
        //浏览推荐文章是调用
        [BDIDataStatistics tapRecommendArticleWithModel:model requestId:_requestId];
    }else{
        [BDIDataStatistics additemWithModel:model];
    }
}
-(void)BDIShowAccuratePushDataWithequestId:(NSString *)requestId{
    if (_dataArry.count > 0) {
        //展示精准推送时调用的BDI接口
        NSMutableArray *idds = [[NSMutableArray alloc] initWithCapacity:0];
        for (HomeModel *model in _dataArry) {
            [idds addObject:model.in_id];
        }
        [BDIDataStatistics DFeedBackWithIdArry:idds requestId:requestId];
    }
}

#pragma mark ChannelListCellDelegate
-(void)didSelectCommentWithModel:(HomeModel *)model{
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:model.in_id completion:nil];
}
-(void)didSelectLikeWithModel:(HomeModel *)model{
    if ([[MemberManager sharedInstance] isLogined]) {
//        if ([model.in_is_collect integerValue] == Collect) {
//            [[WebAccessManager sharedInstance]removeCollectInfo:model.in_id completion:^(WebResponse *response, NSError *error) {
//                if (response.success) {
//                    // 收藏成功
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
//                    
//                    AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
//                    
//                    waveView.maxR=30;
//                    waveView.duration=1;
//                    waveView.waveDelta=4;
//                    waveView.waveCount=3;
//                    waveView.maxAlpha=1;
//                    waveView.minAlpha=0;
//                    waveView.waveStyle = Heart;
//                    //    waveView.waveStyle = Heart;
//                    waveView.mainColor = [UIColor colorWithHex:0xcccccc];
//                    //    waveView.boundaryAlpha = 0.8;
//                    [self.uiLikeView addSubview:waveView];
//                    
//                    [_uiLikeImgView setImage:[UIImage imageNamed:@"喜欢"]];
//                    self.info.in_is_collect = [NSString stringWithFormat:@"%d", NotCollect];
//                    dispatch_main_after(1.2, ^{
//                        [SVProgressHUDUtil showSuccessWithStatus:@"取消成功"];
//                        self.uiLikeView.userInteractionEnabled = YES;
//                    });
//                }else{
//                    dispatch_main_after(1.2, ^{
//                        [SVProgressHUDUtil showErrorWithStatus:@"取消失败"];
//                        self.uiLikeView.userInteractionEnabled = YES;
//                    });
//                }
//            }];
//        }else{
//            self.uiLikeView.userInteractionEnabled = NO;
//            [[WebAccessManager sharedInstance]saveCollectInfo:self.info.in_id completion:^(WebResponse *response, NSError *error) {
//                if (response.success) {
//                    // 收藏成功
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
//                    // 未收藏，进行收藏操作
//                    AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
//                    
//                    waveView.maxR=30;
//                    waveView.duration=1;
//                    waveView.waveDelta=4;
//                    waveView.waveCount=3;
//                    waveView.maxAlpha=1;
//                    waveView.minAlpha=0;
//                    waveView.waveStyle = Heart;
//                    //    waveView.waveStyle = Heart;
//                    waveView.mainColor = [UIColor colorWithHex:0x33cfda];
//                    //[UIColor colorWithRed:0 green:0.7 blue:1 alpha:1];
//                    //    waveView.boundaryAlpha = 0.8;
//                    
//                    [self.uiLikeView addSubview:waveView];
//                    [_uiLikeImgView setImage:[UIImage imageNamed:@"已喜欢"]];
//                    self.info.in_is_collect = [NSString stringWithFormat:@"%d", Collect];
//                    
//                    dispatch_main_after(1.2, ^{
//                        [SVProgressHUDUtil showSuccessWithStatus:@"收藏成功"];
//                        self.uiLikeView.userInteractionEnabled = YES;
//                    });
//                }else{
//                    dispatch_main_after(1.2, ^{
//                        [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
//                        self.uiLikeView.userInteractionEnabled = YES;
//                    });
//                }
//            }];
//        }
    }
    else{
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:false isShowAlertYinDao:NO  completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
