//
//  XCPickerView.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/22.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "XCPickerView.h"

typedef void(^ResultBlock)(NSString *result);

@interface XCPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@end
@implementation XCPickerView
{
    ResultBlock _resultBlock;
    NSArray *_dataArry;
    UIView *_contentView;
    UIPickerView *_pickerView;
    
    NSInteger _defaultSelectRow;
    NSInteger _defaultComponent;
    
}
-(id)init{
    if (self = [super init]) {
        [self initDataWithDefaultSelectRow:0 defaultSelectComponent:0 dataArry:nil];
        [self setupView];
    }
    return self;
}
-(id)initWithDefaultSelectRow:(NSInteger)selectRow defaultSelectComponent:(NSInteger)selectComponent dataArry:(NSArray *)dataArry result:(void (^)(NSString *result))resultBlock{
    if (self = [super init]) {
        _resultBlock = resultBlock;
        [self initDataWithDefaultSelectRow:selectRow defaultSelectComponent:selectComponent dataArry:dataArry];
        [self setupView];
    }
    return self;
}
-(void)initDataWithDefaultSelectRow:(NSInteger)selectRow defaultSelectComponent:(NSInteger)selectComponent dataArry:(NSArray *)dataArry{
    _defaultSelectRow = selectRow;
    _defaultComponent = selectComponent;
    
    if (dataArry) {
        _dataArry = dataArry;
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
    NSInteger select = [_pickerView selectedRowInComponent:0];
    _resultBlock(_dataArry[select]);
    NSLog(@"%@",_dataArry[select]);
    [self dismissPicker];
}




#pragma mark - pickerView Delegate and dataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArry.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataArry[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"didSelect %@",_dataArry[row]);
}
//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
//        //文字收缩到多少后停止缩小
//        pickerLabel.minimumScaleFactor = 8;
//        //文字大小自适应
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
//    }
//    // Fill the label text here
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}

@end
