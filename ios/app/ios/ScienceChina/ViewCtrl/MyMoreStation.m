//
//  MyMoreStation.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyMoreStation.h"

@interface MyMoreStation()

@property (weak, nonatomic) IBOutlet UIButton *uiMoreBtn;

@end

@implementation MyMoreStation

- (void)awakeFromNib {
    [super awakeFromNib];
    self.uiMoreBtn.layer.cornerRadius = 3;
    self.uiMoreBtn.layer.borderColor = [UIColor colorWithHex:0x67DEC5].CGColor;
    self.uiMoreBtn.layer.borderWidth = 0.5;
}

+(NSString*)ID{
    return @"MyMoreStation";
}

+(MyMoreStation *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"MyMoreStation" owner:nil options:nil][0];
}

- (IBAction)clickMoreBtn:(id)sender {
    [self.delegate clickMoreStation];
}
@end
