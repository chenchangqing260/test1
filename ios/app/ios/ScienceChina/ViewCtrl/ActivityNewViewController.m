//
//  ActivityNewViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityNewViewController.h"
#import "ChannelCollectionViewController.h"
#import "SDCycleScrollView.h"
#import "ActivityBannerCollectionCell.h"
#import "ActivityNormalCollectionCell.h"
#import "ActivityRemTitleCollectionViewCell.h"
#import "ActivityTextCollectionCell.h"
#import "ScienceActivity.h"
#import "TextUtil.h"
#import "LatestActivityViewController.h"
#import "CollectionDetailWebViewController.h"
#import "MyActivityListViewController.h"

#import "ActivityMenuTableViewCell.h"
#import "ActivityRemTableViewCell.h"
#import "ActivityNormalInfoTableViewCell.h"
#import "CoreStatus.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

const CGFloat kNavigationBarHeight = 44;
const CGFloat kStatusBarHeight = 20;
@interface ActivityNewViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ActivityMenuTableViewCellCycleDelegate>
{
    UIScrollView * _mainScrollView;
//    UITableView * _tableView;
    
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIView * headView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)NSMutableArray* carousel_list; // 轮播图
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)UIImageView *loadImageView;
@property (nonatomic, strong)UIImageView *loadNoNetworkImageView;

@property (nonatomic, strong)UILabel *loadLabel;
@property (nonatomic, strong)NSMutableArray* dataList; // 活动列表
@property (nonatomic, strong)NSMutableArray* rlist;
@property (nonatomic, strong)UIButton *rightNavBtn1;
@property (nonatomic, assign)BOOL isload;

@end

@implementation ActivityNewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"活 动";
    
    if([CoreStatus isNetworkEnable]){
        [self setupLoadingView];
        
        [self initData];
        
        [self loadeData];
        
        [self loadSetupView];
    }else{
        [self setupLoadingNoNetworkView];
    }
    
    [self registerNotice];
}

#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:kNOTOICE_REFRESHINDEXVIEW_INFO object:nil];
}

-(void)refreshData{
    self.title = @"";
    
    [self setupLoadingView];
    
    [self initData];
    
    [self loadSetupView];
    
    [self loadeData];
}

-(void)initData{
    self.page = 1;
    self.dataList = [NSMutableArray new];
    self.rlist = [NSMutableArray new];
    self.carousel_list  = [NSMutableArray new];
    self.isload = true;
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return YES;
}

