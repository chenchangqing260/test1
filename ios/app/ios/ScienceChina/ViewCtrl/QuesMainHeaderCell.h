//
//  QuesMainHeaderCell.h
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol QuestionMainHeaderDelegate <NSObject>

- (void)clickAskQuesBtnAction;
- (void)clickMyQuesBtnAction;
- (void)clickMyAnswerBtnAction;
- (void)clickQuestionBainnerAction:(RecList*)ques;

@end

@interface QuesMainHeaderCell : BaseTableViewCell

@property (nonatomic, weak)id<QuestionMainHeaderDelegate> delegate;
@property (nonatomic, strong)NSMutableArray* quesRecList;
+(NSString*)ID;
+(QuesMainHeaderCell *)newCell;

@end
