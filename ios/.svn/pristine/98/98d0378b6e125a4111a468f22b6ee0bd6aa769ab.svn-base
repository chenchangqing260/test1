//
//  MonthIntegralViewController.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MonthIntegralViewController.h"
#import "MonthIntegralForAnnualCompareCell.h"
#import "MonthIntegralForMonthCompareCell.h"
#import "OneYearIntegralModel.h"
#import "OneMonthIntegralModel.h"

@interface MonthIntegralViewController () <UITableViewDelegate,UITableViewDataSource,MonthIntegralForAnnualCompareCellDelegate,MonthIntegralForMonthCompareCellDelegate>
{
    NSMutableArray *_tableData;
    NSMutableArray *_oneYearScoreData;
    NSMutableArray *_oneMonthScoreData;
    NSString *_currentMonthScore;
    NSString *_currentYear;
    NSString *_selectedYear;
    NSString *_selectedMonth;
    
    UIColor *_backColor;
    
    UITableView *_tableView;
    
    BOOL _refreshYearData;
}
@end

@implementation MonthIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
    [self loadData];
}
-(void)initData{
    _currentMonthScore = @"0";
    _tableData = [[NSMutableArray alloc] initWithCapacity:0];
    _oneYearScoreData = [[NSMutableArray alloc] initWithCapacity:0];
    _oneMonthScoreData = [[NSMutableArray alloc] initWithCapacity:0];
    _backColor = RGBCOLOR(244, 244, 244);
}
-(void)setupView{
    self.title = @"积分汇总";
    self.view.backgroundColor = _backColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = _backColor;
    
    [self.view addSubview:_tableView];
}
-(void)loadData{
    
    //当前月份
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    _selectedYear = [NSString stringWithFormat:@"%ld",[dateComponent year]];
    _selectedMonth = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    
    _currentYear = _selectedYear;
    
    NSString *month = _selectedMonth;
    if (_selectedMonth.length < 2) {
        month = [NSString stringWithFormat:@"0%@",_selectedMonth];
    }
    [self getintegralByYear:_selectedYear];
    [self getintegralByMonth:[NSString stringWithFormat:@"%@-%@",_selectedYear,month]];
    
}
-(void)getintegralByYear:(NSString *)year{
    [[WebAccessManager sharedInstance] getScoreByYear:year completion:^(NSDictionary *response, NSError *error) {
        NSLog(@"%@",response);
        if ([response[@"success"] integerValue] == 1) {
            _oneYearScoreData = response[@"data"][@"lineData"];
            if (_oneYearScoreData && _oneYearScoreData.count>0) {
                if ([_selectedMonth integerValue]-1 >= 0 && [_selectedMonth integerValue]-1 < _oneYearScoreData.count) {
                    if ([year integerValue] == [_currentYear integerValue] ) {
                        _currentMonthScore = _oneYearScoreData[[_selectedMonth integerValue]-1];
                    }
                }
            }
            _refreshYearData = YES;
            [_tableView reloadData];

        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}
-(void)getintegralByMonth:(NSString *)month{
    [[WebAccessManager sharedInstance] getScoreByMonth:month completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _refreshYearData = NO;
            _oneMonthScoreData = response.data.pieData;
            [_tableView reloadData];
            
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark MonthIntegralForAnnualCompareCellDelegate
-(void)didSelectedYear:(NSString *)result{
    _selectedYear = result;
    [self getintegralByYear:result];
}
#pragma markMonthIntegralForMonthCompareCellDelegate
-(void)didSelectedMonth:(NSString *)result{
    _selectedMonth = result;
    
    NSString *month = result;
    if (result.length < 2) {
        month = [NSString stringWithFormat:@"0%@",result];
    }
    NSString *time = [NSString stringWithFormat:@"%@-%@",_selectedYear,month];
    [self getintegralByMonth:time];
}
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MonthIntegralForAnnualCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:[MonthIntegralForAnnualCompareCell ID]];
        if (!cell) {
            cell = [[MonthIntegralForAnnualCompareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MonthIntegralForAnnualCompareCell ID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        if (_refreshYearData) {
            [cell setCellWithScoresArry:_oneYearScoreData];
        }
        return  cell;
    }
    else if (indexPath.section == 1) {
        MonthIntegralForMonthCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:[MonthIntegralForMonthCompareCell ID]];
        if (!cell) {
            cell = [[MonthIntegralForMonthCompareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MonthIntegralForMonthCompareCell ID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        if (!_refreshYearData) {
            [cell setCellWithScoresArry:_oneMonthScoreData];
        }
        return  cell;
    }
    
    return  nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;//_tableData.count;;
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.section == 0) {
        height = MonthIntegralForAnnualCompareCellHeight;
    } else if (indexPath.section == 1) {
        height = MonthIntegralForMonthCompareCellHeight;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if (section == 0) {
        height = 37.0;
    } else if (section == 1) {
        height = 8.0;
    }
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat height;
    if (section == 0) {
        height = 37.0;
    } else if (section == 1) {
        height = 8.0;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showWidth, height)];
    view.backgroundColor = _backColor;
    
    if (section == 0) {
        CGFloat left = 28;
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(28.0, (view.bounds.size.height-13)/2.0, 150, 13)];
        leftLabel.font = FONT_12;
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.text = [NSString stringWithFormat:@"本月积分%@",_currentMonthScore];
        
        CGFloat iconW = 17.5;
        CGFloat iconH = 17.5;
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width-left-iconW, (view.frame.size.height-iconH)/2.0, iconW, iconH)];
        rightImageView.image = [UIImage imageNamed:@"iconMoneyOnJiFen"];
        
        [view addSubview:rightImageView];
        [view addSubview:leftLabel];
    }
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
