//
//  UIImage+ResizeMagick.h
//
//
//  Created by Vlad Andersen on 1/5/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeMagick)

- (NSString *) resizedAndReturnPath;
- (NSData *) resizedAndReturnData;
- (NSData *) resizedAndReturnDataWithSize:(CGSize)size compressionQuality:(CGFloat)quality;
- (NSData *) resizedImageWithMaximumSize: (CGSize) size compressionQuality:(CGFloat)quality;

- (UIImage *) resizedImageByMagick: (NSString *) spec;
- (UIImage *) resizedImageByWidth:  (NSUInteger) width;
- (UIImage *) resizedImageByHeight: (NSUInteger) height;
- (UIImage *) resizedImageWithMaximumSize: (CGSize) size;
- (UIImage *) resizedImageWithMinimumSize: (CGSize) size;

@end
