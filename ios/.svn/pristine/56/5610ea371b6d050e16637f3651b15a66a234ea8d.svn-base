

//
//  SpecifyCategoryViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "SpecifyCategoryViewController.h"
#import "A_AdvancedVibrancyView.h"
#import "MRFlipTransition.h"
#import "CategoryCollectionViewCell.h"
#import "XHTwitterPaggingViewer.h"
#import "SubCategoryViewController.h"

@interface SpecifyCategoryViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *uiCategoryCollectionView;
@property (nonatomic, strong)NSMutableArray* categoryArray;
@property (weak, nonatomic) IBOutlet UIView *uiGuideView;

@end

@implementation SpecifyCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    _categoryArray = [NSMutableArray new];
    
    [self initCollectionView];
    
    // 2、加载数据
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* collectArray = nil;
    if ([MemberManager sharedInstance].isLogined) {
        collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
    }else{
        collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategory];
    }
    [collectArray enumerateObjectsUsingBlock:^(NSString *categoryStr, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* strArray = [categoryStr componentsSeparatedByString:@"~-"];
        InfoCategory* category = [InfoCategory new];
        category.at_id = strArray[0];
        if (strArray[1]) {
            category.at_name_ch = strArray[1];
        }
        if (strArray[2]) {
            category.at_img_url = strArray[2];
        }
        if (strArray[3]) {
            category.at_type = strArray[3];
        }
        
        [_categoryArray addObject:category];
    }];
    [self.uiCategoryCollectionView reloadData];
    
    NSUserDefaults* setting = [NSUserDefaults standardUserDefaults];
    NSString* categoryguide = [setting objectForKey:@"specCategoryGuide"];
    if (categoryguide) {
        [self.uiGuideView removeFromSuperview];
    }else{
        [setting setObject:@"show" forKey:@"specCategoryGuide"];
        [setting synchronize];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(MRFlipTransition *)self.navigationController.transitioningDelegate updateContentSnapshot:self.view afterScreenUpdate:YES];
}


