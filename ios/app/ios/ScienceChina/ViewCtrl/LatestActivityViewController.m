//
//  LatestActivityViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "LatestActivityViewController.h"
#import "LatestAndHotAcitivityCollectionCell.h"
#import "CollectionDetailWebViewController.h"
#import "HotAcitivityCollectionCell.h"
#import "TextUtil.h"

@interface LatestActivityViewController ()

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* activity_list; // 数据

@property (nonatomic, strong)UIImageView *loadImageView;

@end

@implementation LatestActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isHot) {
        self.title = @"热门互动";
    }else{
        self.title = @"最新活动";
    }
    
    // 1、初始化数据
    [self initData];
    [self setupLoadingView];
    
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
    if (_isHot) {
        [[WebAccessManager sharedInstance]getInteractiveActivityListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
            self.uiCollectionView.hidden=NO;
            self.loadImageView.hidden=YES;
            [self.uiCollectionView.mj_footer endRefreshing];
            [self.uiCollectionView.mj_header endRefreshing];
            
            if (response.success) {
                if (self.page == 1) {
                    self.activity_list = response.data.activity_list;
                    
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
        
    }else{
        [[WebAccessManager sharedInstance]fourthGetActivityLatestWithPage:self.page completion:^(WebResponse *response, NSError *error) {
            self.uiCollectionView.hidden=NO;
            self.loadImageView.hidden=YES;
            [self.uiCollectionView.mj_footer endRefreshing];
            [self.uiCollectionView.mj_header endRefreshing];
            
            if (response.success) {
                if (self.page == 1) {
                    self.activity_list = response.data.activity_list;
                    
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
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[LatestAndHotAcitivityCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[LatestAndHotAcitivityCollectionCell ID]];
     [self.uiCollectionView registerNib:[UINib nibWithNibName:[HotAcitivityCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[HotAcitivityCollectionCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.activity_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 判断有没有强力推荐
    if ([indexPath row] < self.activity_list.count) {
         if (_isHot) {
             HotAcitivityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HotAcitivityCollectionCell ID] forIndexPath:indexPath];
             
             ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
             [cell setCellWithScienceActivity:sa];
             return cell;
         }else{
             LatestAndHotAcitivityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LatestAndHotAcitivityCollectionCell ID] forIndexPath:indexPath];
             
             ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
             [cell setCellWithScienceActivity:sa];
             return cell;
         }

    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
    [self forwardToDetailViewWithActivity:sa];
    //[self refreshCollectionCellDataByVisitCountIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
     if (_isHot) {
         ScienceActivity* sa=[self.activity_list objectAtIndex:indexPath.row];
         
         CGFloat textHeight = [TextUtil boundingRectWithText:sa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
         if(textHeight<40){
             return CGSizeMake(kSCREEN_WIDTH,kSCREEN_WIDTH * (260-23) / kWIDTH_375);
         }else{
             return CGSizeMake(kSCREEN_WIDTH,kSCREEN_WIDTH * 260 / kWIDTH_375);
         }
     }else{
             return CGSizeMake(kSCREEN_WIDTH, 186);
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

#pragma mark - 工具类
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
                    
                    webVC.titleStr = sa.title;
                    webVC.shareModel = shareModel;
                    webVC.av_id_Str = sa.av_id;
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
                webVC.shareModel = shareModel;
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC loadWebWithUrl:response.data.av_url];
            }else{
                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

// 刷新当前cell 访问量加1
- (void)refreshCollectionCellDataByVisitCountIndexPath:(NSIndexPath*)indexPath{
    // 获取数据
    ScienceActivity* currentSa = [self.activity_list objectAtIndex:(indexPath.row)];
    int visitCount = [currentSa.visitors intValue] + 1;
    [currentSa setVisitors:[NSString stringWithFormat:@"%d",visitCount]];
    
    NSMutableArray* tempArray = [NSMutableArray new];
    for (int i=0; i<self.activity_list.count; i++) {
        ScienceActivity* sa = [self.activity_list objectAtIndex:i];
        if (i == indexPath.row) {
            [tempArray addObject:currentSa];
        }else{
            [tempArray addObject:sa];
        }
    }
    
    self.activity_list = tempArray;
    
    // 刷新当前Cell数据
    [self.uiCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
}
@end
