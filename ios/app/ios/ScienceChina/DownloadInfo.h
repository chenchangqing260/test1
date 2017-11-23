//
//  DownloadInfo.h
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadInfo : NSObject

@property (nonatomic,strong) NSString* in_id;
@property (nonatomic,strong) NSString* in_title;
@property (nonatomic,strong) NSString* in_img_url;
@property (nonatomic,strong) NSString* in_movie_url;
@property (nonatomic,strong) NSString* in_video_duration;
@property (nonatomic,strong) NSString* in_publish_date_str;
@property (nonatomic,strong) NSString* in_article_type;

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *destinationPath;

@end
