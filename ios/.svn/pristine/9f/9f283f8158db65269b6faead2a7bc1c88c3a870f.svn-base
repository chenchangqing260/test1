//
//  BDIDataStatistics.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/16.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BDIDataStatistics.h"
#import "HomeModel.h"
#import "InfoObj.h"
#define BDI_RecommendId @"rec_C51AACBF_E18F_3D28_30FD_41078DE8F289"

@implementation BDIDataStatistics


+(void)onAddUserWithUserId:(NSString *)userid{
    [BDIAgent addUser:userid options:nil resp:^(NSError *error, id feedback) {
        
    }];
}


// 1.iid：文章id，string类型
//2.uid：用户id，string类型 （未登录为空）
+(void)onVisitWithModel:(id)model{
    
    //@{@"uid":((uid!=nil)&&([uid isKindOfClass:[NSString class]])&&(uid.length>0))?uid:@"301358"}
    Member* member = [[MemberManager sharedInstance]getMember];
    NSString *userid = [NSString stringWithFormat:@"%@",member.member_id];
    NSString *articleId = @"";
    if ([model isKindOfClass:[HomeModel class]]) {
        HomeModel *_model = (HomeModel *)model;
        articleId = _model.in_id;
    }
    else if ([model isKindOfClass:[InfoObj class]]) {
        InfoObj *_model = (InfoObj *)model;
        articleId = _model.in_id;
    }
    NSDictionary *userinfo;
    if ([[MemberManager sharedInstance] isLogined]) {
        userinfo = @{@"uid":userid};
    }
    [BDIAgent visit:articleId options:userinfo resp:^(NSError *error, id feedback) {
        if (feedback) {
            NSLog(@"%@",[feedback description]);
        }else{
            NSString *recommendId = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
            NSString *requestId = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
            NSLog(@"%@，%@",recommendId,requestId);
        }
    }];
}

