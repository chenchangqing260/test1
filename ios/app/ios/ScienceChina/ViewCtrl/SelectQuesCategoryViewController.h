//
//  SelectQuesCategoryViewController.h
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "QuestionCategory.h"

@protocol SelectQuesCategoryDelegate <NSObject>

- (void)selectCategory:(QuestionCategory*)category;

@end

@interface SelectQuesCategoryViewController : BaseViewController

@property (nonatomic, weak)id<SelectQuesCategoryDelegate> delegate;

@end
