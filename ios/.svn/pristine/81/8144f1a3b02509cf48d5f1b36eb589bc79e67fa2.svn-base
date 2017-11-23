//
//  CollectionReusableHeaderViewOnMy.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CollectionReusableHeaderViewOnMyHeight 282


@protocol CollectionReusableHeaderViewOnMyDelegate <NSObject>
-(void)tapUserHeader;//点击用户头像
-(void)tapLeftButton;//点击左导航按钮
-(void)tapMonthIntegral;//点击本月积分视图
-(void)tapCollectViewDelegateFun;//点击收藏视图
-(void)tapIntegralViewDelegateFun;//点击积分视图
-(void)tapCommentViewDelegateFun;//点击评论视图
@end



@interface CollectionReusableHeaderViewOnMy : UICollectionReusableView
@property(nonatomic,assign)id<CollectionReusableHeaderViewOnMyDelegate>delegate;
+(NSString *)ID;
-(void)refreshHeaderView;
-(void)setNumsWithWebResponse:(WebResponse *)response;
@end