-(void)loadSetupView{
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //给导航栏添加背景view
    CGRect backView_frame = CGRectMake(0, -kStatusBarHeight, kScreenWith, kNavigationBarHeight+kStatusBarHeight);
    UIView *backView = [[UIView alloc] initWithFrame:backView_frame];
    UIColor *backColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
    //给当前颜色加上透明度
    backView.backgroundColor = [backColor colorWithAlphaComponent:0.0f];
    [self.navigationController.navigationBar addSubview:backView];
    self.backView = backView;
    self.backColor = backColor;
    
    
//    UIButton *leftNavBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftNavBtn1.frame = CGRectMake(0, 30, 60, 25);
//    [leftNavBtn1 setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
//    [leftNavBtn1 setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateHighlighted];
//    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
//        [leftNavBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, 15)];
//    }else{
//        [leftNavBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0,-9, 0, 15)];
//    }
//
//    [leftNavBtn1 addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.backView addSubview:leftNavBtn1];
    
    UIButton *creBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    creBtn1.frame = CGRectMake(kScreenWith/2-30, 30, 60, 25);
    [creBtn1 setTitle:@"活 动" forState:UIControlStateNormal];
    [creBtn1.titleLabel setFont:FONT_18];
    [creBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [creBtn1   setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 15 ]];
//    [creBtn1 addTarget:self action:@selector(creBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:creBtn1];
    
    
    _rightNavBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightNavBtn1.frame = CGRectMake(kScreenWith-90, 30, 70, 20);
    [_rightNavBtn1 setTitle:@"我的活动" forState:UIControlStateNormal];
    [_rightNavBtn1.titleLabel setFont:FONT_14];
    [_rightNavBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_rightNavBtn1.layer setMasksToBounds:YES];
    [_rightNavBtn1.layer setCornerRadius:3.0];
    [_rightNavBtn1.layer setBorderWidth:1.0];
    [_rightNavBtn1.layer  setBorderColor: RGBCOLOR(255.0, 255.0, 255.0).CGColor];
    _rightNavBtn1.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
    _rightNavBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [_rightNavBtn1  setBackgroundColor:[UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:0.42]];
    
    [_rightNavBtn1 addTarget:self action:@selector(rightNavBtn   ) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_rightNavBtn1];
         self.backView.backgroundColor = [UIColor clearColor];
    
    UIButton *creBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    creBtn2.frame = CGRectMake(kScreenWith-130, 0, 170, 90);
    [creBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [creBtn2 addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
//    [creBtn2  setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1]];
    [self.backView addSubview:creBtn2];
    
    //标题
    //    self.navigationItem.title = @"活动";
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //
    //    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftNavBtn.frame = CGRectMake(0, 0, 60, 25);
    //    [leftNavBtn setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    //    [leftNavBtn setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateHighlighted];
    //    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    //    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    //    self.navigationItem.leftBarButtonItem = leftItem;
    
    //    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    rightNavBtn.frame = CGRectMake(0, 0, 60, 25);
    //    [rightNavBtn setTitle:@"我的活动" forState:UIControlStateNormal];
    //    [rightNavBtn.titleLabel setFont:FONT_14];
    //    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    //
    //    [rightNavBtn.layer setMasksToBounds:YES];
    //    [rightNavBtn.layer setCornerRadius:2.0];
    //    [rightNavBtn.layer setBorderWidth:1.0];
    //    [rightNavBtn.layer  setBorderColor: RGBCOLOR(255.0, 255.0, 255.0).CGColor];
    //    rightNavBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
    //    rightNavBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //
    //    [rightNavBtn addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    //    self.navigationItem.rightBarButtonItem = rightItem;
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    CGRect bounds = CGRectMake( 0 , 0 , kScreenWith, 200) ;
    UIView * contentView = [[UIView alloc]initWithFrame:bounds];
    contentView.backgroundColor = [UIColor grayColor];
    
    //    UIImageView * imageView = [[UIImageView alloc]initWithFrame:bounds];
    //    imageView.center = contentView.center;
    //    imageView.image = [UIImage imageNamed:@"beijing.jpg"];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:bounds delegate:self placeholderImage:[UIImage imageNamed:@"close"]];
//    _cycleScrollView.showPageControl = NO;
    _cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:14.0];
    _cycleScrollView.titleLabelHeight = 30.0;
    _cycleScrollView.titleLabelBackgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRightTop;
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageCurrentDot"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageDot"];
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"资讯默认图"];
    _cycleScrollView.autoScrollTimeInterval = 5;
    
    //创建下方页数标签
//    [_cycleScrollView createIndexLabel];
    
    self.headView = contentView;
    //    self.headerImageView = _cycleScrollView;
    [self.headView addSubview:_cycleScrollView];
    
    //    UIButton *leftNavBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftNavBtn2.frame = CGRectMake(12, 30, 60, 25);
    //    [leftNavBtn2 setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    //    [leftNavBtn2 setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateHighlighted];
    //    [leftNavBtn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 15)];
    //    [leftNavBtn2 addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [_cycleScrollView addSubview:leftNavBtn2];
    //
    //    UIButton *creBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    creBtn2.frame = CGRectMake(kScreenWith/2-30, 30, 60, 25);
    //    [creBtn2 setTitle:@"活动" forState:UIControlStateNormal];
    //    [creBtn2.titleLabel setFont:FONT_16];
    //    [creBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [creBtn2 addTarget:self action:@selector(creBtn2) forControlEvents:UIControlEventTouchUpInside];
    //    [_cycleScrollView addSubview:creBtn1];
    //
    //
    //    UIButton *rightNavBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    rightNavBtn2.frame = CGRectMake(kScreenWith-100, 30, 80, 25);
    //    [rightNavBtn2 setTitle:@"我的活动" forState:UIControlStateNormal];
    //    [rightNavBtn2.titleLabel setFont:FONT_14];
    //    [rightNavBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //
    //    [rightNavBtn2.layer setMasksToBounds:YES];
    //    [rightNavBtn2.layer setCornerRadius:2.0];
    //    [rightNavBtn2.layer setBorderWidth:1.0];
    //    [rightNavBtn2.layer  setBorderColor: RGBCOLOR(255.0, 255.0, 255.0).CGColor];
    //    rightNavBtn2.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
    //    rightNavBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //
    //    [rightNavBtn2 addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [_cycleScrollView addSubview:rightNavBtn2];
    
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWith, kScreenHeight-64)];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//加载无网络图标
-(void)setupLoadingNoNetworkView{
    CGFloat loadW = 150.0;
    CGFloat loadH = 150.0;
    _loadNoNetworkImageView = [[UIImageView alloc] init];
    _loadNoNetworkImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0-213, loadW, loadH);
    //_loadImageView.hidden = YES;
    _loadNoNetworkImageView.image = [UIImage imageNamed:@"zhanweitu"];
    [self.view addSubview:_loadNoNetworkImageView];
    
    _loadLabel = [[UILabel alloc] init];
    _loadLabel.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0-20, (self.view.frame.size.height-loadH)/2.0-93, 220, loadH);
    _loadLabel.text = LStr(@"NoNetwork");
    _loadLabel.font = [UIFont boldSystemFontOfSize:16];  // 系统字体 加粗
    [self.view addSubview:_loadLabel];
}


