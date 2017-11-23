//
//  BaseTableViewCell.h
//  passbook
//
//  Created by Ellison on 16/2/18.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

-(UIViewController *)getSuperViewController;
-(UIView *)getSuperView;

@end
