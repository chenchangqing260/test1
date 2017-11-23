//
//  WeChatPublicNumberViewController.h
//  ScienceChina
//
//  Created by xuanyj on 2017/1/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoCategory.h"

@interface WeChatPublicNumberViewController : BaseViewController
@property (nonatomic, assign) BOOL isBackButton;//yes:箭头 no:三条横线的图标,  默认为no
@property (nonatomic, strong) InfoCategory* category;
-(void)resetTableFrameWithIsLeft:(BOOL)isLeft;

@end
