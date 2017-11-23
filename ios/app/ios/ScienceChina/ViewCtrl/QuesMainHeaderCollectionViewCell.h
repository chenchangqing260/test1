//
//  QuesMainHeaderCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/31.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionMainHeaderCellDelegate <NSObject>

- (void)clickAskQuesBtnAction;
- (void)clickMyQuesBtnAction;
- (void)clickMyAnswerBtnAction;
- (void)clickQuestionBainnerAction:(RecList*)ques;

@end

@interface QuesMainHeaderCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<QuestionMainHeaderCellDelegate> delegate;
@property (nonatomic, strong)NSMutableArray* quesRecList;
+(NSString*)ID;

@end
