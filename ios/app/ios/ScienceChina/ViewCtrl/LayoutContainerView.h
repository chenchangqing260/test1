//
//  LayoutContainnerView.h
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@protocol LayoutContinerDelegate <NSObject>

- (void)commentSuccessCallBack;

@end

@interface LayoutContainerView : UIView
@property (nonatomic, weak)id<LayoutContinerDelegate> delegate;
-(instancetype)initWithModelArray:(NSArray *)modelArray;
@end
