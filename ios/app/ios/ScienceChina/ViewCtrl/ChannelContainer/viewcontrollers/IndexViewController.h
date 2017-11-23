//
//  IndexViewController.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/3.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoCategory.h"

@interface IndexViewController : BaseViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) InfoCategory* category;
@end
