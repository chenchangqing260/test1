//
//  SummaryViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SummaryViewController.h"
#import "SummaryData.h"
#import "RegisterTableCell.h"
#import "ChuanBoTableCell.h"
#import "SectionView.h"
#import "ZFChart.h"

#define tableTitleCellHeight 40.0f;
#define tableMoreCellHeight 40.0f;
#define tableDataCellHeight 40.0f;
#define tableSectionHeight 35.0f;

@interface SummaryViewController ()<ZFGenericChartDataSource, ZFBarChartDelegate>

#pragma mark - 页面元素关联
@property (weak, nonatomic) IBOutlet UIView *uiTopLeftViewForPerson;
@property (weak, nonatomic) IBOutlet UIView *uiTopLeftViewForAll;
@property (weak, nonatomic) IBOutlet UIButton *uiSciencerStsBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiArticleShareStsBtn;
@property (weak, nonatomic) IBOutlet UIButton *uiOrgShareStsBtn;
@property (weak, nonatomic) IBOutlet UIView *uiChartView;
@property (weak, nonatomic) IBOutlet UIView *uiThirdView;
@property (weak, nonatomic) IBOutlet UIButton *uiSciencerStsListBtn; // 科普中国注册活跃榜
@property (weak, nonatomic) IBOutlet UIButton *uiShareStsListBtn; // 科普中国传播活跃榜
@property (weak, nonatomic) IBOutlet UITableView *uiDataTableView;
@property (weak, nonatomic) IBOutlet UILabel *uiLabRegisterDate;
@property (weak, nonatomic) IBOutlet UILabel *uiLabRegisterCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabShareActCount;
@property (weak, nonatomic) IBOutlet UILabel *uiLabShareOrgCount;

#pragma mark - 页面约束关联
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopViewHeight; // 375-119
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopViewBottomImgHeight; // 375-33
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conNewRegisterCountBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conSciencerStsListBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conThirdViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conSecondViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopAndSecondSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conSecondAndThirdSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conThird1ViewHeight;

#pragma mark - 自定义属性
@property (nonatomic, strong) NSMutableArray *chartData;
@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) ZFBarChart * barChart;

@property (nonatomic, strong) NSMutableArray* sciencer_sts; // 新增注册用户量
@property (nonatomic, strong) NSMutableArray* article_share_sts; // 新增分享文章
@property (nonatomic, strong) NSMutableArray* org_share_sts; // 新增分享基站
@property (nonatomic, strong) NSString* share_rank; // 第二个标记
@property (nonatomic, assign) NSInteger share_total; //分享统计数量
@property (nonatomic, strong) NSMutableArray* shareStsList; // 分享
@property (nonatomic, strong) NSString* sciencer_rank; // 第一个标记
@property (nonatomic, assign) NSInteger sciencer_total; // 科普员统计数量
@property (nonatomic, strong) NSMutableArray* sciencerStsList; // 科普员
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong)ShareModel* shareModel;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、title显示和底部列表标题显示
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        self.title = @"全国概况";
        self.content = @"全国各省市";
    }else if([_sciencer.sc_type isEqualToString:@"1"]){
        
        if([_sciencer.province rangeOfString:@"市"].location !=NSNotFound)
        {
            self.title = [NSString stringWithFormat:@"%@概况",_sciencer.province];
            self.content = [NSString stringWithFormat:@"%@各区县",_sciencer.province];
        }
        else
        {
            self.title = [NSString stringWithFormat:@"%@概况",_sciencer.province];
            self.content = [NSString stringWithFormat:@"%@各市",_sciencer.province];
        }
        
        
    }else if([_sciencer.sc_type isEqualToString:@"2"]){
        self.title = [NSString stringWithFormat:@"%@概况",_sciencer.city];
        self.content = [NSString stringWithFormat:@"%@各区县",_sciencer.city];
    }else if([_sciencer.sc_type isEqualToString:@"3"]){
        self.title = [NSString stringWithFormat:@"%@概况",_sciencer.county];
        self.content = [NSString stringWithFormat:@"%@各乡镇",_sciencer.county];
    }else if([_sciencer.sc_type isEqualToString:@"4"]){
        self.title = [NSString stringWithFormat:@"%@概况",_sciencer.town];
        self.content = _sciencer.town;
    }else{
        self.title = @"我的概况";
    }
    
    // 2、初始化界面
    [self initConAndView];
    
    // 3、网络数据获取
    [self getSciencerSummaryData];
}

