//
//  HomeModel.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(id)initWithDic:(NSMutableDictionary *)dic{
    if (self = [super init]) {
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:dic];
        if ([[dictionary allKeys] containsObject:@"tag"] &&
            [dictionary[@"tag"] isKindOfClass:[NSArray class]]) {
            NSArray *tagrry = dictionary[@"tag"];
            if (tagrry.count > 0) {
                [dictionary setObject:tagrry[0] forKey:@"in_classify"];
            }else{
                [dictionary setObject:@"0" forKey:@"in_classify"];
            }
        }
        if ([[dictionary allKeys] containsObject:@"cat"] && [dictionary[@"cat"] isKindOfClass:[NSArray class]]) {
            NSArray *tagrry = dictionary[@"cat"];
            if (tagrry.count > 0) {
                [dictionary setObject:tagrry[0] forKey:@"in_article_type"];
            }else{
                [dictionary setObject:@"" forKey:@"in_article_type"];
            }
        }
        
        if (![[dictionary allKeys] containsObject:@"in_article_type"]) {
            [dictionary setObject:@"" forKey:@"in_article_type"];
        }
        if (![[dictionary allKeys] containsObject:@"in_classify"]) {
            [dictionary setObject:@"" forKey:@"in_classify"];
        }
        if (![[dictionary allKeys] containsObject:@"in_img_url_two"]) {
            [dictionary setObject:@"" forKey:@"in_img_url_two"];
        }
        if (![[dictionary allKeys] containsObject:@"url"]) {
            [dictionary setObject:@"" forKey:@"in_movie_url"];
        }
        if (![[dictionary allKeys] containsObject:@"in_video_duration"]) {
            [dictionary setObject:@"" forKey:@"in_video_duration"];
        }
        
        for (NSString *key in [dictionary allKeys]) {
            
            NSString *value = [NSString stringWithFormat:@"%@",dictionary[key]];
            if ([self isBlankString:value] ) {
                value = @"";
            }else{
                value = dictionary[key];
            }
            
            if ([key isEqualToString:@"iid"] ||  [key isEqualToString:@"in_id"]) {
                self.in_id = value;
            }else if ([key isEqualToString:@"title"] || [key isEqualToString:@"in_title"]) {
                self.in_title = value;
            }else if ([key isEqualToString:@"vcnt"] || [key isEqualToString:@"in_hits"]) {
                self.in_hits = value;
            }else if ([key isEqualToString:@"pic"] || [key isEqualToString:@"in_img_url"]) {
                self.in_img_url = value;
            }else if ([key isEqualToString:@"abs"] || [key isEqualToString:@"in_desc"]) {
                self.in_desc = value;
            }else if ([key isEqualToString:@"ccnt"] || [key isEqualToString:@"in_reviewCount"]) {
                self.in_reviewCount = value;
            }else if ([key isEqualToString:@"url"] || [key isEqualToString:@"in_movie_url"]) {
                self.in_movie_url = value;
            }else if ([key isEqualToString:@"in_img_url2"] || [key isEqualToString:@"in_img_url_two"]) {
                self.in_img_url2 = value;
            }else if ([key isEqualToString:@"in_classify"]) {
                self.in_classify = value;
            }else if ([key isEqualToString:@"in_pic_amount"]) {
                self.in_pic_amount = value;
            }else if ([key isEqualToString:@"in_video_duration"]) {
                self.in_video_duration = value;
            }else if ([key isEqualToString:@"in_publish_date_str"]) {
                self.in_publish_date_str = value;
            }
            else if ([key isEqualToString:@"in_collectCount"]) {
                self.in_collectCount = value;
            }
            else if ([key isEqualToString:@"typ"]) {
                self.in_collectCount = value;
            }
            else if ([key isEqualToString:@"in_article_type"]) {
                self.in_article_type = value;
            }else if ([key isEqualToString:@"in_is_station"]) {
                self.self.in_is_station = value;
            }else if ([key isEqualToString:@"ni_type"]){
                self.ni_type = value;
            }else if ([key isEqualToString:@"ni_av_type"]){
                self.ni_av_type =value;
            }else if ([key isEqualToString:@"ni_av_name"]){
                self.ni_av_name =value;
            }else if ([key isEqualToString:@"ni_rele_id"]){
                self.ni_rele_id =value;
            }else if ([key isEqualToString:@"ni_bind_id"] || [key isEqualToString:@"nrd"]){
                self.ni_bind_id =value;
            }else if ([key isEqualToString:@"nt"]||[key isEqualToString:@"ni_type"]){
                self.ni_type =value;
            }else if ([key isEqualToString:@"nat"]||[key isEqualToString:@"ni_av_type"]){
                self.ni_av_type =value;
            }else if ([key isEqualToString:@"nan"]||[key isEqualToString:@"ni_av_name"]){
                self.ni_av_name =value;
            }else if ([key isEqualToString:@"nri"]||[key isEqualToString:@"ni_rele_id"]){
                self.ni_rele_id =value;
            }else if ([key isEqualToString:@"nibi"]||[key isEqualToString:@"ni_bind_id"]){
                self.ni_bind_id =value;
            }
        }
    }
    return self;
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isEqual:@"<null>"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
