//
//  XCYMDatePickerView.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/27.
//  Copyright © 2016年 sevenplus. All rights reserved.
//  年月选择器

#import <UIKit/UIKit.h>

@interface XCYMDatePickerView : UIView
/**
 * 初始化完成后 无需 添加到父视图
 */
-(id)initWithSlectedCurrentMonth:(BOOL)isSlectedCurrentMonth minYear:(NSInteger)minYear maxYear:(NSInteger)maxYear result:(void (^)(NSString *year,NSString *month))resultBlock;

-(void)showPicker;
/*将pickerview  彻底移除*/
-(void)removePicker;
@end
