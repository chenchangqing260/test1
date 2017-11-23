//
//  BaseTableViewCell.m
//  passbook
//
//  Created by Ellison on 16/2/18.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // 设置Cell的选中颜色，点击两次点击才能够调用的问题
    self.selectedBackgroundView = [[UIView alloc] initWithFrame: self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithHex:0xffffff alpha:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UIViewController *)getSuperViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(UIView *)getSuperView{
    UIViewController *vc = [self getSuperViewController];
    if (vc != nil) {
        return vc.view;
    }else{
        return nil;
    }
}

@end
