//
//  GTMBase64Util.h
//  hxz
//
//  Created by sevenplus on 15/12/4.
//  Copyright © 2015年 goodswiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTMBase64Util : NSObject

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

@end
