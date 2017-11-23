//
//  VideoInfoView.h
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoObj.h"

@protocol VideoInfoViewDelegate <NSObject>

- (void)playVideo;
- (void)goToCommentList;
- (void)didToEStation;
- (void)didToDownloadVideo;

@end

@interface VideoInfoView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conInfoViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImageViewHeightRatio;
@property (nonatomic, assign)CGFloat viewHeight;

@property (nonatomic, weak)id<VideoInfoViewDelegate> delegate;

// XIB创建视图
+(VideoInfoView *)newView;

// 初始化界面元素数据
- (void)loadInfoHtml:(NSString*)in_id;
- (void)initViewWithInfoObj:(InfoObj*)info;
- (void)refreshAttentBtn:(InfoObj*)info;
- (void)refreshDownloadState;

@end