//首页，基站，搜索 中 有浏览文章
+(void)additemWithModelNew:(id)model{
    /**
     *   浏览文章的时候调用additem和visit
     title : 文章名称   string类型
     pic： 文章的图片   string类型
     iid： 文章的id  string类型
     cat：文章类目，用“|”分隔的字符串(从根类目到子类目顺序)(配置类型：list)
     ptime : 文章发表时间， 时间戳  double类型 单位秒 11位
     vcnt ： 浏览人数 int类型
     ccnt ： 评论人数 int类型
     
     abs：咨询描述
     tag：资讯类别（0-图文资讯，1-图片资讯，2-视频资讯，3-专题资讯 ，4-文字资讯）
     ccnt：资讯评论数量
     url：视频地址url
     typ：收藏数
     其余的字段还有资讯图片地址2，资讯图片地址3，视频资讯持续时间，资讯发布时间，资讯收藏数量，图片总数量 都放到attr中，attr是扩展属性，json格式，key您自己定义字段名就行，不过需要注意的是ios安卓的字段名必须一样
     */
    
    NSString *title = @"";
    NSString *pic = @"";
    NSString *iid = @"";
    NSString *cat = @"";
    NSString *ptimeStr = @"";
    NSNumber *vcnt;
    NSNumber *ccnt;
    NSString *abs = @"";
    NSString *tag = @"";
    NSString *url = @"";
    NSString *typ = @""; //收藏数
    NSString *ni_type = @"";
    NSString *ni_av_type = @"";
    NSString *ni_av_name = @"";
    NSString *ni_rele_id = @"";
    NSString *ni_bind_id = @"";
    
    NSString *attr = @""; //附加字段
    
    NSString *in_video_duration = @"";
    NSString *in_collectCount = @"";
    NSString *in_pic_amount = @"";
    NSString *in_publish_date_str = @"";
    NSString *in_img_url = @"";
    NSString *in_img_url2 = @"";
    
    
    NSMutableDictionary *attrInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    //NSString *
    
    if ([model isKindOfClass:[HomeModel class]]) {
        HomeModel *_model = (HomeModel *)model;
        
//        title = _model.in_title;
//        pic = _model.in_img_url;
//        iid = _model.in_id;
//        cat = _model.in_article_type;
//        ptimeStr = _model.in_publish_date_str;
//        vcnt = [NSNumber numberWithInt:[_model.in_hits intValue]];
//        ccnt = [NSNumber numberWithInt:[_model.in_reviewCount intValue]];
//        
//        abs = _model.in_desc;
//        tag = _model.in_classify;
//        url = _model.in_movie_url ? _model.in_movie_url : @"";
//        typ = _model.in_collectCount;
//        
//        in_video_duration = _model.in_video_duration;
//        in_collectCount = _model.in_collectCount;
//        in_pic_amount = _model.in_pic_amount;
//        in_publish_date_str = _model.in_publish_date_str;
//        in_img_url = _model.in_img_url;
//        in_img_url2 = _model.in_img_url2;
        
        title = _model.ni_title;
        pic = _model.ni_img_url;
        iid = _model.ni_id;
        cat = _model.ni_article_type;
        ptimeStr = _model.ni_publish_date_str;
        vcnt = [NSNumber numberWithInt:[_model.ni_hits intValue]];
        ccnt = [NSNumber numberWithInt:[_model.ni_reviewCount intValue]];
        
        abs = _model.ni_desc;
        tag = _model.ni_classify;
        url = _model.ni_movie_url ? _model.ni_movie_url : @"";
        typ = _model.ni_collectCount;
        
        in_video_duration = _model.ni_video_duration;
        in_collectCount = _model.ni_collectCount;
        in_pic_amount = _model.ni_pic_amount;
        in_publish_date_str = _model.ni_publish_date_str;
        in_img_url = _model.ni_img_url;
        in_img_url2 = _model.ni_img_url2;
        
        ni_type = _model.ni_type;
        if([ni_type integerValue]  ==1){
            ni_av_type = _model.ni_av_type;
            ni_av_name = _model.ni_av_name;
            if(_model.ni_rele_id){
             ni_rele_id = _model.ni_rele_id;
            }
            if(_model.ni_rele_id){
             ni_bind_id = _model.ni_bind_id;
            }
        }
    }
    else if ([model isKindOfClass:[InfoObj class]]) {
        InfoObj *_model = (InfoObj *)model;
        
        title = _model.in_title;
        pic = _model.in_img_url;
        iid = _model.in_id;
        cat = _model.in_article_type ? _model.in_article_type : @"";
        ptimeStr = _model.in_publish_date_str;
        vcnt = [NSNumber numberWithInt:[_model.in_hits intValue]];
        ccnt = [NSNumber numberWithInt:[_model.in_reviewCount intValue]];
        
        abs = _model.in_desc;
        tag = _model.in_classify;
        url = _model.in_movie_url ? _model.in_movie_url : @"";
        typ = _model.in_collectCount;
        
        in_video_duration = _model.in_video_duration;
        in_collectCount = _model.in_collectCount;
        in_pic_amount = _model.in_pic_amount;
        in_publish_date_str = _model.in_publish_date_str;
        in_img_url = _model.in_img_url;
        in_img_url2 = _model.in_img_url2;
        
    }
    
    if (in_collectCount) {
        [attrInfo setObject:in_collectCount forKey:@"in_collectCount"];
    }
    
    if (in_pic_amount) {
        [attrInfo setObject:in_pic_amount forKey:@"in_pic_amount"];
    }
    
    if (in_publish_date_str) {
        [attrInfo setObject:in_publish_date_str forKey:@"in_publish_date_str"];
    }
    
    if (in_img_url) {
        [attrInfo setObject:in_img_url forKey:@"in_img_url"];
    }
    
    if (cat) {
        [attrInfo setObject:cat forKey:@"in_article_type"];
    }
    
    if (tag) {
        [attrInfo setObject:tag forKey:@"in_classify"];
    }
    
    if([ni_type integerValue]  ==1){
        if (ni_type) {
            [attrInfo setObject:ni_type forKey:@"ni_type"];
        }
        
        if (ni_av_type) {
            [attrInfo setObject:ni_av_type forKey:@"ni_av_type"];
        }
        
        if (ni_av_name) {
            [attrInfo setObject:ni_av_name forKey:@"ni_av_name"];
        }
        
        
        if(ni_rele_id&&![ni_rele_id isEmptyOrWhitespace]){
            [attrInfo setObject:ni_rele_id forKey:@"ni_rele_id"];
        }
        if(ni_bind_id&&![ni_bind_id isEmptyOrWhitespace]){
            [attrInfo setObject:ni_bind_id forKey:@"ni_bind_id"];
        } 
    }
    
    //图集
    if ([tag integerValue] ==  1) {
        if (in_img_url2) {
            [attrInfo setObject:in_img_url2 forKey:@"in_img_url_two"];
        }
        
    }
    //视频时长
    if ([tag integerValue] ==  2) {
        if (in_video_duration) {
            [attrInfo setObject:in_video_duration forKey:@"in_video_duration"];
        }
        
    }
    
    attr = [self dictionaryToJson:attrInfo];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:ptimeStr];
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[inputDate timeIntervalSince1970]];

    NSNumber *ptime = [NSNumber numberWithDouble:[timeSp doubleValue]];
    
    
    NSMutableDictionary *medicalInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"title":title,
                                                                                       @"pic":pic,
                                                                                       @"iid":iid,
                                                                                       @"cat":cat,
                                                                                       @"ptime":ptime,
                                                                                       @"vcnt":vcnt,
                                                                                       @"ccnt":ccnt,
                                                                                       @"abs":abs,
                                                                                       @"tag":tag,
                                                                                       @"url":url,
                                                                                       @"typ":typ,
                                                                                       @"attr":attr,
                                                                                       @"nt":ni_type,
                                                                                       @"nat":ni_av_type,
                                                                                       @"nan":ni_av_name,
                                                                                       @"nri":ni_rele_id,
                                                                                       @"nibi":ni_bind_id
                                                                                       }];
    //不是视频，不传url
    if ([tag integerValue] !=  2) {
        [medicalInfo removeObjectForKey:@"url"];
    }
    [BDIAgent addItem:iid options:medicalInfo resp:^(NSError *error, id feedback) {
        if (feedback) {
            NSLog(@"feedback：%@",[feedback description]);
        }else{
            NSString *recommendId = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
            NSString *requestId = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
            NSLog(@"error： %@，%@",recommendId,requestId);
        }
    }];
}

