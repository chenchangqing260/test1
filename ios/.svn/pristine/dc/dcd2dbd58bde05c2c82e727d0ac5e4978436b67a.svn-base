//
//  PromptCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "PromptCollectionViewCell.h"

@interface PromptCollectionViewCell()


@property (weak, nonatomic) IBOutlet UILabel *UIPromptlable;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UIView *UIview;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn;

@end

@implementation PromptCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"PromptCollectionViewCell";
}

- (IBAction)clickBtn:(id)sender {
    [self.delegate backToHomePage];
}

-(void)setCellWithSciencePrompt:(BOOL)showSpace{
    
    NSString *_imageName;
    NSString *_tip;
    if (showSpace) {
        _tip = @"返回头条首页";
        _imageName = @"icon_comeback";
    }else{
        _tip = @"下拉显示您关心的内容";
        _imageName = @"down";
    }
    self.UIPromptlable.text = _tip;
    [self.UIImage setImage:[UIImage imageNamed:_imageName] ];
    
    [self layoutIfNeeded];
}

@end
