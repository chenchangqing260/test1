//
//  EStationPeronalViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationPeronalViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "EStationPicTextCell.h"
#import "EStationPicCell.h"
#import "EStationTextCell.h"
#import "VCFloatingActionButton.h"
#import "TextUtil.h"
#import "AddChannelViewController.h"

typedef enum{Attented = 1, NoAttent = 0} stationAttent;

@interface EStationPeronalViewController ()<floatMenuDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_nav;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_nav;
@property (weak, nonatomic) IBOutlet UIView *uiNavBarView;
@property (weak, nonatomic) IBOutlet UILabel *uiNavTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *uiAttentBtn;

@property (nonatomic, strong)EStation* station;
// 自定义变量
@property (nonatomic, strong)NSMutableArray* infoArray;
@property (nonatomic, assign)NSInteger page;
@property (strong, nonatomic) NSMutableArray *hadSelectedChannelArr;

@property (strong, nonatomic) VCFloatingActionButton *shareButton;

// 自定义顶部视图
@property (nonatomic,strong)UIImageView *headerBgImageView;
@property (nonatomic,strong)UIView *layerView; // 黑色蒙版
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *descLabel;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,assign)CGFloat scale; // 顶部背景图的比例
@property (nonatomic,assign)CGFloat headerBgImgHeight; // 顶部背景图的高度
@property (nonatomic,assign)CGFloat headerImgHeight; // 顶部头像的高度

@end

@implementation EStationPeronalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    [self initViewAndCon];
    
    // 2、初始化TableView的HeaderView
    [self initHeaderView];
        
    // 5、注册通知，是否关注
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAttentStatus) name:@"refreshAttentStatusForPersonal" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //get hadselectedchannel
    
    [self loadEStationInfo];
    
    // 4、加载网络数据
    [self loadEStationInfoList];
    [self loadhadSelectedChannel];
    
}
- (void)refreshAttentStatus{
    // 获取E站详情
    [[WebAccessManager sharedInstance]getEStationById:self.si_id Completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.station = response.data.station;
            if ([self.station.si_is_concern intValue] == Attented) {
                // 已关注
                [self.btn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.btn setTitle:@"已关注" forState:UIControlStateHighlighted];
                [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
            }else{
                // 未关注
                [self.btn setTitle:@"关注" forState:UIControlStateNormal];
                [self.btn setTitle:@"关注" forState:UIControlStateHighlighted];
                [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
                [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
            }
            
            // 刷新其他关注数据
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStationList" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTypeStationList" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshStationRankList" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadSearchResult" object:nil];
        }
    }];
}

#pragma mark - 初始化界面和约束
- (void)initViewAndCon{
    // 1、初始化变量常量
    _hadSelectedChannelArr = [NSMutableArray new];
    _infoArray = [NSMutableArray new];
    self.page = 1;
    self.scale = kWIDTH_375 / 225;
    self.headerBgImgHeight = kSCREEN_WIDTH / self.scale;
    self.headerImgHeight = 60;
    self.uiNavBarView.alpha = 0;
    
    // 2、增加分享按钮
    CGRect floatFrame = CGRectMake(self.leftEdge+self.showWidth - 44 - 20, kSCREEN_HEIGHT - 44 - 40, 44, 44);
    
    self.shareButton= [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] withScrollview:self.uiTableView];
    self.shareButton.imageArray = @[@"微信Share",@"QQShare",@"朋友圈Share",@"空间Share",@"微博Share"];
    self.shareButton.labelArray = @[@"",@"",@"",@"",@""];
    self.shareButton.hideWhileScrolling = YES;
    self.shareButton.delegate = self;
    
    [self.view addSubview:self.shareButton];
    
    
}

