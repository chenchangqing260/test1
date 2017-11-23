//
//  IndexViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "IndexViewController.h"
#import "ChannelCollectionViewController.h"
#import "TextUtil.h"
#import "LatestActivityViewController.h"
#import "CollectionDetailWebViewController.h"
#import "SDCursorView.h"
#import "HomeModel.h"
#import "IndexBannerCollectionViewCell.h"
#import "PicAndWenCollectionViewCell.h"
#import "WenCollectionViewCell.h"
#import "PicListCollectionViewCell.h"
#import "VedioCollectionViewCell.h"
#import "ActivityCollectionNewViewCell.h"
#import "ActivityRemIndexCollectionViewCell.h"
#import "ActivityIndexTitleCollectionViewCell.h"
#import "ActivityIndexWebViewController.h"
#import "PromptCollectionViewCell.h"
#import "SpecialIIndexInfoCollectionViewCell.h"
#import "WeChatPublicNumberHeaderCollectionViewCell.h"
#import "MyMoreStationCollectionViewCell.h"
#import "MyEStationCollectionViewCell.h"
#import "QuesMainHeaderCollectionViewCell.h"
#import "QuesMainItemCollectionViewCell.h"
#import "TextUtil.h"
#import "MusicCollectionViewCell.h"
#import "MusicDetialViewController.h"

static NSString* at_name_ch;//首页基站，用于判断返回时重新加载

static BOOL _showingBDIData = NO; //是否正在精准推送

@interface IndexViewController ()<IndexBannerCollectionViewCellCycleDelegate,PromptCollectionViewCellCycleDelegate,MyMoreStationCollectionViewCellDelegate,QuestionMainHeaderCellDelegate>

{
    
    BOOL callDFeedBack;
    NSString *_requestId;//精准推送使用的字段
    
}

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger indexPathRow; //从第几行开始资讯 ，资讯开始时不需要间隔
@property (nonatomic, strong)NSMutableArray* carousel_list; // 轮播图
@property (nonatomic, strong)NSMutableArray* dataList; // 资讯列表
@property (nonatomic, strong)NSMutableArray* activityList; //活动列表

@property (nonatomic, strong)UIImageView *loadImageView;
@property (nonatomic, strong)NSMutableArray* page1DataList; //存放首页第一页资讯
@property (nonatomic, strong)NSMutableArray* page1carouselList; //存放首页第一页轮播图
@property (nonatomic, strong)NSMutableArray* quesRecList; // 轮播图

@property (weak, nonatomic) IBOutlet UIImageView *UIJZImage;
@property (weak, nonatomic) IBOutlet UILabel *UIWXTX;
@property (weak, nonatomic) IBOutlet UIButton *UIGZ;



@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化界面
    [self setupLoadingView];
    
    // 2、初始化数据
    [self initData];
    
    // 3、注册CollectionView
    [self initCollectionView];
    
    // 4、加载数据
    //    [self loadData];
    [self loadNetWorkDataForSetUpView];
    
    //self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

////界面初始化时进入
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([at_name_ch isEqualToString:@"基站"]){
        [self loadData];
    }
    
    if (self.index == 0&&_showingBDIData == YES) {
        _showingBDIData = NO;
        [self loadData];
        
    }
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return YES;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

//初始化数据
-(void)initData{
    self.page = 1;
    self.dataList = [NSMutableArray new];
    self.activityList = [NSMutableArray new];
    self.carousel_list = [NSMutableArray new];
    self.page1DataList = [NSMutableArray new];
    self.page1carouselList = [NSMutableArray new];
    
    
//    _showingBDIData = NO;
    [self.UIJZImage setHidden:YES];
    [self.UIWXTX setHidden:YES];
    [self.UIGZ setHidden:YES];
}

//加载默认图标
-(void)setupLoadingView{
    self.uiCollectionView.hidden=YES;
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    //_loadImageView.hidden = YES;
    [self.view addSubview:_loadImageView];
    [self.view insertSubview:_loadImageView atIndex:0];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
}

