//
//  XCDatePickerView.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCDatePickerViewDelegate <NSObject>
@optional
-(void)changeDate:(NSDate *)date;
@end

@interface XCDatePickerView : UIView
@property (nonatomic,assign)id <XCDatePickerViewDelegate> delegate;
@property (nonatomic,assign)BOOL showDay;

/**
 *  初始化时间选择器
 *
 *  @param dateFormateString 时间格式 如："YY-dd-mm hh:MM:ss"
 *  @param minimumDateString 最小时间
 *  @param maximumDateString 最大时间
 *  @param defaultDate       默认显示的时间
 *  @param pickerMode        传nil 默认设置为UIDatePickerModeDate 否则设置为用户设置的类型
 *  @param pickFrame         pickView的frame  传nil,按照默认的显示；否则设置为用户设置的frame
 *
 *  @return 时间选择器
 */
-(id)initWithDateFormateString:(NSString*)dateFormateString minimumDateString:(NSString*)minimumDateString maximumDateString:(NSString *)maximumDateString defaultDate:(NSString *)defaultDate datePickerMode:(UIDatePickerMode)pickerMode result:(void (^)(NSDate *date))resultBlock;

-(void)showPicker;
/*将pickerview  彻底移除*/
-(void)removePicker;
@end
