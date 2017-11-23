//
//  LeftListCell.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/1.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LeftListCellHeight 50

@interface LeftListCell : UITableViewCell
-(void)setCellWithTitle:(NSString *)title imageName:(NSString *)imagename lineHidden:(BOOL)lineHidden;
@end
