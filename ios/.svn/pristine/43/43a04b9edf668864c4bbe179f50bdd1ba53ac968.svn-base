//
//  SummaryDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SummaryDetailViewController.h"
#import "SummaryDetailTableCell.h"
#import "SummaryDetail.h"
#import "HcdDateTimePickerView.h"
#import "Provice.h"
#import "AddCity.h"
#import "Country.h"
#import "Town.h"
#import "MultipleAddressView.h"
#import "TextUtil.h"

#define tableCellHeight 148.0f;
#define tableCellHeightLow 116.0f;

@interface SummaryDetailViewController ()<NSXMLParserDelegate>

// XML解析
@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, strong) NSXMLParser *par;
@property (nonatomic,strong) MultipleAddressView *addressView;
@property (nonatomic, strong) NSMutableArray* provinceArray; // 待选择省份
@property (nonatomic, strong) NSMutableArray* cityArray; // 待选择市区
@property (nonatomic, strong) NSMutableArray* countryArray; // 待选择区县
@property (nonatomic, strong) NSMutableArray* townArray; // 待选择街道
@property (nonatomic, strong)Provice *xmlProvice;
@property (nonatomic, strong)AddCity *xmlCity;
@property (nonatomic, strong)Country* xmlCountry;
@property (nonatomic, strong)Town* xmlTown;


// 查询条件
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString* province_code;
@property (nonatomic, strong) NSString* city_code;
@property (nonatomic, strong) NSString* county_code;
@property (nonatomic, strong) NSString* town_code;
@property (nonatomic, strong) NSString* month;
@property (nonatomic, strong) NSString* sort_type;
@property (nonatomic, strong) NSString* sort_direction;

// 自定义变量
@property (nonatomic, strong) NSMutableArray* stsDetailList;
@property (nonatomic, strong) HcdDateTimePickerView * dateTimePickerView;

@property (nonatomic, strong) Provice* provice;
@property (nonatomic, strong) AddCity* addCity;
@property (nonatomic, strong) Country* county;
@property (nonatomic, strong) Town* town;

// 关联界面元素
@property (weak, nonatomic) IBOutlet UILabel *uiArticleCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiStationCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiRegisterCountLab;
@property (weak, nonatomic) IBOutlet UIButton *uiAreaBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiDataBtn;
@property (weak, nonatomic) IBOutlet UIView *uiBlackLayer;
@property (weak, nonatomic) IBOutlet UIView *uiViewSort;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conViewSortBottomSpace;
@property (weak, nonatomic) IBOutlet UIButton *uiSortUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortAcUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortAcDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortScUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiSortScDownBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conAreaBtnWidth;

@end

@implementation SummaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、title显示
    self.conAreaBtnWidth.constant = kSCREEN_WIDTH / 3;
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        self.title = @"全国详情";
    }else if([_sciencer.sc_type isEqualToString:@"1"]){
        self.title = [NSString stringWithFormat:@"%@详情",_sciencer.province];
    }else if([_sciencer.sc_type isEqualToString:@"2"]){
        self.title = [NSString stringWithFormat:@"%@详情",_sciencer.city];
    }else if([_sciencer.sc_type isEqualToString:@"3"]){
        self.title = [NSString stringWithFormat:@"%@详情",_sciencer.county];
    }else if([_sciencer.sc_type isEqualToString:@"4"]){
        self.title = [NSString stringWithFormat:@"%@详情",_sciencer.town];
        self.conAreaBtnWidth.constant = 0;
        self.uiAreaBtn.hidden = YES;
    }else{
        self.title = @"我的详情";
    }
    
    // 2、初始化界面和元素
    [self initViewAndData];
}

#pragma mark - 界面元素初始化
-(void)initViewAndData{
    // 1、初始化界面
    self.conViewSortBottomSpace.constant = -200;
    self.uiBlackLayer.hidden = YES;
    
    // 2、初始化数据
    self.stsDetailList = [NSMutableArray new];
    self.page = 1;
    
    // 3、从网络获取元素
    [self loadDetailData];
    [self loadDetailList];
    
    // 4、加载地址
    self.addressView = [[MultipleAddressView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self xmlData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [self handleAddressDataBySciencer];
        });
    });
}

