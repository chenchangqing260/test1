//
//  DownloadInfoCell.m
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "DownloadInfoCell.h"
#import "CustomDownloadManager.h"
#import "FGGDownloadManager.h"

@interface DownloadInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiSummaryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UIView *uiLayerView;
@property (weak, nonatomic) IBOutlet UILabel *uiStatusLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLayerViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *uiStateImageView;

@property (nonatomic, strong) DownloadInfo* downloadInfo;
@property (nonatomic, strong) NSIndexPath* indexPath;

@property (nonatomic, strong) UIImage* downloadImg;
@property (nonatomic, strong) UIImage* pauseImg;
@property (nonatomic, strong) UIImage* completeImg;

@property (nonatomic,assign) CGFloat showWidth;

@end

@implementation DownloadInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        self.showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    
    self.conLayerViewWidth.constant = self.showWidth - 14;
    _completeImg = [UIImage imageNamed:@"缓存播放"];
    _downloadImg = [UIImage imageNamed:@"go"];
    _pauseImg = [UIImage imageNamed:@"缓存暂停"];
}


+(NSString*)ID{
    return @"DownloadInfoCell";
}

+(DownloadInfoCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"DownloadInfoCell" owner:nil options:nil][0];
}

- (void)initCellDataWithReply:(DownloadInfo*)downloadInfo withIndex:(NSIndexPath*)indexPath{
    self.downloadInfo = downloadInfo;
    self.indexPath = indexPath;
    
    CGFloat progress = [[FGGDownloadManager shredManager] lastProgress:_downloadInfo.in_movie_url];
    
    self.conLayerViewWidth.constant = (self.showWidth - 14) * (1 - progress);
    if (progress < 1) {
        // 暂停状态，显示三角形开始按钮
        self.uiStatusLab.hidden = NO;
        self.uiLayerView.hidden = NO;
        
        if (progress == 0) {
            self.uiStatusLab.text = @"点击下载!";
        }else{
            int pr = floor(progress * 100);
            self.uiStatusLab.text = [NSString stringWithFormat:@"%@%d%@", @"已暂停，完成", pr, @"%, 点击继续下载！"];
        }
        [self.uiStateImageView setImage:_downloadImg];
    }else{
        // 下载状态，显示两个竖型暂停按钮
        self.uiStatusLab.hidden = YES;
        self.uiLayerView.hidden = YES;
        [self.uiStateImageView setImage:_completeImg];
    }
    
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:downloadInfo.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [_uiTitleLab setText:downloadInfo.in_title];
    [_uiSummaryLab setText:[NSString stringWithFormat:@"%@ / %@", downloadInfo.in_article_type, downloadInfo.in_video_duration]];
    [_uiTimeLab setText:downloadInfo.in_publish_date_str];
}

// 下载数据
- (void)startDownload{
    CGFloat progress = [[FGGDownloadManager shredManager] lastProgress:_downloadInfo.in_movie_url];
    int pr = floor(progress * 100);
    self.uiStatusLab.text = [NSString stringWithFormat:@"%@%d%@", @"正在下载, 完成", pr, @"%"];
    self.conLayerViewWidth.constant = (self.showWidth - 14) * (1 - progress);
    
    if (progress < 1) {
        self.uiStatusLab.hidden = NO;
        self.uiLayerView.hidden = NO;
        [self.uiStateImageView setImage:_pauseImg];
    }else{
        self.uiStatusLab.hidden = YES;
        self.uiLayerView.hidden = YES;
        [self.uiStateImageView setImage:_downloadImg];
    }
    [self layoutIfNeeded];
}

- (void)pauseDownload{
    CGFloat progress = [[FGGDownloadManager shredManager] lastProgress:_downloadInfo.in_movie_url];
    self.conLayerViewWidth.constant = (self.showWidth - 14) * (1 - progress);
    
    if (progress < 1) {
        self.uiStatusLab.hidden = NO;
        self.uiLayerView.hidden = NO;
        
        if (progress == 0) {
            self.uiStatusLab.text = @"点击下载!";
        }else{
            int pr = floor(progress * 100);
            self.uiStatusLab.text = [NSString stringWithFormat:@"%@%d%@", @"已暂停，完成", pr, @"%, 点击继续下载！"];
        }
        [self.uiStateImageView setImage:_downloadImg];
    }else{
        self.uiStatusLab.hidden = YES;
        self.uiLayerView.hidden = YES;
        [self.uiStateImageView setImage:_completeImg];
    }
    
    [self layoutIfNeeded];
}

- (void)completeDownload{
    self.uiStatusLab.hidden = YES;
    self.uiLayerView.hidden = YES;
    [self.uiStateImageView setImage:_completeImg];
    [self layoutIfNeeded];
}

- (BOOL)isDownloading{
    NSData *data1 = UIImagePNGRepresentation(self.uiStateImageView.image);
    NSData *data = UIImagePNGRepresentation(_downloadImg);
    if ([data isEqual:data1]) {
        // 处于暂停状态
        return false;
    }else{
        // 处于播放状态
        return true;
    }
}

- (IBAction)clickStateImgViewTap:(id)sender {
    [self.delegate clickStateImgView:self.downloadInfo WithIndex:self.indexPath];
}

@end
