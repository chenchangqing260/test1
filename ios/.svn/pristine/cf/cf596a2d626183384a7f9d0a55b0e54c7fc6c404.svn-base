//
//  WeChatPublicNumberViewController.m
//  ScienceChina
//
//  Created by xuanyj on 2017/1/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "WeChatPublicNumberViewController.h"
#import "CollectionDetailWebViewController.h"
#import "WeChatPublicNumberHeaderView.h"
//#import "WeChatPublicNumberCell.h"
#import "ChannelListCell.h"
#import "HomeModel.h"

@interface WeChatPublicNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_tableData;
    UIColor *_backColor;
    
    UITableView * _tableView;
    WeChatPublicNumberHeaderView *_weChatHeaderView;
    UIImageView *_loadImageView;
    
    BOOL _isLeft;
    
}
//@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, assign)NSInteger page;
@end

@implementation WeChatPublicNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isBackButton) {
        [self setBackNavBtn];
    } else {
        [self setLeftNavBtn];
    }
}
-(void)initData{
    _page = 0;
    _tableData = [[NSMutableArray alloc] initWithCapacity:0];
    _backColor = RGBCOLOR(244, 244, 244);
    self.category = [[InfoCategory alloc] init];
    self.category.at_id = @"AT201604301608271002";
    self.category.at_name_ch = @"微信";
}
-(void)resetTableFrameWithIsLeft:(BOOL)isLeft{
    _isLeft = isLeft;
    if (isLeft) {
        _tableView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64);
    }else{
        // 改版
//        _tableView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-ChannelHeight);
    }
    
}
-(void)setLeftNavBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)setBackNavBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
// 左侧导航点击事件
-(void)leftNavBtn{
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController showLeftController:YES];
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setupView{

    self.title = @"科普中国";
    self.view.backgroundColor = _backColor;
    
    _weChatHeaderView= [[WeChatPublicNumberHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, WeChatPublicNumberHeaderViewHeight)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.tableHeaderView = _weChatHeaderView;
    _tableView.backgroundColor = _backColor;
    [self.view addSubview: _tableView];
    [self resetTableFrameWithIsLeft:_isLeft];
    
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    _loadImageView.hidden = YES;
    [self.view addSubview:_loadImageView];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerFresh)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置 Header
    _tableView.mj_header = header;
    //_tableView.mj_footer = footer;
    
}
#pragma mark - TableView MJRefresh
-(void)headerFresh{
    _page = 0;
    [self loadData];
}

-(void)footerFresh{
    _page += 1;
    [self loadData];
}

-(void)loadData{
    //[SVProgressHUDUtil showWithStatus:@"正在加载..."];
    if (_tableData.count < 1) {
        _loadImageView.hidden = NO;
    } else {
        _loadImageView.hidden = YES;
    }
    [[WebAccessManager sharedInstance]getWeiChatPublicNOListWithPage:self.page Completion:^(WebResponse *response, NSError *error) {
        //[SVProgressHUDUtil dismiss];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        _tableView.hidden = NO;
        
        if (response.success) {
            _tableData = response.data.list;
            [_tableView reloadData];
            /*
            if (self.page == 0) {
                _tableData = response.data.list;
                [_tableView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_tableData addObjectsFromArray:[response.data.list copy]];
                    
                    [_tableView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                    [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
                }
            }
             */
            
        }else{
            self.page -= 1;
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
        
        if (_tableData.count < 1) {
            _loadImageView.hidden = NO;
        } else {
            _loadImageView.hidden = YES;
        }
    }];
}
-(void)getWebPageHtmlWithIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUDUtil showWithStatus:@"正在加载..."];
    HomeModel* model = [_tableData objectAtIndex:[indexPath section]];
    [[WebAccessManager sharedInstance]getWeiChatPublicNODetailWithId:model.in_id Completion:^(WebResponse *response, NSError *error) {
        
        [SVProgressHUDUtil dismiss];
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (response.success) {
            if (response.data.html && ![response.data.html isEqualToString:@""]) {
                CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];
                //[webVC loadWebWithUrl:response.data.html];
                [webVC writeHtmlToWebview:response.data.html];
            }
            
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChannelListCell ID]];
    if (!cell) {
        cell = [[ChannelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChannelListCell ID]];
    }
    if (indexPath.section < _tableData.count) {
        HomeModel* model = [_tableData objectAtIndex:[indexPath section]];
        [cell setCellWithModel:model];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableData.count;;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self getWebPageHtmlWithIndexPath:indexPath];
    
    HomeModel* model = [_tableData objectAtIndex:[indexPath section]];
    NSString *url = model.in_id;//[NSString stringWithFormat:@"http://news.wewen.io/articles/%@",model.in_id];
    CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC loadWebWithUrl:url];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if (indexPath.section < _tableData.count) {
        
        HomeModel* model = [_tableData objectAtIndex:[indexPath section]];
        if ([model.in_classify isEqualToString:@"0"]) {
            cellHeight = ChannelListCellHeight_graphic;
        }
        else if ([model.in_classify isEqualToString:@"1"]) {
            cellHeight = ChannelListCellHeight_graphic_MultiplePictures;
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
    if (section == 0) {
        sectionHeight = 4.0;
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
    if (section == 0) {
        sectionHeight = 4.0;
    }
    return sectionHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
