//
//  MyActivityListViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/25.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MyActivityListViewController.h"
#import "MyActivityCollectionCell.h"
#import "CollectionDetailWebViewController.h"
#import "ActivityNewViewController.h"

@interface MyActivityListViewController ()

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* activity_list; // 数据
@property (weak, nonatomic) IBOutlet UILabel *UITiShi;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn;

@property (nonatomic, strong)UIImageView *loadImageView;

@property (weak, nonatomic) IBOutlet UIImageView *UILoadImage;

@end

@implementation MyActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的活动";
    // 1、初始化数据
    [self initData];
//    [self setupLoadingView];
    
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
    //隐藏提示去报名
    self.UITiShi.hidden = YES;
    self.UIBtn.hidden = YES;
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
    [[WebAccessManager sharedInstance]fourthV2MyActivityListWithPage:self.page ompletion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                self.activity_list = response.data.activity_list;
                
//                if(self.activity_list&&self.activity_list.count>0){
//                    //隐藏提示去报名
//                    self.UITiShi.hidden = YES;
//                    self.UIBtn.hidden = YES;
//                    self.UILoadImage.hidden = YES;
//                    //刷新view
//                    [self.uiCollectionView reloadData];
//                }else{
                    //显示提示去报名
                    //隐藏view
                    self.uiCollectionView.hidden =YES;
                    self.UITiShi.hidden = NO;
                    self.UIBtn.hidden = NO;
                    [self.UIBtn.layer setMasksToBounds:YES];
                    [self.UIBtn.layer setCornerRadius:4.0];
//                    [self.UIBtn.layer setBorderWidth:1.0];
//                    [self.UIBtn.layer  setBorderColor: RGBCOLOR(57.0, 61.0, 64.0).CGColor];
//                }
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
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[MyActivityCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[MyActivityCollectionCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.activity_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 判断有没有强力推荐
    if ([indexPath row] < self.activity_list.count) {
        MyActivityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MyActivityCollectionCell ID] forIndexPath:indexPath];
        
        ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
        [cell setCellDataWithActivity:sa];
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
    [self forwardToDetailViewWithActivity:sa];
    //[self refreshCollectionCellDataByVisitCountIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kSCREEN_WIDTH, 111);
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
    [[WebAccessManager sharedInstance]fourthV2MyActivityDetailWithAv_id:sa.av_id completion:^(WebResponse *response, NSError *error) {
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

- (IBAction)UIBtnClick:(id)sender {
     [self.navigationController pushViewController:[ActivityNewViewController new] animated:YES];
}

@end
