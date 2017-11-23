//
//  MainSearchViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/17.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#define dMainSearchRecord @"main_search_record"

#import "MainSearchViewController.h"
#import "ESearchTitleCell.h"
#import "ESearchContentCell.h"
#import "ESearchSpaceCell.h"
#import "HomeModel.h"
#import "PicTextInfoCollectionViewCell.h"
#import "TextUtil.h"
#import "PicAndWenCollectionViewCell.h"
#import "PicListCollectionViewCell.h"
#import "VedioCollectionViewCell.h"
#import "SpecialIIndexInfoCollectionViewCell.h"
#import "WenCollectionViewCell.h"

@interface MainSearchViewController ()<ESearchTtileDelegate>

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge;
//
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_collection;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_collection;

@property (weak, nonatomic) IBOutlet UITableView *uiSearchHisTableView;
@property (weak, nonatomic) IBOutlet UITextField *uiSearchTF;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (weak, nonatomic) IBOutlet UIView *uiNoResultView;

@property (nonatomic, strong)NSMutableArray* infoArray; // 资讯列表
@property (nonatomic, strong)NSArray* searchHisArray; // 搜索历史
@property (nonatomic, strong)NSArray* hotArray; // 热门搜索
@property NSInteger page;

@property BOOL showHisTableView;


@end

@implementation MainSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化界面数据
    [self initViewAndConAttribute];
    
    // 2、初始化历史记录表，并显示视图
    [self loadAndShowHisTableView];
    
    // 3、加载热门搜索
    [self loadHostSearch];
    
    // 4、初始化CollectionView
    [self initCollectionView];
}

#pragma mark - 重写父类方法
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    // 1、初始化界面元素,TextField加左视图
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 24, 16)];
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, 16, 16)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:imgView];
    self.uiSearchTF.leftView = leftView;
    self.uiSearchTF.leftViewMode = UITextFieldViewModeAlways;
    [self.uiSearchTF becomeFirstResponder];
    
    // 2、初始化数据
    self.infoArray = [NSMutableArray new];
    self.searchHisArray = [NSMutableArray new];
    self.hotArray = [NSMutableArray new];
    self.page = 1;
    self.uiNoResultView.hidden = YES;
}

#pragma mark - 历史记录处理
// 显示历史记录列表
- (void)loadAndShowHisTableView{
    // 1、获取搜索历史
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *searchRecordArray = [userDefaultes arrayForKey:dMainSearchRecord];
    if (searchRecordArray) {
        self.searchHisArray = searchRecordArray;
    }
    // 显示历史记录，并显示
    [self.uiSearchHisTableView reloadData];
    [self.uiContentView bringSubviewToFront:self.uiSearchHisTableView];
    [self.uiContentView sendSubviewToBack:self.uiTableView];
    self.showHisTableView = YES;
}


// 保存搜索记录
- (void)saveSearchRecord:(NSString *)keyword{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray *searchRecordArray = [NSMutableArray new];
    NSArray *search_record = (NSMutableArray *)[userDefaultes arrayForKey:dMainSearchRecord];
    if (search_record != nil) {
        searchRecordArray = [NSMutableArray arrayWithArray:search_record];
    }
    
    if (![keyword isEmptyOrWhitespace] && ![searchRecordArray containsObject:keyword]) {
        [searchRecordArray insertObject:keyword atIndex:0];
    }
    
    // 同步数据
    [userDefaultes setObject:[searchRecordArray copy] forKey:dMainSearchRecord];
    [userDefaultes synchronize];
}

#pragma mark - 网络加载数据
// 加载热门搜索
- (void)loadHostSearch{
    [[WebAccessManager sharedInstance]getHotSearchForInfoWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.hotArray =  [response.data.hotSearchList componentsSeparatedByString:@","];
            [self.uiSearchHisTableView reloadData];
            [self.view bringSubviewToFront:self.uiSearchHisTableView];
        }
    }];
}

// 搜索数据
- (void)searchInfoByKeyWord{
    
    if([self.uiSearchTF.text isEqualToString:@""]){
         [SVProgressHUDUtil showInfoWithStatus:@"查询数据不能为空！"];
        return;
    }
    
    
    self.showHisTableView = NO;
    [self.uiContentView sendSubviewToBack:self.uiSearchHisTableView];
    [self.uiContentView bringSubviewToFront:self.uiTableView];
    
    if (self.page == 1) {
        [SVProgressHUDUtil show];
    }
    
    [[WebAccessManager sharedInstance]searchInfoByKeywork:self.uiSearchTF.text page:self.page Completion:^(WebResponse *response, NSError *error) {
        [SVProgressHUDUtil dismiss];
        [self.uiCollectionView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _infoArray = response.data.searchList;
                if (_infoArray && _infoArray.count > 0) {
                    self.uiNoResultView.hidden = YES;
                    [self.uiCollectionView reloadData];
                }else{
                    self.uiNoResultView.hidden = NO;
                }
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_infoArray addObjectsFromArray:[response.data.searchList copy]];
                    
                    [self.uiCollectionView reloadData];
                }else{
                    // 没有数据了
                    self.page -= 1;
                }
            }
        }else{
            self.page -= 1;
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            self.uiNoResultView.hidden = NO;
        }
        
        if (self.page < 1) {
            self.page = 1;
        }
    }];
}