#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 点击事件，手势
- (IBAction)clickCloseView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initCollectionView{
    [self.uiCategoryCollectionView registerNib:[UINib nibWithNibName:[CategoryCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[CategoryCollectionViewCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoryArray.count;
}

- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(5.f, 0, 5.f, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section
{
    return CGSizeMake(0, 0); //same as default !
}

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(50.f, 0, 50.f, 0); //Sorry, horizontal scroll is not supported now.
}

- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(64.f, 0, 0, 0);
}

- (CGFloat)reorderingItemAlpha:(UICollectionView *)collectionview
{
    return .3f;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.uiCategoryCollectionView reloadData];
    // 加入定制数组
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    //NSArray* collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategory];
    
    NSMutableArray* tempArray = [NSMutableArray new];
    for (InfoCategory* category in self.categoryArray) {
        NSString* categoryStr = [NSString stringWithFormat:@"%@~-%@~-%@~-%@",category.at_id, category.at_name_ch, category.at_img_url, category.at_type];
        [tempArray addObject:categoryStr];
    }
    
    // 网络数据和本地数据不一致，则进行数据同步
    if ([MemberManager sharedInstance].isLogined) {
        [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
    }else{
        [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategory];
    }
    
    [defaults synchronize];
    
    // 刷新首页数据
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_RELOADHOMEPAGE object:nil];
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    InfoCategory *category = [_categoryArray objectAtIndex:fromIndexPath.item];
    [_categoryArray removeObjectAtIndex:fromIndexPath.item];
    [_categoryArray insertObject:category atIndex:toIndexPath.item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [self.uiCategoryCollectionView dequeueReusableCellWithReuseIdentifier:[CategoryCollectionViewCell ID] forIndexPath:indexPath];
    //[cell.uiImageView removeFromSuperview];
    //    cell.uiImageView.backgroundColor = [UIColor redColor];
    //    cell.backgroundColor = [UIColor greenColor];
    //cell.uiImageView.frame = cell.bounds;
    InfoCategory *category = [_categoryArray objectAtIndex:indexPath.item];
    [cell.uiImageView sd_setImageWithURL:[NSURL URLWithString:category.at_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [cell.uiImageView setContentMode:UIViewContentModeScaleToFill];
    [cell.uiImageView.layer setMasksToBounds:YES];
    [cell.contentView addSubview:cell.uiImageView];
    [cell.uiCNTitleLab setText:category.at_name_ch];
    [cell.uiENTitleLab setText:category.at_name_en];
    [cell.contentView bringSubviewToFront:cell.uiBgView];
    [cell.contentView bringSubviewToFront:cell.uiENTitleLab];
    [cell.contentView bringSubviewToFront:cell.uiCNTitleLab];
    [cell.contentView bringSubviewToFront:cell.uiCloseBtn];
    cell.uiCloseBtn.hidden = NO;
    cell.uiCloseBtn.tag = 5000 + indexPath.row;
    [cell.uiCloseBtn addTarget:self action:@selector(delCollectImg:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.uiImageView layoutIfNeeded];
    
    return cell;
}

- (void)delCollectImg:(UIButton*)sender{
    NSInteger idx = sender.tag - 5000;
    // 去除一个
    if (idx < _categoryArray.count) {
        InfoCategory* category = [_categoryArray objectAtIndex:idx];
        [[WebAccessManager sharedInstance]delCollectCategoryWithAtId:category.at_id completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                // 发送通知刷新分类页面数据
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCollectionData" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_RELOADHOMEPAGE object:nil];
                
                [self.uiCategoryCollectionView performBatchUpdates:^{
                    [_categoryArray removeObjectAtIndex:idx];
                    [self.uiCategoryCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]]];
                } completion:^(BOOL finished) {
                    [self.uiCategoryCollectionView reloadData];
                    // 加入定制数组
                    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                    //NSArray* collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategory];
                    
                    NSMutableArray* tempArray = [NSMutableArray new];
                    for (InfoCategory* category in self.categoryArray) {
                        NSString* categoryStr = [NSString stringWithFormat:@"%@~-%@~-%@~-%@",category.at_id, category.at_name_ch, category.at_img_url, category.at_type];
                        [tempArray addObject:categoryStr];
                    }
                    
                    // 网络数据和本地数据不一致，则进行数据同步
                    if ([MemberManager sharedInstance].isLogined) {
                        [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
                    }else{
                        [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategory];
                    }
                    [defaults synchronize];
                    
                    // 刷新首页数据
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_RELOADHOMEPAGE object:nil];
                }];
            }else{
                [SVProgressHUDUtil showInfoWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _categoryArray.count) {
        InfoCategory* category = [_categoryArray objectAtIndex:[indexPath row]];
        if ([category.at_type isEqualToString:@"2"]) {
            // 专题分类
            [FlowUtil startToTopicListVCNav:self.navigationController at_id:category.at_id];
        }else{
            [[WebAccessManager sharedInstance]getSubCategoryWithAtId:category.at_id completion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    // 1、得到子分类
                    NSMutableArray* subArray = response.data.pullDowninforTypeList;
                    
                    // 2、将大分类放在最先的位置
                    NSMutableArray* allArray = subArray;
                    category.at_name = category.at_name_ch;
                    [allArray insertObject:category atIndex:0];
                    
                    // 3、处理数据得到所有的标题
                    NSMutableArray *titles = [NSMutableArray new];
                    for (InfoCategory* category in allArray) {
                        [titles addObject:category.at_name];
                    }
                    
                    XHTwitterPaggingViewer* twitterPaggingViewer = [[XHTwitterPaggingViewer alloc] init];
                    
                    // 3.1、设置滑动视图
                    NSMutableArray *viewControllers = [NSMutableArray new];
                    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
                        SubCategoryViewController *vc = [[SubCategoryViewController alloc] init];
                        vc.title = title;
                        vc.category = [allArray objectAtIndex:idx];
                        [viewControllers addObject:vc];
                    }];
                    
                    twitterPaggingViewer.viewControllers = viewControllers;
                    twitterPaggingViewer.didChangedPageCompleted = ^(NSInteger cuurentPage, NSString *title) {
                        SubCategoryViewController *vc = viewControllers[cuurentPage];
                        [vc loadeDataForSubView];
                    };
                    
                    // 3.2、设置右侧弹出视图
                    twitterPaggingViewer.subCategoryItemArray = subArray;
                    
                    [self.navigationController pushViewController:twitterPaggingViewer animated:YES];
                }
            }];
        }
    }
}

- (IBAction)clickCloseGuideGes:(id)sender {
    [self.uiGuideView removeFromSuperview];
}
@end
