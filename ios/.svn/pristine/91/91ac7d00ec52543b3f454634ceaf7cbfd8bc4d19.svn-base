//
//  InteractionAndLocalActivityViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "InteractionAndLocalActivityViewController.h"
//#import "InteractionAndLocalActivityViewCell.h"
#import "ScienceActivity.h"
#import "CollectionDetailWebViewController.h"

#import "ActivityNormalNewCollectionCell.h"

#import "YJShowAreaoverController.h"
#import "YJ_const.h"
#import "TextUtil.h"
#import "AreaAlertViewController.h"

#define COLOR_ITEM          [UIColor whiteColor]
#define COLOR_ITEM_SELECTED [UIColor yellowColor]
#define COLOR_BACKGROUND    [UIColor darkGrayColor]

@interface InteractionAndLocalActivityViewController ()<AreaAlertViewControllerDelegate>
{
    UITableView *_tableView;
    UILabel *_currentMonthLabel;
    UILabel *_rightLabel;
    YJShowAreaoverController *popController;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *UILoadImage;
@property (weak, nonatomic) IBOutlet UILabel *UILoadLable;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* activity_list; // 数据

@property (nonatomic, strong)UIImageView *loadImageView;
@property (nonatomic, assign)NSString * region_code;
@end

@implementation InteractionAndLocalActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地方活动";
    
    // 1、初始化数据
    [self initData];
    [self setupLoadingView];
    [self setupView];
    
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
    self.region_code = @"0";
    [self.UILoadImage setHidden:YES];
    [self.UILoadLable setHidden:YES];
}

-(void)setupView{
    
//    CGFloat btnH = 44.0;
//    CGFloat imgW = 23.0;
//    CGFloat imgH = 23.0;
//    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, btnH)];
//    _rightLabel.font = FONT_15;
//    _rightLabel.text = @"活动地区";
//    _rightLabel.textColor = [UIColor whiteColor];
//    _rightLabel.textAlignment = NSTextAlignmentLeft;
    
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(_rightLabel.frame.size.width+10, (btnH-imgH)/2.0, imgW, imgW)];
//
//    CGFloat monthW = 35.0;
//    CGFloat monthH = 20.0;
//    _currentMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 2, monthW, monthH)];
//    _currentMonthLabel.font = FONT_15;
//    _currentMonthLabel.text = @"全国";
//    _currentMonthLabel.textColor = [UIColor whiteColor];
//    _currentMonthLabel.textAlignment = NSTextAlignmentCenter;
//    [_currentMonthLabel.layer setMasksToBounds:YES];
//    [_currentMonthLabel.layer setCornerRadius:2.0];
//    [_currentMonthLabel.layer setBorderWidth:1.0];
//    [_currentMonthLabel.layer  setBorderColor: RGBCOLOR(54.0, 205.0, 224.0).CGColor];
//
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, rightView.frame.origin.x+rightView.frame.size.width, btnH);
//    [rightButton addTarget:self action:@selector(tapRight:) forControlEvents:UIControlEventTouchUpInside];
    
//    [rightButton addSubview:_rightLabel];
//    [rightButton addSubview:rightView];
//    [rightView addSubview:_currentMonthLabel];
    
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    CGFloat btnH = 35.0;
    CGFloat imgW = 10.0;
    CGFloat imgH = 5.0;
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, btnH)];
    _rightLabel.font = FONT_15;
    _rightLabel.text = @"全国";
    _rightLabel.textColor = [UIColor whiteColor];
    _rightLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_rightLabel.frame.size.width+2, (btnH-imgH)/2.0, imgW, imgH)];
    rightImageView.image = [UIImage imageNamed:@"downmenu"];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, rightImageView.frame.origin.x+rightImageView.frame.size.width, btnH);
    [rightButton addTarget:self action:@selector(tapRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton addSubview:_rightLabel];
    [rightButton addSubview:rightImageView];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSArray *)menuTitles
{
    return @[@"全国", @"北京", @"杭州", @"重庆", @"苏州", @"四川",@"全国", @"北京", @"杭州", @"重庆", @"苏州", @"四川"];
}