#pragma mark - 点击事件(包括手势和按钮点击)
- (IBAction)clickCanelBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (self.showHisTableView) {
        // 当前显示历史记录，点击取消，若查询记录为空，则点击返回则返回上一页，若有结果，则返回查询结果列表
        if (self.infoArray.count == 0) {
            // 返回
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            // 隐藏搜索记录，显示搜索结果
            [self.uiContentView sendSubviewToBack:self.uiSearchHisTableView];
            [self.uiContentView bringSubviewToFront:self.uiTableView];
            self.showHisTableView = NO;
        }
    }else{
        // 当前显示搜索结果，点击直接返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - TableView Delegate, DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 历史记录和热门搜索，若历史记录为空的话，就直接显示热门搜索，若历史记录不为空，则显示历史记录和热门搜索
    if (self.searchHisArray.count == 0) {
        return self.hotArray.count + 1; // 包含顶部的热门搜索一行
    }else{
        return self.searchHisArray.count + self.hotArray.count + 3; // 加的3个cell位顶部的历史搜索，中间的间隔，热门搜索。
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 查询历史
    if (self.searchHisArray.count == 0) {
        if (indexPath.row == 0) {
            // 标题
            ESearchTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchTitleCell ID]];
            if (!cell) {
                cell = [ESearchTitleCell newCell];
            }
            cell.uiTitleLab.text = @"热门搜索";
            cell.uiCleanHisBtn.hidden = YES;
            return cell;
        }else{
            // 内容
            ESearchContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchContentCell ID]];
            if (!cell) {
                cell = [ESearchContentCell newCell];
            }
            cell.conImageViewWidth.constant = 10;
            cell.conTitleLeftSpace.constant = 5;
            if (indexPath.row == 1) {
                cell.uiImageView.image = [UIImage imageNamed:@"红火"];
            }else if(indexPath.row == 2){
                cell.uiImageView.image = [UIImage imageNamed:@"橘火"];
            }else if(indexPath.row == 3){
                cell.uiImageView.image = [UIImage imageNamed:@"黄火"];
            }else{
                cell.uiImageView.image = [UIImage imageNamed:@"灰火"];
            }
            cell.uiContentLab.text = [_hotArray objectAtIndex:(indexPath.row - 1)];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            // 标题
            ESearchTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchTitleCell ID]];
            if (!cell) {
                cell = [ESearchTitleCell newCell];
            }
            cell.uiTitleLab.text = @"历史记录";
            cell.delegate = self;
            cell.uiCleanHisBtn.hidden = NO;
            return cell;
        }else if(indexPath.row == self.searchHisArray.count + 1){
            ESearchSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchSpaceCell ID]];
            if (!cell) {
                cell = [ESearchSpaceCell newCell];
            }
            return cell;
        }else if(indexPath.row == self.searchHisArray.count + 2){
            ESearchTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchTitleCell ID]];
            if (!cell) {
                cell = [ESearchTitleCell newCell];
            }
            cell.uiTitleLab.text = @"热门搜索";
            cell.uiCleanHisBtn.hidden = YES;
            return cell;
        }else{
            // 内容
            ESearchContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ESearchContentCell ID]];
            if (!cell) {
                cell = [ESearchContentCell newCell];
            }
            if (indexPath.row <= self.searchHisArray.count) {
                // 历史记录
                cell.conImageViewWidth.constant = 0;
                cell.conTitleLeftSpace.constant = 0;
                cell.uiContentLab.text = [_searchHisArray objectAtIndex:(indexPath.row - 1)];
            }else{
                // 热门搜索
                NSInteger index = indexPath.row - 3 - self.searchHisArray.count;
                cell.uiContentLab.text = [_hotArray objectAtIndex:index];
                cell.conImageViewWidth.constant = 10;
                cell.conTitleLeftSpace.constant = 5;
                if (index == 0) {
                    cell.uiImageView.image = [UIImage imageNamed:@"红火"];
                }else if(index == 1){
                    cell.uiImageView.image = [UIImage imageNamed:@"橘火"];
                }else if(index == 2){
                    cell.uiImageView.image = [UIImage imageNamed:@"黄火"];
                }else{
                    cell.uiImageView.image = [UIImage imageNamed:@"灰火"];
                }
            }
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 除了热门搜索框，历史搜索框，中间间隔框，其他都可以点击
    if (self.searchHisArray.count == 0) {
        if (indexPath.row != 0){
            // 内容
            NSString* text = [_hotArray objectAtIndex:(indexPath.row - 1)];
            self.uiSearchTF.text = text;
            [self textFieldShouldReturn:self.uiSearchTF];
        }
    }else{
        if (indexPath.row != 0 && indexPath.row != self.searchHisArray.count + 1 && indexPath.row != self.searchHisArray.count + 2){
            if (indexPath.row <= self.searchHisArray.count) {
                // 历史记录
                NSString* text = [_searchHisArray objectAtIndex:(indexPath.row - 1)];
                self.uiSearchTF.text = text;
                [self textFieldShouldReturn:self.uiSearchTF];
            }else{
                // 热门搜索
                NSString* text = [_hotArray objectAtIndex:(indexPath.row - 3 - self.searchHisArray.count)];
                self.uiSearchTF.text = text;
                [self textFieldShouldReturn:self.uiSearchTF];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchHisArray.count != 0 && indexPath.row == self.searchHisArray.count + 1) {
        return 10;
    }
    return 40;
}

#pragma mark - UICollectionView DataSource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    //    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicTextInfoCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicTextInfoCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicAndWenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicAndWenCollectionViewCell ID]];
    
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[PicListCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicListCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[VedioCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[VedioCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[SpecialIIndexInfoCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[SpecialIIndexInfoCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[WenCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[WenCollectionViewCell ID]];
    
    
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
    //    if ([indexPath section] < _infoArray.count) {
    //        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
    //        PicTextInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PicTextInfoCollectionViewCell ID] forIndexPath:indexPath];
    //        [cell initCellData:model];
    //        //        //set offset accordingly
    //        //        CGFloat yOffset = ((self.uiCollectionView.contentOffset.y - cell.frame.origin.y) / kSCREEN_WIDTH / kWIDTH_375 * 212) * IMAGE_OFFSET_SPEED;
    //        //        cell.imageOffset = CGPointMake(0.0f, yOffset);
    //        return cell;
    //    }
    //
    //    return  nil;
    //资讯列表
    if ([indexPath section] < _infoArray.count) {
        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
        // 以下都是资讯
        if([model.in_classify isEqualToString:@"0"]){
            //图片资讯
            PicAndWenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:[PicAndWenCollectionViewCell ID] forIndexPath:indexPath];
            
            [cell setCellWithScienceActivity:model showSpace:NO  zhuanti:NO hmType:@"1"];
            return cell;
            
            //                }
        }else  if([model.in_classify isEqualToString:@"1"]){
            //图集资讯
            PicListCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                              [PicListCollectionViewCell ID] forIndexPath:indexPath];
            [cell setCellWithScienceActivity:model showSpace:NO hmType:@"1"];
            return cell;
        }else  if([model.in_classify isEqualToString:@"2"]){
            //视频资讯
            VedioCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                            [VedioCollectionViewCell ID] forIndexPath:indexPath];
            
            
            [cell setCellWithScienceActivity:model showSpace:NO hmType:@"1"];
            return cell;
        }else  if([model.in_classify isEqualToString:@"3"]){
            
            //专题资讯
            SpecialIIndexInfoCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                                        [SpecialIIndexInfoCollectionViewCell ID] forIndexPath:indexPath];
            
            [cell setCellWithScienceSpecial:model showSpace:NO];
            return cell;
            
        }else{
            //文字资讯
            WenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:
                                          [WenCollectionViewCell ID] forIndexPath:indexPath];
            [cell setCellWithScienceActivity:model showSpace:NO hmType:@"1"];
            
            return cell;
        }
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
        
        //浏览文章时进行数据统计
        [BDIDataStatistics onVisitWithModel:model];
        [BDIDataStatistics additemWithModel:model];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    // 计算高度
    //    if ([indexPath section] < _infoArray.count) {
    //        HomeModel* model = [_infoArray objectAtIndex:[indexPath section]];
    //
    //        // 1、原来高度(6S，两行文字，高度为32)
    //        CGFloat height = 145;
    //        if (kSCREEN_WIDTH < kWIDTH_375) {
    //            height = 155;
    //        }
    //
    //        if (![model.in_classify isEqualToString:@"4"]) {
    //            if (isIpad) {
    //                height += MAIN_SCREEN_WIDTH_ONIpad / kWIDTH_375 * 212;
    //            } else {
    //                height += kSCREEN_WIDTH / kWIDTH_375 * 212;
    //            }
    //
    //        }
    //
    //        // 2、根据文字高度自动调整
    //        CGFloat textHeight = 0;
    //
    //        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //        NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    //        if (!fontSize) {
    //            fontSize = @"Normal";
    //            [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
    //            [settings synchronize];
    //        }
    //
    //        if (isIpad) {
    //            if ([fontSize isEqualToString:@"Small"]){
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(MAIN_SCREEN_WIDTH_ONIpad - 30, 0) Font:FONT_12].height;
    //            }else if([fontSize isEqualToString:@"Large"]){
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(MAIN_SCREEN_WIDTH_ONIpad - 30, 0) Font:FONT_16].height;
    //            }else{
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(MAIN_SCREEN_WIDTH_ONIpad - 30, 0) Font:FONT_13].height;
    //            }
    //        } else {
    //            if ([fontSize isEqualToString:@"Small"]){
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_12].height;
    //            }else if([fontSize isEqualToString:@"Large"]){
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_16].height;
    //            }else{
    //                textHeight = [TextUtil boundingRectWithText:model.in_desc size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_13].height;
    //            }
    //        }
    //
    //        // 16 为一行的高度
    //        if (textHeight < 16) {
    //            textHeight = 16;
    //        }else{
    //            textHeight = 32;
    //        }
    //
    //        height = height - 32 + textHeight;
    //
    //        // 3、由于5S以下title上下间隔由18变为13，所以5S以下需要减去10;
    //        if (kSCREEN_WIDTH < kWIDTH_375) {
    //            height = height - 15;
    //        }
    //
    //        return CGSizeMake(kSCREEN_WIDTH, height);
    //    }else{
    //        return CGSizeMake(0, 0);
    //    }
    if ([indexPath section] < _infoArray.count) {
        HomeModel* h = [_infoArray objectAtIndex:[indexPath section]];
       
                if([h.in_classify isEqualToString:@"0"]){
                    //                         CGFloat textHeight = [TextUtil boundingRectWithText:h.ni_title size:CGSizeMake(kSCREEN_WIDTH - 159, 0) Font:FONT_18].height;
                    //
                    //                        if(textHeight<50){
                    //                            return CGSizeMake(kSCREEN_WIDTH, 134-11 );
                    //                        }else{
                    //                            return CGSizeMake(kSCREEN_WIDTH, 134);
                    //                        }
                    return CGSizeMake(kSCREEN_WIDTH, 134);
                }else if([h.in_classify isEqualToString:@"1"]){
                    CGFloat textHeight = [TextUtil boundingRectWithText:h.in_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                    if(textHeight<30){
                        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (182-22) / kWIDTH_375 );
                    }else{
                        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 182 / kWIDTH_375 );
                    }
                }else if([h.in_classify isEqualToString:@"2"]){
                    CGFloat textHeight = [TextUtil boundingRectWithText:h.in_title size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_18].height;
                    if(textHeight<40){
                        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * (307-21) / kWIDTH_375 );
                    }else{
                        return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 307 / kWIDTH_375 );
                    }
                }else if([h.in_classify isEqualToString:@"3"]){
                    //                        if([h.ni_show_mode isEqualToString:@"01"]){
                    //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 94 / kWIDTH_375 );
                    //                        }else{
                    //                            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 270 / kWIDTH_375 );
                    //                        }
                    return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 270 / kWIDTH_375 );
                }else{
                    return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 127 / kWIDTH_375 );
                }


        
