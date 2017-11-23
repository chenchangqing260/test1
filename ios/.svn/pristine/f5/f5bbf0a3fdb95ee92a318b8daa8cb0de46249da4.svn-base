//
//  LabelUtil.m
//  ScienceChina
//
//  Created by Ellison on 16/5/5.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "LabelUtil.h"

@implementation LabelUtil

+ (NSAttributedString*)getNSAttributedStringWithLabel:(UILabel*)label text:(NSString*)text{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:label.textColor,             NSFontAttributeName:label.font, NSParagraphStyleAttributeName: paragraphStyle}];
    return attrStr;
}

+ (NSAttributedString*)getNSAttributedStringWithLabel:(UILabel*)label lineSpace:(CGFloat)lineSpace text:(NSString*)text{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:label.textColor,             NSFontAttributeName:label.font, NSParagraphStyleAttributeName: paragraphStyle}];
    return attrStr;
}

@end
