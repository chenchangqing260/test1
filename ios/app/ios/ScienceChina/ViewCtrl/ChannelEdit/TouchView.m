//
//  TouchView.m
//  V1_Circle
//
//  Created by 刘瑞龙 on 15/11/2.
//  Copyright © 2015年 com.Dmeng. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

//-(float)getTextSizeWithInOrOut:(BOOL)inOrOut{
//    if (inOrOut) {
//        return 15.0;
//    }else{
//        return 12.0;
//    }
//}
//
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
//        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
//        self.contentLabel.textAlignment = NSTextAlignmentCenter;
//        self.contentLabel.backgroundColor = [UIColor colorWithRed:103/255.0 green:204/255.0 blue:216/255.0 alpha:1.0];
//        self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:NO]];
//        self.contentLabel.textColor = [UIColor whiteColor];
//        self.contentLabel.layer.borderWidth = 0.5;
//        self.contentLabel.layer.borderColor = self.contentLabel.backgroundColor.CGColor;
//        self.contentLabel.layer.cornerRadius = self.contentLabel.frame.size.height/2.0;
//        self.contentLabel.clipsToBounds = YES;
//        [self addSubview:self.contentLabel];
//        
//        self.closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 18.5, 1.5, 16, 16)];
//        self.closeImageView.hidden = YES;
//        self.closeImageView.image = [UIImage imageNamed:@"delOneChannel"];
//        [self addSubview:self.closeImageView];
//    }
//    return self;
//}
//
//-(void)inOrOutTouching:(BOOL)inOrOut{
//    if (inOrOut) {
//        //self.contentLabel.frame = self.bounds;
//        //self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:YES]];
//        self.backgroundColor = [UIColor clearColor];
//        self.alpha = 0.7;
//        self.contentLabel.alpha = 0.7;
//        
//    }else{
//        self.contentLabel.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10);
//        self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:NO]];
//        self.backgroundColor = [UIColor clearColor];
//        self.alpha = 1.0;
//        self.contentLabel.alpha = 1.0;
//    }
//}

-(float)getTextSizeWithInOrOut:(BOOL)inOrOut{
    if (inOrOut) {
        return 15.0;
    }else{
        return 12.0;
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 0, self.bounds.size.height - 0)];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:103/255.0 green:204/255.0 blue:216/255.0 alpha:1.0];
        self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:NO]];
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.layer.borderWidth = 0.5;
        self.contentLabel.layer.borderColor = [UIColor colorWithHex:0x67ccd8].CGColor;//self.contentLabel.backgroundColor.CGColor;
        //self.contentLabel.layer.cornerRadius = self.contentLabel.frame.size.height/2.0;
        //self.contentLabel.clipsToBounds = YES;
        [self addSubview:self.contentLabel];
        
        self.closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 14, -2, 20, 20)];
        self.closeImageView.hidden = YES;
        //self.closeImageView.image = [UIImage imageNamed:@"delOneChannel"];
        self.closeImageView.userInteractionEnabled = YES;
        [self addSubview:self.closeImageView];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 16, 16)];
        img.image = [UIImage imageNamed:@"delOneChannel"];
        img.userInteractionEnabled = YES;
        [self.closeImageView addSubview:img];
        
        UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [self.closeImageView addGestureRecognizer:tapClose];
    }
    return self;
}

-(void)inOrOutTouching:(BOOL)inOrOut{
    if (inOrOut) {
        //self.contentLabel.frame = self.bounds;
        //self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:YES]];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.7;
        self.contentLabel.alpha = 0.7;
        
    }else{
        self.contentLabel.frame = CGRectMake(0, 0, self.bounds.size.width - 0, self.bounds.size.height - 0);
        self.contentLabel.font = [UIFont systemFontOfSize:[self getTextSizeWithInOrOut:NO]];
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        self.contentLabel.alpha = 1.0;
    }
}

-(void)close:(UITapGestureRecognizer *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapClose:)]) {
        [self.delegate tapClose:sender];
    }
}

@end