//        if([model.in_classify isEqualToString:@"0"]){
//            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 104 / kWIDTH_375 );
//        }else if([model.in_classify isEqualToString:@"1"]){
//            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 181 / kWIDTH_375 );
//        }else if([model.in_classify isEqualToString:@"2"]){
//            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 287 / kWIDTH_375 );
//        }else if([model.in_classify isEqualToString:@"3"]){
//            if([model.ni_show_mode isEqualToString:@"01"]){
//                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 104 / kWIDTH_375 );
//            }else{
//                return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 280 / kWIDTH_375 );
//            }
//
//        }else{
//            return CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH * 117 / kWIDTH_375 );
//        }
    }else{
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kSCREEN_WIDTH, 15);
}

- (void)collectionViewRefreshFooterData{
    self.page += 1;
    [self searchInfoByKeyWord];
}

#pragma mark - MJRefresh
-(BOOL)showMJHeader{
    return NO;
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    // 1、保存搜索历史记录
    [self saveSearchRecord:self.uiSearchTF.text];
    
    // 2、查询数据
    self.page = 1;
    [self searchInfoByKeyWord];
    
    return YES;
}

// 获取焦点
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self loadAndShowHisTableView];
}

#pragma mark - ESearchTtileDelegate
- (void)clickCleanHisBtn{
    // 清空历史记录
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray *keywords = [NSMutableArray array];
    [userDefaultes setObject:[keywords copy] forKey:dMainSearchRecord];
    [userDefaultes synchronize];
    
    // 刷新视图
    [self loadAndShowHisTableView];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    [self.view endEditing:YES];
}

@end
