//
//  LeftListViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/1.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "LeftListViewController.h"
#import "LeftListCell.h"
#import "LoginAndRegisterViewController.h"
#import "Member.h"


#define Title_Main    @"首页"
#define Title_WeiChat @"微信"
#define Title_Weibo   @"微博"
#define Title_Station @"基站"
#define Title_QA      @"问答"
#define Title_Catch   @"离线缓存"
#define Title_MyAttention @"合作单位"
#define Title_My      @"我的"
#define Title_Category @"分类"

@interface LeftListViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titles;
    NSArray *_images;
    UIColor *_backColor;
    CGFloat _leftViewWidth;
    UITableView *_dataTable;
    UIImageView *_headerImgView;
    UILabel *_headerLabel;
}
@property (nonatomic, strong)Member* member;
@end

static CGFloat headerViewheight = 130;
static CGFloat footerViewheight = 35;

@implementation LeftListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNotice];
    [self initData];
    [self setupview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 1、初始化数据
    self.member = [[MemberManager sharedInstance]getMember];
    
    //重置头像跟名称
    [self refreshMyViewData:nil];
}
#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshMyViewData:) name:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
}

-(void)initData{
    //    _titles = @[Title_Main,Title_WeiChat,Title_Weibo,Title_Station,Title_QA,Title_Catch,Title_My];
    //    _images = @[@"left_icon_main",@"left_icon_wechat",@"left_icon_weibo",@"left_icon_station",@"left_icon_QA",@"left_icon_catch",@"left_icon_my"];

    _titles = @[Title_Main,Title_WeiChat,Title_Weibo,Title_Station,Title_QA,Title_MyAttention,Title_Catch,Title_My];
    _images = @[@"left_icon_main",@"left_icon_wechat",@"left_icon_weibo",@"left_icon_station",@"left_icon_QA",@"left_icon_myAttention",@"left_icon_catch",@"left_icon_my"];
    
    _backColor = [UIColor colorWithHex:0x2c3e50];
    
    _leftViewWidth = MAIN_SCREEN_WIDTH-315.0/750.0*MAIN_SCREEN_WIDTH;
}

-(void)setupview{
    self.view.backgroundColor = _backColor;
    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, MAIN_SCREEN_WIDTH, 20)];
    tab.backgroundColor = _backColor;
    [self.view addSubview:tab];
    
    UIView *_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _leftViewWidth, headerViewheight)];
    _headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *_headerBackImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_leftViewWidth-55.0)/2.0, 35, 55, 55)];
    _headerBackImgView.image = [UIImage imageNamed:@"left_header_back"];
    _headerBackImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader)];
    [_headerBackImgView addGestureRecognizer:tap];
    
    CGFloat _headerImgW = 50;
    _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_headerBackImgView.frame.size.width-_headerImgW)/2.0, (_headerBackImgView.frame.size.width-_headerImgW)/2.0, _headerImgW, _headerImgW)];
    _headerImgView.image = [UIImage imageNamed:@"userHeaderDefaultIcon"];
    _headerImgView.layer.cornerRadius = _headerImgW/2.0;
    _headerImgView.clipsToBounds = YES;
    
    
    [_headerBackImgView addSubview:_headerImgView];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _headerBackImgView.frame.origin.y+_headerBackImgView.frame.size.height+10, _headerView.frame.size.width, 15.0)];
    _headerLabel.backgroundColor = [UIColor clearColor];
    _headerLabel.text = @"请登录";
    _headerLabel.textColor = [UIColor whiteColor];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self.view addSubview:_headerView];
    [_headerView addSubview:_headerBackImgView];
    [_headerView addSubview:_headerLabel];
    
    _dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.frame.origin.y+headerViewheight, _leftViewWidth, MAIN_SCREEN_HEIGHT-headerViewheight-footerViewheight)];
    _dataTable.dataSource = self;
    _dataTable.delegate = self;
    _dataTable.backgroundColor = _backColor;
    _dataTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_dataTable];
    
    
    UIView *_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT-footerViewheight, _leftViewWidth, footerViewheight)];
    _footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_footerView];
    
    UIImage *_footImg = [UIImage imageNamed:@"logo_left"];
    UIImageView *_footerImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_footerView.frame.size.width-113.0)/2.0, 0, 113.0, 25.0)];
    _footerImgView.image = _footImg;
    [_footerView addSubview:_footerImgView];
    
    //默认选中第一行
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [_dataTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void)tapHeader{
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    
//    if ([[MemberManager sharedInstance] isLogined]) {
//        [menuController.memberInfoVC reSetLeftButton];
//        [menuController setRootController:menuController.memberInfoNav animated:YES];
//    }
//    else{
//        JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:[LoginAndRegisterViewController new]];
//        navigationController.modalPresentationStyle = UIModalPresentationCustom;
//        [menuController presentViewController:navigationController animated:YES completion:nil];
//    }
}