#pragma mark - 初始化
// 界面约束和界面元素初始化
- (void)initConAndView{
    // 1、界面约束
    self.conScrollViewWidth.constant = kSCREEN_WIDTH;
    self.conTopViewHeight.constant = 119 * kSCREEN_WIDTH / kWIDTH_375;
    self.conTopViewBottomImgHeight.constant = 33 *kSCREEN_WIDTH / kWIDTH_375;
    
    // 2、Button按钮的样式，Button都设置为未选择，将第一个新增注册量设置为选择
    
    // 3、个人概况不显示底部的列表和中间的新增注册量
    if ([_sciencer.sc_type isEqualToString:@"5"]) {
        // 3.1 隐藏底部列表
        self.uiThirdView.hidden = YES;
        // 3.2 将左侧新增注册量设为长度0
        self.conNewRegisterCountBtnWidth.constant = 0;
        // 3.3 设置新增注册量为未选择，新增分享文章量为选择，新增分享基站为未选择
        self.uiSciencerStsBtn.selected = NO;
        self.uiArticleShareStsBtn.selected = YES;
        self.uiOrgShareStsBtn.selected = NO;
        // 3.4、选择的新增分享文章变为蓝色底，其他透明底
        [self showBtnStatusButton:self.uiSciencerStsBtn];
        [self showBtnStatusButton:self.uiArticleShareStsBtn];
        [self showBtnStatusButton:self.uiOrgShareStsBtn];
        
        // 3.5、显示注册日期
        self.uiTopLeftViewForAll.hidden = YES;
        self.uiTopLeftViewForPerson.hidden = NO;
    }else{
        // 3.1 显示底部列表
        self.uiThirdView.hidden = NO;
        // 3.2 长度为1/3
        self.conNewRegisterCountBtnWidth.constant = (kSCREEN_WIDTH - 20) / 3; // 左右为10
        // 3.3 设置新增注册量为选择，新增分享文章量为未选择，新增分享基站为未选择
        self.uiSciencerStsBtn.selected = YES;
        self.uiArticleShareStsBtn.selected = NO;
        self.uiOrgShareStsBtn.selected = NO;
        // 3.4、选择的新增分享文章变为蓝色底，其他透明底
        [self showBtnStatusButton:self.uiSciencerStsBtn];
        [self showBtnStatusButton:self.uiArticleShareStsBtn];
        [self showBtnStatusButton:self.uiOrgShareStsBtn];
        
        // 3.6、显示注册人数
        self.uiTopLeftViewForAll.hidden = NO;
        self.uiTopLeftViewForPerson.hidden = YES;
    }
    
    // 4、乡镇没有科普中国注册活跃版显示
    if([_sciencer.sc_type isEqualToString:@"4"]){
        // 1、设置左侧的科普中国活跃榜的长度为0
        self.conSciencerStsListBtnWidth.constant = 0;
        // 2、左侧科普中国活跃榜设置为为选择，科普中国传播活跃榜设置为全屏
        self.uiSciencerStsListBtn.selected = NO;
        self.uiShareStsListBtn.selected = YES;
        // 3、设置背景色
        [self showBtnStatusButton:self.uiSciencerStsListBtn];
        [self showBtnStatusButton:self.uiShareStsListBtn];
    }else{
        // 1、设置左侧的科普中国活跃榜的长度为0
        self.conSciencerStsListBtnWidth.constant = kSCREEN_WIDTH / 2;
        // 2、左侧科普中国活跃榜设置为为选择，科普中国传播活跃榜设置为全屏
        self.uiSciencerStsListBtn.selected = YES;
        self.uiShareStsListBtn.selected = NO;
        // 3、设置背景色
        [self showBtnStatusButton:self.uiSciencerStsListBtn];
        [self showBtnStatusButton:self.uiShareStsListBtn];
    }
    
    // 5、刷新ScrollView
    [self refreshScrollViewHeight];
    self.chartData = [NSMutableArray new];
    self.titleData = [NSMutableArray new];
}