#pragma mark - 加载网络数据
-(void)loadDetailData{
    [[WebAccessManager sharedInstance]getSummaryDetailDataForSciencerByScId:self.sciencer.sc_id completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 处理数据
            [self.uiArticleCountLab setText:response.data.article_share_count];
            [self.uiRegisterCountLab setText:response.data.sciencer_count];
            [self.uiStationCountLab setText:response.data.org_share_count];
        }
    }];
}

-(void)loadDetailList{
    if (self.provice) {
        self.province_code = self.provice.code;
    }else{
        self.province_code = nil;
    }
    
    if (self.addCity) {
        self.city_code = self.addCity.code;
    }else{
        self.city_code = nil;
    }
    
    if (self.county) {
        self.county_code = self.county.code;
    }else{
        self.county_code = nil;
    }
    
    if (self.town) {
        self.town_code = self.town.code;
    }else{
        self.town_code = nil;
    }
    
    [[WebAccessManager sharedInstance]getSummaryDetailListForSciencerByScId:self.sciencer.sc_id page:self.page province_code:self.province_code city_code:self.city_code county_code:self.county_code town_code:self.town_code month:self.month sort_type:self.sort_type sort_direction:self.sort_direction completion:^(WebResponse *response, NSError *error) {
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

#pragma mark - 关联事件
- (IBAction)areaBtnAction:(id)sender {
    [self.view endEditing:YES];
    __weak __typeof(self)weakSelf = self;
    weakSelf.addressView.block = ^(Provice* _Nullable provice, AddCity* _Nullable city, Country* _Nullable county, Town* _Nonnull town){
        weakSelf.provice = provice;
        weakSelf.addCity = city;
        weakSelf.county = county;
        weakSelf.town = town;
        
        if (provice) {
            NSString * str= [self getStrNumber:provice.name];
            weakSelf.uiAreaBtn.selected = YES;
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateNormal];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateSelected];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateHighlighted];
        }
        
        if (city) {
            NSString * str= [self getStrNumber:city.name];
            weakSelf.uiAreaBtn.selected = YES;
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateNormal];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateSelected];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateHighlighted];
        }
        
        if (county) {
            NSString * str= [self getStrNumber:county.name];
            weakSelf.uiAreaBtn.selected = YES;
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateNormal];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateSelected];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateHighlighted];
        }
        
        if (town) {
            NSString * str= [self getStrNumber:town.name];
            weakSelf.uiAreaBtn.selected = YES;
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateNormal];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateSelected];
            [weakSelf.uiAreaBtn setTitle:str forState:UIControlStateHighlighted];
        }
        
        // 执行搜索
        [self tableViewRefreshHeaderData];
    };
    [self.addressView showView:self.view];
}

//判断并截取字符串
-(NSString*)getStrNumber:(NSString*)str{
    NSUInteger  character = 0;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    if(character>8){
        return [NSString stringWithFormat:@"%@...",[str substringToIndex:4]];//截取掉下标2之前的字符串;
    }else{
        return str;
    }
    
}

