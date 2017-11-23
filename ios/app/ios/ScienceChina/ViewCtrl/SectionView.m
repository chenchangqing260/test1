//
//  SectionView.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SectionView.h"

@interface SectionView()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation SectionView

- (void)setTitleWithString:(NSString*)title{
    [self.titleLab setText:title];
}

@end