-(void)setupLoadingView{
    self.uiCollectionView.hidden=YES;
    
     if([CoreStatus isNetworkEnable]){
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
}


#pragma mark - 加载网络数据
-(void)loadeData{
    [[WebAccessManager sharedInstance]fourthGetActivityHomeListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            
            _loadImageView.hidden = YES;
            _loadLabel.hidden = YES;
            _loadNoNetworkImageView.hidden = YES;
            
            if (self.page == 1) {
                self.carousel_list = response.data.carousel_list;
                
                NSMutableArray* urlArray = [NSMutableArray new];
                NSMutableArray* titleArray = [NSMutableArray new];
                for(ScienceActivity* sa in self.carousel_list){
                    [urlArray addObject:sa.image_name];
                    if (sa.title) {
                        [titleArray addObject:sa.title];
                    }else{
                        [titleArray addObject:@""];
                    }
                }
                
                _cycleScrollView.imageURLStringsGroup = urlArray;
                _cycleScrollView.titlesGroup = titleArray;

                self.rlist = response.data.recommend_list;
                NSMutableArray* alist = response.data.activity_list;

                [self.dataList removeAllObjects];

                if (self.rlist) {
                    for(int i=0; i< self.rlist.count; i++){
                        ScienceActivity* sa = [ self.rlist objectAtIndex:i];
                        sa.isRec = 1;
                        [self.dataList addObject:sa];
                    }
                }

                if (alist) {
                    [self.dataList addObjectsFromArray:[alist copy]];
                }

                 CGRect bounds = CGRectMake( 0 , 0 , kScreenWith, 205) ;
                UIView * topView = [[UIView alloc]initWithFrame:bounds];
                [topView addSubview:self.headView];
                self.uiTableView.tableHeaderView = topView;
//                [self.view addSubview:_tableView];
                
                [self.uiTableView reloadData];
            }else{
                if (response.data.activity_list.count > 0) {
                    // 还有数据
                    if (response.data.activity_list) {
                        [self.dataList addObjectsFromArray:[response.data.activity_list copy]];
                    }


                    [self.uiTableView reloadData];
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

// 左侧导航点击事件
// 改版调整为跳转关注页面
-(void)leftNavBtn{
    //    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    //    [menuController showLeftController:YES];
    [self.navigationController pushViewController:[ChannelCollectionViewController new] animated:YES];
}

// 右侧导航点击事件
-(void)rightNavBtn{
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:NO completion:nil];
    }else{
        [self.navigationController pushViewController:[MyActivityListViewController new] animated:YES];
    }
}

#pragma mark SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ScienceActivity *sa = _carousel_list[index];
    
    [self forwardToDetailViewWithActivity:sa];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if([CoreStatus isNetworkEnable]){
          return self.dataList.count+2;
     }else{
          return 0;
     }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        ActivityMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActivityMenuTableViewCell ID]];
        if (!cell) {
            cell = [ActivityMenuTableViewCell newCell];
            cell.delegate = self;
        }
         return cell;
    }
    
    if(indexPath.row == 1){
        ActivityRemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActivityRemTableViewCell ID]];
        if (!cell) {
            cell = [ActivityRemTableViewCell newCell];
        }
       
        return cell;
    }
    
    
       ActivityNormalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ActivityNormalInfoTableViewCell ID]];
    if (!cell) {
        cell = [ActivityNormalInfoTableViewCell newCell];
    }
    
    ScienceActivity* sa=[self.dataList objectAtIndex:indexPath.row-2];
    [cell setCellWithScienceActivityData:sa];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 95;
    }else if(indexPath.row == 1){
        return 40;
    }else{
         ScienceActivity* sa=[self.dataList objectAtIndex:indexPath.row-2];
        
        CGFloat textHeight = [TextUtil boundingRectWithText:sa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
        if(textHeight<40){
            return kSCREEN_WIDTH * (260-23) / kWIDTH_375;
        }else{
            return kSCREEN_WIDTH * 260 / kWIDTH_375;
        }
    }

}

