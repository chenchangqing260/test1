//
//  BottomOperationView.h
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoObj.h"
#import "Comment.h"

@protocol BottomOperationViewDelegate <NSObject>

- (void)didBackAction;
- (void)didToCommentList;
- (void)didToLoginView;
- (void)didShare;

@end

@interface BottomOperationView : UIView

@property (nonatomic, weak)id<BottomOperationViewDelegate> delegate;
@property (nonatomic, assign)CGFloat height;

-(void)initViewDataWithInfo:(InfoObj*)info;
+(BottomOperationView *)newNib;

@end
