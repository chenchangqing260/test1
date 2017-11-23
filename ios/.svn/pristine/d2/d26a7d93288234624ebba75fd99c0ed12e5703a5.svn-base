//
//  TopicListViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicListViewController.h"
#import "TopicItemCell.h"
#import "HomeModel.h"
#import "TextUtil.h"

@interface TopicListViewController ()

@property (nonatomic, strong)NSMutableArray* topicArray; // 资讯列表
@property NSInteger page;

@end

@implementation TopicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题";
    
    // 1、初始化数据
    [self initViewAndConAttribute];
    
    // 2、初始化CollectionView
    [self initCollectionView];
    
    // 3、加载数据
    [self loadeData];
}

// 父类调用方法
-(void)loadeDataForSubView{
    if (self.page == 1) {
        [self loadeData];
    }
}

#pragma mark - 网络数据加载
-(void)loadeData{
    [[WebAccessManager sharedInstance]getInfoListByCategoryId:self.at_id page:_page showSlide:@"0" completion:^(WebResponse *response, NSError *error) {
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        self.uiCollectionView.hidden = NO;
        
        if (response.success) {
            if (self.page == 1) {
                _topicArray = response.data.list;
                [self.uiCollectionView reloadData];
            }else{
                if (response.data.list.count > 0) {
                    // 还有数据
                    [_topicArray addObjectsFromArray:[response.data.list copy]];
                    
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

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.page = 1;
    self.topicArray = [NSMutableArray new];
}

#pragma mark - UICollectionView DataSource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[TopicItemCell ID] bundle:nil] forCellWithReuseIdentifier:[TopicItemCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _topicArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] < _topicArray.count) {
        HomeModel* model = [_topicArray objectAtIndex:[indexPath section]];
        TopicItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TopicItemCell ID] forIndexPath:indexPath];
        [cell initCellDataWithHomeModel:model];
        return cell;
    }
    
    return  nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _topicArray.count) {
        HomeModel* model = [_topicArray objectAtIndex:[indexPath section]];
        
        // 跳转到专题列表
        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:model.in_id];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 计算高度
    if ([indexPath section] < _topicArray.count) {
        HomeModel* model = [_topicArray objectAtIndex:[indexPath section]];
        
        // 1、图片高度165 375宽度的
        CGFloat height = kSCREEN_WIDTH * 165 / kWIDTH_375;
        
        // 2、计算标题文字的高度(最多两行)
        CGFloat titleHeight = [TextUtil boundingRectWithText:model.in_title lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_16].height;
        if (titleHeight > 23) {
            titleHeight = 40;
        }
        
        // 3、计算描述内容的高度（最多两行）
        CGFloat descHeight = [TextUtil boundingRectWithText:model.in_desc lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_13].height;
        
        if (descHeight > 16) {
            descHeight = 32;
        }
        
        // 4、计算高度
        CGFloat space = 18;
        if (kSCREEN_WIDTH < kWIDTH_375) {
            space = 13;
        }
        height += space; // 为距离顶部图片距离
        height += titleHeight;
        height += space; // 为顶部底部距离描述的距离
        height += descHeight;
        height += space; // 距离底部的
        
        return CGSizeMake(kSCREEN_WIDTH, height);
    }else{
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kSCREEN_WIDTH, 15);
}

- (void)collectionViewRefreshHeaderData{
    self.page = 1;
    [self loadeData];
}

- (void)collectionViewRefreshFooterData{
    self.page += 1;
    [self loadeData];
}

@end
