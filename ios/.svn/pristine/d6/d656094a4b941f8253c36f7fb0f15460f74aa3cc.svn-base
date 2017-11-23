//
//  XCDatePickerView.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "XCDatePickerView.h"

typedef void(^ResultBlock)(NSDate *date);

@interface XCDatePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation XCDatePickerView
{
    UIDatePicker    *_timePickerView;//pick
    NSDateFormatter *_dateFormater;
    
    ResultBlock _resultBlock;
    
}
-(id)initWithDateFormateString:(NSString*)dateFormateString minimumDateString:(NSString*)minimumDateString maximumDateString:(NSString *)maximumDateString defaultDate:(NSString *)defaultDate datePickerMode:(UIDatePickerMode)pickerMode result:(void (^)(NSDate *date))resultBlock{
    if (self = [super init]) {
        [self creatViewWithDateFormateString:dateFormateString minimumDateString:minimumDateString maximumDateString:maximumDateString  defaultDate:defaultDate datePickerMode:pickerMode result:resultBlock];
    }
    return self;
}
-(void)creatViewWithDateFormateString:(NSString*)dateFormateString minimumDateString:(NSString*)minimumDateString maximumDateString:(NSString *)maximumDateString  defaultDate:(NSString *)defaultDate datePickerMode:(UIDatePickerMode)pickerMode result:(void (^)(NSDate *date))resultBlock{
    
    _resultBlock = resultBlock;
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    //ActionSheet-tool bar
    UIToolbar   *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 40)];
    pickerDateToolbar.backgroundColor = [UIColor whiteColor];
    [pickerDateToolbar sizeToFit];
    
    //tool-取消
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBarCanelClick)];
    cancelBtn.tintColor = [UIColor colorWithHex:0x3499da];
    //tool- 取消 and 确定 之间的间距
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //tool-确定
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定  " style:UIBarButtonItemStyleDone target:self action:@selector(toolBarDoneClick)];
    doneBtn.tintColor = [UIColor colorWithHex:0x3499da];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    [barItems addObject:cancelBtn];
    [barItems addObject:flexSpace];
    [barItems addObject:doneBtn];
    [pickerDateToolbar setItems:barItems animated:YES];
    
    //ActionSheet-data pick
    _dateFormater = [[NSDateFormatter alloc] init];
    [_dateFormater setDateFormat:dateFormateString];//@"yyyy-MM-dd"];
    
    //开始时间
    NSDate *minimumDate = [_dateFormater dateFromString:minimumDateString];//@"1900-01"
    minimumDate         = [self getNewDateWithNoTimeDifferenceWithCurrentDate:minimumDate];
    
    //结束时间
    NSDate *maximumDate = [_dateFormater dateFromString:maximumDateString];
    maximumDate         = [self getNewDateWithNoTimeDifferenceWithCurrentDate:maximumDate];
    
    //时间选择器
    _timePickerView = [[UIDatePicker alloc] init];
    _timePickerView.frame = CGRectMake(0, 40, self.frame.size.width,216);
    _timePickerView.backgroundColor = [UIColor whiteColor];
    [_timePickerView setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]]; // 0.4s
    [_timePickerView setMinimumDate:minimumDate];
    [_timePickerView setMaximumDate:maximumDate];
    if (pickerMode) {
        [_timePickerView setDatePickerMode:pickerMode];
    }else{
        [_timePickerView setDatePickerMode:UIDatePickerModeDate];
    }
    if (defaultDate) {
        NSDate *defaultD = [_dateFormater dateFromString:defaultDate];
        defaultD         = [self getNewDateWithNoTimeDifferenceWithCurrentDate:defaultD];
        [_timePickerView setDate:defaultD];
    }
    
    // 盛放时间选择器的view
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-256, self.frame.size.width, 216+40)];
    contentView.tag = 11;
    
    //背景button，作用：点击消失
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    dismissButton.backgroundColor = [UIColor clearColor];
    [dismissButton addTarget:self action:@selector(dismissPick) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView addSubview:pickerDateToolbar];
    [contentView addSubview:_timePickerView];
    [self addSubview:dismissButton];
    [self addSubview:contentView];
}

#pragma mark tool bar button click
-(void)toolBarCanelClick{
    [self dismissPick];
}
-(void)toolBarDoneClick{
    [self dismissPick];
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeDate:)]) {
        [self.delegate changeDate:_timePickerView.date];
    }
    _resultBlock(_timePickerView.date);
}

#pragma mark actionView
-(void)dismissPick{
    
    [UIView animateWithDuration:0.5 animations:^{
        UIView *contentView  = [self viewWithTag:11];
        contentView.frame = CGRectMake(0, self.bounds.size.height, contentView.frame.size.width, contentView.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCancel)]) {
//        [self.delegate tapCancel];
//    }
}
//
//-(void)removePicker{
//    [UIView animateWithDuration:0.5 animations:^{
//        UIView *contentView  = [self viewWithTag:11];
//        contentView.frame = CGRectMake(0, self.bounds.size.height, contentView.frame.size.width, contentView.frame.size.height);
//        
//    } completion:^(BOOL finished) {
//        self.hidden = YES;
//        [self removeFromSuperview];
//    }];
//}

-(void)showPicker
{
    self.hidden = NO;
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        UIView *contentView  = [self viewWithTag:11];
        contentView.frame = CGRectMake(contentView.frame.origin.x, self.frame.size.height-contentView.frame.size.height, contentView.frame.size.width, contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
    }];
}
#pragma mark 时间处理
-(NSDate *)getDateFromTihsDate:(NSDate *)date year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    //    NSInteger month;
    //    if (isBefore) {
    //        month = -1;//获取date的前一个月
    //    } else {
    //        month = 1; //获取date的后一个月
    //    }
    
    //-2:date的前2个月；2:获取date的后2个月；0:当月，年，日同理
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    
    [adcomps setDay:day];
    //[adcomps setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"GTM"]];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    return newdate;
}
-(NSDate *)getNewDateWithNoTimeDifferenceWithCurrentDate:(NSDate *)currentDate{
    //+8小时间隔
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    NSDate *newDate = [currentDate dateByAddingTimeInterval:interval];
    return  newDate;
}

-(void)setPickerFrame:(CGRect)frame{
    _timePickerView.frame = frame;
}

@end
