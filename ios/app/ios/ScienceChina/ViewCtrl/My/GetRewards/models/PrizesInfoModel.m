//
//  PrizesInfoModel.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PrizesInfoModel.h"

@implementation PrizesInfoModel
-(void)setIsGet:(NSString *)isGet{
    if ([isGet integerValue] == 0) {
        _isReceived = YES;
    } else {
        _isReceived = NO;
    }
}
@end