//首页，基站，搜索 中 有浏览文章
+(void)additemWithModel:(id)model{
    /**
     *   浏览文章的时候调用additem和visit
     title : 文章名称   string类型
     pic： 文章的图片   string类型
     iid： 文章的id  string类型
     cat：文章类目，用“|”分隔的字符串(从根类目到子类目顺序)(配置类型：list)
     ptime : 文章发表时间， 时间戳  double类型 单位秒 11位
     vcnt ： 浏览人数 int类型
     ccnt ： 评论人数 int类型
     
     abs：咨询描述
     tag：资讯类别（0-图文资讯，1-图片资讯，2-视频资讯，3-专题资讯 ，4-文字资讯）
     ccnt：资讯评论数量
     url：视频地址url
     typ：收藏数
     其余的字段还有资讯图片地址2，资讯图片地址3，视频资讯持续时间，资讯发布时间，资讯收藏数量，图片总数量 都放到attr中，attr是扩展属性，json格式，key您自己定义字段名就行，不过需要注意的是ios安卓的字段名必须一样
     */
    
    NSString *title = @"";
    NSString *pic = @"";
    NSString *iid = @"";
    NSString *cat = @"";
    NSString *ptimeStr = @"";
    NSNumber *vcnt;
    NSNumber *ccnt;
    NSString *abs = @"";
    NSString *tag = @"";
    NSString *url = @"";
    NSString *typ = @""; //收藏数
    
    NSString *attr = @""; //附加字段
    
    NSString *in_video_duration = @"";
    NSString *in_collectCount = @"";
    NSString *in_pic_amount = @"";
    NSString *in_publish_date_str = @"";
    NSString *in_img_url = @"";
    NSString *in_img_url2 = @"";
    
    
    NSMutableDictionary *attrInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    //NSString *
    
    if ([model isKindOfClass:[HomeModel class]]) {
        HomeModel *_model = (HomeModel *)model;
        
        title = _model.in_title;
        pic = _model.in_img_url;
        iid = _model.in_id;
        cat = _model.in_article_type;
        ptimeStr = _model.in_publish_date_str;
        vcnt = [NSNumber numberWithInt:[_model.in_hits intValue]];
        ccnt = [NSNumber numberWithInt:[_model.in_reviewCount intValue]];
        
        abs = _model.in_desc;
        tag = _model.in_classify;
        url = _model.in_movie_url ? _model.in_movie_url : @"";
        typ = _model.in_collectCount;
        
        in_video_duration = _model.in_video_duration;
        in_collectCount = _model.in_collectCount;
        in_pic_amount = _model.in_pic_amount;
        in_publish_date_str = _model.in_publish_date_str;
        in_img_url = _model.in_img_url;
        in_img_url2 = _model.in_img_url2;
        
    }
    else if ([model isKindOfClass:[InfoObj class]]) {
        InfoObj *_model = (InfoObj *)model;
        
        title = _model.in_title;
        pic = _model.in_img_url;
        iid = _model.in_id;
        cat = _model.in_article_type ? _model.in_article_type : @"";
        ptimeStr = _model.in_publish_date_str;
        vcnt = [NSNumber numberWithInt:[_model.in_hits intValue]];
        ccnt = [NSNumber numberWithInt:[_model.in_reviewCount intValue]];
        
        abs = _model.in_desc;
        tag = _model.in_classify;
        url = _model.in_movie_url ? _model.in_movie_url : @"";
        typ = _model.in_collectCount;
        
        in_video_duration = _model.in_video_duration;
        in_collectCount = _model.in_collectCount;
        in_pic_amount = _model.in_pic_amount;
        in_publish_date_str = _model.in_publish_date_str;
        in_img_url = _model.in_img_url;
        in_img_url2 = _model.in_img_url2;
        
    }
    
    if (in_collectCount) {
        [attrInfo setObject:in_collectCount forKey:@"in_collectCount"];
    }
    
    if (in_pic_amount) {
        [attrInfo setObject:in_pic_amount forKey:@"in_pic_amount"];
    }
    
    if (in_publish_date_str) {
        [attrInfo setObject:in_publish_date_str forKey:@"in_publish_date_str"];
    }
    
    if (in_img_url) {
        [attrInfo setObject:in_img_url forKey:@"in_img_url"];
    }
    
    if (cat) {
        [attrInfo setObject:cat forKey:@"in_article_type"];
    }
    
    if (tag) {
        [attrInfo setObject:tag forKey:@"in_classify"];
    }
    
    //图集
    if ([tag integerValue] ==  1) {
        if (in_img_url2) {
            [attrInfo setObject:in_img_url2 forKey:@"in_img_url_two"];
        }
        
    }
    //视频时长
    if ([tag integerValue] ==  2) {
        if (in_video_duration) {
            [attrInfo setObject:in_video_duration forKey:@"in_video_duration"];
        }
        
    }
    
    attr = [self dictionaryToJson:attrInfo];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:ptimeStr];
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[inputDate timeIntervalSince1970]];
    
    NSNumber *ptime = [NSNumber numberWithDouble:[timeSp doubleValue]];
    
    
    NSMutableDictionary *medicalInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"title":title,
                                                                                       @"pic":pic,
                                                                                       @"iid":iid,
                                                                                       @"cat":cat,
                                                                                       @"ptime":ptime,
                                                                                       @"vcnt":vcnt,
                                                                                       @"ccnt":ccnt,
                                                                                       @"abs":abs,
                                                                                       @"tag":tag,
                                                                                       @"url":url,
                                                                                       @"typ":typ,
                                                                                       @"attr":attr
                                                                                       }];
    //不是视频，不传url
    if ([tag integerValue] !=  2) {
        [medicalInfo removeObjectForKey:@"url"];
    }
    [BDIAgent addItem:iid options:medicalInfo resp:^(NSError *error, id feedback) {
        if (feedback) {
            NSLog(@"feedback：%@",[feedback description]);
        }else{
            NSString *recommendId = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
            NSString *requestId = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
            NSLog(@"error： %@，%@",recommendId,requestId);
        }
    }];
}


