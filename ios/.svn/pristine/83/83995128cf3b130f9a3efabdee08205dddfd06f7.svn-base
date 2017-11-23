//
//  EStationSearchViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationSearchViewController.h"
#import "ESearchSpaceCell.h"
#import "ESearchTitleCell.h"
#import "ESearchContentCell.h"
#import "EStationListCell.h"

#define dSearchRecord @"search_record"

@interface EStationSearchViewController ()<ESearchTtileDelegate,EStationListCellDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_view;

@property (weak, nonatomic) IBOutlet UITableView *uiSearchHisTableView;
@property (weak, nonatomic) IBOutlet UITextField *uiSearchTF;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (weak, nonatomic) IBOutlet UIView *uiNoResultView;

@property (nonatomic, strong)NSMutableArray* stationArray;
@property (nonatomic, strong)NSArray* searchHisArray; // 搜索历史
@property (nonatomic, strong)NSArray* hotArray; // 热门搜索
@property NSInteger page;

@property BOOL showHisTableView;

@end

@implementation EStationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化界面数据
    [self initViewAndConAttribute];
    
    // 2、初始化历史记录表，并显示视图
    [self loadAndShowHisTableView];
    
    // 3、加载热门搜索
    [self loadHostSearch];
    
    // 4、注册通知，若有刷新结果，刷新数据
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSearchResult) name:@"reloadSearchResult" object:nil];
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
    self.stationArray = [NSMutableArray new];
    self.searchHisArray = [NSMutableArray new];
    self.hotArray = [NSMutableArray new];
    self.page = 1;
    self.uiNoResultView.hidden = YES;
    
    
    self.leadingEdge_view.constant = self.trailingEdge_view.constant = self.leftEdge;
}

#pragma mark - 可重写方法
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 自定义方法(包括通知)
- (void)reloadSearchResult{
    self.page = 1;
    [self searchStationByKeyWord];
}

#pragma mark - 点击事件（按钮和手势）
- (IBAction)clickCanelBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (self.showHisTableView) {
        // 当前显示历史记录，点击取消，若查询记录为空，则点击返回则返回上一页，若有结果，则返回查询结果列表
        if (self.stationArray.count == 0) {
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

#pragma mark - 网络数据处理
// 加载热门搜索
- (void)loadHostSearch{
    [[WebAccessManager sharedInstance]getHotSearchForStationWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.hotArray =  [response.data.hotSearchList componentsSeparatedByString:@","];
            [self.uiSearchHisTableView reloadData];
            [self.view bringSubviewToFront:self.uiSearchHisTableView];
        }
    }];
}

// 搜索数据
- (void)searchStationByKeyWord{
    self.showHisTableView = NO;
    [self.uiContentView sendSubviewToBack:self.uiSearchHisTableView];
    [self.uiContentView bringSubviewToFront:self.uiTableView];
    if (self.page == 1) {
        [SVProgressHUDUtil show];
    }
    
    [[WebAccessManager sharedInstance]searchStationInfoBykeyWork:self.uiSearchTF.text page:self.page Completion:^(WebResponse *response, NSError *error) {
        [SVProgressHUDUtil dismiss];
        [self.uiTableView.mj_footer endRefreshing];
        if (response.success) {
            if (self.page == 1) {
                _stationArray = response.data.stationList;
                if (_stationArray && _stationArray.count > 0) {
                    self.uiNoResultView.hidden = YES;
                    [self.uiContentView sendSubviewToBack:self.uiNoResultView];
                    [self.uiTableView reloadData];
                }else{
                    self.uiNoResultView.hidden = NO;
                    [self.uiContentView bringSubviewToFront:self.uiNoResultView];
                }
            }else{
                if (response.data.stationList.count > 0) {
                    // 还有数据
                    [_stationArray addObjectsFromArray:[response.data.stationList copy]];
                    
                    [self.uiTableView reloadData];
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

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.uiSearchHisTableView == tableView) {
        // 历史记录和热门搜索，若历史记录为空的话，就直接显示热门搜索，若历史记录不为空，则显示历史记录和热门搜索
        if (self.searchHisArray.count == 0) {
            return self.hotArray.count + 1; // 包含顶部的热门搜索一行
        }else{
            return self.searchHisArray.count + self.hotArray.count + 3; // 加的3个cell位顶部的历史搜索，中间的间隔，热门搜索。
        }
    }else{
        // 查询结果
        return self.stationArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.uiSearchHisTableView == tableView) {
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
    }else{
        EStationListCell *cell = [tableView dequeueReusableCellWithIdentifier:[EStationListCell ID]];
        if (!cell) {
            cell = [EStationListCell newCell];
        }
        
        cell.delegate = self;
        
        [cell initCellData:[_stationArray objectAtIndex:indexPath.row] indexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==  self.uiTableView) {
        EStation* station = [_stationArray objectAtIndex:indexPath.row];
        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
    }else{
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.uiSearchHisTableView == tableView) {
        if (self.searchHisArray.count != 0 && indexPath.row == self.searchHisArray.count + 1) {
            return 10;
        }
        return 40;
    }else{
        return 100;
    }
}


#pragma mark - MJRefresh
-(BOOL)showMJHeader{
    return NO;
}

// 刷新头
- (void)tableViewRefreshFooterData{
    self.page += 1;
    [self searchStationByKeyWord];
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    // 1、保存搜索历史记录
    [self saveSearchRecord:self.uiSearchTF.text];
    
    // 2、查询数据
    [self searchStationByKeyWord];
    
    return YES;
}

// 获取焦点
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self loadAndShowHisTableView];
}

#pragma mark - 历史记录处理
// 显示历史记录列表
- (void)loadAndShowHisTableView{
    // 1、获取搜索历史
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *searchRecordArray = [userDefaultes arrayForKey:dSearchRecord];
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
    NSArray *search_record = (NSMutableArray *)[userDefaultes arrayForKey:dSearchRecord];
    if (search_record != nil) {
        searchRecordArray = [NSMutableArray arrayWithArray:search_record];
    }
    
    if (![keyword isEmptyOrWhitespace] && ![searchRecordArray containsObject:keyword]) {
        [searchRecordArray insertObject:keyword atIndex:0];
    }
    
    // 同步数据
    [userDefaultes setObject:[searchRecordArray copy] forKey:dSearchRecord];
    [userDefaultes synchronize];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    [self.view endEditing:YES];
}

#pragma mark - ESearchTtileDelegate
- (void)clickCleanHisBtn{
    // 清空历史记录
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray *keywords = [NSMutableArray array];
    [userDefaultes setObject:[keywords copy] forKey:dSearchRecord];
    [userDefaultes synchronize];
    
    // 刷新视图
    [self loadAndShowHisTableView];
}

#pragma mark - EStationListCell Delegate
-(void)refreshTableViewCellWithIndexPath:(NSIndexPath*)indexPath;{
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:indexPath];
    [self.uiTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStation" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCategoryStationList" object:nil];
    
}
@end