- (IBAction)sortBtnAction:(id)sender {
    self.uiBlackLayer.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.conViewSortBottomSpace.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)dateBtnAction:(id)sender {
    __weak typeof(self) wself = self;
    self.dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerYearMonthMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    self.dateTimePickerView.topViewColor = [UIColor colorWithHex:0x18D6E3];
    self.dateTimePickerView.buttonTitleColor = [UIColor colorWithHex:0xFFFFFF];
    self.dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSArray *dateArray = [datetimeStr componentsSeparatedByString:@"-"];
        wself.uiDataBtn.selected = YES;
        [wself.uiDataBtn setTitle:[NSString stringWithFormat:@"%@年%@月", dateArray[0], dateArray[1]] forState:UIControlStateNormal];
        [wself.uiDataBtn setTitle:[NSString stringWithFormat:@"%@年%@月", dateArray[0], dateArray[1]] forState:UIControlStateSelected];
        [wself.uiDataBtn setTitle:[NSString stringWithFormat:@"%@年%@月", dateArray[0], dateArray[1]] forState:UIControlStateHighlighted];
        
        NSString* day = [dateArray objectAtIndex:1];
        if (day.length == 1) {
            day = [NSString stringWithFormat:@"0%@", day];
        }
        
        // 执行搜索
        wself.month = [NSString stringWithFormat:@"%@-%@", dateArray[0], day];
        DLog(@"%@", wself.month);
        [wself tableViewRefreshHeaderData];
    };
    
    if (self.dateTimePickerView) {
        [self.view addSubview:self.dateTimePickerView];
        [self.dateTimePickerView showHcdDateTimePicker];
    }
}

- (IBAction)sortCanelBtnAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.conViewSortBottomSpace.constant = -200;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.uiBlackLayer.hidden = YES;
        
        // 回复当前状态
        if ([self.sort_type isEqualToString:@"1"] && [self.sort_direction isEqualToString:@"1"]) {
            self.uiSortUpBtn.selected = YES;
        }else{
            self.uiSortUpBtn.selected = NO;
        }
        
        if ([self.sort_type isEqualToString:@"1"] && [self.sort_direction isEqualToString:@"2"]) {
            self.uiSortDownBtn.selected = YES;
        }else{
            self.uiSortDownBtn.selected = NO;
        }
        
        if ([self.sort_type isEqualToString:@"2"] && [self.sort_direction isEqualToString:@"1"]) {
            self.uiSortAcUpBtn.selected = YES;
        }else{
            self.uiSortAcUpBtn.selected = NO;
        }
        
        if ([self.sort_type isEqualToString:@"2"] && [self.sort_direction isEqualToString:@"2"]) {
            self.uiSortAcDownBtn.selected = YES;
        }else{
            self.uiSortAcDownBtn.selected = NO;
        }
        
        if ([self.sort_type isEqualToString:@"3"] && [self.sort_direction isEqualToString:@"1"]) {
            self.uiSortScUpBtn.selected = YES;
        }else{
            self.uiSortScUpBtn.selected = NO;
        }
        
        if ([self.sort_type isEqualToString:@"3"] && [self.sort_direction isEqualToString:@"2"]) {
            self.uiSortScDownBtn.selected = YES;
        }else{
            self.uiSortScDownBtn.selected = NO;
        }
        
        [self showBtnStatus];
    }];
}

