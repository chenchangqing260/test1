//
//  SpecialActivityNewViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/28.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialActivityNewViewController.h"
#import "SpecialActivityViewController.h"
#import "SpecialMoreCollectionCell.h"
//#import "SpecialFirstCollectionCell.h"
#import "SpecialFirstNewCollectionCell.h"
#import "SpecialActivityCollectionCell.h"
#import "SpecialNoneCollectionCell.h"
#import "ScienceActivity.h"
#import "CollectionDetailWebViewController.h"
#import "TextUtil.h"

@interface SpecialActivityNewViewController ()<SpecialFirstNewCollectionCellDelegate>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* activity_list; // 数据

@property (nonatomic, strong)UIImageView *loadImageView;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation SpecialActivityNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动专题";
    
    // 1、初始化数据
    [self initData];
    [self setupLoadingView];
    
//    [self setupView];
    
    // 2、注册CollectionView
    [self initCollectionView];
    
    // 3、加载数据
    [self loadeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化界面和数据
-(void)initData{
    self.page = 1;
    self.activity_list = [NSMutableArray new];
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
    [[WebAccessManager sharedInstance]fourthGetActivitySpecialListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                
                if (response.data.share_info) {
                    // 设置分享对象
                    self.shareModel = [ShareModel new];
                    self.shareModel.in_share_contentURL = response.data.share_info.share_url;
                    self.shareModel.in_share_imageURL  = response.data.share_info.share_image_url;
                    self.shareModel.in_share_title  = response.data.share_info.share_title;
                    self.shareModel.in_share_desc  = response.data.share_info.share_desc;
                }
                
                self.activity_list = response.data.special_activity_list;
                
                [self.uiCollectionView reloadData];
            }else{
                if (response.data.activity_list.count > 0) {
                    
                    [self.activity_list addObjectsFromArray:[response.data.activity_list copy]];
                    
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

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialActivityCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialActivityCollectionCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialFirstNewCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialFirstNewCollectionCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialMoreCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialMoreCollectionCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialNoneCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialNoneCollectionCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.activity_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"Section:%ld Index:%ld", (long)indexPath.section, (long)indexPath.row);
    // 判断有没有强力推荐
//    if ([indexPath section] < self.activity_list.count) {
//        ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.section];
//        SpecialFirstNewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialFirstNewCollectionCell ID] forIndexPath:indexPath];
//        cell.delegate = self;
//        ScienceActivity* sa = [spsa.activity_list objectAtIndex:indexPath.row];
//        [cell setCellDataWithSpecialActivity:spsa SpecialActivity:sa indexPath:indexPath showTitle:YES];
//
//        return cell;
//    }
    
    ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
    SpecialFirstNewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialFirstNewCollectionCell ID] forIndexPath:indexPath];
    cell.delegate = self;
    [cell setCellDataWithSpecialActivity:spsa SpecialActivity:nil indexPath:indexPath showTitle:YES];
    
    return cell;
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 点击专题和更多，跳转专题列表，其他跳转相应的
    
    ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
    
    [FlowUtil startToFourActivitySpecialDetailListVCNav:self.navigationController WithSpsa:spsa];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(kSCREEN_WIDTH, 0);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
    
    CGFloat textHeight = [TextUtil boundingRectWithText:spsa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
    if(textHeight<40){
        return CGSizeMake(kSCREEN_WIDTH,237-23);
    }else{
        return CGSizeMake(kSCREEN_WIDTH,237);
    }
    
//    if ([spsa.total intValue] == 0) {
//        return CGSizeMake(kSCREEN_WIDTH, 225);
//    }else if([spsa.total intValue] > 0  && [spsa.total intValue] <= 3){
//        if (indexPath.row == 0) {
//            return CGSizeMake(kSCREEN_WIDTH, 225);
//        }else{
//            return CGSizeMake(kSCREEN_WIDTH, 280);
//        }
//    }else{
//        if (indexPath.row == 0) {
//            return CGSizeMake(kSCREEN_WIDTH, 225);
//        }else if(indexPath.row == spsa.activity_list.count){
//            return CGSizeMake(kSCREEN_WIDTH, 0);
//        }else{
//            return CGSizeMake(kSCREEN_WIDTH, 280);
//        }
//    }
}

- (void)collectionViewRefreshHeaderData{
    _page = 1;
    [self loadeData];
}

- (void)collectionViewRefreshFooterData{
    _page += 1;
    [self loadeData];
}

#pragma mark - 工具类
- (void)forwardToDetailViewWithActivity:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath{
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
                
                webVC.titleStr = sa.title;
                webVC.shareModel = shareModel;
                webVC.av_id_Str = sa.av_id;
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
    
    // [self refreshCollectionCellDataByVisitCountIndexPath:indexPath];
}

// 刷新当前cell 访问量加1
- (void)refreshCollectionCellDataByVisitCountIndexPath:(NSIndexPath*)indexPath{
    // 获取数据
    ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
    NSMutableArray* aList = spsa.activity_list;
    ScienceActivity* currentSa = [aList objectAtIndex:(indexPath.row)];
    int visitCount = [currentSa.visitors intValue] + 1;
    [currentSa setVisitors:[NSString stringWithFormat:@"%d",visitCount]];
    
    NSMutableArray* tempArray = [NSMutableArray new];
    for (int i=0; i<aList.count; i++) {
        ScienceActivity* sa = [aList objectAtIndex:i];
        if (i == indexPath.row) {
            [tempArray addObject:currentSa];
        }else{
            [tempArray addObject:sa];
        }
    }
    
    spsa.activity_list = tempArray;
    
    NSMutableArray* tempArray1 = [NSMutableArray new];
    for (int i=0; i<self.activity_list.count; i++) {
        ScienceActivity* spsa1 = [self.activity_list objectAtIndex:i];
        if (i == indexPath.row) {
            [tempArray1 addObject:spsa];
        }else{
            [tempArray1 addObject:spsa1];
        }
    }
    
    self.activity_list = tempArray1;
    // 刷新当前Cell数据
    [self.uiCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
}

#pragma mark - Deleate
- (void)clickSBtn:(ScienceActivity*)spsa SA:(ScienceActivity*)sa{
    [FlowUtil startToFourActivitySpecialDetailListVCNav:self.navigationController WithSpsa:spsa];
}

- (void)clickABtn:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath{
    [self forwardToDetailViewWithActivity:sa indexPath:indexPath];
}

@end
