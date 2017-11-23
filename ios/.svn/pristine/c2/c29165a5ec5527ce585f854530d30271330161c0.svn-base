//
//  SettingTableViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

typedef NS_ENUM(NSInteger,SWITCHFlag){
    SWITCHFlag_message = 0,
    SWITCHFlag_daliyShow,
    SWITCHFlag_video,
    SWITCHFlag_comment,
};

@interface SettingTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *uiImgView;
@property (weak, nonatomic) IBOutlet UIImageView *uiFontImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiFontTextLab;
@property (weak, nonatomic) IBOutlet UISwitch *uiSwitch;
@property (weak, nonatomic) IBOutlet UIView *uiFontSizeView;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (weak, nonatomic) IBOutlet UIView *uiLogoutView;
@property (weak, nonatomic) IBOutlet UIView *uiBottomLine;
@property (nonatomic, assign)SWITCHFlag flag;

+(NSString*)ID;
+(SettingTableViewCell *)newCell;

@end
