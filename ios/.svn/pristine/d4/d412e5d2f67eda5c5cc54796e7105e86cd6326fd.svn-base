//
//  ActivityViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityViewController.h"
#import "ChannelCollectionViewController.h"
#import "ActivityBannerCollectionCell.h"
#import "ActivityNormalCollectionCell.h"
#import "ActivityRemTitleCollectionViewCell.h"
#import "ActivityTextCollectionCell.h"
#import "ScienceActivity.h"
#import "TextUtil.h"
#import "LatestActivityViewController.h"
#import "CollectionDetailWebViewController.h"
#import "SDCursorView.h"
#import "MyActivityListViewController.h"
#import "ActivaityTypesCollectionViewCell.h"

@interface ActivityViewController ()<ActivityBannerCellCycleDelegate>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* carousel_list; // 轮播图
@property (nonatomic, strong)NSMutableArray* rlist; // 轮播图
@property (nonatomic, strong)NSMutableArray* dataList; // 活动列表

@property (nonatomic, strong)UIImageView *loadImageView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活 动";
    // 1、初始化界面
    [self setupView];
    [self setupLoadingView];
    
    // 2、初始化数据
    [self initData];
    
    // 3、注册CollectionView
    [self initCollectionView];
    
    // 4、加载数据
    [self loadeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return YES;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

#pragma mark - 初始化界面和数据
-(void)setupView{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 60, 25);
    [leftNavBtn setTitle:@"关注" forState:UIControlStateNormal];
    [leftNavBtn.titleLabel setFont:FONT_14];
    [leftNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 25);
    [rightNavBtn setTitle:@"我的活动" forState:UIControlStateNormal];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initData{
    self.page = 1;
    self.dataList = [NSMutableArray new];
    self.rlist = [NSMutableArray new];
}

// 左侧导航点击事件
-(void)leftNavBtn{
    [self.navigationController pushViewController:[ChannelCollectionViewController new] animated:YES];
}

// 右侧导航点击事件
-(void)rightNavBtn{
    if (![[MemberManager sharedInstance] isLogined]) {
        // 跳转登录界面
        [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO  isShowAlertYinDao:NO   completion:nil];
    }else{
        [self.navigationController pushViewController:[MyActivityListViewController new] animated:YES];
    }
}

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
-(void)loadeData{
    [[WebAccessManager sharedInstance]fourthGetActivityHomeListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                self.carousel_list = response.data.carousel_list;
                
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
                
                [self.uiCollectionView reloadData];
            }else{
                if (response.data.activity_list.count > 0) {
                    // 还有数据
                    if (response.data.activity_list) {
                        [self.dataList addObjectsFromArray:[response.data.activity_list copy]];
                    }
                    
                    
                    [self.uiCollectionView reloadData];
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

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityBannerCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityBannerCollectionCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityRemTitleCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityRemTitleCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityNormalCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityNormalCollectionCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityTextCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityTextCollectionCell ID]];
    
     [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivaityTypesCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivaityTypesCollectionViewCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 有推荐资源，则显示强力推荐那个 title
    if (self.rlist && self.rlist.count > 0) {
        return self.dataList.count + 2;
    }
    return self.dataList.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 判断有没有强力推荐
    if (self.rlist && self.rlist.count > 0) {
        // 有强力推荐
        if ([indexPath row] < self.dataList.count + 2) {
            // 1、第一个为轮播图
            if ([indexPath row] == 0) {
                ActivityBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityBannerCollectionCell ID] forIndexPath:indexPath];
                
                cell.delegate = self;
                
                if (self.carousel_list) {
                    cell.cycleSAList = self.carousel_list;
                }
                
                [cell setCellData];
                
                return cell;
            }
            
            if ([indexPath row] == 1) {
                ActivaityTypesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivaityTypesCollectionViewCell ID] forIndexPath:indexPath];
                return cell;
            }
            
            // 2、为强力推荐标题
            if ([indexPath row] == 2) {
                ActivityRemTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityRemTitleCollectionViewCell ID] forIndexPath:indexPath];
                
                return cell;
            }
            
            // 3、其他为cell
            ScienceActivity* sa = [self.dataList objectAtIndex:(indexPath.row - 3)];
            if (!sa.image_name || [sa.image_name isEmptyOrWhitespace]) {
                // 无图片
                ActivityTextCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityTextCollectionCell ID] forIndexPath:indexPath];
                
                if ([indexPath row] == 2) {
                    [cell setCellWithScienceActivity:sa showSpace:NO];
                }else{
                    [cell setCellWithScienceActivity:sa showSpace:YES];
                }
                
                return cell;
            }else{
                // 有图片
                ActivityNormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityNormalCollectionCell ID] forIndexPath:indexPath];
                if ([indexPath row] == 2) {
                    [cell setCellWithScienceActivity:sa showSpace:NO];
                }else{
                    [cell setCellWithScienceActivity:sa showSpace:YES];
                }
                
                return cell;
            }
        }
    }else{
        if ([indexPath row] < self.dataList.count + 1) {
            // 1、第一个为轮播图
            if ([indexPath row] == 0) {
                ActivityBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityBannerCollectionCell ID] forIndexPath:indexPath];
                cell.delegate = self;
                
                if (self.carousel_list) {
                    cell.cycleSAList = self.carousel_list;
                }
                
                [cell setCellData];
                
                return cell;
            }
            
            // 2、其他为cell
            ScienceActivity* sa = [self.dataList objectAtIndex:(indexPath.row - 1)];
            if (!sa.image_name || [sa.image_name isEmptyOrWhitespace]) {
                // 无图片
                ActivityTextCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityTextCollectionCell ID] forIndexPath:indexPath];
                [cell setCellWithScienceActivity:sa showSpace:YES];
                return cell;
            }else{
                // 有图片
                ActivityNormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityNormalCollectionCell ID] forIndexPath:indexPath];
                [cell setCellWithScienceActivity:sa showSpace:YES];
                return cell;
            }
        }
    }
    
    return  nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rlist && self.rlist.count > 0) {
        // 有强力推荐
        [self forwardToDetailViewWithActivity:[self.dataList objectAtIndex:(indexPath.row -2)]];
    }else{
        // 没有强力推荐
        [self forwardToDetailViewWithActivity:[self.dataList objectAtIndex:(indexPath.row -1)]];
    }
    
    // [self refreshCollectionCellDataByVisitCountIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0 ) {
        if (self.carousel_list && self.carousel_list.count > 0) {
            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 175 / kWIDTH_375 + 90);
        }else{
            return CGSizeMake(kSCREEN_WIDTH, 90);
        }
    }
    
    
    if ([indexPath row] == 1) {
        return CGSizeMake(kSCREEN_WIDTH, 120);
    }
    
    if ([indexPath row] == 2) {
        if (self.rlist.count > 0) {
            // 强力推荐标题
            return CGSizeMake(kSCREEN_WIDTH, 40);
        }else{
            // 没有强力推荐，就是正常活动，分由图片的和没有图片的
            ScienceActivity* sa = [self.dataList objectAtIndex:0];
            if (!sa.image_name || [sa.image_name isEmptyOrWhitespace]) {
                // 没有图片
                CGFloat height = 49 + 15 + 15 + 12; //  15 - 文字到下面眼睛的距离，15-眼睛Label高度，12-眼睛到底部的距离
                CGFloat textHeight = [self jisuanTextHeight:sa.title];
                return  CGSizeMake(kSCREEN_WIDTH, textHeight + height);
            }else{
                // 有图片
                return  CGSizeMake(kSCREEN_WIDTH, 87 + 49 + kSCREEN_WIDTH * 175 / kWIDTH_375);
            }
        }
    }
    
    ScienceActivity* sa = nil;
    if (self.rlist.count > 0) {
        sa = [self.dataList objectAtIndex:(indexPath.row - 2)];
    }else{
        sa = [self.dataList objectAtIndex:(indexPath.row - 1)];
    }
    
    if (!sa.image_name || [sa.image_name isEmptyOrWhitespace]) {
        // 没有图片
        CGFloat height = 49 + 48; //  48为Label到底部距离
        CGFloat textHeight = [self jisuanTextHeight:sa.title];
        return  CGSizeMake(kSCREEN_WIDTH, textHeight + height);
    }else{
        // 有图片
        return  CGSizeMake(kSCREEN_WIDTH, 87 + 49 + kSCREEN_WIDTH * 175 / kWIDTH_375);
    }
}

