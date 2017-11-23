//
//  ScoreModel.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ScoreModel.h"

@implementation ScoreModel
-(void)setScore_type:(NSString *)score_type{
    _score_type = score_type;
    _scoreImageName = [NSString stringWithFormat:@"score_type_%@",score_type];
}
@end
