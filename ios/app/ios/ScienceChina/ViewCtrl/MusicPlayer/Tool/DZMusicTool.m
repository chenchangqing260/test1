//
//  DZMusicTool.m
//  Music
//
//  Created by dengwei on 15/9/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DZMusicTool.h"
#import "DZMusic.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation DZMusicTool

singleton_implementation(DZMusicTool)

-(void)prepareToPlayWithMusic:(DZMusic *)music{
    //创建播放器
//    music.filename = @"http://m2.music.126.net/dUZxbXIsRXpltSFtE7Xphg==/1375489050352559.mp3";
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
//    NSURL *musicURL = [NSURL URLWithString:@"http://m2.music.126.net/dUZxbXIsRXpltSFtE7Xphg==/1375489050352559.mp3"];
    
    NSError *error = nil;
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    
    self.playerItem = [[AVPlayerItem alloc] initWithURL:musicURL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.player.volume = 10.0f;
    
//    self.player =  [AVPlayer playerWithURL:musicURL];
//     self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    if (error) {
        NSLog(@"%s %@", __func__, error);
    }
    
    //准备
//    [self.player prepareToPlay];
    
    //建议:锁屏信息最好在程序退出到后台的时候再设置
    //设置锁屏音乐信息
//    NSMutableDictionary *info = [NSMutableDictionary dictionary];
//    //设置专辑名称
//    info[MPMediaItemPropertyAlbumTitle] = @"网络热曲";
//    //设置歌曲名
//    info[MPMediaItemPropertyTitle] = music.name;
//    //设置歌手
//    info[MPMediaItemPropertyArtist] = music.singer;
    //设置专辑图片
//    UIImage *image = [UIImage imageNamed:music.icon];
//    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
//    info[MPMediaItemPropertyArtwork] = artwork;
    //设置歌曲时间
//    CMTime duration = self.player.currentItem.asset.duration;
//    float seconds = CMTimeGetSeconds(duration);
//    NSLog(@"duration: %.2f", seconds);
//
//    //时间格式
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    [formatter setDateFormat:@"MMM dd,yyyy HH:mm tt"];
    
    //时间字符串NSDate
    
//    NSDate *date = [formatter dateFromString:self.player.currentItem.duration];
    
    //时间转时间戳
    
//    NSTimeInterval interval = [date timeIntervalSince1970];
 
    
//    info[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
//    info[MPMediaItemPropertyPlaybackDuration] = interval;
//    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
}

-(void)play{
    [self.player play];
}

-(void)pause{
    [self.player pause];
}

@end
