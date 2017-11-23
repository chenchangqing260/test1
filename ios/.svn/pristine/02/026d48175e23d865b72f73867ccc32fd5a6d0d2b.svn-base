//
//  ChannelListCell.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/2.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeModel.h"
#define ChannelListCellHeight_graphic 104 //图文——一张图片
#define ChannelListCellHeight_graphic_MultiplePictures 162  //图文——多张图片
#define ChannelListCellHeight_video 262 //视频
#define ChannelListCellHeight_text 104.0 //文字资讯

@protocol ChannelListCellDelegate <NSObject>
//点击了评论按钮
-(void)didSelectCommentWithModel:(HomeModel *)model;
//点击了收藏按钮
-(void)didSelectLikeWithModel:(HomeModel *)model;
@end

@interface ChannelListCell : UITableViewCell
@property (nonatomic,assign) id<ChannelListCellDelegate> delegate;
+(NSString*)ID;
-(void)setCellWithModel:(HomeModel *)model;
@end