- (void)collectionViewRefreshHeaderData{
    _page = 1;
    [self loadeData];
}

- (void)collectionViewRefreshFooterData{
    _page += 1;
    [self loadeData];
}

// 刷新当前cell 访问量加1
- (void)refreshCollectionCellDataByVisitCountIndexPath:(NSIndexPath*)indexPath{
    // 获取数据
    if (self.rlist.count > 0) {
        // 强力推荐标题
        ScienceActivity* currentSa = [self.dataList objectAtIndex:indexPath.row - 2];
        int visitCount = [currentSa.visitors intValue] + 1;
        [currentSa setVisitors:[NSString stringWithFormat:@"%d",visitCount]];
        
        NSMutableArray* tempArray = [NSMutableArray new];
        for (int i=0; i<self.dataList.count; i++) {
            ScienceActivity* sa = [self.dataList objectAtIndex:i];
            if (i == indexPath.row - 2) {
                [tempArray addObject:currentSa];
            }else{
                [tempArray addObject:sa];
            }
        }
        
        self.dataList = tempArray;
    }else{
        // 没有强力推荐，就是正常活动，分由图片的和没有图片的
        ScienceActivity* currentSa = [self.dataList objectAtIndex:indexPath.row - 1];
        int visitCount = [currentSa.visitors intValue] + 1;
        [currentSa setVisitors:[NSString stringWithFormat:@"%d",visitCount]];
        
        NSMutableArray* tempArray = [NSMutableArray new];
        for (int i=0; i<self.dataList.count; i++) {
            ScienceActivity* sa = [self.dataList objectAtIndex:i];
            if (i == indexPath.row - 1) {
                [tempArray addObject:currentSa];
            }else{
                [tempArray addObject:sa];
            }
        }
        
        self.dataList = tempArray;
    }
    
    // 刷新当前Cell数据
    [self.uiCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
}

#pragma mark 工具类方法
- (CGFloat)jisuanTextHeight:(NSString*)text{
    CGFloat textHeight = 0;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    if (!fontSize) {
        fontSize = @"Normal";
        [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
        [settings synchronize];
    }
    if ([fontSize isEqualToString:@"Small"]) {
        textHeight = [TextUtil boundingRectWithText:text size:CGSizeMake(kSCREEN_WIDTH - 26, 0) Font:FONT_14].height;
    }else if([fontSize isEqualToString:@"Large"]) {
        textHeight = [TextUtil boundingRectWithText:text size:CGSizeMake(kSCREEN_WIDTH - 26, 0) Font:FONT_19].height;
    }else{
        textHeight = [TextUtil boundingRectWithText:text size:CGSizeMake(kSCREEN_WIDTH - 26, 0) Font:FONT_16].height;
    }
    
    // 16 为一行的高度
    if (textHeight < 20) {
        textHeight = 20;
    }else{
        textHeight = 45;
    }
    
    return textHeight;
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

#pragma mark - ActivityBannerCellCycleDelegate
- (void)clickCycleWithImageURL:(ScienceActivity*)sa{
    [self forwardToDetailViewWithActivity:sa];
}

- (void)clickHotBtn{
    [FlowUtil startToFourActivityLatestAndHotVCNav:self.navigationController withIsHot:YES];
}

- (void)clickLatestBtn{
    [FlowUtil startToFourActivityLatestAndHotVCNav:self.navigationController withIsHot:NO];
}

- (void)clickSpecialBtn{
    [FlowUtil startToFourActivityNewSpecialVCNav:self.navigationController];
}

@end
