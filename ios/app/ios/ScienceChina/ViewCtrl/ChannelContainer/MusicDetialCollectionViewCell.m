//
//  MusicDetialCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/11/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MusicDetialCollectionViewCell.h"

@interface MusicDetialCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *uiplayimge;

@end

@implementation MusicDetialCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"MusicDetialCollectionViewCell";
}

-(void)setCellWithHomeModel:(HomeModel*)sa isShow:(BOOL)isShow{
    
    if(isShow){
        [_uiplayimge setImage:[UIImage imageNamed:@"playbar_pausebtn_click"]];
    }else{
        [_uiplayimge setImage:[UIImage imageNamed:@"Play"]];
    }
    
}

@end