#pragma mark - 加载网络数据
-(void)loadData{
    
    NSString *_id = _category.at_id;
    NSString *showSlide = @"0";
    if (self.index == 0) {
        showSlide = @"1";
    }
    
    self.activityList = [NSMutableArray new];
    
    //如果是从百分点数据返回，直接返回第一页，加载已保存的第一页数据
    if(self.index==0&&self.page==1&&self.page1DataList.count!=0){
        [self.dataList removeAllObjects];

        [self.dataList addObjectsFromArray:[self.page1DataList copy]];

        self.carousel_list = [NSMutableArray new];
        [self.carousel_list addObjectsFromArray:[self.page1carouselList copy]];

        if(self.dataList&&self.dataList>0){
            [self.uiCollectionView reloadData];
        }

    }
//    else{
    
        if([_category.at_name_ch isEqualToString:@"微信"]){
            [[WebAccessManager sharedInstance]getWeiChatPublicNOListWithPage:self.page Completion:^(WebResponse *response, NSError *error) {
                //[SVProgressHUDUtil dismiss];
                self.uiCollectionView.hidden=NO;
                self.loadImageView.hidden=YES;
                [self.uiCollectionView.mj_footer endRefreshing];
                [self.uiCollectionView.mj_header endRefreshing];
                if (response.success) {
                    //                    if(self.page == 1){
                    [self initData];
                    [self.dataList removeAllObjects];
                    
                    if(response.data.list&&response.data.list>0){
                        HomeModel* hn=[[HomeModel alloc]init];
                        hn.ni_id = @"0";
                        hn.ni_type = @"wx_head";
                        [self.dataList addObject:hn];
                        
                        [self.dataList addObjectsFromArray:[response.data.list copy]];
                        [self.uiCollectionView reloadData];
                    }
                    //                    }else{
                    //                        if(response.data.list.count>0){
                    //
                    //                            if (response.data.list) {
                    //                                NSMutableArray* nlist = response.data.list;
                    //                                //重置数据
                    //                                [self refreshData:nlist];
                    //                            }
                    //
                    //                            if(self.dataList&&self.dataList>0){
                    //                                [self.uiCollectionView reloadData];
                    //                            }
                    //
                    //                        }else{
                    //                            self.page -= 1;
                    //                        }
                    //                    }
                    
                    
                }else{
                    self.page -= 1;
                    [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                }
                
            }];
        }else  if([_category.at_name_ch isEqualToString:@"基站"]){
            
            [self setEstaionData];
            
            
        }else  if([_category.at_name_ch isEqualToString:@"问答"]){
            
            [self loadQuesListData];
            
            
        }else{
            //根据分类获取资讯
//            long rows=30;
//
//            if(self.index==0&&self.page==1){
//                //头条第一页获取，去除活动的站位，不然第二页后台会重复数据
//                rows=25;
//            }
            
            [[WebAccessManager sharedInstance]getNewInfoListByCategoryId:_id page:_page showSlide:showSlide rows:10 completion:^(WebResponse *response, NSError *error) {
                self.uiCollectionView.hidden=NO;
                self.loadImageView.hidden=YES;
                [self.uiCollectionView.mj_footer endRefreshing];
                [self.uiCollectionView.mj_header endRefreshing];
                
                
                if (response.success) {
//                     [SVProgressHUDUtil dismiss];
                    
                    if(self.page == 1){
                        self.carousel_list = [NSMutableArray new];
                        
                        //头条加载第一页，判断是否已立即加载推荐列表，如果
                        //加载了推荐列表，头条内容加载立即停止
                        if(self.index==0){
                            if(_showingBDIData){
                                return;
                            }
                        }
                        
                        self.carousel_list = response.data.infoRrecList;
                        self.activityList = response.data.activityList;
                        
                        NSMutableArray* nlist = response.data.list;
                        
                        [self.dataList removeAllObjects];
                        //重置数据
                        [self refreshData:nlist];
                        //对第一页轮播图，资讯赋值
                        self.page1carouselList = [NSMutableArray new];
                        self.page1DataList = [NSMutableArray new];
                        [self.page1DataList addObjectsFromArray:[self.dataList copy]];
                        [self.page1carouselList addObjectsFromArray:[self.carousel_list copy]];
                        
                        if(self.dataList&&self.dataList>0){
                            [self.uiCollectionView reloadData];
                        }
                        
                    }else{
                        
                        if(response.data.list.count>0){
                            
                            if (response.data.list) {
                                NSMutableArray* nlist = response.data.list;
                                //重置数据
                                [self refreshData:nlist];
                            }
                            
                            if(self.dataList&&self.dataList>0){
                                [self.uiCollectionView reloadData];
                            }
                            
                        }else{
                            self.page -= 1;
                            [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
                        }
                    }
                    
                }else{
                    self.page -= 1;
                    [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                }
            }];
            
        }
        
        
//    }
    
}

- (void)loadQuesListData{

    [[WebAccessManager sharedInstance]getQuestionBannerWtihCompletion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.quesRecList = [NSMutableArray new];
                self.quesRecList = response.data.recList;
                if(self.quesRecList){
                   [self.uiCollectionView reloadData];
                }

            }
    }];
    
    
    [[WebAccessManager sharedInstance]getQuestionListWtihTypeid:nil page:self.page memberId:nil Completion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_header endRefreshing];
        [self.uiCollectionView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                [self initData];
                [self.dataList removeAllObjects];
                
                self.dataList = response.data.questionsList;
                [self.uiCollectionView reloadData];

            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [self.dataList addObjectsFromArray:[response.data.questionsList copy]];
                    
                    [self.uiCollectionView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                     [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
                }
            }
        }else{
            self.page -= 1;
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

//基站数据
-(void)setEstaionData{
    [[WebAccessManager sharedInstance]getMyAttentionStationListPage:_page Completion:^(WebResponse *response, NSError *error) {
        
        [self.loadImageView setHidden:YES];
        [self.uiCollectionView.mj_header endRefreshing];
        [self.uiCollectionView.mj_footer endRefreshing];
        if (response.success) {
            // 加载成功，根据数量现实相应视图tableView视图
            if (self.page == 1) {
                
                [self initData];
                //                        [self.dataList removeAllObjects];
                
                [self.dataList addObjectsFromArray:[response.data.stationList copy]];
                [self.uiCollectionView reloadData];
                
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [self.dataList addObjectsFromArray:[response.data.stationList copy]];
                    
                    [self.uiCollectionView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                     [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
                }
            }
            
            if (self.dataList&&self.dataList.count > 0) {
                [self.UIJZImage setHidden:YES];
                [self.UIWXTX setHidden:YES];
                [self.UIGZ setHidden:YES];
                self.uiCollectionView.hidden=NO;
            }else{
                [self.UIJZImage setHidden:NO];
                [self.UIWXTX setHidden:NO];
                [self.UIGZ setHidden:NO];
                self.uiCollectionView.hidden=YES;
            }
        }else{
            self.page -= 1;
            // 加载失败，现实关注视图
            [self.UIJZImage setHidden:NO];
            [self.UIWXTX setHidden:NO];
            [self.UIGZ setHidden:NO];
        }
    }];
}

//重置数据  如果有活动，活动插到资讯表中 ，如果没有，直接返回false
- (void)refreshData:(NSMutableArray *)nlist{
    if(nlist&&nlist.count>0){
        //有轮播图，新增一个轮播图站位
        if(self.carousel_list&&self.carousel_list.count>0&&self.page == 1){
            HomeModel* hn=[[HomeModel alloc]init];
            hn.ni_type = @"22";
            [self.dataList addObject:hn];
            //下拉提示站位
            if(self.index == 0){
                hn=[[HomeModel alloc]init];
                hn.ni_type = @"23";
                [self.dataList addObject:hn];
            }
        }
        
        if (self.activityList&&self.activityList.count>0) {
            //默认活动从资讯第五条后开始插入
            NSInteger recBeginNum=5;
            
            //资讯不足五条，活动直接插到最后
            if(nlist.count<recBeginNum){
                recBeginNum=nlist.count;
            }
            //活动插入后，继续写入后面资讯
            
            for(NSInteger i=0; i< recBeginNum; i++){
                //写入资讯
                HomeModel* hm=[nlist objectAtIndex:i];
                [self.dataList addObject:hm];
            }
            
            for(NSInteger i=0; i< self.activityList.count; i++){
                //在0位写入活动前，新增写入活动头标题
                if(i==0){
                    HomeModel* hn=[[HomeModel alloc]init];
                    hn.ni_type = @"11";
                    [self.dataList addObject:hn];
                }
                //新增活动
                HomeModel* hm=[self.activityList objectAtIndex:i];
                [self.dataList addObject:hm];
            }
            
            for(NSInteger i=recBeginNum; i< nlist.count; i++){
                //写入资讯
                HomeModel* hm=[nlist objectAtIndex:i];
                [self.dataList addObject:hm];
            }
        }else{
            [self.dataList addObjectsFromArray:[nlist copy]];
        }
    }
}

//是否进入推送数据
- (void)loadNetWorkDataForSetUpView{
    callDFeedBack = NO;
    _page = 1;
    if (self.index == 0) {
        if (_showingBDIData) {
            [self loadAccuratePushData];
        }else{
            //[self loadCycleSlideData];//获取轮播图数据
            [self loadData];//获取头条数据
        }
        
    }else{
        [self loadData];
    }
}

//获取精准推送数据
-(void)loadAccuratePushData{
    self.dataList = [NSMutableArray new];
    self.activityList = [NSMutableArray new];
    self.carousel_list = [NSMutableArray new];
    _loadImageView.hidden = YES;
    //    self.activityList = [NSMutableArray new];
    self.carousel_list = [NSMutableArray new];
    NSMutableArray* nlist =  [NSMutableArray new];
    [BDIDataStatistics getRecommendDataWithSuccess:^(NSMutableArray *feedback,NSString *requestId) {
        
        //转换成新首页字段
        if(feedback&&feedback.count){
            for(NSInteger i=0; i< feedback.count; i++){
                if(i==0){
                    HomeModel* hn=[[HomeModel alloc]init];
                    hn.ni_id = @"0";
                    hn.ni_type = @"23";
                    [nlist addObject:hn];
                }
                //写入资讯
                HomeModel* hm=[feedback objectAtIndex:i];
                HomeModel* hn=[[HomeModel alloc]init];
                
                hn.ni_id = hm.in_id;
                hn.ni_title = hm.in_title;
                hn.ni_img_url = hm.in_img_url;
                hn.ni_img_url2 = hm.in_img_url2;
                hn.ni_img_url3 = hm.in_img_url2;
                hn.ni_desc = hm.in_desc;
                hn.ni_classify = hm.in_classify;
                hn.ni_video_duration = hm.in_video_duration;
                hn.ni_publish_date_str = hm.in_publish_date_str;
                hn.ni_collectCount = hm.in_collectCount;
                
                NSNumber *longNumber = (NSNumber*)hm.in_reviewCount;
                
                hn.ni_reviewCount = [longNumber stringValue];
                hn.ni_article_type = hm.in_article_type;
                hn.ni_movie_url = hm.in_movie_url;
                hn.ni_pic_amount = hm.in_pic_amount;
                hn.ni_is_station = hm.in_is_station;
                
                if([hm.ni_type isEqualToString:@"1"]&&![hm.ni_type isEmptyOrWhitespace]){
                    hn.ni_type = hm.ni_type;
                    hn.ni_av_type = hm.ni_av_type;
                    hn.ni_av_name = hm.ni_av_name;
                    hn.ni_rele_id = hm.ni_rele_id;
                    hn.ni_bind_id = hm.ni_bind_id;
                    hn.ni_type = @"1";
                    [self.activityList addObject:hn];
                }else{
                    hn.ni_type = @"0";
                    [nlist addObject:hn];
                }
                
                
            }
            //重置数据
            [self refreshData:nlist];
            
            
        }
        
        _requestId = requestId;
        [self BDIShowAccuratePushDataWithequestId:requestId];
        dispatch_async(dispatch_get_main_queue(), ^{
            callDFeedBack = YES;
            _loadImageView.hidden = YES;
            self.uiCollectionView.hidden=NO;
            [self.uiCollectionView.mj_footer endRefreshing];
            [self.uiCollectionView.mj_header endRefreshing];
            if(self.dataList&&self.dataList>0){
                [self.uiCollectionView reloadData];
            }
        });
    } error:^(NSString *errorMessage) {
        _loadImageView.hidden = YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
    }];
}

#pragma mark 精准推送数据统计
-(void)BDIDataStatisticsWithModel:(HomeModel *)model{
    //浏览文章时进行数据统计
    [BDIDataStatistics onVisitWithModel:model];
    if (callDFeedBack) {
        //浏览推荐文章是调用
        [BDIDataStatistics tapRecommendArticleWithModel:model requestId:_requestId];
    }else{
        [BDIDataStatistics additemWithModelNew:model];
    }
}
-(void)BDIShowAccuratePushDataWithequestId:(NSString *)requestId{
    if (_dataList.count > 0) {
        //展示精准推送时调用的BDI接口
        NSMutableArray *idds = [[NSMutableArray alloc] initWithCapacity:0];
        for (HomeModel *model in _dataList) {
            if(![model.ni_id isEqualToString:@"0"]&&![model.ni_type isEqualToString:@"11"]){
                [idds addObject:model.ni_id];
            }
        }
        [BDIDataStatistics DFeedBackWithIdArry:idds requestId:requestId];
    }
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[IndexBannerCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[IndexBannerCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicAndWenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicAndWenCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[WenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[WenCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicListCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicListCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[VedioCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[VedioCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityCollectionNewViewCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityCollectionNewViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityRemIndexCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityRemIndexCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityIndexTitleCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityIndexTitleCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PromptCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PromptCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialIIndexInfoCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialIIndexInfoCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[WeChatPublicNumberHeaderCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[WeChatPublicNumberHeaderCollectionViewCell ID]];
    
    
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[MyMoreStationCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[MyMoreStationCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[MyEStationCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[MyEStationCollectionViewCell ID]];
    
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[QuesMainHeaderCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[QuesMainHeaderCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[QuesMainItemCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[QuesMainItemCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[MusicCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[MusicCollectionViewCell ID]];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([_category.at_name_ch isEqualToString:@"基站"]&&self.dataList.count>0){
        return self.dataList.count+1;
    }if([_category.at_name_ch isEqualToString:@"问答"]&&self.dataList.count>0){
        return self.dataList.count+1;
    }else{
        return self.dataList.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.indexPathRow=0;
    // 1、第一个为轮播图
    if (![_category.at_name_ch isEqualToString:@"基站"]&&[indexPath row] == 0&&self.carousel_list&&self.carousel_list.count>0) {
        
        IndexBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[IndexBannerCollectionViewCell ID] forIndexPath:indexPath];
        cell.delegate = self;
        
        if (self.carousel_list) {
            cell.cycleSAList = self.carousel_list;
        }
        
        [cell setCellData];
        
        return cell;
    }
    
    
    //前一条数据 用于判断是否显示信息之间的间隔
    if(![_category.at_name_ch isEqualToString:@"基站"]&&![_category.at_name_ch isEqualToString:@"问答"]){
        //当前数据
        HomeModel* h=[self.dataList objectAtIndex:indexPath.row];
        
        if([h.ni_type isEqualToString:@"23"]){
            PromptCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                             [PromptCollectionViewCell ID] forIndexPath:indexPath];
            
            cell.delegate = self;
            [cell setCellWithSciencePrompt:_showingBDIData];
            
            return cell;
            
        }
        
        
        //从第几位开始资讯，资讯开始时不需要间隔  首页第1或2位，其他第0位
        if(self.index==0){
            if (self.carousel_list&&self.carousel_list.count>0) {
                self.indexPathRow=2;
            }else{
                self.indexPathRow=1;
            }
        }
        
        HomeModel* hn=[[HomeModel alloc]init];
        if(indexPath.row!=0){
            hn=[self.dataList objectAtIndex:indexPath.row-1];
        }
        
        if([_category.at_name_ch isEqualToString:@"微信"]){
            //微信列表
            if([h.ni_type isEqualToString:@"wx_head"]){
                WeChatPublicNumberHeaderCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier: [WeChatPublicNumberHeaderCollectionViewCell ID] forIndexPath:indexPath];
                
                return cell;
                
            }
            
            if([h.in_classify isEqualToString:@"0"]){
                //图片资讯
                PicAndWenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                    [PicAndWenCollectionViewCell ID] forIndexPath:indexPath];
                
                [cell setCellWithScienceActivity:h showSpace:NO  zhuanti:NO
                                          hmType:@"1"];
                
                return cell;
                
            }else  if([h.in_classify isEqualToString:@"1"]){
                //图集资讯
                PicListCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                  [PicListCollectionViewCell ID] forIndexPath:indexPath];
                [cell setCellWithScienceActivity:h showSpace:NO hmType:@"1"];
                return cell;
            }else  if([h.in_classify isEqualToString:@"2"]){
                //视频资讯
                VedioCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                [VedioCollectionViewCell ID] forIndexPath:indexPath];
                
                [cell setCellWithScienceActivity:h showSpace:NO hmType:@"1"];
                return cell;
            }else  if([h.in_classify isEqualToString:@"3"]){
                
                if([h.ni_show_mode isEqualToString:@"01"]){
                    PicAndWenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                        [PicAndWenCollectionViewCell ID] forIndexPath:indexPath];
                    
                    if(indexPath.row ==self.indexPathRow|| [hn.ni_type isEqualToString:@"0"]){
                        [cell setCellWithScienceActivity:h showSpace:NO  zhuanti:YES hmType:0];
                    }else{
                        [cell setCellWithScienceActivity:h showSpace:YES  zhuanti:YES hmType:0];
                    }
                    
                    return cell;
                }else{
                    //专题资讯
                    SpecialIIndexInfoCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                                [SpecialIIndexInfoCollectionViewCell ID] forIndexPath:indexPath];
                    
                    if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                        [cell setCellWithScienceSpecial:h showSpace:NO];
                    }else{
                        [cell setCellWithScienceSpecial:h showSpace:YES];
                    }
                    return cell;
                }
                
            }else{
                //文字资讯
                WenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                              [WenCollectionViewCell ID] forIndexPath:indexPath];
                [cell setCellWithScienceActivity:h showSpace:NO hmType:@"1"];
                return cell;
            }
        }else{
            
            if([_category.at_name_ch isEqualToString:@"音频"]){
                
                MusicCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                  [MusicCollectionViewCell ID] forIndexPath:indexPath];
                if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                    [cell setCellWithHomeModel:h showSpace:NO];
                }else{
                    [cell setCellWithHomeModel:h showSpace:YES];
                }
                return cell;
                
            }else{
                
                //资讯列表
                if([h.ni_type isEqualToString:@"0"]){
                    
                    if([h.ni_classify isEqualToString:@"0"]){
                        //图片资讯
                        //                if(h.ni_img_url && ![h.ni_img_url isEmptyOrWhitespace]){
                        PicAndWenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                            [PicAndWenCollectionViewCell ID] forIndexPath:indexPath];
                        
                        if(indexPath.row ==self.indexPathRow|| [hn.ni_type isEqualToString:@"0"]){
                            [cell setCellWithScienceActivity:h showSpace:NO  zhuanti:NO
                                                      hmType:@"0"];
                        }else{
                            [cell setCellWithScienceActivity:h showSpace:YES  zhuanti:NO hmType:@"0"];
                        }
                        
                        return cell;
                        
                        //                }
                    }else  if([h.ni_classify isEqualToString:@"1"]){
                        //图集资讯
                        PicListCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                          [PicListCollectionViewCell ID] forIndexPath:indexPath];
                        if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                            [cell setCellWithScienceActivity:h showSpace:NO hmType:@"0"];
                        }else{
                            [cell setCellWithScienceActivity:h showSpace:YES hmType:@"0"];
                        }
                        return cell;
                    }else  if([h.ni_classify isEqualToString:@"2"]){
                        //视频资讯
                        VedioCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                        [VedioCollectionViewCell ID] forIndexPath:indexPath];
                        
                        if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                            [cell setCellWithScienceActivity:h showSpace:NO hmType:@"0"];
                        }else{
                            [cell setCellWithScienceActivity:h showSpace:YES hmType:@"0"];
                        }
                        return cell;
                    }else  if([h.ni_classify isEqualToString:@"3"]){
                        
                        //专题资讯
                        SpecialIIndexInfoCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                                    [SpecialIIndexInfoCollectionViewCell ID] forIndexPath:indexPath];
                        
                        if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                            [cell setCellWithScienceSpecial:h showSpace:NO];
                        }else{
                            [cell setCellWithScienceSpecial:h showSpace:YES];
                        }
                        return cell;
                        
                    }else{
                        //文字资讯
                        WenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                      [WenCollectionViewCell ID] forIndexPath:indexPath];
                        if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                            [cell setCellWithScienceActivity:h showSpace:NO hmType:@"0"];
                        }else{
                            [cell setCellWithScienceActivity:h showSpace:YES hmType:@"0"];
                        }
                        return cell;
                    }
                }else{
                    //活动
                    if([h.ni_type isEqualToString:@"11"]){
                        //活动头标题
                        ActivityRemIndexCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                                   [ActivityRemIndexCollectionViewCell ID] forIndexPath:indexPath];
                        
                        return cell;
                    }else{
                        if(h.ni_img_url&&![h.ni_img_url isEmptyOrWhitespace]){
                            //有图片的活动
                            ActivityCollectionNewViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:
                                                                    [ActivityCollectionNewViewCell ID] forIndexPath:indexPath];
                            [cell setCellWithScienceActivity:h indexPath:indexPath showSpace:NO];
                            return cell;
                        }else{
                            //没有图片的活动
                            ActivityIndexTitleCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                                         [ActivityIndexTitleCollectionViewCell ID] forIndexPath:indexPath];
                            [cell setCellWithScienceActivity:h indexPath:indexPath showSpace:NO];
                            return cell;
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
    }else{
        //基站列表
        if([_category.at_name_ch isEqualToString:@"基站"]){
            if (indexPath.row == 0) {
                MyMoreStationCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier: [MyMoreStationCollectionViewCell ID] forIndexPath:indexPath];
                cell.delegate = self;
                return cell;
            }else{
                EStation* h=[self.dataList objectAtIndex:indexPath.row - 1];
                MyEStationCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                     [MyEStationCollectionViewCell ID] forIndexPath:indexPath];
                [cell initCellData:h];
                return cell;
            }
            
        }else{
            //问答列表
            if (indexPath.row == 0) {
                QuesMainHeaderCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier: [QuesMainHeaderCollectionViewCell ID] forIndexPath:indexPath];
                cell.delegate = self;
                cell.quesRecList = self.quesRecList;
                return cell;
            }else{
                Question* question =[self.dataList objectAtIndex:indexPath.row - 1];
                QuesMainItemCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                       [QuesMainItemCollectionViewCell ID] forIndexPath:indexPath];
                [cell initCellDataWithQuestion:question];
                return cell;
            }
            
        }
        
        
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(![_category.at_name_ch isEqualToString:@"基站"]&&![_category.at_name_ch isEqualToString:@"问答"]){
        HomeModel* sa = [self.dataList objectAtIndex:indexPath.row];
        [self forwardToDetailViewWithActivity:sa];
        
        at_name_ch = @"";
    }else  if([_category.at_name_ch isEqualToString:@"问答"]){
        Question* question =[self.dataList objectAtIndex:indexPath.row - 1];
        [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
    }else{
        at_name_ch = @"基站";
        if (indexPath.row != 0) {
            EStation* station = [self.dataList objectAtIndex:(indexPath.row - 1)];
            [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
        }
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPathRow=0;
    if ([indexPath row] == 0&&self.carousel_list&&self.carousel_list.count>0) {
        if (self.carousel_list && self.carousel_list.count > 0) {
            self.indexPathRow=1;
            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 180 / kWIDTH_375 );
        }else{
            return CGSizeMake(kSCREEN_WIDTH, 0);
        }
    }
    
    if(![_category.at_name_ch isEqualToString:@"基站"]&&![_category.at_name_ch isEqualToString:@"问答"]){
        HomeModel* h=[self.dataList objectAtIndex:indexPath.row];
        if([h.ni_type isEqualToString:@"23"]){
            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 25 / kWIDTH_375 );
            
        }
        
        if(self.index==0){
            if (self.carousel_list&&self.carousel_list.count>0) {
                self.indexPathRow=2;
            }else{
                self.indexPathRow=1;
            }
        }
        
        HomeModel* hn=[[HomeModel alloc]init];
        if(indexPath.row!=0){
            hn=[self.dataList objectAtIndex:indexPath.row-1];
        }
        
        if([_category.at_name_ch isEqualToString:@"微信"]){
            //微信
            if([h.ni_type isEqualToString:@"wx_head"]){
                return CGSizeMake(kSCREEN_WIDTH, 120);
            }
            
            if([h.in_classify isEqualToString:@"0"]){
//                CGFloat textHeight = [TextUtil boundingRectWithText:h.in_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:FONT_18].height;
//
//                if(textHeight<50){
//                    return CGSizeMake(kSCREEN_WIDTH, 134-11 );
//                }else{
//                    return CGSizeMake(kSCREEN_WIDTH, 134);
//                }
                return CGSizeMake(kSCREEN_WIDTH, 134);
            }else if([h.in_classify isEqualToString:@"1"]){
                CGFloat textHeight = [TextUtil boundingRectWithText:h.in_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                if(textHeight<30){
                    return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (182-22) / kWIDTH_375 );
                }else{
                    return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 182 / kWIDTH_375 );
                }
            }else if([h.in_classify isEqualToString:@"2"]){
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 277 / kWIDTH_375 );
            }else if([h.in_classify isEqualToString:@"3"]){
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 94 / kWIDTH_375 );
            }else{
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 127 / kWIDTH_375 );
            }
        }else{
            
            if([_category.at_name_ch isEqualToString:@"音频"]){
                
                 if(indexPath.row ==self.indexPathRow||[hn.ni_type isEqualToString:@"0"]){
                     
                     return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 130 / kWIDTH_375 );

                 }else{
                     
                     return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 140 / kWIDTH_375 );

                 }
                
            }else{
                
                if([h.ni_type isEqualToString:@"0"]){
                    if(![hn.ni_type isEqualToString:@"0"]&&indexPath.row !=self.indexPathRow){
                        
                        if([h.ni_classify isEqualToString:@"0"]){
                            //                        CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:FONT_18].height;
                            //
                            //                        if(textHeight<50){
                            //                            return CGSizeMake(kSCREEN_WIDTH, 144-11 );
                            //                        }else{
                            //                            return CGSizeMake(kSCREEN_WIDTH, 144);
                            //                        }
                            
                            return CGSizeMake(kSCREEN_WIDTH, 144);
                        }else if([h.ni_classify isEqualToString:@"1"]){
                            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                            if(textHeight<30){
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (200-22) / kWIDTH_375 );
                            }else{
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 200 / kWIDTH_375 );
                            }
                        }else if([h.ni_classify isEqualToString:@"2"]){
                            
                            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                            if(textHeight<40){
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (295-23) / kWIDTH_375 );
                            }else{
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 295 / kWIDTH_375 );
                            }
                        }else if([h.ni_classify isEqualToString:@"3"]){
                            //                        if([h.ni_show_mode isEqualToString:@"01"]){
                            //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 104 / kWIDTH_375 );
                            //                        }else{
                            //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 280 / kWIDTH_375 );
                            //                        }
                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 280 / kWIDTH_375 );
                        }else{
                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 137 / kWIDTH_375 );
                        }
                    }else{
                        if([h.ni_classify isEqualToString:@"0"]){
                            //                         CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:FONT_18].height;
                            //
                            //                        if(textHeight<50){
                            //                            return CGSizeMake(kSCREEN_WIDTH, 134-11 );
                            //                        }else{
                            //                            return CGSizeMake(kSCREEN_WIDTH, 134);
                            //                        }
                            return CGSizeMake(kSCREEN_WIDTH, 134);
                        }else if([h.ni_classify isEqualToString:@"1"]){
                            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                            if(textHeight<30){
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (190-23) / kWIDTH_375 );
                            }else{
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 190 / kWIDTH_375 );
                            }
                        }else if([h.ni_classify isEqualToString:@"2"]){
                            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                            if(textHeight<40){
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (285-21) / kWIDTH_375 );
                            }else{
                                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 285 / kWIDTH_375 );
                            }
                        }else if([h.ni_classify isEqualToString:@"3"]){
                            //                        if([h.ni_show_mode isEqualToString:@"01"]){
                            //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 94 / kWIDTH_375 );
                            //                        }else{
                            //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 270 / kWIDTH_375 );
                            //                        }
                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 270 / kWIDTH_375 );
                        }else{
                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 127 / kWIDTH_375 );
                        }
                    }
                    
                }else{
                    if([h.ni_type isEqualToString:@"11"]){
                        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 54 / kWIDTH_375 );
                    }else{
                        if(h.ni_img_url&&![h.ni_img_url isEmptyOrWhitespace]){
                            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                            if(textHeight<40){
                                return CGSizeMake(kSCREEN_WIDTH, 258-22 );
                            }else{
                                return CGSizeMake(kSCREEN_WIDTH, 258 );
                            }
                        }else{
                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 131 / kWIDTH_375 );
                        }
                        
                    }
                }
            }
                
        }
        
    }else{
         if([_category.at_name_ch isEqualToString:@"基站"]){
             if(indexPath.row == 0){
                 return CGSizeMake(kSCREEN_WIDTH, 60 );
             }else{
                 return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 90 / kWIDTH_375 );
             }
         }else{
             //问答列表
             if (indexPath.row == 0) {
                 if (self.quesRecList && self.quesRecList.count > 0) {
                     CGFloat showWidth = kSCREEN_WIDTH;
                     if (isIpad) {
                         showWidth = MAIN_SCREEN_WIDTH_ONIpad;
                     }
                      return CGSizeMake(kSCREEN_WIDTH, 175 * showWidth / kWIDTH_375 + 100);
                 }else{
                      return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 100 / kWIDTH_375 );
                 }
             }else{
                 CGFloat showWidth = kSCREEN_WIDTH;
                 if (isIpad) {
                     showWidth = MAIN_SCREEN_WIDTH_ONIpad;
                 }
                 
                  Question* question =[self.dataList objectAtIndex:indexPath.row - 1];
                 
                 CGFloat height = 13;
                 height += 36;
                 height += 15;
                 height += 20;
                 height += 13;
                 
                 CGFloat contentHeight = 0;
                 
                 NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                 NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
                 if (!fontSize) {
                     fontSize = @"Normal";
                     [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
                     [settings synchronize];
                 }
                 if ([fontSize isEqualToString:@"Small"]) {
                     contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_13].height;
                 }else if([fontSize isEqualToString:@"Large"]) {
                     contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_18].height;
                 }else{
                     contentHeight = [TextUtil boundingRectWithText:question.qu_content lineSpace:3 size:CGSizeMake(showWidth - 40, 0) Font:FONT_14].height;
                 }
                 
                 // 计算提问内容
                 
                 height += contentHeight;
                 
                 if (question.qu_img && ![question.qu_img isEmptyOrWhitespace]) {
                     height += 10;
                     height += showWidth * 208 / kWIDTH_375;
                 }
                 
                 height += 10;
                 height += 45;
                 height += 10;
                 
                return CGSizeMake(kSCREEN_WIDTH, height );
             }
         }

    }
}

