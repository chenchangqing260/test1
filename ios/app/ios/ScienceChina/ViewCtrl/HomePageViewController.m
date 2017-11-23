//
//  HomePageViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HomePageViewController.h"
#import "PicTextInfoCollectionViewCell.h"
#import "HomeModel.h"
#import "TextUtil.h"
#import "PicturesDetailViewController.h"

@interface HomePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray* infoArray;
@property (nonatomic, strong)NSMutableArray* usePageArray;
@property (nonatomic, assign)NSInteger page;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化
    [self initAttributeAndVariable];
    [self initCollectionView];
    
    // 2、加载网络数据
    [self loadeData];
    
    // 3、检查是否要显示版本更新
    [UpdateVersionUtil checkVersion];
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return YES;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

#pragma mark - 网络数据加载
-(void)loadeData{
    // 第一次刷新把已经处理的页数删除
    if (self.page == 1) {
        [_usePageArray removeAllObjects];
    }
    
    // 将已经显示的页数封装
    NSString* usePage = @"";
    for (int i=0; i<_usePageArray.count; i++) {
        usePage = [usePage stringByAppendingString:[_usePageArray objectAtIndex:i]];
        if (i < _usePageArray.count - 1) {
            usePage = [usePage stringByAppendingString:@","];
        }
    }
    
    [[WebAccessManager sharedInstance]getHomeInfoListWithPage:_page usePage:usePage completion:^(WebResponse *response, NSError *error) {
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
            [self.usePageArray addObjectsFromArray:[[response.data.usePage componentsSeparatedByString:@","] mutableCopy]];
            
            if (self.page == 1) {
                _infoArray = response.data.list;
                [self.uiCollectionView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_infoArray addObjectsFromArray:[response.data.list copy]];
                    
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

#pragma mark - 初始化数据和变量
- (void)initAttributeAndVariable{
    _page = 1;
    _infoArray = [NSMutableArray new];
    _usePageArray = [NSMutableArray new];
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicTextInfoCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicTextInfoCollectionViewCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _infoArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] < _infoArray.count) {
        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
        PicTextInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PicTextInfoCollectionViewCell ID] forIndexPath:indexPath];
        [cell initCellData:model];
//        //set offset accordingly
//        CGFloat yOffset = ((self.uiCollectionView.contentOffset.y - cell.frame.origin.y) / kSCREEN_WIDTH / kWIDTH_375 * 212) * IMAGE_OFFSET_SPEED;
//        cell.imageOffset = CGPointMake(0.0f, yOffset);
        return cell;
    }
    
    return  nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _infoArray.count) {
        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
        
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 计算高度
    if ([indexPath section] < _infoArray.count) {
        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
        
        // 1、原来高度(6S，两行文字，高度为32)
        CGFloat height = 145;
        if (kSCREEN_WIDTH < kWIDTH_375) {
            height = 155;
        }
        
        if (![model.in_classify isEqualToString:@"4"]) {
            height += kSCREEN_WIDTH / kWIDTH_375 * 212;
        }
        
        // 2、根据文字高度自动调整
        CGFloat textHeight = 0;

        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
        if (!fontSize) {
            fontSize = @"Normal";
            [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
            [settings synchronize];
        }
        if ([fontSize isEqualToString:@"Small"]) {
             textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_12].height;
        }else if([fontSize isEqualToString:@"Large"]) {
             textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_16].height;
        }else{
             textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_13].height;
        }
       
        // 16 为一行的高度
        if (textHeight < 16) {
            textHeight = 16;
        }else{
            textHeight = 32;
        }
        
        height = height - 32 + textHeight;
        
        // 3、由于5S以下title上下间隔由18变为13，所以5S以下需要减去10;
        if (kSCREEN_WIDTH < kWIDTH_375) {
            height = height - 15;
        }
        
        return CGSizeMake(kSCREEN_WIDTH, height);
    }else{
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kSCREEN_WIDTH, 15);
}

- (void)collectionViewRefreshHeaderData{
    _page = 1;
    [self loadeData];
}

- (void)collectionViewRefreshFooterData{
    _page += 1;
    [self loadeData];
}

//#pragma mark - UIScrollViewdelegate methods
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    for(PicTextInfoCollectionViewCell *view in self.uiCollectionView.visibleCells) {
//        CGFloat yOffset = ((self.uiCollectionView.contentOffset.y - view.frame.origin.y) / kSCREEN_WIDTH / kWIDTH_375 * 212) * IMAGE_OFFSET_SPEED;
//        view.imageOffset = CGPointMake(0.0f, yOffset);
//    }
//}

@end
