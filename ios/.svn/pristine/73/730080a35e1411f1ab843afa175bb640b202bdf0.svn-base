//
//  ChuanBoListViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ChuanBoListViewController.h"
#import "ChuanBoTableCell.h"
#import "SectionView.h"

#define tableTitleCellHeight 40.0f;
#define tableSectionHeight 35.0f;
#define tableDataCellHeight 40.0f;

@interface ChuanBoListViewController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray* shareStsList;
@property (nonatomic, strong) NSString* content;

@end

@implementation ChuanBoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"科普中国传播活跃榜";
    
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        self.content = @"全国各省市";
    }else if([_sciencer.sc_type isEqualToString:@"1"]){
        if([_sciencer.province rangeOfString:@"市"].location !=NSNotFound)
        {
            self.content = [NSString stringWithFormat:@"%@各区县",_sciencer.province];
        }
        else
        {
            self.content = [NSString stringWithFormat:@"%@各市",_sciencer.province];
        }
    }else if([_sciencer.sc_type isEqualToString:@"2"]){
        self.content = [NSString stringWithFormat:@"%@各区县",_sciencer.city];
    }else if([_sciencer.sc_type isEqualToString:@"3"]){
        self.content = [NSString stringWithFormat:@"%@各乡镇",_sciencer.county];
    }else if([_sciencer.sc_type isEqualToString:@"4"]){
        self.content = _sciencer.town;
    }
    
    self.page = 1;
    self.shareStsList = [NSMutableArray new];
    
    [self loadDetailList];
}

#pragma mark - 加载网络数据
-(void)loadDetailList{
    [[WebAccessManager sharedInstance]getShareStsListForSciencerByScId:self.sciencer.sc_id page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            if (self.page == 1) {
                self.shareStsList = response.data.shareStsList;
                
                [self.uiTableView reloadData];
            }else{
                if (response.data.shareStsList.count > 0) {
                    // 还有数据
                    [self.shareStsList addObjectsFromArray:[response.data.shareStsList copy]];
                    
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

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shareStsList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChuanBoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChuanBoTableCell ID]];
    if (!cell) {
        cell = [ChuanBoTableCell newCell];
    }
    SummaryData* summaryData = nil;
    if (indexPath.row != 0) {
        summaryData = [self.shareStsList objectAtIndex:[indexPath row] - 1];
    }
    
    [cell setCellWithSummaryData:summaryData titleContent:self.content index:indexPath.row showMore:NO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return tableTitleCellHeight;
    }
    return tableDataCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        return 0;
    }
    return tableSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [[NSBundle mainBundle]loadNibNamed:@"SectionView" owner:nil options:nil][0];
    view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 28);
    [view setTitleWithString:self.sectionTitle];
    return view;
}

#pragma mark - TableView MJRefresh
- (void)tableViewRefreshHeaderData{
    _page = 1;
    [self loadDetailList];
}

- (void)tableViewRefreshFooterData{
    _page += 1;
    [self loadDetailList];
}
@end

