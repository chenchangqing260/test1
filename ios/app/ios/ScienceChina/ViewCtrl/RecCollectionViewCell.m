//
//  RecCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "RecCollectionViewCell.h"

@interface RecCollectionViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *uiFirstView;
@property (weak, nonatomic) IBOutlet UIImageView *uiFirstImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiFirstLab;
@property (weak, nonatomic) IBOutlet UIView *uiSecondView;
@property (weak, nonatomic) IBOutlet UIImageView *uiSecondImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiSecondLab;
@property (weak, nonatomic) IBOutlet UIView *uiThreeView;
@property (weak, nonatomic) IBOutlet UIImageView *uiThreeImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiThreeLab;
@property (weak, nonatomic) IBOutlet UIView *uiFourView;
@property (weak, nonatomic) IBOutlet UIImageView *uiFourImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiFourLab;
@property (weak, nonatomic) IBOutlet UIView *uiFiveView;
@property (weak, nonatomic) IBOutlet UIImageView *uiFiveImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiFiveLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentLab;

@end

@implementation RecCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.uiFirstView.hidden = YES;
    self.uiSecondView.hidden = YES;
    self.uiThreeView.hidden = YES;
    self.uiFourView.hidden = YES;
    self.uiFiveView.hidden = YES;
    
    // 添加点击手势
    UITapGestureRecognizer* singleFingerOne0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFirstView)];
    singleFingerOne0.numberOfTouchesRequired = 1; //手指数
    singleFingerOne0.numberOfTapsRequired = 1; //tap次数
    singleFingerOne0.delegate = self;
    [self.uiFirstView addGestureRecognizer:singleFingerOne0];
    
    UITapGestureRecognizer* singleFingerOne1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSecondView)];
    singleFingerOne1.numberOfTouchesRequired = 1; //手指数
    singleFingerOne1.numberOfTapsRequired = 1; //tap次数
    singleFingerOne1.delegate = self;
    [self.uiSecondView addGestureRecognizer:singleFingerOne1];
    
    UITapGestureRecognizer* singleFingerOne2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickThreeView)];
    singleFingerOne2.numberOfTouchesRequired = 1; //手指数
    singleFingerOne2.numberOfTapsRequired = 1; //tap次数
    singleFingerOne2.delegate = self;
    [self.uiThreeView addGestureRecognizer:singleFingerOne2];
    
    UITapGestureRecognizer* singleFingerOne3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFourView)];
    singleFingerOne3.numberOfTouchesRequired = 1; //手指数
    singleFingerOne3.numberOfTapsRequired = 1; //tap次数
    singleFingerOne3.delegate = self;
    [self.uiFourView addGestureRecognizer:singleFingerOne3];
    
    UITapGestureRecognizer* singleFingerOne4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFiveView)];
    singleFingerOne4.numberOfTouchesRequired = 1; //手指数
    singleFingerOne4.numberOfTapsRequired = 1; //tap次数
    singleFingerOne4.delegate = self;
    [self.uiFiveView addGestureRecognizer:singleFingerOne4];
}

#pragma mark - 点击手势方法
- (void)clickFirstView{
    if (_recArray[0]) {
        [self.delegate clickRecViewWithInfo:_recArray[0]];
    }
}

- (void)clickSecondView{
    if (_recArray[1]) {
        [self.delegate clickRecViewWithInfo:_recArray[1]];
    }
}

- (void)clickThreeView{
    if (_recArray[2]) {
        [self.delegate clickRecViewWithInfo:_recArray[2]];
    }
}

- (void)clickFourView{
    if (_recArray[3]) {
        [self.delegate clickRecViewWithInfo:_recArray[3]];
    }
}

- (void)clickFiveView{
    if (_recArray[4]) {
        [self.delegate clickRecViewWithInfo:_recArray[4]];
    }
}

+(NSString*)ID{
    return @"RecCollectionViewCell";
}

- (IBAction)clickBackBtnAction:(id)sender {
    [self.delegate clickBack];
}

- (void)setRecArray:(NSMutableArray *)recArray{
    _recArray = recArray;
    
    // 初始化数据
    if (_recArray && _recArray.count > 0) {
        self.uiFirstView.hidden = NO;
        InfoObj* model = [recArray objectAtIndex:0];
        [_uiFirstImgView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _uiFirstLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiFirstLab text:model.in_title];
    }else{
        self.uiFirstView.hidden = YES;
    }
    
    if (_recArray && _recArray.count > 1) {
        self.uiSecondView.hidden = NO;
        InfoObj* model = [recArray objectAtIndex:1];
        [_uiSecondImgView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _uiSecondLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiSecondLab text:model.in_title];
    }else{
        self.uiSecondView.hidden = YES;
    }
    
    if (_recArray && _recArray.count > 2) {
        self.uiThreeView.hidden = NO;
        InfoObj* model = [recArray objectAtIndex:2];
        [_uiThreeImgView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _uiThreeLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiThreeLab text:model.in_title];
    }else{
        self.uiThreeView.hidden = YES;
    }
    
    if (_recArray && _recArray.count > 3) {
        self.uiFourView.hidden = NO;
        InfoObj* model = [recArray objectAtIndex:3];
        [_uiFourImgView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _uiFourLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiFourLab text:model.in_title];
    }else{
        self.uiFourView.hidden = YES;
    }
    
    if (_recArray && _recArray.count > 4) {
        self.uiFiveView.hidden = NO;
        InfoObj* model = [recArray objectAtIndex:4];
        [_uiFiveImgView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _uiFiveLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiFiveLab text:model.in_title];
    }else{
        self.uiFiveView.hidden = YES;
    }
}

- (void)setCommentCount:(NSString *)commentCount{
    _commentCount = commentCount;
    [_uiCommentLab setText:[NSString stringWithFormat:@"%@%@评论%@",@"  ", commentCount, @"  "]];
}

#pragma mark - 点击事件
- (IBAction)clickShareBtn:(id)sender {
    [self.delegate clickShareBtn];
}

- (IBAction)clickToCommentBtn:(id)sender {
    [self.delegate clickCommentCountBtn];
}


@end
