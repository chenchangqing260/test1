//
//  GetRewardsViewController.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GetRewardsViewController.h"
#import "GetRewardsCellForVolunteer.h"
#import "GetRewardsCellForNonVolunteer.h"
#import "GetRewardsCellReceived.h"
#import "XCDatePickerView.h"
#import "GetPrizesModel.h"
#import "PrizesInfoModel.h"
#import "XCDatePickerView.h"
#import "XCYMDatePickerView.h"
#import "PopoverView.h"

@interface GetRewardsViewController ()<UITableViewDelegate,UITableViewDataSource,GetRewardsCellForNonVolunteerDelegate>
{
    NSMutableArray *_volunteerArry;
    NSMutableArray *_nonVolunteerArry;
    GetPrizesModel *_userPrizeModel;
    
    UIColor *_backColor;
    
    NSString *_selectedYearAndMonthStr;
    
    UITableView *_tableView;
    UILabel *_currentMonthLabel;
    UILabel *_monthIntegralHeaderLabel;
    
}
@property (nonatomic,strong)NSString *selectedMonthStr;
@end

@implementation GetRewardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
    [self loadData];
}
-(void)initData{

    _volunteerArry = [[NSMutableArray alloc] initWithCapacity:0];
    _nonVolunteerArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    _backColor = RGBCOLOR(244, 244, 244);
    
    //当前月份
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    NSString *_currentYear = [NSString stringWithFormat:@"%ld",[dateComponent year]];
    NSString *_currentMonth = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    
    NSString *month = _currentMonth;
    if (_currentMonth.length < 2) {
        month = [NSString stringWithFormat:@"0%@",_currentMonth];
    }
    
    self.selectedMonthStr = _currentMonth;
    _selectedYearAndMonthStr = [NSString stringWithFormat:@"%@-%@",_currentYear,month];
}
-(void)setSelectedMonthStr:(NSString *)selectedMonthStr{
    
    NSString *year = [_selectedYearAndMonthStr componentsSeparatedByString:@"-"][0];
    _selectedMonthStr = selectedMonthStr;
    _currentMonthLabel.text = _selectedMonthStr;
    _monthIntegralHeaderLabel.text = [NSString stringWithFormat:@"%@年%@月积分",year,_selectedMonthStr];
}
-(void)setupView{
    self.title = @"领奖区";
    self.view.backgroundColor = _backColor;
    
    CGFloat btnH = 44.0;
    CGFloat imgW = 23.0;
    CGFloat imgH = 23.0;
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, btnH)];
    rightLabel.font = FONT_12;
    rightLabel.text = @"选月";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rightLabel.frame.size.width+10, (btnH-imgH)/2.0, imgW, imgW)];
    rightImageView.image = [UIImage imageNamed:@"calendar_getReward"];
    
    CGFloat monthW = 19.0;
    CGFloat monthH = 12.5;
    _currentMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 8.5, monthW, monthH)];
    _currentMonthLabel.font = FONT_12;
    _currentMonthLabel.text = _selectedMonthStr;
    _currentMonthLabel.textColor = [UIColor whiteColor];
    _currentMonthLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, rightImageView.frame.origin.x+rightImageView.frame.size.width, btnH);
    [rightButton addTarget:self action:@selector(tapRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton addSubview:rightLabel];
    [rightButton addSubview:rightImageView];
    [rightImageView addSubview:_currentMonthLabel];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    CGFloat tableHeaderH = 377.0/750.0*self.showWidth;
    UIImageView *_tableHeader = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, tableHeaderH)];
    _tableHeader.image = [UIImage imageNamed:@"bannerForGetRewards"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = _backColor;
    _tableView.tableHeaderView = _tableHeader;
    
    [self.view addSubview:_tableView];
}

