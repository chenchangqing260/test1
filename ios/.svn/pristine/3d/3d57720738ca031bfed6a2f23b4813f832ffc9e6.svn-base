//
//  MonthIntegralForMonthCompareCell.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//


#import "MonthIntegralForMonthCompareCell.h"
#import "OneMonthIntegralModel.h"
#import "SCChart.h"
#import "XCPickerView.h"
#import "PopoverView.h"
#import "PieCollorCollectionView.h"

@implementation MonthIntegralForMonthCompareCell
{
    NSString *_thisMonth;
    
    UILabel *_monthLabel;
    UIImageView *_arrow;
    
    XCPickerView *_pickerView;
    
    SCPieChart *_chartView;
    
    PieCollorCollectionView *_tipView;
    NSArray *_colors;
    
    UILabel *_noDataLabel;
}

+(NSString *)ID{
    return @"MonthIntegralForMonthCompareCell";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    CGFloat _contentWidth = isIpad? MAIN_SCREEN_WIDTH_ONIpad : MAIN_SCREEN_WIDTH;
    CGFloat left_title = 28.0;
    CGFloat right = 15.0;
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_title, 0, 150, 44)];
    _titleLabel.text = @"当月对比";
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
    
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _arrow.frame.origin.x, _yeatButton.frame.size.height)];
    _monthLabel.font = FONT_12;
    _monthLabel.textColor = [UIColor colorWithHex:0x7a7a7a];
    _monthLabel.textAlignment = NSTextAlignmentLeft;
    
    [_yeatButton addSubview:_monthLabel];
    [_yeatButton addSubview:_arrow];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.size.height, _contentWidth, 1)];
    line.backgroundColor = RGBCOLOR(244, 244, 244);
    
    CGFloat cercleW = 204;
    UIView *cercleView = [[UIView alloc] initWithFrame:CGRectMake((_contentWidth-cercleW)/2.0, line.frame.origin.y+1+27.0, cercleW, cercleW)];
    
