//
//  SpecialInfoViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialInfoViewController.h"
#import "SDCycleScrollView.h"
#import "HomeModel.h"
#import "SpecialPicAndWenBaseTableViewCell.h"
#import "SpecialPicListTableViewCell.h"
#import "SpecialVedioTableViewCell.h"
#import "SpecialWenTableViewCell.h"
#import "SpecialBannerCollectionViewCell.h"
//#import "SpecialEndTableViewCell.h"

@interface SpecialInfoViewController ()<SpecialBannerCollectionViewCellCycleDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UILabel *UITitile;
@property (weak, nonatomic) IBOutlet UILabel *UIDesc;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *UIBanner;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIBannerConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UITableViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zongconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zongHeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIScrollConstraint;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn1;
@property (weak, nonatomic) IBOutlet UIImageView *UIBtnImg1;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn2;
@property (weak, nonatomic) IBOutlet UIImageView *UIBtnImg2;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn3;
@property (weak, nonatomic) IBOutlet UIImageView *UIBtnImg3;
@property (weak, nonatomic) IBOutlet UICollectionView *UiCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIBtnConStraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIMaxConStraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageConStraint;

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSString* classify;
@property (nonatomic, strong)NSMutableArray* carousel_list; // 轮播图
@property (nonatomic, strong)NSMutableArray* dataList; // 资讯列表

/** window */
@property (nonatomic, strong) UIWindow *window;
/** 悬浮按钮 */
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) Boolean isShowBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIVideoImageConstraint;
@property (nonatomic, strong)ShareModel* shareModel;
@end

@implementation SpecialInfoViewController

- (void)viewDidLoad {
//    [super viewWillAppear:YES];
    [super viewDidLoad];
     self.title = @"专题详情";
    
    [self setupView];
    
    [self initData];
    
    [self initCollectionView];
    
//    [self performSelector:@selector(creatSuspendBtn) withObject:nil afterDelay:0];
    
    [self loadList];
}

////界面初始化时进入
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if(!_isShowBtn&&self.uiScrollView.contentOffset.y <kSCREEN_WIDTH * self.constraint / kWIDTH_375){
//        [self creatSuspendBtn];
//        _isShowBtn=true;
//    }
}
//
////界面销毁时进入
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    //将要消失
//    if(_isShowBtn){
//        [_window resignKeyWindow];
//        _window = nil;
//        _isShowBtn=false;
//    }
//}

//初始化数据
-(void)initData{

    self.UITopConstraint.constant = 0;
    self.uiScrollView.scrollsToTop = NO;
    self.UiCollectionView.scrollEnabled = NO;
    
    //设置开启主滑动
    self.uiScrollView.scrollEnabled = YES;
    //设置禁止tableView滑动
    self.uiTableView.scrollEnabled = NO;
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
        self.UIImageConStraint.constant = 170;
    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_667){
        self.UIImageConStraint.constant = 190;
    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
        self.UIImageConStraint.constant = 195;
    }
    
    self.UIScrollConstraint.constant = kSCREEN_WIDTH * 375 / kWIDTH_375;
    self.zongconstraint.constant = kSCREEN_WIDTH * 375 / kWIDTH_375;
    self.zongHeConstraint.constant = kSCREEN_WIDTH * 430 / kWIDTH_375;
    self.UIBtnConStraint.constant = kSCREEN_WIDTH * 125 / kWIDTH_375;

    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
        self.UIVideoImageConstraint.constant = kSCREEN_WIDTH * 51 / kWIDTH_375;
    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
        self.UIVideoImageConstraint.constant = kSCREEN_WIDTH * 46 / kWIDTH_375;
    }
    self.page = 1;
    self.dataList = [NSMutableArray new];
    self.carousel_list = [NSMutableArray new];
    self.classify = @"";
    
    self.UIBtnImg1.hidden = NO;
    self.UIBtnImg2.hidden = YES;
    self.UIBtnImg3.hidden = YES;
    
    [_UIBtn1 setTitleColor:[UIColor colorWithRed:54.0f/255.0f green:205.0f/255.0f blue:224.0f/255.0f alpha:1] forState:UIControlStateNormal];
