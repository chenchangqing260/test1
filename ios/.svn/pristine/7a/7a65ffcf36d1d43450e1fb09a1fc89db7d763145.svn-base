//
//  AreaAlertCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "AreaAlertCollectionViewCell.h"
#import "Area.h"
@interface AreaAlertCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIView *UiTitleLable;

@end

@implementation AreaAlertCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"AreaAlertCollectionViewCell" owner:self options:nil].lastObject;
    }
    return self;
}

+(NSString *)ID{
    return @"AreaAlertCollectionViewCell";
}


-(void)setcellModel:(Area *)hm{
    self.UITitle.text = hm.region_name;
    if([hm.isSelect isEqualToString:@"0"]){
         [self.UiTitleLable setBackgroundColor:[UIColor whiteColor]];
        [self.UITitle setTextColor:[UIColor blackColor]];
        
        [self.UiTitleLable setBackgroundColor:[UIColor colorWithRed:(0/225.0) green:(0/255.0) blue:(0/255.0) alpha:0.04]];
    }else{
        [self.UiTitleLable setBackgroundColor:[UIColor colorWithRed:(51.0/225.0) green:(207.0/255.0) blue:(218.0/255.0) alpha:1]];
        [self.UITitle setTextColor:[UIColor whiteColor]];
    }
    
}

@end
