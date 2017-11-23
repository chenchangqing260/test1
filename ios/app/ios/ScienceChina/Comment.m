//
//  Comment.m
//  ScienceChina
//
//  Created by Ellison on 16/5/6.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "Comment.h"
#import "Constant.h"

@implementation Comment

- (Class)classInArrayForKey:(NSString *)key
{
    if ([key isEqualToString:@"reList"]) {
        return [Comment class];
    }
    
    return NULL;
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    NSDictionary *attribute = @{NSFontAttributeName: CommentFont,NSParagraphStyleAttributeName: paragraphStyle};
    CGSize textSize = [self.r_content boundingRectWithSize:CGSizeMake(size.width, 0)
                                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                      attributes:attribute
                                                         context:nil].size;
    return textSize;
}
@end
