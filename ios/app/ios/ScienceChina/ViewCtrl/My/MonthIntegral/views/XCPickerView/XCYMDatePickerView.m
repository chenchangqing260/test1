//
//  XCYMDatePickerView.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/27.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "XCYMDatePickerView.h"

typedef void(^ResultBlock)(NSString *year,NSString *month);

@interface XCYMDatePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@end
@implementation XCYMDatePickerView
{
    ResultBlock _resultBlock;
    NSMutableArray *_yearsArry;
    NSArray *_monthsArry;
    UIView *_contentView;
    UIPickerView *_pickerView;
    
    NSString *_selectedYear;
    NSString *_selectedMonth;
    
    BOOL  _isSlectedCurrentMonth;
    
}
-(id)init{
    if (self = [super init]) {
        //当前月份
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
        
        [self initDataWithSlectedCurrentMonth:NO minYear:1990 maxYear:[dateComponent year]];
        [self setupView];
    }
    return self;
}
-(id)initWithSlectedCurrentMonth:(BOOL)isSlectedCurrentMonth minYear:(NSInteger)minYear maxYear:(NSInteger)maxYear result:(void (^)(NSString *year,NSString *month))resultBlock{
    if (self = [super init]) {
        _resultBlock = resultBlock;
        [self initDataWithSlectedCurrentMonth:isSlectedCurrentMonth minYear:minYear maxYear:maxYear];
        [self setupView];
    }
    return self;
}
-(void)initDataWithSlectedCurrentMonth:(BOOL)isSlectedCurrentMonth  minYear:(NSInteger)minYear maxYear:(NSInteger)maxYear{
    _isSlectedCurrentMonth = isSlectedCurrentMonth;
    _monthsArry = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    _yearsArry = [[NSMutableArray alloc] initWithCapacity:0];
    if (minYear>0 && maxYear>0 && maxYear>=minYear) {
        for (NSInteger i = minYear; i<=maxYear; i++) {
            NSString *title = [NSString stringWithFormat:@"%ld",i];
            [_yearsArry addObject:title];
        }
    }
    
    _selectedYear = _yearsArry[0];
    _selectedMonth = _monthsArry[0];
    if (_isSlectedCurrentMonth) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
        _selectedMonth = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    }
    
}
-(void)setupView{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    [self addGestureRecognizer:tap];
    self.hidden = YES;
    
    CGFloat btnViewH = 40;
    CGFloat btnViewW = 50;
    CGFloat pickerH = 250;
    CGFloat contentViewH = pickerH+btnViewH;
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.bounds.size.width, contentViewH)];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, btnViewH)];
    btnView.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *btnCancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnViewW, btnViewH)];
    [btnCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancle setTitleColor:[UIColor colorWithHex:0x00519b] forState:UIControlStateNormal];
    btnCancle.titleLabel.font=[UIFont systemFontOfSize:15];
    [btnCancle addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnEnter = [[UIButton alloc]initWithFrame:CGRectMake(_contentView.frame.size.width-btnViewW, 0, btnViewW, 40)];
    [btnEnter setTitle:@"确定" forState:UIControlStateNormal];
    [btnEnter setTitleColor:[UIColor colorWithHex:0x00519b] forState:UIControlStateNormal];
    btnEnter.titleLabel.font=[UIFont systemFontOfSize:15];
    [btnEnter addTarget:self action:@selector(enterBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, btnView.frame.origin.y+btnView.frame.size.height, _contentView.frame.size.width, pickerH)];
    _pickerView.backgroundColor=[UIColor whiteColor];
    _pickerView.delegate=self;
    _pickerView.dataSource=self;
    
    //设置默认选中
    if (_isSlectedCurrentMonth) {
        NSInteger selectComponet = 0;
        NSInteger selectRow = 0;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
        
        for (NSInteger i=0; i<_yearsArry.count; i++) {
            NSString *year = _yearsArry[i];
            if ([year integerValue] == [dateComponent year]) {
                selectComponet = i;
                break;
            }
        }
        for (NSInteger i=0; i<_monthsArry.count; i++) {
            NSString *month = _monthsArry[i];
            if ([month integerValue] == [dateComponent month]) {
                selectRow = i;
                break;
            }
        }
        
        [_pickerView selectRow:selectRow inComponent:1 animated:YES];
    }else{
        [_pickerView selectRow:0 inComponent:0 animated:YES];
    }
    
    [btnView addSubview:btnCancle];
    [btnView addSubview:btnEnter];
    
    [self addSubview:_contentView];
    [_contentView addSubview:btnView];
    [_contentView addSubview:_pickerView];
}
-(void)showPicker
{
    self.hidden = NO;
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    
    [_pickerView reloadAllComponents];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height-_contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
    }];
}
-(void)removePicker{
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}
-(void)dismissPicker{
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
#pragma mark - pickerView取消按钮
-(void)cancleBtnAction
{
    [self dismissPicker];
}
#pragma mark - pickerView确定按钮
-(void)enterBtnAction
{
    //NSInteger select = [_pickerView selectedRowInComponent:0];
    
    NSString *result = [NSString stringWithFormat:@"%@-%@",_selectedYear,_selectedMonth];
     _resultBlock(_selectedYear,_selectedMonth);
    NSLog(@"didSelect time : %@",result);
    [self dismissPicker];
}




#pragma mark - pickerView Delegate and dataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger nums = 0;
    if (component == 0) {
        nums = _yearsArry.count;
    }else{
        nums = _monthsArry.count;
    }
    return nums;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    if (component == 0) {
        title = _yearsArry[component];
    }else{
        title = _monthsArry[row];
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _selectedYear = _yearsArry[component];
    }else{
        _selectedMonth = _monthsArry[row];
    }
}

@end
