//
//  QuestionCycleTableViewCell.h
//  ScienceChina
//
//  Created by 三川薛 on 16/6/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface QuestionCycleTableViewCell : BaseTableViewCell

@property (strong, nonatomic)  UILabel *titleLab;

@property (strong, nonatomic)  UIView *backGroundView;

@property (strong, nonatomic)  UIView *CycleImgView;

@property (strong, nonatomic)  UIButton *questionBtn;

@property (strong, nonatomic)  UILabel *questionLab;

@property (strong, nonatomic)  UIButton *typeBtn;

@property (strong, nonatomic)  UILabel *typeLab;

@property (strong, nonatomic)  UIButton *myQuestionBtn;

@property (strong, nonatomic)  UILabel *myQuestionLab;

+(NSString*)ID;
+(QuestionCycleTableViewCell *)newCell;
-(void)addsubviews;


@end
