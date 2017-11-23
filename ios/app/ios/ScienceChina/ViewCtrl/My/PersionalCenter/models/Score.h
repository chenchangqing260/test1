//
//  Score.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/27.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
//"currentMonthScore": 7003.00,
//"fromScore": 5000,
//"grade": "3",
//"toScore": 10000,
//"totalScore": 7003.00,
//"scoreLog": [
//             {
//                 "create_time": "2016-12-27 09:29:20",
//                 "day": "2016-12-27",
//                 "id": "90",
//                 "info": "",
//                 "member_id": "ME201612231255461000",
//                 "score_add": 1.00,
//                 "score_type": "01",
//                 "type_info": "每日登录积分"
//             }
//             ]
@property (nonatomic, strong) NSString *currentMonthScore;
@property (nonatomic, strong) NSString *fromScore;
@property (nonatomic, strong) NSString *toScore;
@property (nonatomic, strong) NSString *totalScore;
@property (nonatomic, strong) NSString *grade;//等级
@property (nonatomic, strong) NSString *gradeName;//称谓
@property (nonatomic, strong) NSMutableArray *scoreLog;
@end
