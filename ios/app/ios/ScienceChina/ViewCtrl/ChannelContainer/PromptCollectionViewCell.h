//
//  PromptCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PromptCollectionViewCellCycleDelegate <NSObject>
- (void)backToHomePage;

@end

@interface PromptCollectionViewCell : UICollectionViewCell

+(NSString*)ID;
-(void)setCellWithSciencePrompt:(BOOL)showSpace;
@property (nonatomic, weak)id<PromptCollectionViewCellCycleDelegate> delegate;
@end
