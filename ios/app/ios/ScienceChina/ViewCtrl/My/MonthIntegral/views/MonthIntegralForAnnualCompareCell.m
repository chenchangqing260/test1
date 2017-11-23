//
//  MonthIntegralForAnnualCompareCell.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MonthIntegralForAnnualCompareCell.h"
#import "JHLineChart.h"
#import "PopoverView.h"

@implementation MonthIntegralForAnnualCompareCell
{
    NSString *_currentYear;//当前年份
    
    UILabel *_titleLabel;
    UILabel *_yearLabel;
    JHLineChart *_lineChart;
    UIImageView *_arrow;
}
+(NSString *)ID{
    return @"MonthIntegralForAnnualCompareCell";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _currentYear = [self getCurrentYear];

    CGFloat _contentWidth = isIpad? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    CGFloat left = 28.0;
    CGFloat right = 15.0;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, 150, 44)];
    _titleLabel.font = FONT_12;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat buttonW = 50;
    CGFloat arrowW = 14;
    CGFloat arrowH = 8;
    UIButton *_yeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _yeatButton.frame = CGRectMake(_contentWidth-right-buttonW, 0, buttonW, 44);
    [_yeatButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    
    _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(_yeatButton.frame.size.width-arrowW, (_yeatButton.frame.size.height-arrowH)/2.0, arrowW, arrowH)];
    _arrow.image = [UIImage imageNamed:@"arrowOnJiFen"];
    
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _arrow.frame.origin.x, _yeatButton.frame.size.height)];
    _yearLabel.font = FONT_12;
    _yearLabel.textColor = [UIColor colorWithHex:0x7a7a7a];
    _yearLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.size.height, _contentWidth, 1)];
    line.backgroundColor = RGBCOLOR(244, 244, 244);
    
    CGFloat _chartViewH = 237.0;
    UIView *chartView = [[UIView alloc] initWithFrame:CGRectMake(0, MonthIntegralForAnnualCompareCellHeight-_chartViewH, _contentWidth, _chartViewH)];
    [self showFirstQuardrantSuperView:chartView];
    
    
    [_yeatButton addSubview:_yearLabel];
    [_yeatButton addSubview:_arrow];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_yeatButton];
    [self.contentView addSubview:line];
    [self.contentView addSubview:chartView];
    
    _titleLabel.text = [NSString stringWithFormat:@"%@年积分获得对比",_currentYear];
    _yearLabel.text = _currentYear;
    
}

//第一象限折线图
- (void)showFirstQuardrantSuperView:(UIView *)superView{
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height) andLineChartType:JHChartLineValueNotForEveryX];
    
    lineChart.xLineDataArr = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    lineChart.contentInsets = UIEdgeInsetsMake(0, 30, 20, 10);
    lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    lineChart.animationPathWidth = 2;
    lineChart.lineWidth = 1;
    lineChart.showYLevelLine = NO;//是否显示横向虚线
    lineChart.showYLine = NO;
    lineChart.showValueLeadingLine = NO;
    lineChart.valueFontSize = 10.0;
    lineChart.pointNumberColorArr = @[[UIColor colorWithHex:0x33cfda]];
    lineChart.backgroundColor = [UIColor whiteColor];
    lineChart.xAndYLineColor = [UIColor blackColor];
    lineChart.xNumberColor = [UIColor blackColor];
    lineChart.yNumberColor = [UIColor blackColor];
    lineChart.contentFill = NO;
    lineChart.pathCurve = NO;//曲线、直线
    lineChart.customYLineDataArr = NO;
    //lineChart.yLineDataArr = @[@3000,@6000,@9000];
    [superView addSubview:lineChart];
    _lineChart = lineChart;
}
-(void)showPicker:(UIButton *)sender{
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.maxHeight = 200;
    [popoverView showToView:_arrow withActions:[self years]];
}
- (NSArray<PopoverAction *> *)years {
    
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=2015; i<=[_currentYear integerValue]; i++) {
        NSString *title = [NSString stringWithFormat:@"%d",i];
        PopoverAction *action = [PopoverAction actionWithImage:nil title:title handler:^(PopoverAction *action) {
        #pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
            
            DLog(@">>>>>>>>>>>>>>>>>>>>>>>  %@",action.title);
            

            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedYear:)]) {
                [self.delegate didSelectedYear:action.title];
            }
            
            _titleLabel.text = [NSString stringWithFormat:@"%@年积分获得对比",action.title];
            _yearLabel.text = action.title;
            
        }];
        [actions addObject:action];
    }
    
    return actions;
}
-(NSString *)getCurrentYear{
    //当前年份
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    NSString *currentYear = [NSString stringWithFormat:@"%ld",[dateComponent year]];
    return currentYear;
}

-(void)setCellWithScoresArry:(NSArray *)scoresArry{

    if (scoresArry && scoresArry.count>0) {
        [_lineChart clear];
        _lineChart.valueLineColorArr =@[ [UIColor colorWithHex:0xeb6100]];
        _lineChart.pointColorArr = @[[UIColor colorWithHex:0xeb6100]];
        _lineChart.pointNumberColorArr = @[[UIColor colorWithHex:0x33cfda]];
        _lineChart.positionLineColorArr = @[[UIColor blueColor]];
        _lineChart.contentFillColorArr = @[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.468]];
        _lineChart.valueArr = @[scoresArry];
        [_lineChart showAnimation];
    }
}

@end