//获取推荐数据
+(void)getRecommendDataWithSuccess:(void (^)(NSMutableArray *feedback,NSString *requestId))sccessBlock error:(void (^)(NSString *errorMessage))errorBlack{
    [BDIAgent recommend:BDI_RecommendId options:nil resp:^(NSError *error, id feedback) {
        
        NSString *requestId   = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
        NSString *recommendId = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
        requestId = requestId ? requestId:@"";
        if (feedback) {
            
            NSLog(@"精准推送：%@",feedback);
            
            NSMutableArray *modelArry = [[NSMutableArray alloc] initWithCapacity:0];
            NSArray *arry = [NSArray arrayWithArray:feedback];
            for (NSDictionary *dic in arry) {
                HomeModel *model = [[HomeModel alloc] initWithDic:dic];
                [modelArry addObject:model];
            }
            sccessBlock(modelArry,requestId);
            
        }else{
            NSLog(@"%@，%@",recommendId,requestId);
            errorBlack(requestId);
        }
    }];
}

/*推荐位实际展示后调用DFeedBack接口*/
+(void)DFeedBackWithIdArry:(NSArray*)idds requestId:(NSString *)requestId{
    NSString *allIdsStr = @"";
    NSString *placeholder = @"";
    for (int i=0; i<idds.count; i++) {
        if (i > 0) {
            placeholder = @"|";
        }
        NSString *iid = idds[i];
        allIdsStr = [NSString stringWithFormat:@"%@%@%@",allIdsStr,placeholder,iid];
        NSLog(@"iids:%@",allIdsStr);
    }
    NSDictionary *backDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             allIdsStr, @"iids",
                             requestId, @"rid", nil];
    [BDIAgent event:@"MDFeedBack" params:backDic  resp:nil delegate:nil];
}

+(void)tapRecommendArticleWithModel:(id)model requestId:(NSString *)requestId{
    NSString *medicalid;
    if ([model isKindOfClass:[HomeModel class]]) {
        HomeModel *_model = (HomeModel *)model;
        medicalid = _model.in_id;
    }
    else if ([model isKindOfClass:[InfoObj class]]) {
        InfoObj *_model = (InfoObj *)model;
        medicalid = _model.in_id;
    }
    
    requestId = requestId?requestId:@"";
    NSMutableDictionary *userinfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    if ([[MemberManager sharedInstance] isLogined]) {
        Member* member = [[MemberManager sharedInstance]getMember];
        NSString *userid = [NSString stringWithFormat:@"%@",member.member_id];
        [userinfo setObject:userid forKey:@"uid"];
    }
    [userinfo setObject:requestId forKey:@"rid"];
    [BDIAgent feedback:BDI_RecommendId itemId:medicalid options:userinfo resp:^(NSError *error, id feedback) {
        //NSLog(@"error: %@, feedback: %@", error, feedback);
    }];

}

//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
