//
//  CollectionDetailWebViewController.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/14.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareModel.h"

@protocol CollectionDetailDelegate <NSObject>

- (void)refreshCollectionCellDataByVisitCount;

@end

@interface CollectionDetailWebViewController : BaseViewController

@property (nonatomic, weak)id<CollectionDetailDelegate> delegate;
@property (nonatomic, strong)NSString* titleStr;
@property (nonatomic, strong)NSString* av_id_Str;
@property (nonatomic, strong)ShareModel* shareModel;
-(void)loadWebWithUrl:(NSString *)url;
-(void)writeHtmlToWebview:(NSString *)html;
@property (nonatomic,strong) NSString* edit_url;//编辑活动页面地址

@property (nonatomic, assign)NSInteger falg;

@end
