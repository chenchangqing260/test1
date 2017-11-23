//
//  RecCollectionViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoObj.h"
#import "ShareModel.h"

@protocol RecPicCollectionDelegate <NSObject>

- (void)clickBack;
- (void)clickRecViewWithInfo:(InfoObj*)info;
- (void)clickShareBtn;
- (void)clickCommentCountBtn;

@end

@interface RecCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<RecPicCollectionDelegate> delegate;
@property (nonatomic, strong)NSMutableArray* recArray;
@property (nonatomic, strong)NSString* commentCount;

+(NSString*)ID;

@end