- (IBAction)sortSelectBtnAction:(id)sender {
    if (sender == self.uiSortUpBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortUpBtn.selected) {
            self.uiSortUpBtn.selected = NO;
        }else{
            self.uiSortUpBtn.selected = YES;
        }
        
        self.uiSortDownBtn.selected = NO;
        self.uiSortAcUpBtn.selected = NO;
        self.uiSortAcDownBtn.selected = NO;
        self.uiSortScUpBtn.selected = NO;
        self.uiSortScDownBtn.selected = NO;
    }
    
    if (sender == self.uiSortDownBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortDownBtn.selected) {
            self.uiSortDownBtn.selected = NO;
        }else{
            self.uiSortDownBtn.selected = YES;
        }
        
        self.uiSortUpBtn.selected = NO;
        self.uiSortAcUpBtn.selected = NO;
        self.uiSortAcDownBtn.selected = NO;
        self.uiSortScUpBtn.selected = NO;
        self.uiSortScDownBtn.selected = NO;
    }
    
    if (sender == self.uiSortAcUpBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortAcUpBtn.selected) {
            self.uiSortAcUpBtn.selected = NO;
        }else{
            self.uiSortAcUpBtn.selected = YES;
        }
        
        self.uiSortUpBtn.selected = NO;
        self.uiSortDownBtn.selected = NO;
        self.uiSortAcDownBtn.selected = NO;
        self.uiSortScUpBtn.selected = NO;
        self.uiSortScDownBtn.selected = NO;
    }
    
    if (sender == self.uiSortAcDownBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortAcDownBtn.selected) {
            self.uiSortAcDownBtn.selected = NO;
        }else{
            self.uiSortAcDownBtn.selected = YES;
        }
        
        self.uiSortUpBtn.selected = NO;
        self.uiSortDownBtn.selected = NO;
        self.uiSortAcUpBtn.selected = NO;
        self.uiSortScUpBtn.selected = NO;
        self.uiSortScDownBtn.selected = NO;
    }
    
    if (sender == self.uiSortScUpBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortScUpBtn.selected) {
            self.uiSortScUpBtn.selected = NO;
        }else{
            self.uiSortScUpBtn.selected = YES;
        }
        
        self.uiSortUpBtn.selected = NO;
        self.uiSortDownBtn.selected = NO;
        self.uiSortAcUpBtn.selected = NO;
        self.uiSortAcDownBtn.selected = NO;
        self.uiSortScDownBtn.selected = NO;
    }
    
    if (sender == self.uiSortScDownBtn) {
        // 选择设为不选中，不选中设置为选中
        if (self.uiSortScDownBtn.selected) {
            self.uiSortScDownBtn.selected = NO;
        }else{
            self.uiSortScDownBtn.selected = YES;
        }
        
        self.uiSortUpBtn.selected = NO;
        self.uiSortDownBtn.selected = NO;
        self.uiSortAcUpBtn.selected = NO;
        self.uiSortAcDownBtn.selected = NO;
        self.uiSortScUpBtn.selected = NO;
    }
    
    [self showBtnStatus];
}