- (void)initViewData{
    // 1、界面数据
    [self.uiNavTitleLab setText:self.station.si_name];
    self.nameLabel.text = self.station.si_name;
    self.descLabel.attributedText = [LabelUtil getNSAttributedStringWithLabel:self.descLabel text:self.station.si_desc];
    
    // 2、加载图片
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.station.si_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    //    [self.headerBgImageView sd_setImageWithURL:[NSURL URLWithString:self.station.si_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        // 5 模糊图片
    //        [self.headerBgImageView setImageToBlur:self.headerBgImageView.image blurRadius:6 completionBlock:nil];
    //    }];
    
    // 3、根据是否关注显示不同数据
    // 根据是否关注现实不同的按钮样式
    if ([self.station.si_is_concern intValue] == Attented) {
        // 已关注
        [self.btn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.btn setTitle:@"已关注" forState:UIControlStateHighlighted];
        [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
    }else{
        // 未关注
        [self.btn setTitle:@"关注" forState:UIControlStateNormal];
        [self.btn setTitle:@"关注" forState:UIControlStateHighlighted];
        [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
    }
    
    // 设置分享对象
    self.shareModel = [ShareModel new];
    self.shareModel.in_share_contentURL = self.station.si_share_contentURL;
    self.shareModel.in_share_imageURL  = self.station.si_share_imageURL;
    self.shareModel.in_share_title  = self.station.si_share_title;
    self.shareModel.in_share_desc  = self.station.si_share_desc;
    self.shareModel.share_type  = @"04";
    self.shareModel.or_id = self.station.si_id;
}

- (void)initHeaderView{
    CGFloat textHeight = [TextUtil boundingRectWithText:self.station.si_desc lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 40, 0) Font:FONT_13].height;
    if (textHeight > 40) {
        self.headerBgImgHeight = self.headerBgImgHeight - 20 + textHeight;
    }

    // 1、初始化背景图
    self.headerBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.headerBgImgHeight)];
    self.headerBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerBgImageView.clipsToBounds = YES;
    self.headerBgImageView.image = [UIImage imageNamed:@"MyStationHeaderBack"];
    //[self.headerBgImageView setImageToBlur:self.headerBgImageView.image blurRadius:1 completionBlock:nil];//模糊图片
    
    self.layerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.headerBgImgHeight)];
    self.layerView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    
    // 2、初始化头像
    CGFloat headImgY = 54; //(self.headerBgImgHeight - self.headerImgHeight) / 2 - 20;
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.showWidth - self.headerImgHeight) / 2, headImgY, self.headerImgHeight, self.headerImgHeight)];
    self.headerImageView.backgroundColor = [UIColor clearColor];
    self.headerImageView.layer.cornerRadius = self.headerImgHeight * 0.5;
    self.headerImageView.clipsToBounds = YES;
    // 2.1 头像边框视图
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.headerImgHeight + 8, self.headerImgHeight + 8)];
    bgView.layer.cornerRadius = (self.headerImgHeight + 8) * 0.5;
    bgView.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.3];
    bgView.center = _headerImageView.center;
    // 2.2 加载Label
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, headImgY + self.headerImgHeight + 15, self.showWidth - 40, 20)];
    self.nameLabel.font = FONT_16;
    self.nameLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat Y = headImgY + self.headerImgHeight + 40;
    if (kSCREEN_WIDTH > kWIDTH_375) {
        Y += 15;
    }else if(kSCREEN_WIDTH == kWIDTH_375){
        Y += 5;
    }
    
    self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, Y, self.showWidth - 40, textHeight)];
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = FONT_13;
    self.descLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    
    // 2.3 加载按钮视图
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH - 60, 20, 60, 44)];
    [self.btn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
    [self.btn setTitle:@"关注" forState:UIControlStateNormal];
    [self.btn.titleLabel setFont:FONT_15];
    [self.btn addTarget:self action:@selector(clickAttentOperationBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(self.uiNavBarView.frame.origin.x, 20, 60, 44);
    [self.backBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateHighlighted];
    [self.backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.backBtn addTarget:self action:@selector(clickLeftNavBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3、初始化顶部视图
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, self.headerBgImgHeight)];
    self.topView.backgroundColor = [UIColor clearColor];
    
    // 4、添加视图
    [self.view addSubview:self.headerBgImageView];
    [self.view addSubview:self.layerView];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.backBtn];
    [self.topView addSubview:bgView];
    [self.topView addSubview:self.headerImageView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.descLabel];
    
    // 5、添加头视图
    self.uiTableView.tableHeaderView = self.topView;
    [self.view bringSubviewToFront:self.uiTableView];
    [self.view bringSubviewToFront:self.btn];
    [self.view bringSubviewToFront:self.backBtn];
    [self.view bringSubviewToFront:self.shareButton];
    
    //6.是否增加编辑按钮
    if ([_isShowEditBtn isEqualToString:@"yes"])
    {
        UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60, 64, 60, 30)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        editBtn.titleLabel.textColor = [UIColor whiteColor];
        [editBtn addTarget:self action:@selector(EditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:editBtn];
    }
    
}

#pragma mark - 重写父类方法
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 网络数据加载
- (void)loadhadSelectedChannel
{
    
}

- (void)loadEStationInfo{
    // 获取E站详情
    [[WebAccessManager sharedInstance]getEStationById:self.si_id Completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.station = response.data.station;
            // 2、初始化界面数据
            [self initViewData];
        }
    }];
}

