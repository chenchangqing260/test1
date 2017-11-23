//
//  ActivityIndexWebViewController.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"

#import "ShareModel.h"

@interface ActivityIndexWebViewController : BaseViewController

@property (nonatomic, strong)NSString* titleStr;
@property (nonatomic, strong)ShareModel* shareModel;
-(void)loadWebWithUrl:(NSString *)url;
-(void)writeHtmlToWebview:(NSString *)html;

@end
