//
//  ChooseCompanyViewController.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "SciencerCompany.h"

@protocol ChooseCompanyDelegate <NSObject>

- (void)setCompanyData:(NSString*)companyName;

@end

@interface ChooseCompanyViewController : BaseViewController

@property (nonatomic, strong)NSString* town_code;
@property (nonatomic, weak)id<ChooseCompanyDelegate> delegate;

@end
