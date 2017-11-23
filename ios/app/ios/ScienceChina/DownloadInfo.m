//
//  DownloadInfo.m
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "DownloadInfo.h"

@implementation DownloadInfo

@synthesize in_id,in_title,in_img_url,in_movie_url,in_video_duration,in_publish_date_str,in_article_type;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.in_id forKey:@"in_id"];
    [encoder encodeObject:self.in_title forKey:@"in_title"];
    [encoder encodeObject:self.in_img_url forKey:@"in_img_url"];
    [encoder encodeObject:self.in_movie_url forKey:@"in_movie_url"];
    [encoder encodeObject:self.in_video_duration forKey:@"in_video_duration"];
    [encoder encodeObject:self.in_publish_date_str forKey:@"in_publish_date_str"];
    [encoder encodeObject:self.in_article_type forKey:@"in_article_type"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.destinationPath forKey:@"destinationPath"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.in_id = [decoder decodeObjectForKey:@"in_id"];
        self.in_title = [decoder decodeObjectForKey:@"in_title"];
        self.in_img_url = [decoder decodeObjectForKey:@"in_img_url"];
        self.in_movie_url = [decoder decodeObjectForKey:@"in_movie_url"];
        self.in_video_duration = [decoder decodeObjectForKey:@"in_video_duration"];
        self.in_publish_date_str = [decoder decodeObjectForKey:@"in_publish_date_str"];
        self.in_article_type = [decoder decodeObjectForKey:@"in_article_type"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.destinationPath = [decoder decodeObjectForKey:@"destinationPath"];
    }
    return  self;
}

@end