- (void)tapRight:(UIButton *)sender
{
//    ShowAreaAlertViewController *contentController = [[ShowAreaAlertViewController alloc] init];
//    [contentController.view setFrame:CGRectMake(12, 20, 200, 200)];
    
    AreaAlertViewController *contentController = [[AreaAlertViewController alloc] init];
        [contentController.view setFrame:CGRectMake(0, 0, 150, 150)];
    contentController.delegate = self;
    contentController.select_id = _region_code;
    
    popController = [[YJShowAreaoverController alloc] initWithContentViewController:contentController popoverContentSize:CGSizeMake(150, 150)];
    popController.view.layer.cornerRadius = 5;
    popController.view.layer.masksToBounds = YES;
    [popController presentPopoverFromRect:sender.frame inView:sender.superview permitterArrowDirections:YJPopoverArrowDirection_up animated:YES];
    
//    AreaAlertViewController * transparentVC = [[AreaAlertViewController alloc] initWithNibName:@"AreaAlertViewController" bundle:nil];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//        transparentVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//    }else{
//        self.modalPresentationStyle=UIModalPresentationOverFullScreen;
//    }
//    [self presentViewController:transparentVC animated:YES completion:nil];

}
//- (void)tapRight:(UIButton *)sender
//{
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    for (int i = 0; i < self.menuTitles.count; i++)
//    {
//        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.menuTitles[i]
//                                                                   titleColor:COLOR_ITEM
//                                                                selectedTitle:self.menuTitles[i]
//                                                           selectedTitleColor:COLOR_ITEM_SELECTED
//                                                                         icon:nil
//                                                                 selectedIcon:nil];
//        [items addObject:popMenuItem];
//    }
//
//    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithDelegate:self superView:self.navigationController.view popMenus:[items copy]];
//    [popMenu setMode:JinnPopMenuModeSegmentedControl];
//    [popMenu setShouldHideWhenBackgroundTapped:YES];
//    [popMenu setShouldHideWhenItemSelected:YES];
//    [popMenu setMaxItemNumEachLine:2];
//    //    [popMenu show];
//
//    [popMenu setOffset:-250];
//    [popMenu setX_offset:130];
//    [popMenu setShowAnimation:JinnPopMenuAnimationFade];
//    [popMenu setDismissAnimation:JinnPopMenuAnimationFade];
//    [popMenu setBezelStyle:JinnPopMenuStyleBlur];
//    [popMenu setMargin:CGPointMake(5, 5)];
//    [popMenu setShouldHideWhenBackgroundTapped:YES];
//    [popMenu show];
//    [popMenu selectItemAtIndex:0];
//    [popMenu.backgroundView setBackgroundColor:[UIColor clearColor]];
//    [popMenu.bezelView.layer setCornerRadius:10];
//}

-(void)clickBtn:(Area *)sa{
    
    [self initData];
    
    _rightLabel.text = sa.region_name;
    _region_code = sa.region_code;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [popController closeAllView];
    });
    

    [self loadeData];
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
    [[WebAccessManager sharedInstance]getRegionActivityListWithPage:self.page region_code:_region_code completion:^(WebResponse *response, NSError *error) {
        self.uiCollectionView.hidden=NO;
        self.loadImageView.hidden=YES;
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            
            if (self.page == 1) {
                
                if (response.data.activity_list.count == 0) {
                    [self.UILoadImage setHidden:NO];
                    [self.UILoadLable setHidden:NO];
                    self.uiCollectionView.hidden=YES;
                }
                
                    self.activity_list = response.data.activity_list;
                    
                    [self.uiCollectionView reloadData];
 
            }else{
                if (response.data.activity_list.count > 0) {
                    
                    [self.activity_list addObjectsFromArray:[response.data.activity_list copy]];
                    
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
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[ActivityNormalNewCollectionCell ID] bundle:nil] forCellWithReuseIdentifier:[ActivityNormalNewCollectionCell ID]];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return self.activity_list.count;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.activity_list.count;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    // 判断有没有强力推荐
//    if ([indexPath section] < self.activity_list.count) {
        ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
        
        ActivityNormalNewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ActivityNormalNewCollectionCell ID] forIndexPath:indexPath];
        
        [cell setCellWithScienceActivity:spsa];
//    }
    return cell;
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 点击专题和更多，跳转专题列表，其他跳转相应的
    
    ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
    
    [self forwardToDetailViewWithActivity:sa];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScienceActivity* sa = [self.activity_list objectAtIndex:indexPath.row];
    
    CGFloat textHeight = [TextUtil boundingRectWithText:sa.title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
    if(textHeight<40){
        return CGSizeMake(kSCREEN_WIDTH,kSCREEN_WIDTH * (260-23) / kWIDTH_375);
    }else{
        return CGSizeMake(kSCREEN_WIDTH,kSCREEN_WIDTH * 260 / kWIDTH_375);
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
            [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController toRegister:NO isShowAlertYinDao:NO  completion:nil];
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

#pragma mark - Deleate
- (void)clickSBtn:(ScienceActivity*)spsa SA:(ScienceActivity*)sa{
    [FlowUtil startToFourActivitySpecialDetailListVCNav:self.navigationController WithSpsa:spsa];
}

- (void)clickABtn:(ScienceActivity*)sa indexPath:(NSIndexPath*)indexPath{
    [self forwardToDetailViewWithActivity:sa];
}

#pragma mark - JinnPopMenuDelegate

//- (void)popMenu:(JinnPopMenu *)popMenu didSelectAtIndex:(NSInteger)index
//{
//    NSLog(@"Item (%d) did select!", (int)index);
//    _currentMonthLabel.text = [self.menuTitles objectAtIndex:(int)index];
//}

@end