- (void)loadChartWithUnit:(NSString*)unit{
    self.barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.uiChartView.bounds.size.height)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"";
    self.barChart.unit = unit;
    //    self.barChart.isAnimated = NO;
    //    self.barChart.isResetAxisLineMinValue = YES;
    self.barChart.isResetAxisLineMaxValue = YES;
    //    self.barChart.isShowAxisLineValue = NO;
    //    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
    //    self.barChart.isShowXLineSeparate = YES;
    //    self.barChart.isShowYLineSeparate = YES;
    //    self.barChart.topicLabel.textColor = ZFWhite;
    //    self.barChart.unitColor = ZFWhite;
    //    self.barChart.xAxisColor = ZFWhite;
    self.barChart.axisLineNameFont = FONT_12;
    self.barChart.xAxisColor = [UIColor colorWithHex:0xB8B8B8];
    self.barChart.yAxisColor = [UIColor colorWithHex:0xB8B8B8];
    self.barChart.axisLineNameColor = [UIColor colorWithHex:0x545454];
    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.barChart.shadowColor = ZFWhite;
    self.barChart.valueOnChartFont = FONT_11;
    self.barChart.isShowAxisArrows = NO;
    
    [self.uiChartView addSubview:self.barChart];
    [self.barChart strokePath];
}

#pragma mark - 重写父Controller方法
// 以下三个方法连起来使用，显示右侧按钮，则需要显示内容
-(BOOL)showRightNavItem{
    if ([_sciencer.sc_type isEqualToString:@"5"]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)rightNavBtnAction{
    // 跳转概况详情页
    [FlowUtil startToSummaryDetailVCNav:self.navigationController withSciencer:self.sciencer];
}

#pragma mark - 网络访问
- (void)getSciencerSummaryData{
    [[WebAccessManager sharedInstance] getSummaryDataForSciencerByScId:self.sciencer.sc_id completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 刷新界面数据
            // 1、顶部数据
            [self.uiLabRegisterDate setText:response.data.register_date];
            [self.uiLabRegisterCount setText:response.data.sciencer_count];
            
            [self.uiLabShareActCount setText:response.data.article_share_count];
            [self.uiLabShareOrgCount setText:response.data.org_share_count];
            self.sciencer_sts = response.data.sciencer_sts;
            self.article_share_sts = response.data.article_share_sts;
            self.org_share_sts = response.data.org_share_sts;
            self.sciencer_rank = response.data.sciencer_rank;
            self.share_rank = response.data.share_rank;
            
            // 2、中间的折线图
            if ([_sciencer.sc_type isEqualToString:@"5"]) {
                // 个人，直接显示
                [self handleChartWithDataArray:self.article_share_sts];
            }else{
                [self handleChartWithDataArray:self.sciencer_sts];
            }
            
            // 3、处理返回的数据
            self.sciencer_total = [response.data.sciencer_total integerValue];
            self.share_total = [response.data.share_total integerValue];
            self.sciencerStsList = response.data.sciencerStsList;
            self.shareStsList = response.data.shareStsList;
            
            // 4、刷新TableView
            [self.uiDataTableView reloadData];
            [self refreshScrollViewHeight];
            
            // 5、设置分享对象
            self.shareModel = [ShareModel new];
            self.shareModel.in_share_contentURL = response.data.share_url;
            self.shareModel.in_share_imageURL  = response.data.share_image_url;
            self.shareModel.in_share_title  = response.data.share_title;
            self.shareModel.in_share_desc  = response.data.share_desc;
        }else{
            
        }
    }];
}

