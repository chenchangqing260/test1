//
//  SummaryPersonDetailViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SummaryPersonDetailViewController.h"
#import "SummaryDetailTableCell.h"
#import "SummaryDetail.h"
#import "HcdDateTimePickerView.h"
#import "Provice.h"
#import "AddCity.h"
#import "Country.h"
#import "Town.h"
#import "MultipleAddressView.h"
#import "TextUtil.h"
#import "SummaryPersonDetailTableCell.h"

#define tableCellHeight 148.0f;
#define tableCellHeightLow 116.0f;

@interface SummaryPersonDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *article_share_count;
@property (weak, nonatomic) IBOutlet UILabel *UIaddress;
@property (nonatomic, assign) NSInteger page;
@property (weak, nonatomic) IBOutlet UILabel *org_share_count;
@property (weak, nonatomic) IBOutlet UILabel *sciencer_count;
@property (nonatomic, strong) NSMutableArray* stsDetailList;
@end

@implementation SummaryPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、title显示
    self.title = @"注册人数概况";
    
    // 2、初始化界面和元素
    [self initViewAndData];
}

#pragma mark - 界面元素初始化
-(void)initViewAndData{
    // 1、初始化界面
    self.UIaddress.text = _Region_name;
    // 2、初始化数据
    self.stsDetailList = [NSMutableArray new];
    self.page = 1;
    
    [self loadHeadData];
    // 3、从网络获取元素
    [self loadDetailList];
    
}

#pragma mark - 加载网络数据
-(void)loadHeadData{
    [[WebAccessManager sharedInstance]getRegisterSummaryHead:_town_code completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _sciencer_count.text = response.data.sciencer_count;
            _org_share_count.text = response.data.org_share_count;
            _article_share_count.text = response.data.article_share_count;
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
    
}

-(void)loadDetailList{
    
    [[WebAccessManager sharedInstance]getRegisterSummaryBody:_town_code page:self.page completion:^(WebResponse *response, NSError *error) {
        [self.uiTableView.mj_footer endRefreshing];
        [self.uiTableView.mj_header endRefreshing];
        
        if (response.success) {
            // 1、将评论数据处理成可加载的数据
            if (self.page == 1) {
                self.stsDetailList = response.data.stsDetailList;
                [self.uiTableView reloadData];
            }else{
                if (response.data.stsDetailList.count > 0) {
                    // 还有数据
                    [self.stsDetailList addObjectsFromArray:[response.data.stsDetailList copy]];
                    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stsDetailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SummaryPersonDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[SummaryPersonDetailTableCell ID]];
    if (!cell) {
        cell = [SummaryPersonDetailTableCell newCell];
    }
    SummaryDetail* detail = [self.stsDetailList objectAtIndex:[indexPath row]];
    
    //    if(indexPath.row==0){
    //          [cell setCellWithSummaryDetail:detail isTown:self.sciencer.sc_type isShowTop:false];
    //    }else{
    //         [cell setCellWithSummaryDetail:detail isTown:self.sciencer.sc_type isShowTop:true];
    //    }
    [cell setCellWithSummaryDetail:detail isTown:@"0" isShowTop:true];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [FlowUtil startToSummaryPersonDetailVCNav:self.navigationController withSciencer:self.sciencer Region_name:detail.region_name];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SummaryDetail* detail = [self.stsDetailList objectAtIndex:[indexPath row]];
    int n=0;
    if (![detail.channels isEmptyOrWhitespace]){
        NSArray* tagArray = nil;
        if (detail.channels) {
            tagArray = [detail.channels componentsSeparatedByString:@","];
        }
        
        if (!tagArray) {
            n=32;
        }
    }else{
        n=32;
    }
    
    if(indexPath.row==0){
        
        return 106-n;
    }else{
        return 116-n;
    }
    
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