//    _colors = @[[UIColor colorWithHex:0xd03547],[UIColor colorWithHex:0x6cc1ac],[UIColor colorWithHex:0xe34053],
//                        [UIColor colorWithHex:0x60a5b4],[UIColor colorWithHex:0x5fb29e],[UIColor colorWithHex:0x6fb8c7],
//                        [UIColor colorWithHex:0x6fb8cf],[UIColor colorWithHex:0xf36a41],[UIColor colorWithHex:0xf95827],
//                        [UIColor colorWithHex:0xfdbb3d],[UIColor colorWithHex:0xffa800]];
//    _colors = @[[UIColor colorWithHex:0xff0000],[UIColor colorWithHex:0xff7f00],[UIColor colorWithHex:0xffff00],
//                [UIColor colorWithHex:0x00ff00],[UIColor colorWithHex:0x00ffff],[UIColor colorWithHex:0x0000ff],
//                [UIColor colorWithHex:0x871f78],[UIColor colorWithHex:0xcd7f32],[UIColor colorWithHex:0xdb9370],
//                [UIColor colorWithHex:0x4f4f2f],[UIColor colorWithHex:0xff00ff]];
//    NSArray *items = @[[SCPieChartDataItem dataItemWithValue:10 color:_colors[0] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[1] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[2] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[3] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[4] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[5] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[6] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[7] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[8] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:5 color:_colors[9] description:@""],
//                       [SCPieChartDataItem dataItemWithValue:5 color:_colors[10] description:@""]
//                       ];
    
    _colors = @[[UIColor colorWithHex:0x985155],[UIColor colorWithHex:0x25495f],
                [UIColor colorWithHex:0x152c3a],[UIColor colorWithHex:0xd96b30],
                [UIColor colorWithHex:0xe6b53c],[UIColor colorWithHex:0x269d81],
                [UIColor colorWithHex:0x068043],[UIColor colorWithHex:0x6bc233]];//,[UIColor colorWithHex:0xb0e283]
    NSArray *items = @[[SCPieChartDataItem dataItemWithValue:10 color:_colors[0] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[1] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[2] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[3] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[4] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[5] description:@""],
                       [SCPieChartDataItem dataItemWithValue:10 color:_colors[6] description:@""],
                       [SCPieChartDataItem dataItemWithValue:30 color:_colors[7] description:@""],
                       ];
    
    
    SCPieChart *chartView = [[SCPieChart alloc] initWithFrame:CGRectMake((_contentWidth-cercleW)/2.0, line.frame.origin.y+1+27.0, cercleW, cercleW) items:items];
    chartView.descriptionTextColor = [UIColor whiteColor];
    chartView.descriptionTextFont  = FONT_12;
    [chartView strokeChart];
    
    _chartView = chartView;
    
    CGFloat left_tip = 23.0;
    _tipView = [[PieCollorCollectionView alloc] initWithFrame:CGRectMake(left_tip, cercleView.frame.origin.y+cercleView.frame.size.height+27.0, _contentWidth-left_tip*2, 0)];
    
    _noDataLabel = [[UILabel alloc] initWithFrame:chartView.frame];
    _noDataLabel.text = @"查询月份没有积分！";
    _noDataLabel.font = FONT_18;
    _noDataLabel.textColor = [UIColor grayColor];
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
    _noDataLabel.hidden = YES;
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_yeatButton];
    [self.contentView addSubview:line];
    [self.contentView addSubview:cercleView];
    [self.contentView addSubview:_tipView];
    [self.contentView addSubview:chartView];
    [self.contentView addSubview:_noDataLabel];
    
    //当前月份
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    NSString *currentMonth = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    _monthLabel.text = [NSString stringWithFormat:@"%@月",currentMonth];
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i=1; i<=12; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",i];
        [data addObject:str];
    }
    
    //    typeof(self) weakSelf = self;
    //    _pickerView = [[XCPickerView alloc] initWithDefaultSelectRow:0 defaultSelectComponent:0 dataArry:data result:^(NSString *result) {
    //        _monthLabel.text = [NSString stringWithFormat:@"%@月",result];
    //        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didSelectedMonth:)]) {
    //            [weakSelf.delegate didSelectedMonth:result];
    //        }
    //    }];    
}
-(void)showPicker:(UIButton *)sender{
    //[_pickerView showPicker];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.maxHeight = 200;
    [popoverView showToView:_arrow withActions:[self months]];
}
- (NSArray<PopoverAction *> *)months {
    
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=1; i<=12; i++) {
        NSString *title = [NSString stringWithFormat:@"%d",i];
        PopoverAction *action = [PopoverAction actionWithImage:nil title:title handler:^(PopoverAction *action) {
            #pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
           _monthLabel.text = [NSString stringWithFormat:@"%@月",action.title];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedMonth:)]) {
                [self.delegate didSelectedMonth:action.title];
            }
            
        }];
        [actions addObject:action];
    }
    
    return actions;
}

-(void)setCellWithScoresArry:(NSArray *)scoresArry{
    
    if (scoresArry && scoresArry.count>0) {
        BOOL hasNum = NO;
        NSMutableArray *percentValues = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
        for (OneMonthIntegralModel *model in scoresArry) {
            
            
            NSString *per = [NSString stringWithFormat:@"%f",[model.item_per floatValue] *10];
            NSString *num = model.itemNum;
            
            [ary addObject:per];
            [percentValues addObject:model.item_per];
            
            if ([model.itemNum integerValue] > 0) {
                hasNum = YES;
            }
        }
        if (hasNum) {
            _chartView.hidden = NO;
            _chartView.percentValues = percentValues;
            [_chartView updateChartByNumbers:ary];
        }else{
            _chartView.hidden = YES;
        }
        
        [_tipView setViewWithClolos:_colors items:scoresArry];
    }else{
        _chartView.hidden = YES;
    }
    
    _noDataLabel.hidden = !_chartView.hidden;

}

@end