#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadeData];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadeData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row!=0&&indexPath.row!=1){
        ScienceActivity *sa = self.dataList[indexPath.row-2];
        
        [self forwardToDetailViewWithActivity:sa];
    }else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

}

- (void)clickHotBtn{
    [FlowUtil startToFourActivityLatestAndHotVCNav:self.navigationController withIsHot:YES];
}
- (void)clickNewBtn{
    [FlowUtil startToFourActivityLatestAndHotVCNav:self.navigationController withIsHot:NO];
}
- (void)clickSpecialBtn{
    [FlowUtil startToFourActivityNewSpecialVCNav:self.navigationController];
}
- (void)clicklocationBtn{
    [FlowUtil startToInteractionAndLocalActivityVCNav:self.navigationController];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"offset %lf ",scrollView.contentOffset.y);
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 64)/136.0f;
    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    
//    self.backView.backgroundColor = [UIColor redColor];
    
    if (offset_Y >140) {
        
        self.backView.backgroundColor = [UIColor blackColor];
    }else{
        
        if (offset_Y < -29) {
            _rightNavBtn1.hidden = YES;
        }else{
            _rightNavBtn1.hidden = NO;
        }
        
        self.backView.backgroundColor = [UIColor clearColor];
    }
    
//    if (offset_Y < -64) {
//        //放大比例
//        CGFloat add_topHeight = -(offset_Y+kNavigationBarHeight+kStatusBarHeight);
//        self.scale = (200+add_topHeight)/200;
//        //改变 frame
//        CGRect contentView_frame = CGRectMake(0, -add_topHeight, kScreenWith, 200+add_topHeight);
//
//
//        _headView.frame = contentView_frame;
//        CGRect imageView_frame = CGRectMake(-(kScreenWith*self.scale-kScreenWith)/2.0f,
//                                            0,
//                                            kScreenWith*self.scale,
//                                            200+add_topHeight);
//        self.headerImageView.frame = imageView_frame;
//    }
    
}

- (void)forwardToDetailViewWithActivity:(ScienceActivity*)sa{
    if ([sa.av_type isEqualToString:@"01"] || [sa.av_type isEqualToString:@"02"]||[sa.av_type isEqualToString:@"03"]) {
        if (![[MemberManager sharedInstance] isLogined]) {
            // 跳转登录界面
            [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:NO completion:nil];
        }else{
            [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.av_id completion:^(WebResponse *response, NSError *error) {
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
                    webVC.titleStr = sa.title;
                    webVC.av_id_Str = sa.av_id;
                    webVC.shareModel = shareModel;
                    [self.navigationController pushViewController:webVC animated:YES];
                    [webVC loadWebWithUrl:response.data.av_url];
                }else{
                    [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                }
            }];
        }
    }else if([sa.av_type isEqualToString:@"04"]){
        [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.av_id completion:^(WebResponse *response, NSError *error) {
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
                webVC.titleStr = sa.title;
                webVC.av_id_Str = sa.av_id;
                webVC.shareModel = shareModel;
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC loadWebWithUrl:response.data.av_url];
            }else{
                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }else if([sa.av_type isEqualToString:@"05"]){
        [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.av_id completion:^(WebResponse *response, NSError *error) {
        }];
        // 资讯
        if ([sa.article_classify isEqualToString:@"0"] || [sa.article_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:sa.rele_id completion:nil];
        }else if([sa.article_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:sa.rele_id completion:nil];
        }else if([sa.article_classify isEqualToString:@"2"]){
            // 视频
            [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:sa.rele_id completion:nil];
        }else if([sa.article_classify isEqualToString:@"3"]){
            // 专题
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:sa.rele_id];
        }
    }else if([sa.av_type isEqualToString:@"06"]){
        // 跳转专题详情列表
        [FlowUtil startToFourActivitySpecialDetailListVCNav:self.navigationController WithSpsa:sa];
    }else{
        [[WebAccessManager sharedInstance]fourthV2GetActivityDetailWithAv_id:sa.av_id completion:^(WebResponse *response, NSError *error) {
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
                
                webVC.titleStr = sa.title;
                webVC.av_id_Str = sa.av_id;
                webVC.shareModel = shareModel;
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC loadWebWithUrl:response.data.av_url];
            }else{
                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

@end