- (void)showBtnStatus{
    // 根据选中和不选中改变状态
    if (self.uiSortUpBtn.selected) {
        [self.uiSortUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortUpBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortUpBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
    
    if (self.uiSortDownBtn.selected) {
        [self.uiSortDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortDownBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortDownBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
    
    if (self.uiSortAcUpBtn.selected) {
        [self.uiSortAcUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortAcUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortAcUpBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortAcUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortAcUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortAcUpBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
    
    if (self.uiSortAcDownBtn.selected) {
        [self.uiSortAcDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortAcDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortAcDownBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortAcDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortAcDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortAcDownBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
    
    if (self.uiSortScUpBtn.selected) {
        [self.uiSortScUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortScUpBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortScUpBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortScUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortScUpBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortScUpBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
    
    if (self.uiSortScDownBtn.selected) {
        [self.uiSortScDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateSelected];
        [self.uiSortScDownBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiSortScDownBtn setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
    }else{
        // 至为灰色
        [self.uiSortScDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateSelected];
        [self.uiSortScDownBtn setTitleColor:[UIColor colorWithHex:0xF6F6F6] forState:UIControlStateNormal];
        [self.uiSortScDownBtn setBackgroundColor:[UIColor colorWithHex:0x595959]];
    }
}

- (IBAction)sortConfirmBtnAction:(id)sender {
    if (!self.uiSortUpBtn.selected
        && !self.uiSortDownBtn.selected
        && !self.uiSortAcUpBtn.selected
        && !self.uiSortAcDownBtn.selected
        && !self.uiSortScUpBtn.selected
        && !self.uiSortScDownBtn.selected) {
        self.sort_type = nil;
        self.sort_direction = nil;
        
        self.uiSortBtn.selected = NO;
    }else{
        self.uiSortBtn.selected = YES;
        if (self.uiSortUpBtn.selected) {
            self.sort_type = @"1";
            self.sort_direction = @"1";
        }
        if (self.uiSortDownBtn.selected) {
            self.sort_type = @"1";
            self.sort_direction = @"2";
        }
        if (self.uiSortAcUpBtn.selected) {
            self.sort_type = @"2";
            self.sort_direction = @"1";
        }
        if (self.uiSortAcDownBtn.selected) {
            self.sort_type = @"2";
            self.sort_direction = @"2";
        }
        if (self.uiSortScUpBtn.selected) {
            self.sort_type = @"3";
            self.sort_direction = @"1";
        }
        if (self.uiSortScDownBtn.selected) {
            self.sort_type = @"3";
            self.sort_direction = @"2";
        }
    }
    
    // 执行搜索
    [self tableViewRefreshHeaderData];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.conViewSortBottomSpace.constant = -200;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.uiBlackLayer.hidden = YES;
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stsDetailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SummaryDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[SummaryDetailTableCell ID]];
    if (!cell) {
        cell = [SummaryDetailTableCell newCell];
    }
    SummaryDetail* detail = [self.stsDetailList objectAtIndex:[indexPath row]];
    
    [cell setCellWithSummaryDetail:detail isTown:self.sciencer.sc_type];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SummaryDetail* detail = [self.stsDetailList objectAtIndex:[indexPath row]];
    [FlowUtil startToSummaryPersonDetailVCNav:self.navigationController withSciencer:detail.town_code Region_name:detail.region_name];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SummaryDetail* detail = [self.stsDetailList objectAtIndex:[indexPath row]];
    // 计算文字长度
    NSString* textStr = @"";
    if ([self.sciencer.sc_type isEqualToString:@"4"]) {
        // 乡镇级，不显示下面的注册人数
        textStr = [NSString stringWithFormat:@"%@ %@", detail.sc_name, detail.region_name];
    }else{
        textStr = detail.region_name;
    }
    
    CGSize size = [TextUtil boundingRectWithText:textStr lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 39, 0) Font:FONT_17];
    
    if (![detail.channels isEmptyOrWhitespace]){
        
        if (size.height <= 39) {
            return tableCellHeight;
        }else if(size.height > 39 && size.height < 60){
            return 148 - 39 + 55;
        }else{
            return 148 - 39 + 80;
        }
    }
    
    if (size.height <= 39) {
        return tableCellHeightLow;
    }else if(size.height > 39 && size.height < 60){
        return 116 - 39 + 55;
    }else{
        return 116 - 39 + 80;
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

#pragma mark - 处理地址选择
- (void)handleAddressDataBySciencer{
    NSMutableArray* selectProviceArray = [NSMutableArray new];
    NSMutableArray* selectCityArray = [NSMutableArray new];
    NSMutableArray* selectCountyArray = [NSMutableArray new];
    
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        // 全国级显示所有省市
        selectProviceArray = self.provinceArray;
        [self.addressView loadAddressViewWithProviceArray:selectProviceArray provice:nil city:nil country:nil town:nil];
    }else if([_sciencer.sc_type isEqualToString:@"1"]){
        // 升级显示所有市
        Provice* tempProvice = nil;
        for (int i=0; i<self.provinceArray.count; i++) {
            tempProvice = [self.provinceArray objectAtIndex:i];
            if ([tempProvice.name.trim isEqualToString:self.sciencer.province]) {
                break;
            }
        }
        
        [selectProviceArray addObject:tempProvice];
        [self.addressView loadAddressViewWithProviceArray:selectProviceArray provice:tempProvice city:nil country:nil town:nil];
    }else if([_sciencer.sc_type isEqualToString:@"2"]){
        // 市级显示所有区县
        Provice* tempProvice = nil;
        AddCity* tempCity = nil;
        for (int i=0; i<self.provinceArray.count; i++) {
            tempProvice = [self.provinceArray objectAtIndex:i];
            if ([tempProvice.name.trim isEqualToString:self.sciencer.province]) {
                
                break;
            }
        }
        
        for (int i=0; i<tempProvice.cityArray.count; i++) {
            tempCity = [tempProvice.cityArray objectAtIndex:i];
            if ([tempCity.name.trim isEqualToString:self.sciencer.city]) {
                break;
            }
        }
        
        [selectCityArray addObject:tempCity];
        tempProvice.cityArray = selectCityArray;
        [selectProviceArray addObject:tempProvice];
        [self.addressView loadAddressViewWithProviceArray:selectProviceArray provice:tempProvice city:tempCity country:nil town:nil];
    }else if([_sciencer.sc_type isEqualToString:@"3"]){
        // 区县，显示所有街道
        Provice* tempProvice = nil;
        AddCity* tempCity = nil;
        Country* tempCounty = nil;
        for (int i=0; i<self.provinceArray.count; i++) {
            tempProvice = [self.provinceArray objectAtIndex:i];
            if ([tempProvice.name.trim isEqualToString:self.sciencer.province]) {
                break;
            }
        }
        
        for (int i=0; i<tempProvice.cityArray.count; i++) {
            tempCity = [tempProvice.cityArray objectAtIndex:i];
            if ([tempCity.name.trim isEqualToString:self.sciencer.city]) {
                break;
            }
        }
        
        for (int i=0; i<tempCity.countryArray.count; i++) {
            tempCounty = [tempCity.countryArray objectAtIndex:i];
            if ([tempCounty.name.trim isEqualToString:self.sciencer.county]) {
                break;
            }
        }
        
        [selectCountyArray addObject:tempCounty];
        tempCity.countryArray = selectCountyArray;
        [selectCityArray addObject:tempCity];
        tempProvice.cityArray = selectCityArray;
        [selectProviceArray addObject:tempProvice];
        [self.addressView loadAddressViewWithProviceArray:selectProviceArray provice:tempProvice city:tempCity country:tempCounty town:nil];
    }else if([_sciencer.sc_type isEqualToString:@"4"]){
        // 不可点击
    }else{
        // 不可点击
    }
}

//===============================XML获取数据源================================
#pragma mark - 地址xml解析
- (void)xmlData
{
    //获取事先准备好的XML文件
    NSBundle *b = [NSBundle mainBundle];
    NSString *path = [b pathForResource:@"region" ofType:@".xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    self.par = [[NSXMLParser alloc]initWithData:data];
    //添加代理
    self.par.delegate = self;
    //初始化数组，存放解析后的数据
    self.provinceArray = [NSMutableArray new];
    [self.par parse];
}

//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    //NSLog(@"准备节点-%@",elementName);
    
    if ([self.currentElement isEqualToString:@"province"]){
        self.xmlProvice = [Provice new];
        self.xmlProvice.code = [attributeDict objectForKey:@"code"];
        self.xmlProvice.name = [attributeDict objectForKey:@"name"];
        self.xmlProvice.cityArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"city"]){
        self.xmlCity = [AddCity new];
        self.xmlCity.code = [attributeDict objectForKey:@"code"];
        self.xmlCity.name = [attributeDict objectForKey:@"name"];
        self.xmlCity.countryArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"county"]){
        self.xmlCountry = [Country new];
        self.xmlCountry.code = [attributeDict objectForKey:@"code"];
        self.xmlCountry.name = [attributeDict objectForKey:@"name"];
        self.xmlCountry.townArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"town"]){
        self.xmlTown = [Town new];
        self.xmlTown.code = [attributeDict objectForKey:@"code"];
        self.xmlTown.name = [attributeDict objectForKey:@"name"];
    }
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if ([elementName isEqualToString:@"province"]){
        [self.provinceArray addObject:self.xmlProvice];
    }
    
    if ([elementName isEqualToString:@"city"]){
        [self.xmlProvice.cityArray addObject:self.xmlCity];
    }
    
    if ([elementName isEqualToString:@"county"]){
        [self.xmlCity.countryArray addObject:self.xmlCountry];
    }
    
    if ([elementName isEqualToString:@"town"]){
        [self.xmlCountry.townArray addObject:self.xmlTown];
    }
    
    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}
//===============================XML获取数据源结束=================================

@end