- (NSArray<PopoverAction *> *)actions {
    
    NSString *formaterStr = @"yyyy-MM";
    NSDateFormatter *_dateFormater = [[NSDateFormatter alloc] init];
    [_dateFormater setDateFormat:formaterStr];//@"yyyy-MM-dd"];
    
    
    NSMutableArray *tiems = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *currentM = [_dateFormater stringFromDate:[NSDate date]];
    [tiems addObject:currentM];
    for (int i=1; i<=2; i++) {
        NSDate *beforeDate = [self getBeforeTimeWithMonthWithDateFormatterStr:formaterStr months:-i];
        NSString *beforeYear = [_dateFormater stringFromDate:beforeDate];
        [tiems addObject:beforeYear];
    }
    
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *title in tiems) {
        PopoverAction *action = [PopoverAction actionWithImage:nil title:title handler:^(PopoverAction *action) {
            #pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
            
            NSString *month = [[title componentsSeparatedByString:@"-"] lastObject];
            _selectedYearAndMonthStr = title;//[NSString stringWithFormat:@"%@-%@",year,month];
            self.selectedMonthStr = month;
            [self loadData];
            
        }];
        [actions addObject:action];
    }
    
    return actions;
}

-(void)tapRight:(UIButton *)sender{
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.maxHeight = 200;
    [popoverView showToView:sender withActions:[self actions]];
}


- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}
-(NSDate *)getBeforeTimeWithMonthWithDateFormatterStr:(NSString *)dateFormaterStr months:(NSInteger)month{
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormaterStr];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    //DLog(@"---前两个月 =%@",beforDate);
    return newdate;
}

