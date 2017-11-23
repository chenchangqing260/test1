//
//  MusicDetialCollectionViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/11/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicDetialCollectionViewCell : UICollectionViewCell
+(NSString*)ID;
-(void)setCellWithHomeModel:(HomeModel*)sa isShow:(BOOL)isShow;
@end
