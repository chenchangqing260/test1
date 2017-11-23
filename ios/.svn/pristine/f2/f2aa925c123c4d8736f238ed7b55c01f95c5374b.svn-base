//
//  SpecialDetailsNewViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/31.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialDetailsNewViewController.h"
#import "ChannelCollectionViewController.h"

#import "SpecialIndexBannerCollectionViewCell.h"
#import "SpecialPicAndWenCollectionViewCell.h"
#import "SpecialPicListCollectionViewCell.h"
#import "VedioCollectionViewCell.h"
#import "WenCollectionViewCell.h"
#import "TextUtil.h"

@interface SpecialDetailsNewViewController ()<SpecialIndexBannerCollectionViewCellCycleDelegate>

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* carousel_list; // 轮播图
@property (nonatomic, strong)NSMutableArray* rlist; // 轮播图
@property (nonatomic, strong)NSMutableArray* dataList; // 活动列表

@property (nonatomic, strong)UIImageView *loadImageView;
@property (nonatomic, strong)NSString* special_desc;
@property (nonatomic, strong)NSString* sepcial_image_url;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation SpecialDetailsNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题详情";
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
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 20);
    [rightNavBtn setTitle:@"分 享" forState:UIControlStateNormal];
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
    
    [[WebAccessManager sharedInstance]getSpecialItemListForSciencerBySpId:self.hm.ni_id page:self.page completion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                self.dataList = response.data.list;
                self.carousel_list = response.data.infoRrecList;
                self.special_desc = response.data.specialarticle.ni_desc;
                self.sepcial_image_url = response.data.specialarticle.ni_img_url;
                
                if (response.data.share_info) {
                    // 设置分享对象
                    self.shareModel = [ShareModel new];
                    self.shareModel.in_share_contentURL = response.data.share_info.share_url;
                    self.shareModel.in_share_imageURL  = response.data.share_info.share_image_url;
                    self.shareModel.in_share_title  = response.data.share_info.share_title;
                    self.shareModel.in_share_desc  = response.data.share_info.share_desc;
                }
                
               
                [self.uiCollectionView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [self.dataList addObjectsFromArray:[response.data.list copy]];
                    
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
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialIndexBannerCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialIndexBannerCollectionViewCell ID]];
    
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialPicAndWenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialPicAndWenCollectionViewCell ID]];
    
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialPicListCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialPicListCollectionViewCell ID]];
    
     [self.uiCollectionView registerNib:[UINib nibWithNibName:[VedioCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[VedioCollectionViewCell ID]];
    
    
     [self.uiCollectionView registerNib:[UINib nibWithNibName:[WenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[WenCollectionViewCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     if (self.carousel_list) {
         return self.dataList.count + 1;
     }else{
         return self.dataList.count;
     }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        SpecialIndexBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialIndexBannerCollectionViewCell ID] forIndexPath:indexPath];
        
        cell.delegate = self;
        
        if (self.carousel_list) {
            cell.cycleSAList = self.carousel_list;
        }
        
        [cell setCellData:self.special_desc image_url:self.sepcial_image_url cycleSAList:self.carousel_list];
        
        return cell;
    }else{
        
        HomeModel* sa=[self.dataList objectAtIndex:indexPath.row - 1];
        
        // 资讯
        if ([sa.ni_classify isEqualToString:@"0"]) {
            SpecialPicAndWenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialPicAndWenCollectionViewCell ID] forIndexPath:indexPath];
            [cell setCellWithScienceActivity:sa hmType:@"0"];
            
            return cell;
        }else if([sa.ni_classify isEqualToString:@"1"]){
            // 图集
            SpecialPicListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SpecialPicListCollectionViewCell ID] forIndexPath:indexPath];
            [cell setCellWithScienceActivity:sa hmType:@"0"];
            
             return cell;
        }else if([sa.ni_classify isEqualToString:@"2"]){
            // 视频
            VedioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[VedioCollectionViewCell ID]forIndexPath:indexPath];
            [cell setCellWithScienceActivity:sa showSpace:NO hmType:@"0"];
             return cell;
        }else{
            //文字资讯
            WenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                          [WenCollectionViewCell ID] forIndexPath:indexPath];
            [cell setCellWithScienceActivity:sa showSpace:NO hmType:@"0"];
            return cell;
        }
      
    }
    
    return  nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row != 0){
           [self forwardToDetailViewWithActivity:[self.dataList objectAtIndex:(indexPath.row -1)]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0 ) {
        if (self.carousel_list && self.carousel_list.count > 0) {
            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 340 / kWIDTH_375);
        }else{
            return CGSizeMake(kSCREEN_WIDTH, 90);
        }
    }else{
        HomeModel* h=[self.dataList objectAtIndex:indexPath.row - 1];
        
        // 资讯
        if([h.ni_classify isEqualToString:@"0"]){
            
            return CGSizeMake(kSCREEN_WIDTH, 104);
        }else if([h.ni_classify isEqualToString:@"1"]){
            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
            if(textHeight<30){
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (230-23) / kWIDTH_375 );
            }else{
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 230 / kWIDTH_375 );
            }
        }else if([h.ni_classify isEqualToString:@"2"]){
            CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
            if(textHeight<40){
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (307-21) / kWIDTH_375 );
            }else{
                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 307 / kWIDTH_375 );
            }
        }else{
            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 127 / kWIDTH_375 );
        }
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


- (void)forwardToDetailViewWithActivity:(HomeModel*)sa{
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

#pragma mark - ActivityBannerCellCycleDelegate
- (void)clickCycleWithImageURL:(HomeModel*)sa{
    [self forwardToDetailViewWithActivity:sa];
}

@end