-(void)loadData{
    NSString *month = [[_selectedYearAndMonthStr componentsSeparatedByString:@"-"]lastObject];
    month = month.length>1?month:[NSString stringWithFormat:@"0%@",month];
    NSString *time = [NSString stringWithFormat:@"%@-%@",[_selectedYearAndMonthStr componentsSeparatedByString:@"-"][0],month];
    [[WebAccessManager sharedInstance] getRewardWithMonth:time Completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _userPrizeModel = [[GetPrizesModel alloc] init];
            _userPrizeModel.currentMonthScore = response.data.currentMonthScore;
            _userPrizeModel.isKepu = response.data.isKepu;
            _userPrizeModel.info = response.data.info;
            
            //prizes 是当前用户的状态下的奖品情况，prizesAnother 是可以看到的另一种用户的状态下的奖品情况
            if (_userPrizeModel.isVolunteer) {
                [_volunteerArry removeAllObjects];
                [_volunteerArry addObjectsFromArray:response.data.prizes];
                
                [_nonVolunteerArry removeAllObjects];
                [_nonVolunteerArry addObjectsFromArray:response.data.prizesAnother];
                
            }else{
                [_volunteerArry removeAllObjects];
                [_volunteerArry addObjectsFromArray:response.data.prizesAnother];
                
                [_nonVolunteerArry removeAllObjects];
                [_nonVolunteerArry addObjectsFromArray:response.data.prizes];
            }
            
            [_tableView reloadData];
            
            
        } else {
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark GetRewardsCellForNonVolunteerDelegate
-(void)getRewardWithModel:(PrizesInfoModel *)model{
    [[WebAccessManager sharedInstance] exchangeRewardWithMonth:_selectedYearAndMonthStr PrizeId:model.prize_id completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            [self loadData];
        } else {
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isVolunteerData = NO;
    PrizesInfoModel *model;
    if (indexPath.section == 0) {
        model = _volunteerArry[indexPath.row];
        isVolunteerData = YES;
    }
    else if (indexPath.section == 1){
        model = _nonVolunteerArry[indexPath.row];
        isVolunteerData = NO;
    }
    
    if (model.isReceived) {
        GetRewardsCellReceived *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellReceived ID]];
        if (!cell) {
            cell = [[GetRewardsCellReceived alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellReceived ID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellWithModel:model];
        return  cell;
    }
    else{
        GetRewardsCellForNonVolunteer *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellForNonVolunteer ID]];
        if (!cell) {
            cell = [[GetRewardsCellForNonVolunteer alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellForNonVolunteer ID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        [cell setCellWithModel:model currentMonthScore:_userPrizeModel.currentMonthScore isVolunteerData:isVolunteerData isVolunteerUser:_userPrizeModel.isVolunteer];
        return  cell;
    }
    return nil;
    
    
    
    
    if (indexPath.section == 0) {
        
        PrizesInfoModel *model = _volunteerArry[indexPath.row];
        if (model.isReceived) {
            GetRewardsCellReceived *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellReceived ID]];
            if (!cell) {
                cell = [[GetRewardsCellReceived alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellReceived ID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCellWithModel:_volunteerArry[indexPath.row]];
            return  cell;
        }
        else{
            GetRewardsCellForVolunteer *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellForVolunteer ID]];
            if (!cell) {
                cell = [[GetRewardsCellForVolunteer alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellForVolunteer ID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCellWithModel:_volunteerArry[indexPath.row]];
            return  cell;
        }
        
    }
    else if (indexPath.section == 1) {
        PrizesInfoModel *model = _volunteerArry[indexPath.row];
        if (model.isReceived) {
            GetRewardsCellReceived *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellReceived ID]];
            if (!cell) {
                cell = [[GetRewardsCellReceived alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellReceived ID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCellWithModel:_nonVolunteerArry[indexPath.row]];
            return  cell;
        }
        else{
            GetRewardsCellForNonVolunteer *cell = [tableView dequeueReusableCellWithIdentifier:[GetRewardsCellForNonVolunteer ID]];
            if (!cell) {
                cell = [[GetRewardsCellForNonVolunteer alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GetRewardsCellForNonVolunteer ID]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCellWithModel:_nonVolunteerArry[indexPath.row] currentMonthScore:_userPrizeModel.currentMonthScore isVolunteerData:NO isVolunteerUser:NO];
            return  cell;
        }
        
    }
    
    return  nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if (section == 0) {
        rows = _volunteerArry.count;
    } else if (section == 1) {
        rows = _nonVolunteerArry.count;
    }
    return rows;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return GetRewardsCellForVolunteerCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 37.0;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, 37.0)];
    view.backgroundColor = _backColor;
    
    UIColor *_greenColor = [UIColor colorWithHex:0x33cfdb];
    UIColor *_redColor = [UIColor colorWithHex:0xf34754];
    
    CGFloat left = 16;
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (view.bounds.size.height-13)/2.0, 3, 13)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0.0, 200, view.bounds.size.height)];
    titleLabel.font = FONT_13;
    if (section == 0) {
        
        NSString *score = @"0";
        if (_userPrizeModel) {
            score = _userPrizeModel.currentMonthScore;
        }
        
        leftLabel.backgroundColor = _greenColor;
        titleLabel.textColor = _greenColor;
        titleLabel.text = @"科普员—流量包奖励";
        
        UILabel *integralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width-left-40, 0.0, 40, view.bounds.size.height)];
        integralNumLabel.font = FONT_12;
        integralNumLabel.text = score;
        integralNumLabel.textColor = [UIColor orangeColor];
        integralNumLabel.textAlignment = NSTextAlignmentRight;
        
        _monthIntegralHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(integralNumLabel.frame.origin.x-90, 0.0, 95, view.bounds.size.height)];
        _monthIntegralHeaderLabel.font = FONT_12;
        _monthIntegralHeaderLabel.textColor = [UIColor blackColor];
        _monthIntegralHeaderLabel.textAlignment = NSTextAlignmentLeft;
        //_monthIntegralHeaderLabel.text = [NSString stringWithFormat:@"%@月积分",_selectedMonthStr];
        
        NSString *year = [_selectedYearAndMonthStr componentsSeparatedByString:@"-"][0];
        _monthIntegralHeaderLabel.text = [NSString stringWithFormat:@"%@年%@月积分",year,_selectedMonthStr];
        
        [view addSubview:integralNumLabel];
        [view addSubview:_monthIntegralHeaderLabel];
        
    } else if (section == 1) {
        leftLabel.backgroundColor = _redColor;
        titleLabel.textColor = _redColor;
        titleLabel.text = @"未认证科普员—流量包奖励";
    }
    
    [view addSubview:leftLabel];
    [view addSubview:titleLabel];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
