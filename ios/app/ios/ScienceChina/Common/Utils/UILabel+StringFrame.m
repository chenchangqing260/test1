//
//  UILabel+StringFrame.m
//  passbook
//
//  Created by Ellison on 16/2/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size;
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    NSDictionary *attribute = @{NSFontAttributeName: self.font,NSParagraphStyleAttributeName: paragraphStyle};
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(size.width, 0)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
    return textSize;
//    NSDictionary *attribute = @{NSFontAttributeName: self.font, };
//    
//    CGSize retSize = [self.text boundingRectWithSize:size
//                                             options:\
//                      NSStringDrawingTruncatesLastVisibleLine |
//                      NSStringDrawingUsesLineFragmentOrigin |
//                      NSStringDrawingUsesFontLeading
//                                          attributes:attribute
//                                             context:nil].size;
//    
//    return retSize;
}
- (CGSize)boundingRectWithSize:(CGSize)size lineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary *attribute = @{NSFontAttributeName: self.font,NSParagraphStyleAttributeName: paragraphStyle};
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(size.width, 0)
                                              options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;
    return textSize;
}

@end
