//
//  TiwenTableViewCell.h
//  ScienceChina
//
//  Created by 三川薛 on 16/6/14.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


@interface TiwenTableViewCell : BaseTableViewCell
@property (strong, nonatomic)  UIView *backgroundViewbase;

@property (strong, nonatomic)  UIView *backgroundview;
@property (strong, nonatomic)  UILabel *nameLab;

@property (strong, nonatomic)  UIImageView *touxiangImg;
@property (strong, nonatomic)  UILabel *biaotiLab;
@property (strong, nonatomic)  UILabel *contentTextview;

@property (strong, nonatomic)  UIImageView *contentImg;

@property (strong, nonatomic)  UILabel *backgroundLab;
@property (strong, nonatomic)  UILabel *liulanLab;
@property (strong, nonatomic)  UITextField *pinglunLab;
@property (strong, nonatomic)  UIImageView *pinglunImg;
@property (strong, nonatomic)  UIImageView *liulanImg;

@property (assign, nonatomic)  float heigh;


+(NSString*)ID;
+(TiwenTableViewCell *)newCell;
-(void)setSubviews:(NSString *)contentStr andRepNumStr:(NSString*)pinglun;

@end
