//
//  TopicSubjectListViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicSubjectListViewController.h"
#import "TopicSubItemTableCell.h"
#import "TopicSubItemCycleTableCell.h"
#import "TopicSubItemTextCell.h"
#import "HomeModel.h"
#import "TextUtil.h"

@interface TopicSubjectListViewController ()<TopSubItemCycleDelegate>

@property (nonatomic, strong)NSMutableArray* infoArray;
@property (nonatomic, strong)NSMutableArray* imageURLs;
@property NSInteger page;

@end

@implementation TopicSubjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    [self initViewAndConAttribute];
    
    // 2、加载数据
    [self loadTopicSubjectList];
}

#pragma mark - 重写父类方法
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.page = 1;
    self.infoArray = [NSMutableArray new];
    self.imageURLs = [NSMutableArray new];
}

#pragma mark - 网络数据加载
// 加载E站列表
- (void)loadTopicSubjectList{
    [[WebAccessManager sharedInstance]getTopicSubListWithInId:self.in_id page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                // 加载轮播图
                _imageURLs = [[response.data.specialRreImgs componentsSeparatedByString:@","] mutableCopy];
                
                _infoArray = response.data.specialInforMationList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_infoArray addObjectsFromArray:[response.data.specialInforMationList copy]];
                    
                    [self.uiTableView reloadData];
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

#pragma mark - 点击事件(手势和按钮点击)
- (IBAction)clickBackBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 增加的一个为顶部轮播图的UITableCell
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return _infoArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图
        TopicSubItemCycleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[TopicSubItemCycleTableCell ID]];
        if (!cell) {
            cell = [TopicSubItemCycleTableCell newCell];
        }
        cell.delegate = self;
        cell.imageURLs = _imageURLs;
        
        return cell;
    }else{
        HomeModel* model = [_infoArray objectAtIndex:[indexPath row]];
        
        if([model.in_classify isEqualToString:@"4"]){
            TopicSubItemTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[TopicSubItemTextCell ID]];
            if (!cell) {
                cell = [TopicSubItemTextCell newCell];
            }
            
            [cell initCellDataWithHomeModel:model];
            return cell;
        }else{
            TopicSubItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[TopicSubItemTableCell ID]];
            if (!cell) {
                cell = [TopicSubItemTableCell newCell];
            }
            
            [cell initCellDataWithHomeModel:model];
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if ([indexPath row] < _infoArray.count) {
            HomeModel* model = [_infoArray objectAtIndex:[indexPath row]];
            
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 轮播图在375的高度是235，根据比例计算
        return 235 * kSCREEN_WIDTH / kWIDTH_375;
    }else{
        HomeModel* model = [_infoArray objectAtIndex:[indexPath row]];
        
        if([model.in_classify isEqualToString:@"4"]){
            CGFloat height = 0;
            height += 15;
            height += 20;
            height += 18;
            CGFloat descHeight = [TextUtil boundingRectWithText:model.in_desc lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_16].height;
            height += descHeight;
            height += 15;
            height += 16;
            height += 15;
            
            return height;
        }else{
            // 1、图片高度215 375宽度的
            CGFloat height = kSCREEN_WIDTH * 215 / kWIDTH_375;
            
            // 2、计算标题文字的高度(最多两行)
            CGFloat titleHeight = [TextUtil boundingRectWithText:model.in_title lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:FONT_16].height;
            if (titleHeight > 23) {
                titleHeight = 40;
            }
            
            // 4、计算高度
            CGFloat space = 18;
            if (kSCREEN_WIDTH < kWIDTH_375) {
                space = 13;
            }
            height += 15; // 为图片顶部距离
            height += 10; // 为标题顶部距离
            height += titleHeight;
            if (kSCREEN_WIDTH < kWIDTH_375) {
                height += 13; // 为标题底部距离
                height += 16; // 为时间Label高度
                height += 13; // 距离底部的
            }else{
                height += 18; // 为标题底部距离
                height += 16; // 为时间Label高度
                height += 18; // 距离底部的
            }
            
            return height;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadTopicSubjectList];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadTopicSubjectList];
}

#pragma mark - TopicSubItemCycleDelegate
- (void)clickCycleWithImageURL:(NSString*)imgURL{
    // 点击轮播图图片
}

@end
