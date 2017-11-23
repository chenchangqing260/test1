//
//  TextUtil.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TextUtil.h"

@implementation TextUtil

+ (CGSize)boundingRectWithText:(NSString*)text size:(CGSize)size Font:(UIFont*)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

+ (CGSize)boundingRectWithText:(NSString*)text lineSpace:(CGFloat)lineSpace size:(CGSize)size Font:(UIFont*)font{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary *attribute = @{NSFontAttributeName: font,NSParagraphStyleAttributeName: paragraphStyle};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}

@end