#pragma mark - 自定义方法
// 根据按钮选择和未选择，显示不同的背景色和文字
- (void)showBtnStatusButton:(UIButton*)button{
    [button.layer setMasksToBounds:YES];
    // 1、修改按钮背景色
    if (button.selected) {
        // 按钮选择，显示蓝底白字
        [button setBackgroundColor:[UIColor colorWithHex:0x18D6E3]];
        [button.layer setBorderColor:[UIColor colorWithHex:0x18D6E3].CGColor];
    }else{
        // 按钮未选择，显示灰色字，没有底色
        if (button == self.uiSciencerStsListBtn || button == self.uiShareStsListBtn) {
            [button setBackgroundColor:[UIColor colorWithHex:0xF6F6F6]];
        }else{
            // 设置按钮为纯色，并加上边框
            [button setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
        }
        [button.layer setBorderColor:[UIColor colorWithHex:0xE3E3E3].CGColor];
        [button.layer setBorderWidth:0.5];
    }
    
    if (button == self.uiSciencerStsBtn || button == self.uiOrgShareStsBtn) {
        // 有圆角
        [button.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    }
}

// 根据数据处理折线图
- (void)handleChartWithDataArray:(NSMutableArray*)dataArray{
    [self.chartData removeAllObjects];
    [self.titleData removeAllObjects];
    for (int i=0; i<dataArray.count; i++) {
        SummaryData* sData = [dataArray objectAtIndex:i];
        NSArray* monthArray = [sData.date componentsSeparatedByString:@"-"];
        NSString* str = @"";
        if ([monthArray[1] intValue] >= 10) {
            str = monthArray[1];
        }else{
            str = [NSString stringWithFormat:@"%d", [monthArray[1] intValue]];
        }
        
        str = [NSString stringWithFormat:@"%@月", str];
        
        [_titleData addObject:str];
        [_chartData addObject:sData.count];
    }
    
    // 渲染图表
    if (self.uiSciencerStsBtn.selected) {
        [self loadChartWithUnit:@"人"];
    }else if(self.uiArticleShareStsBtn.selected){
        [self loadChartWithUnit:@"篇"];
    }else{
        [self loadChartWithUnit:@"个"];
    }
}

// 刷新ScollView高度
- (void)refreshScrollViewHeight{
    if (![self.sciencer.sc_type isEqualToString:@"5"]) {
        
        // 1、计算TableView高度
        CGFloat tableHeight = tableTitleCellHeight;
        tableHeight += tableSectionHeight;
        if(self.uiSciencerStsListBtn.selected){
            if(self.sciencer_total > 10){
                tableHeight += tableMoreCellHeight;
            }
            
            for (int i=0; i<self.sciencerStsList.count; i++) {
                tableHeight += tableDataCellHeight;
            }
        }else{
            if(self.share_total > 10){
                tableHeight += tableMoreCellHeight;
            }
            
            for (int i=0; i<self.shareStsList.count; i++) {
                tableHeight += tableDataCellHeight;
            }
        }
        
        self.conThirdViewHeight.constant = self.conThird1ViewHeight.constant + tableHeight;
        
    }else{
        self.conThirdViewHeight.constant = 0;
    }
    
    CGFloat viewHeight = self.conTopViewHeight.constant + self.conTopAndSecondSpace.constant + self.conSecondViewHeight.constant + self.conSecondAndThirdSpace.constant + self.conThirdViewHeight.constant;
    
    // 高度和界面高度比较
    if (viewHeight > (kSCREEN_HEIGHT - kNAV_HEIGHT)) {
        self.conScrollViewHeight.constant = viewHeight;
    }else{
        self.conScrollViewHeight.constant = kSCREEN_HEIGHT - kNAV_HEIGHT;
        
        // 重新设置tabView和thridView高度
        self.conThirdViewHeight.constant = kSCREEN_HEIGHT - kNAV_HEIGHT - self.conTopViewHeight.constant - self.conTopAndSecondSpace.constant - self.conSecondViewHeight.constant - self.conSecondAndThirdSpace.constant;
    }
}

#pragma mark - 页面元素关联事件
- (IBAction)clickChartShowBtnsAction:(id)sender {
    if (sender == self.uiSciencerStsBtn && !self.uiSciencerStsBtn.selected) {
        // 点击新增注册量
        self.uiSciencerStsBtn.selected = YES;
        self.uiArticleShareStsBtn.selected = NO;
        self.uiOrgShareStsBtn.selected = NO;
        [self showBtnStatusButton:self.uiSciencerStsBtn];
        [self showBtnStatusButton:self.uiArticleShareStsBtn];
        [self showBtnStatusButton:self.uiOrgShareStsBtn];
        
        [self handleChartWithDataArray:self.sciencer_sts];
    }
    if (sender == self.uiArticleShareStsBtn && !self.uiArticleShareStsBtn.selected) {
        // 点击新增分享文章
        self.uiSciencerStsBtn.selected = NO;
        self.uiArticleShareStsBtn.selected = YES;
        self.uiOrgShareStsBtn.selected = NO;
        [self showBtnStatusButton:self.uiSciencerStsBtn];
        [self showBtnStatusButton:self.uiArticleShareStsBtn];
        [self showBtnStatusButton:self.uiOrgShareStsBtn];
        [self handleChartWithDataArray:self.article_share_sts];
    }
    if (sender == self.uiOrgShareStsBtn && !self.uiOrgShareStsBtn.selected) {
        // 点击新增分享基站
        self.uiSciencerStsBtn.selected = NO;
        self.uiArticleShareStsBtn.selected = NO;
        self.uiOrgShareStsBtn.selected = YES;
        [self showBtnStatusButton:self.uiSciencerStsBtn];
        [self showBtnStatusButton:self.uiArticleShareStsBtn];
        [self showBtnStatusButton:self.uiOrgShareStsBtn];
        [self handleChartWithDataArray:self.org_share_sts];
    }
    if (sender == self.uiSciencerStsListBtn && !self.uiSciencerStsListBtn.selected) {
        // 点击科普中国注册活跃榜
        self.uiSciencerStsListBtn.selected = YES;
        self.uiShareStsListBtn.selected = NO;
        [self showBtnStatusButton:self.uiSciencerStsListBtn];
        [self showBtnStatusButton:self.uiShareStsListBtn];
        [self.uiDataTableView reloadData];
        [self refreshScrollViewHeight];
    }
    if (sender == self.uiShareStsListBtn && !self.uiShareStsListBtn.selected) {
        // 点击科普中国传播活跃榜
        self.uiSciencerStsListBtn.selected = NO;
        self.uiShareStsListBtn.selected = YES;
        [self showBtnStatusButton:self.uiSciencerStsListBtn];
        [self showBtnStatusButton:self.uiShareStsListBtn];
        [self.uiDataTableView reloadData];
        [self refreshScrollViewHeight];
    }
}

// 分享按钮事件
- (IBAction)shareBtnAction:(id)sender {
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.uiSciencerStsListBtn.selected) {
        if (self.sciencer_total > 10) {
            return self.sciencerStsList.count + 2;
        }
        return self.sciencerStsList.count + 1;
    }else if(self.uiShareStsListBtn.selected){
        if (self.share_total > 10) {
            return self.shareStsList.count + 2;
        }
        return self.shareStsList.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.uiSciencerStsListBtn.selected) {
        RegisterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[RegisterTableCell ID]];
        if (!cell) {
            cell = [RegisterTableCell newCell];
        }
        SummaryData* summaryData = nil;
        if (indexPath.row != 0 && indexPath.row != 11) {
            summaryData = [self.sciencerStsList objectAtIndex:[indexPath row] - 1];
        }
        
        [cell setCellWithSummaryData:summaryData titleContent:self.content index:indexPath.row showMore:YES];
        
        return cell;
    }else{
        ChuanBoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChuanBoTableCell ID]];
        if (!cell) {
            cell = [ChuanBoTableCell newCell];
        }
        SummaryData* summaryData = nil;
        if (indexPath.row != 0 && indexPath.row != 11) {
            summaryData = [self.shareStsList objectAtIndex:[indexPath row] - 1];
        }
        
        [cell setCellWithSummaryData:summaryData titleContent:self.content index:indexPath.row showMore:YES];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 11) {
        // 即点击更多
        if (self.uiSciencerStsListBtn.selected) {
            // 跳转科普中国注册活跃榜列表
            [FlowUtil startToRegisterDetailVCNav:self.navigationController withSciencer:self.sciencer sectionTitle:self.sciencer_rank];
        }else{
            // 跳转科普中国传播活跃榜列表
            [FlowUtil startToChuanboDetailVCNav:self.navigationController withSciencer:self.sciencer sectionTitle:self.share_rank];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return tableTitleCellHeight;
    }else if(indexPath.row == 11){
        return tableMoreCellHeight;
    }
    return tableDataCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([_sciencer.sc_type isEqualToString:@"0"]) {
        return 0;
    }
    
    if (self.uiSciencerStsListBtn.selected) {
        // 跳转科普中国注册活跃榜列表
        if (self.sciencer_total == 0) {
            return 0;
        }
        
        return tableSectionHeight;
    }else{
        // 跳转科普中国传播活跃榜列表
        if (self.share_total == 0) {
            return 0;
        }
        
        return tableSectionHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [[NSBundle mainBundle]loadNibNamed:@"SectionView" owner:nil options:nil][0];
    view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 28);
    if (self.uiSciencerStsListBtn.selected) {
        // 跳转科普中国注册活跃榜列表
        [view setTitleWithString:self.sciencer_rank];
    }else{
        // 跳转科普中国传播活跃榜列表
        [view setTitleWithString:self.share_rank];
    }
    
    return view;
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return self.chartData;
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return self.titleData;
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFMagenta];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    int max = 0;
    for (int i=0; i<self.chartData.count; i++) {
        int value = [[self.chartData objectAtIndex:i] intValue];
        if (value > max) {
            max = value;
        }
    }
    
    if (max < 5) {
        max = 5;
    }
    
    return max;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 5;
}