//获取文字高度
-(CGFloat)getTitleHeight:(NSString*)str w:(CGFloat)w h:(CGFloat)h{
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    return strSize.height;
}

- (void)collectionViewRefreshHeaderData{
    _page = 1;
    if (self.index == 0) {
        _showingBDIData = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetHomeTitleView" object:nil userInfo:@{@"showBDIData":@"1"}];
        
        if (_showingBDIData) {
            [self loadAccuratePushData];
        }else{
            //[self loadCycleSlideData];//获取轮播图数据
            [self loadData];//获取头条数据
            
        }
    }else{
        [self loadData];
    }

    
//    if (!_showingBDIData) {
//        _page = 1;
//        if (self.index == 0) {
//            _showingBDIData = YES;
//            //             [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetHomeTitleView" object:nil userInfo:@{@"showBDIData":@"1"}];
//            self.page = 1;
//            // 2、初始化数据
//            
//            
//            
//        }else{
//            [self loadData];
//        }
//    }else{
//        [self.uiCollectionView.mj_header endRefreshing];
//    }
}


- (void)collectionViewRefreshFooterData{
    _page += 1;
    if (self.index == 0) {
        if (_showingBDIData) {
            _page -= 1;
            //精准推送，不做任何操作
            [self.uiCollectionView.mj_footer endRefreshing];
            [self.uiCollectionView.mj_header endRefreshing];
            
        }else{
            //头条
            [self loadData];
            
        }
    }else{
        [self loadData];
    }
}

