//
//  Question.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "Question.h"
#import "ReplyQuestion.h"

@implementation Question

-(Class)classInArrayForKey:(NSString *)key
{
    if ([key isEqualToString:@"rqList"]) {
        return [ReplyQuestion class];
    }
    
    return NULL;
}

@end