#pragma mark - ZFBarChartDelegate

- (id)valueTextColorArrayInBarChart:(ZFGenericChart *)barChart{
    return [UIColor colorWithHex:0x545454];
}

- (NSArray *)gradientColorArrayInBarChart:(ZFBarChart *)barChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)(id)ZFColor(71, 204, 255, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute.locations = @[@(0.5), @(0.99)];
    //        gradientAttribute.startPoint = CGPointMake(0, 0.5);
    //        gradientAttribute.endPoint = CGPointMake(1, 0.5);
    
    //    ZFGradientAttribute * gradientAttribute1 = [[ZFGradientAttribute alloc] init];
    //    gradientAttribute1.colors = @[[UIColor colorWithHex:0x3bdeff], [UIColor colorWithHex:0x308dff]];
    //    gradientAttribute1.colors = @[(id)ZFColor(71, 204, 255, 1).CGColor, (id)ZFWhite.CGColor];
    //    gradientAttribute1.locations = @[@(0.5), @(0.99)];
    //    gradientAttribute1.startPoint = CGPointMake(0, 0.5);
    //    gradientAttribute1.endPoint = CGPointMake(1, 0.5);
    
    return [NSArray arrayWithObjects:gradientAttribute, nil];
}

- (void)barChart:(ZFBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFBar *)bar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    //可在此处进行bar被点击后的自身部分属性设置,可修改的属性查看ZFBar.h
    bar.barColor = ZFGold;
    bar.isAnimated = YES;
    bar.opacity = 0.5;
    [bar strokePath];
}

- (void)barChart:(ZFBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
}

@end