- (void)loadEStationInfoList{
    [[WebAccessManager sharedInstance]getStationInfoBySiId:self.si_id page:self.page Completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                self.infoArray = response.data.infomationList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [self.infoArray addObjectsFromArray:[response.data.infomationList copy]];
                    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InfoObj* info = [_infoArray objectAtIndex:indexPath.row];
    if([info.in_classify isEqualToString:@"4"]){
        // 文字
        EStationTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationTextCell ID]];
        if (!cell) {
            cell = [EStationTextCell newCell];
        }
        [cell initCellData:info];
        return cell;
    }else if ([info.in_classify isEqualToString:@"0"]) {
        // 图文
        EStationPicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationPicTextCell ID]];
        if (!cell) {
            cell = [EStationPicTextCell newCell];
        }
        [cell initCellData:info isMovie:NO];
        return cell;
    }else if([info.in_classify isEqualToString:@"1"]){
        // 图集
        EStationPicCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationPicCell ID]];
        if (!cell) {
            cell = [EStationPicCell newCell];
        }
        [cell initCellData:info];
        return cell;
    }else if([info.in_classify isEqualToString:@"2"]){
        // 视频
        EStationPicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationPicTextCell ID]];
        if (!cell) {
            cell = [EStationPicTextCell newCell];
        }
        [cell initCellData:info isMovie:YES];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _infoArray.count) {
        InfoObj* model = [_infoArray objectAtIndex:[indexPath row]];
        
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
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoObj* info = [_infoArray objectAtIndex:indexPath.row];
    if([info.in_classify isEqualToString:@"1"]){
        // 图集，计算中间图片的高度
        // 原来375的适配下除了中间图片之外的尺寸
        CGFloat otherHeight = 200 - (kWIDTH_375 - 28 - 4) / 3 * 85 / 115;
        CGFloat imageHeight = (self.showWidth - 28 - 4) / 3 * 85 / 115;
        return imageHeight + otherHeight;
    }
    return 120;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        
    }
}