- (void)refreshMyViewData:(NSNotification*)notification{
    if ([[MemberManager sharedInstance] isLogined]) {
        // 1、设置头像、姓名
        [_headerImgView sd_setImageWithURL:[NSURL URLWithString:[[MemberManager sharedInstance] getMember].img_url] placeholderImage:nil];
        [_headerLabel setText:[[MemberManager sharedInstance] getMember].member_name];
    }else{
        [_headerImgView setImage:[UIImage imageNamed:@"userHeaderDefaultIcon"]];
        [_headerLabel setText:@"请登录"];
    }
}

#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LeftListCell";
    LeftListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell  = [[LeftListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = _backColor;
        UIView *_selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        _selectView.backgroundColor = RGBCOLOR(38,52,67);
        cell.selectedBackgroundView = _selectView;
    }
    //是否隐藏底部横线
    BOOL hidden = NO;
    if (indexPath.row == _titles.count-1) {
        hidden = YES;
    }
    [cell setCellWithTitle:_titles[indexPath.row] imageName:_images[indexPath.row] lineHidden:hidden];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LeftListCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一行默认选中的效果
    // 改版
//    if (indexPath.row != 0) {
//        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        cell.backgroundColor = self.view.backgroundColor;
//        
//        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
//        [_dataTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath,nil] withRowAnimation:UITableViewRowAnimationNone];
//    }
//    
//    //跳转
//    NSString *title = _titles[indexPath.row];
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    if ([title isEqualToString:Title_Main]) {
//        [menuController setRootController:menuController.mainNav animated:YES];
//        
//        /*
//         // tabbar为rootviewcontroller
//        [menuController showRootController:YES];
//        menuController.homeTab.selectedIndex = 1;
//        [menuController.mainVC.navigationController popToRootViewControllerAnimated:NO];
//        [menuController setRootController:menuController.homeTab animated:YES];
//         */
//    }
//    else if ([title isEqualToString:Title_WeiChat]) {
//        //        [menuController setRootController:menuController.weichatNav animated:YES];
//        //        [menuController.weichatWebVC loadWeiChatUrl];
//        
//        [menuController.weiChatPublicNumberVC resetTableFrameWithIsLeft:YES];
//        [menuController setRootController:menuController.weiChatPublicNumberNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_Weibo]) {
//        [menuController setRootController:menuController.weiboNav animated:YES];
//        [menuController.weiboVC loadWeiBoUrl];
//    }
//    else if ([title isEqualToString:Title_Station]) {
//        [menuController setRootController:menuController.estationNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_QA]) {
//        [menuController setRootController:menuController.questionNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_Catch]) {
//        [menuController.catchVC reSetLeftButton];
//        [menuController setRootController:menuController.catchNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_MyAttention]) {
//        [menuController setRootController:menuController.myAttentionNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_My]) {
//        [menuController setRootController:menuController.myNav animated:YES];
//    }
//    else if ([title isEqualToString:Title_Category]) {
//        [menuController setRootController:menuController.categoryNav animated:YES];
//    }
    
}
#pragma mark func
-(void)showMain{
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [_dataTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController setRootController:menuController.mainNav animated:NO];
    
}
-(void)showMyAttention{
    NSIndexPath *ip=[NSIndexPath indexPathForRow:5 inSection:0];
    [_dataTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController setRootController:menuController.myAttentionNav animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
