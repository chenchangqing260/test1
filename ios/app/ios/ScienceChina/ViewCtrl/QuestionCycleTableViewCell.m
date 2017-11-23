//
//  QuestionCycleTableViewCell.m
//  ScienceChina
//
//  Created by 三川薛 on 16/6/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuestionCycleTableViewCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation QuestionCycleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //[self addsubviews];
    // Initialization code
}



+(NSString*)ID{
    return @"QuestionCycleTableViewCell";
}
//不加载xib
+(QuestionCycleTableViewCell *)newCell{
    //return [[NSBundle mainBundle]loadNibNamed:@"QuestionCycleTableViewCell" owner:nil options:nil][0];
    QuestionCycleTableViewCell * cell = [[QuestionCycleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self ID]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//设置控件
-(void)addsubviews
{
    _CycleImgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/(375/175))];
    [self addSubview:_CycleImgView];
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, _CycleImgView.frame.size.height, SCREENWIDTH, 107)];
    
    _backGroundView.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    
    //_backGroundView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_backGroundView];
    
    float jianju = (SCREENWIDTH-162)/4;
    
    _questionBtn = [[UIButton alloc]initWithFrame:CGRectMake(jianju, 14, 54, 54)];
    
    [_questionBtn setBackgroundImage:[UIImage imageNamed:@"tiwen"] forState:UIControlStateNormal];
    
    [_backGroundView addSubview:_questionBtn];
    
    _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(54+2*jianju, 14, 54, 54)];
    
    [_typeBtn setBackgroundImage:[UIImage imageNamed:@"wendafenlei"] forState:UIControlStateNormal];
    
    [_backGroundView addSubview:_typeBtn];
    
    _myQuestionBtn = [[UIButton alloc]initWithFrame:CGRectMake(jianju*3+2*54, 14, 54, 54)];
    
    [_myQuestionBtn setBackgroundImage:[UIImage imageNamed:@"wodetiwen"] forState:UIControlStateNormal];
    
    [_backGroundView addSubview:_myQuestionBtn];
    
    _questionLab = [[UILabel alloc]initWithFrame:CGRectMake(jianju, 76, 54, 20)];
    
    _questionLab.textColor= [UIColor colorWithHex:0x707070];
    
    _questionLab.font = FONT_12;
    
    _questionLab.textAlignment = UITextAlignmentCenter;
    
    _questionLab.text = @"提 问";
    
    [_backGroundView addSubview:_questionLab];
    
    _typeLab = [[UILabel alloc]initWithFrame:CGRectMake(54+2*jianju, 76, 54, 20)];
    
    _typeLab.textColor= [UIColor colorWithHex:0x707070];
    
    _typeLab.font = FONT_12;
    
    _typeLab.textAlignment = UITextAlignmentCenter;
    
    _typeLab.text=@"分 类";
    
    [_backGroundView addSubview:_typeLab];
    
    _myQuestionLab = [[UILabel alloc]initWithFrame:CGRectMake(jianju*3+2*54, 76, 54, 20)];
    
    _myQuestionLab.textColor= [UIColor colorWithHex:0x707070];
    
    _myQuestionLab.font = FONT_12;
    
    _myQuestionLab.textAlignment = UITextAlignmentCenter;
    
    _myQuestionLab.text = @"我 的 提 问";
    
    [_myQuestionLab sizeToFit];
    
    [_backGroundView addSubview:_myQuestionLab];
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
