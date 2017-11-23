//
//  MyMoreStationCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MyMoreStationCollectionViewCell.h"

@interface MyMoreStationCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *uiMoreBtn;

@end

@implementation MyMoreStationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.uiMoreBtn.layer.cornerRadius = 3;
    self.uiMoreBtn.layer.borderColor = [UIColor colorWithHex:0x67DEC5].CGColor;
    self.uiMoreBtn.layer.borderWidth = 0.5;
}

+(NSString*)ID{
    return @"MyMoreStationCollectionViewCell";
}


- (IBAction)clickMoreBtn:(id)sender {
    [self.delegate clickMoreStation];
}

@end

