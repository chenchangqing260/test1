//
//  DownloadInfoCell.h
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadInfo.h"
#import "BaseTableViewCell.h"

@protocol DownloadInfoCellDelegate <NSObject>

- (void)clickStateImgView:(DownloadInfo*) info WithIndex:(NSIndexPath*)indexPath;

@end

@interface DownloadInfoCell : BaseTableViewCell

@property (nonatomic, weak)id<DownloadInfoCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIView *uiBlackLayer;
@property (weak, nonatomic) IBOutlet UIImageView *uiStateImgView;
@property (weak, nonatomic) IBOutlet UIView *uiConView;

+(NSString*)ID;
+(DownloadInfoCell *)newCell;
- (void)initCellDataWithReply:(DownloadInfo*)downloadInfo withIndex:(NSIndexPath*)indexPath;
- (void)startDownload;
- (void)pauseDownload;
- (void)completeDownload;
- (BOOL)isDownloading;

@end