//    [_UIBtn1.layer setBorderWidth:0.25];//边框宽度
//    [_UIBtn1.layer  setBorderColor: RGBCOLOR(213.0, 213.0, 213.0).CGColor];//边框颜色
    
    [_UIBtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
//    [_UIBtn2.layer setBorderWidth:0.25];//边框宽度
//    [_UIBtn2.layer  setBorderColor: RGBCOLOR(213.0, 213.0, 213.0).CGColor];//边框颜色

    [_UIBtn3 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
//    [_UIBtn3.layer setBorderWidth:0.25];//边框宽度
//    [_UIBtn3.layer  setBorderColor: RGBCOLOR(213.0, 213.0, 213.0).CGColor];//边框颜色
    
    [self.UiCollectionView registerNib:[UINib nibWithNibName:[SpecialBannerCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialBannerCollectionViewCell ID]];
    

    
}

////返回按钮
//-(void)creatSuspendBtn{
//    _isShowBtn=true;
//    //悬浮按钮
//    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setImage:[UIImage imageNamed:@"img_zhuanti_back"] forState:UIControlStateNormal];
//    //    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    //    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    _button.frame = CGRectMake(0,0, 64, 64);
//    [_button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    
//    //悬浮按钮所处的顶端UIWindow
//    _window = [[UIWindow alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH * 5 / kWIDTH_375, kSCREEN_WIDTH * 10 / kWIDTH_375, 64, 64)];
//    //使得新建window在最顶端
//    _window.windowLevel = UIWindowLevelAlert + 1;
//    _window.backgroundColor = [UIColor clearColor];
//    [_window addSubview:_button];
//    //显示window
//    [_window makeKeyAndVisible];
//}
//
////返回操作
//-(void)goBack{
//    [_window resignKeyWindow];
//    _window = nil;
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return YES;
}

#pragma mark - 初始化界面和数据
-(void)setupView{

    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 20);
    [rightNavBtn setTitle:@"分 享" forState:UIControlStateNormal];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

// 右侧导航点击事件
-(void)rightNavBtn{
     [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:_shareModel completion:nil];
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.UiCollectionView registerNib:[UINib nibWithNibName:[SpecialPicAndWenBaseTableViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialPicAndWenBaseTableViewCell ID]];
    [self.UiCollectionView registerNib:[UINib nibWithNibName:[SpecialPicListTableViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialPicListTableViewCell ID]];
    [self.UiCollectionView registerNib:[UINib nibWithNibName:[SpecialVedioTableViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialVedioTableViewCell ID]];
    [self.UiCollectionView registerNib:[UINib nibWithNibName:[SpecialWenTableViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialWenTableViewCell ID]];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f-----UIMaxConStraint-----",self.UIMaxConStraint.constant);
//    NSLog(@"%f****uiScrollView******",self.uiScrollView.contentOffset.y);
//    NSLog(@"%f****uiTableView******",self.uiTableView.contentOffset.y);
    //当主滑动到一个数值时，固定滑动
    if (self.uiScrollView.contentOffset.y >self.UIMaxConStraint.constant){
        //设置固定区域
        scrollView.contentOffset = CGPointMake(0, self.UIMaxConStraint.constant);
        //显示顶部黑色区域
//        self.UITopConstraint.constant = 21;
        //隐藏返回按钮
//        [_window resignKeyWindow];
//        _window = nil;
//        _isShowBtn=false;
        //设置禁止主滑动
        self.uiScrollView.scrollEnabled = NO;
        //设置开启tableView滑动
        self.uiTableView.scrollEnabled = YES;
        
        return;
        
    }else if (self.uiScrollView.contentOffset.y <self.UIMaxConStraint.constant){
        //设置开启主滑动
        self.uiScrollView.scrollEnabled = YES;
        //设置禁止tableView滑动
        self.uiTableView.scrollEnabled = NO;
        
        [self.uiTableView.mj_header endRefreshing];
        [self.uiTableView.mj_footer endRefreshing];
        
        //设置滑动到顶部
        CGPoint position = CGPointMake(0, 0);
        [self.uiTableView setContentOffset:position animated:NO];
    }else{
        //当滑动资讯类别区域，向下拉动超过范围时触发
        if(self.uiTableView.contentOffset.y<kSCREEN_WIDTH * -120 / kWIDTH_375){
            //设置开启主滑动
            self.uiScrollView.scrollEnabled = YES;
            //设置禁止tableView滑动
            self.uiTableView.scrollEnabled = NO;
            //去除顶部黑色区域
            self.UITopConstraint.constant = 0;
            //设置滑动到顶部
            CGPoint position = CGPointMake(0, 0);
            [_uiScrollView setContentOffset:position animated:YES];
            
            [self.uiTableView.mj_header endRefreshing];
            [self.uiTableView.mj_footer endRefreshing];
            
            position = CGPointMake(0, 0);
            [self.uiTableView setContentOffset:position animated:NO];
            //如果没有显示返回按钮，开启按钮
//            if(!_isShowBtn){
//                [self creatSuspendBtn];
//                _isShowBtn=true;
//            }
        }
    }
}

#pragma mark - 加载网络数据
//加载专题资讯
-(void)loadList{
    [[WebAccessManager sharedInstance]getSpecialItemListForSciencerBySpId:self.hm.ni_id page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];

        if (response.success) {
            if (self.page == 1) {
                self.dataList = response.data.list;
                self.carousel_list = response.data.infoRrecList;
                self.UITitile.text = response.data.specialarticle.ni_title;
                self.UIDesc.text = response.data.specialarticle.ni_desc;
                [self.UIImage sd_setImageWithURL:[NSURL URLWithString:response.data.specialarticle.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];



                if (response.data.share_info) {
                    // 设置分享对象
                        self.shareModel = [ShareModel new];
                        self.shareModel.in_share_contentURL = response.data.share_info.share_url;
                        self.shareModel.in_share_imageURL  = response.data.share_info.share_image_url;
                        self.shareModel.in_share_title  = response.data.share_info.share_title;
                        self.shareModel.in_share_desc  = response.data.share_info.share_desc;
                }
                
                
                if (!_carousel_list || _carousel_list.count == 0) {
                    // 没有轮播图
                    self.UiCollectionView.hidden = YES;
                    self.UIMaxConStraint.constant-=self.UIBannerConstraint.constant;
                    self.UIBannerConstraint.constant = 0;
                    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
                        self.zongHeConstraint.constant = kSCREEN_WIDTH * 470 / kWIDTH_375;
                    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
                        self.zongHeConstraint.constant = kSCREEN_WIDTH * 410 / kWIDTH_375;
                    }else{
                        self.zongHeConstraint.constant = kSCREEN_WIDTH * 430 / kWIDTH_375;
                    }
                }else{
//                    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){

                     if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
                         self.zongHeConstraint.constant = kSCREEN_WIDTH * 690 / kWIDTH_375;
                     }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
                         self.zongHeConstraint.constant = kSCREEN_WIDTH * 560 / kWIDTH_375;
                     }else{
                         self.zongHeConstraint.constant = kSCREEN_WIDTH * 580 / kWIDTH_375;
                     }
                }

                [self.UiCollectionView reloadData];
                [self.uiTableView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [self.dataList addObjectsFromArray:[response.data.list copy]];
                    
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

//加载专题资讯列表
-(void)loadDetailList:(NSString*)classify
{
    if(self.page>0){
        [[WebAccessManager sharedInstance]getSpecialItemDetailListForSciencerBySpId:self.hm.ni_id page:self.page classify:classify  completion:^(WebResponse *response, NSError *error) {
            [self.uiTableView.mj_footer endRefreshing];
            [self.uiTableView.mj_header endRefreshing];
            
            if (response.success) {
                if (self.page == 1) {
                    [self.dataList removeAllObjects];
                    self.dataList = response.data.list;
                    
                    [self.uiTableView reloadData];
                }else{
                    if (response.data.list.count > 0) {
                        [self.dataList removeAllObjects];
                        // 还有数据、
                        [self.dataList addObjectsFromArray:[response.data.list copy]];
                        
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
}

- (IBAction)clickBtn1:(id)sender {
    
    [_UIBtn1 setTitleColor:[UIColor colorWithRed:54.0f/255.0f green:205.0f/255.0f blue:224.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn3 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    self.UIBtnImg1.hidden = NO;
    self.UIBtnImg2.hidden = YES;
    self.UIBtnImg3.hidden = YES;
    
    self.page = 1;
 
     self.classify = @"";
    [self loadDetailList:@""];
    
    [self toTableViewTop];
}



- (IBAction)clickBtn2:(id)sender {
    [_UIBtn2 setTitleColor:[UIColor colorWithRed:54.0f/255.0f green:205.0f/255.0f blue:224.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn3 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    self.UIBtnImg2.hidden = NO;
    self.UIBtnImg1.hidden = YES;
    self.UIBtnImg3.hidden = YES;
    
    self.page = 1;
   
     self.classify = @"1";
    [self loadDetailList:@"1"];
    
    [self toTableViewTop];
}

- (IBAction)clickBtn3:(id)sender {
    [_UIBtn3 setTitleColor:[UIColor colorWithRed:54.0f/255.0f green:205.0f/255.0f blue:224.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn2 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_UIBtn1 setTitleColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1] forState:UIControlStateNormal];
    
    
    self.UIBtnImg3.hidden = NO;
    self.UIBtnImg2.hidden = YES;
    self.UIBtnImg1.hidden = YES;
    
    self.page = 1;

     self.classify = @"2";
    [self loadDetailList:@"2"];
    
    [self toTableViewTop];
}

- (void)toTableViewTop
{
    if(_dataList&&_dataList.count>0){
        //设置滑动到顶部
        NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.uiTableView scrollToRowAtIndexPath:topRow atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       //当前数据
       HomeModel* h=[self.dataList objectAtIndex:indexPath.row];
       
       if([h.ni_classify isEqualToString:@"0"]){
           SpecialPicAndWenBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SpecialPicAndWenBaseTableViewCell ID]];
           if (!cell) {
               cell = [SpecialPicAndWenBaseTableViewCell newCell];
           }
           [cell setCellWithScienceActivity:h showSpace:NO];
           
           return cell;
           
       }else if([h.ni_classify isEqualToString:@"1"]){
           SpecialPicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SpecialPicListTableViewCell ID]];
           if (!cell) {
               cell = [SpecialPicListTableViewCell newCell];
           }
           [cell setCellWithScienceActivity:h showSpace:NO];
           
           return cell;
           
       }else if([h.ni_classify isEqualToString:@"2"]){
           SpecialVedioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SpecialVedioTableViewCell ID]];
           if (!cell) {
               cell = [SpecialVedioTableViewCell newCell];
           }
           [cell setCellWithScienceActivity:h showSpace:NO];
           
           return cell;
       }else {
           //文字资讯
           SpecialWenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SpecialWenTableViewCell ID]];
           if (!cell) {
               cell = [SpecialWenTableViewCell newCell];
           }
           [cell setCellWithScienceActivity:h showSpace:NO];
           return cell;
       }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeModel* h  = [_dataList objectAtIndex:[indexPath row]];
    
    if([h.ni_classify isEqualToString:@"0"]){
        return kSCREEN_WIDTH * 94 / kWIDTH_375;
    }else if([h.ni_classify isEqualToString:@"1"]){
        return kSCREEN_WIDTH * 162 / kWIDTH_375;
    }else if([h.ni_classify isEqualToString:@"2"]){
        return kSCREEN_WIDTH * 276 / kWIDTH_375;
    }else{
        return kSCREEN_WIDTH * 107 / kWIDTH_375;
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeModel* sa = [self.dataList objectAtIndex:indexPath.row];
    [self forwardToDetailViewWithActivity:sa];
}


#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
//    _page = 1;
//    [self loadList];
    
    if(self.uiTableView.contentOffset.y<kSCREEN_WIDTH * -120 / kWIDTH_375){
        [self.uiTableView.mj_header endRefreshing];
        //设置开启主滑动
        self.uiScrollView.scrollEnabled = YES;
        //设置禁止tableView滑动
        self.uiTableView.scrollEnabled = NO;
        //去除顶部黑色区域
        self.UITopConstraint.constant = 0;
        //设置滑动到顶部
        CGPoint position = CGPointMake(0, 0);
        [_uiScrollView setContentOffset:position animated:YES];
        
        [self toTableViewTop];
    }else{
        [self loadDetailList:self.classify];
    }

}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadList];
}


- (void)forwardToDetailViewWithActivity:(HomeModel*)sa{
    if (self.uiScrollView.contentOffset.y <=self.UIMaxConStraint.constant){
        // 资讯
        if ([sa.ni_classify isEqualToString:@"0"] || [sa.ni_classify isEqualToString:@"4"]) {
            // 图文、文字
            [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
        }else if([sa.ni_classify isEqualToString:@"1"]){
            // 图集
            [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
        }else if([sa.ni_classify isEqualToString:@"2"]){
            // 视频
            [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:sa.ni_id completion:nil];
        }else if([sa.ni_classify isEqualToString:@"3"]){
            // 专题
            [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:sa.ni_rele_id];
        }
    }
    
    
}


#pragma mark - CollectionView Delegate, DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!_carousel_list.count||_carousel_list.count==0){
       return 0;
    }else{
       return 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialBannerCollectionViewCell ID] forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if (self.carousel_list) {
        cell.cycleSAList = self.carousel_list;
    }
    
    [cell setCellData];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%f---iphoneheight---",[UIScreen mainScreen].bounds.size.height);
    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_736){
        //plus
        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 170 / kWIDTH_375 );
    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
         return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 220 / kWIDTH_375 );
    }else{
        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 184 / kWIDTH_375 );
    }

// return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 184 / kSCREEN_WIDTH);
}

#pragma mark - ActivityBannerCellCycleDelegate
- (void)clickCycleWithImageURL:(HomeModel*)sa{
    [self forwardToDetailViewWithActivity:sa];
}

@end