- (void)forwardToDetailViewWithActivity:(HomeModel*)sa{
    
    if(![_category.at_name_ch isEqualToString:@"微信"]){
        
        if([_category.at_name_ch isEqualToString:@"音频"]){
            
//            MusicDetialViewController *audio = [MusicDetialViewController audioPlayerController];
//            [audio initWithArray:nil index:1];
            
            [FlowUtil startToMusicInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
            
        }else{
            if([sa.ni_type isEqualToString:@"0"]){
                
                // 资讯
                if ([sa.ni_classify isEqualToString:@"0"] || [sa.ni_classify isEqualToString:@"4"]) {
                    // 图文、文字
                    [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
                    
                    //            [FlowUtil startToSpecialInfoDetailVCNav:self.navigationController homeModel:sa  completion:nil];
                }else if([sa.ni_classify isEqualToString:@"1"]){
                    // 图集
                    [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
                }else if([sa.ni_classify isEqualToString:@"2"]){
                    // 视频
                    [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
                }else if([sa.ni_classify isEqualToString:@"3"]){
                    // 专题
                    //            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:sa.ni_rele_id];
                    [FlowUtil startToSpecialDetailNewVCNav:self.navigationController homeModel:sa  completion:nil];
                }
                
                //浏览文章时进行数据统计
                [self BDIDataStatisticsWithModel:sa];
                
            }else{
                
                if ([sa.ni_av_type isEqualToString:@"01"] || [sa.ni_av_type isEqualToString:@"02"]||[sa.ni_av_type isEqualToString:@"03"]) {
                    if (![[MemberManager sharedInstance] isLogined]) {
                        // 跳转登录界面
                        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:NO  completion:nil];
                    }else{
                        [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.ni_id completion:^(WebResponse *response, NSError *error) {
                            if (response.success) {
                                CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                                ShareModel* shareModel = nil;
                                if (response.data.share_info) {
                                    shareModel = [ShareModel new];
                                    shareModel.in_share_contentURL = response.data.share_info.share_url;
                                    shareModel.in_share_desc = response.data.share_info.share_desc;
                                    shareModel.in_share_title = response.data.share_info.share_title;
                                    shareModel.in_share_imageURL = response.data.share_info.share_image_url;
                                }
                                
                                webVC.edit_url = response.data.edit_url;
                                webVC.titleStr = sa.ni_title;
                                webVC.shareModel = shareModel;
                                [self.navigationController pushViewController:webVC animated:YES];
                                [webVC loadWebWithUrl:response.data.av_url];
                            }else{
                                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                            }
                        }];
                    }
                }else if([sa.ni_av_type isEqualToString:@"04"]){
                    [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.ni_id completion:^(WebResponse *response, NSError *error) {
                        if (response.success) {
                            CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                            ShareModel* shareModel = nil;
                            if (response.data.share_info) {
                                shareModel = [ShareModel new];
                                shareModel.in_share_contentURL = response.data.share_info.share_url;
                                shareModel.in_share_desc = response.data.share_info.share_desc;
                                shareModel.in_share_title = response.data.share_info.share_title;
                                shareModel.in_share_imageURL = response.data.share_info.share_image_url;
                            }
                            
                            webVC.edit_url = response.data.edit_url;
                            webVC.titleStr = sa.ni_title;
                            webVC.shareModel = shareModel;
                            [self.navigationController pushViewController:webVC animated:YES];
                            [webVC loadWebWithUrl:response.data.av_url];
                        }else{
                            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                        }
                    }];
                }else if([sa.ni_av_type isEqualToString:@"05"]){
                    [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.ni_id completion:^(WebResponse *response, NSError *error) {
                    }];
                    // 资讯
                    if ([sa.ni_classify isEqualToString:@"0"] || [sa.ni_classify isEqualToString:@"4"]) {
                        // 图文、文字
                        [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:sa.ni_rele_id completion:nil];
                    }else if([sa.ni_classify isEqualToString:@"1"]){
                        // 图集
                        [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:sa.ni_rele_id completion:nil];
                    }else if([sa.ni_classify isEqualToString:@"2"]){
                        // 视频
                        [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:sa.ni_rele_id completion:nil];
                    }else if([sa.ni_classify isEqualToString:@"3"]){
                        // 专题
                        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:sa.ni_rele_id];
                    }
                }else if([sa.ni_av_type isEqualToString:@"06"]){
                    
                    [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.ni_id completion:^(WebResponse *response, NSError *error) {
                        if (response.success) {
                            ScienceActivity* as = [[ScienceActivity alloc]init];
                            as.av_id = sa.ni_id;
                            as.av_type = sa.ni_av_type;
                            as.title = sa.ni_title;
                            as.image_name = sa.ni_img_url;
                            as.av_type_name =sa.ni_av_name;
                            as.rele_id = sa.ni_rele_id;
                            as.article_classify = sa.ni_classify;
                            as.participators = sa.ni_participators;
                            as.shelve_at = sa.ni_publish_date_str;
                            // 跳转专题详情列表
                            [FlowUtil startToFourActivitySpecialDetailListVCNav:self.navigationController WithSpsa:as];
                            
                        }
                    }];
                }else{
                    [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.ni_id completion:^(WebResponse *response, NSError *error) {
                        if (response.success) {
                            CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                            ShareModel* shareModel = nil;
                            if (response.data.share_info) {
                                shareModel = [ShareModel new];
                                shareModel.in_share_contentURL = response.data.share_info.share_url;
                                shareModel.in_share_desc = response.data.share_info.share_desc;
                                shareModel.in_share_title = response.data.share_info.share_title;
                                shareModel.in_share_imageURL = response.data.share_info.share_image_url;
                            }
                            
                            webVC.edit_url = response.data.edit_url;
                            webVC.titleStr = sa.ni_title;
                            webVC.shareModel = shareModel;
                            [self.navigationController pushViewController:webVC animated:YES];
                            [webVC loadWebWithUrl:response.data.av_url];
                        }else{
                            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                        }
                    }];
                }
                
            }
        }
        
    }else{
            if(![sa.ni_type isEqualToString:@"wx_head"]){
                //微信
                NSString *url = sa.in_id;//[NSString stringWithFormat:@"http://news.wewen.io/articles/%@",model.in_id];
                CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC loadWebWithUrl:url];
            }

    }
}

#pragma mark - ActivityBannerCellCycleDelegate
- (void)clickCycleWithImageURL:(HomeModel*)sa{
    [self forwardToDetailViewWithActivity:sa];
}


- (void)backToHomePage{
    if (_showingBDIData) {
//        [SVProgressHUDUtil showWithStatus:@"正在加载数据..."];
        _showingBDIData = NO;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetHomeTitleView" object:nil userInfo:@{@"showBDIData":@"0"}];
        [self loadNetWorkDataForSetUpView];
    }
}


#pragma mark - 按钮和手势点击事件
- (IBAction)clickAddEStationBtn:(id)sender {
    at_name_ch = @"基站";
    [FlowUtil startToEStationListVCNav:self.navigationController];
}

#pragma mark - MyMoreStation Delegate
-(void)clickMoreStation{
    at_name_ch = @"基站";
    // 跳转更多分类
    //[FlowUtil startToEStationCategoryVCNav:self.navigationController];
    [FlowUtil startToEStationListVCNav:self.navigationController];
}

#pragma mark - QuestionMainHeaderDelegate
- (void)clickAskQuesBtnAction {
    // 跳转提问界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false  isShowAlertYinDao:NO completion:nil];
    }else{
        [FlowUtil startToAskQuestionVCNav:self.navigationController];
    }
}

- (void)clickMyQuesBtnAction {
    // 跳转我的问题界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false isShowAlertYinDao:NO  completion:nil];
    }else{
        // 跳转我的提问界面
        [FlowUtil startToMyQuestionVCNav:self.navigationController];
    }
}

- (void)clickMyAnswerBtnAction {
    // 跳转我的回答界面
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false isShowAlertYinDao:NO  completion:nil];
    }else{
        // 跳转我的回答界面
        [FlowUtil startToMyAnswerVCNav:self.navigationController];
    }
}

- (void)clickQuestionBainnerAction:(RecList*)ques{
    // 跳转提问详情
    Question* question = [Question new];
    question.qu_id = ques.qu_id;
    question.qu_title = ques.qu_title;
    [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
}

@end