#pragma mark - UIScrollViewDelgate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY =  scrollView.contentOffset.y;
    if (scrollView.contentOffset.y < 0) {
        // 高度宽度同时拉伸 从中心放大
        CGFloat imgH = self.headerBgImgHeight - offsetY;
        CGFloat imgW = imgH * self.scale;
        self.headerBgImageView.frame = CGRectMake((offsetY * self.scale) / 2, 0, imgW,imgH);
        self.layerView.frame = CGRectMake((offsetY * self.scale) / 2, 0, imgW,imgH);
    } else {
        // 根据拉伸的高度，到达120的时候到64之间，显示导航栏，大于再隐藏导航栏
        CGFloat height = self.headerBgImgHeight - offsetY;
        CGFloat alphaHeight = 120;
        if (kNAV_HEIGHT < height && height < alphaHeight) {
            // 透明度设置
            CGFloat viewAlpha = 1 - (height - kNAV_HEIGHT) / 36;
            self.uiNavBarView.alpha = viewAlpha;
            self.nameLabel.alpha = self.descLabel.alpha = (height - kNAV_HEIGHT) / 36;
            [self.view bringSubviewToFront:self.uiNavBarView];
        }else if(height > alphaHeight){
            self.uiNavBarView.alpha = 0;
            self.nameLabel.alpha = self.descLabel.alpha = 1;
            [self.view sendSubviewToBack:self.uiNavBarView];
        }else{
            self.uiNavBarView.alpha = 1;
            self.nameLabel.alpha = self.descLabel.alpha = 0;
            [self.view bringSubviewToFront:self.uiNavBarView];
        }
    }
}

#pragma mark - 自定义方法

#pragma mark - 按钮手势点击事件
// 点击返回按钮
- (IBAction)clickLeftNavBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//编辑按钮
- (void)EditBtnAction:(UIButton *)sender
{
    [SVProgressHUDUtil show];
    [[WebAccessManager sharedInstance]getOrgChannelsWithor_id:_si_id completion:^(WebResponse *response, NSError *error) {
        if (response.success)
        {
            AddChannelViewController *addChannelVC = [[AddChannelViewController alloc]initWithNibName:nil bundle:nil];
            addChannelVC.saveDataTag=2;
            addChannelVC.HadSelectChannel = [NSMutableArray new];
            addChannelVC.HadSelectChannel = response.data.channelList;
            addChannelVC.or_id = _si_id;
            [SVProgressHUDUtil dismiss];
            [self.navigationController pushViewController:addChannelVC animated:1];
        }
        else
        {
            [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
        }
    }];
}

// 取消关注，或关注
- (IBAction)clickAttentOperationBtn:(id)sender {
    if ([_station.si_is_concern intValue] == Attented) {
        // 已关注的，取消关注
        [[WebAccessManager sharedInstance]delStationWithSiId:_station.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                _station.si_is_concern = [NSString stringWithFormat:@"%d", NoAttent];
                // 设置按钮
                [self.btn setTitle:@"关注" forState:UIControlStateNormal];
                [self.btn setTitle:@"关注" forState:UIControlStateHighlighted];
                [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
                [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
                
                // 刷新TableView
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStationList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTypeStationList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshStationRankList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadSearchResult" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshVideoDetailAttentBtn" object:nil];
            }
        }];
    }else{
        // 未关注的，进行关注操作
        [[WebAccessManager sharedInstance]saveStationWithSiId:_station.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                _station.si_is_concern = [NSString stringWithFormat:@"%d", Attented];
                // 设置按钮
                [self.btn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.btn setTitle:@"已关注" forState:UIControlStateHighlighted];
                [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
                
                // 刷新TableView
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStationList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTypeStationList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshStationRankList" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadSearchResult" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshVideoDetailAttentBtn" object:nil];
            }
        }];
    }
}

#pragma mark - MJRefresh
-(BOOL)showMJHeader{
    return NO;
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadEStationInfoList];
}

#pragma mark - Delegate
-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    if (row == 0) {
        [super didShareWithShareMode:ShareWeiXin];
    }else if(row == 1){
        [super didShareWithShareMode:ShareQQ];
    }else if(row == 2){
        [super didShareWithShareMode:ShareWXPengyouquan];
    }else if(row == 3){
        [super didShareWithShareMode:ShareQQZone];
    }else{
        [super didShareWithShareMode:ShareWeibo];
    }
}

@end
