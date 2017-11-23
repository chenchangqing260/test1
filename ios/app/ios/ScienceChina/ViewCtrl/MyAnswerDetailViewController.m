//
//  MyAnswerDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyAnswerDetailViewController.h"
#import "DOFavoriteButton.h"
#import "TextUtil.h"
#import "Question.h"

@interface MyAnswerDetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;

@property (weak, nonatomic) IBOutlet UILabel *uiQuesLab;

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiAnswerCountLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiMemNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiAnswerLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UIView *uiOperationView;
@property (weak, nonatomic) IBOutlet UILabel *uiReplyCountLab;

@property (nonatomic,strong) DOFavoriteButton     *uiZanBtn;

@end

@implementation MyAnswerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的回答";
    
    // 1、初始化
    [self initViewAndConstant];
    
    // 2、加载网络数据
    [self loadData];
}

#pragma mark - 初始化
- (void)initViewAndConstant{
    
    self.leadingEdge_view.constant = self.leftEdge;
    // 1、数据初始化
    self.conScrollViewWidth.constant = self.showWidth;
    self.conScrollViewHeight.constant = 200;
    
    self.uiQuesLab.layer.cornerRadius = 2;
    self.uiQuesLab.layer.masksToBounds = YES;
    
    // 2、增加点赞按钮
    // 增加点赞按钮
    _uiZanBtn = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(0, -2, 30, 30) image:[UIImage imageNamed:@"zan"]];
    //_uiZanBtn.backgroundColor = [UIColor redColor];
    _uiZanBtn.imageColorOff = [UIColor colorWithHex:0xB5B5B5];
    _uiZanBtn.imageColorOn = [UIColor colorWithHex:0x33cfda];
    _uiZanBtn.circleColor = [UIColor colorWithHex:0xFFD700];
    _uiZanBtn.lineColor = [UIColor colorWithHex:0xFFD700];
    _uiZanBtn.duration = 1;
    [self.uiOperationView addSubview:_uiZanBtn];
    
    if ([self.reply.r_is_praise isEqualToString:@"0"]) {
        _uiZanBtn.selected = NO;
    }else{
        _uiZanBtn.selected = YES;
    }
}

#pragma mark - 加载网络数据
-(void)loadData{
    // 计算数据
    self.uiTitleLab.text = self.reply.in_title;
    self.uiAnswerCountLab.text = [NSString stringWithFormat:@"%@%@", self.reply.replyCount, @"条回答"];
    [self.uiImgView sd_setImageWithURL:[NSURL URLWithString:self.reply.r_img_url] placeholderImage:nil];
    [self.uiMemNameLab setText:self.reply.r_name];
    [self.uiAnswerLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiAnswerLab text:self.reply.r_content]];
    [self.uiReplyCountLab setText:self.reply.r_praise_count];
    [self.uiTimeLab setText:[NSString stringWithFormat:@"%@%@", @"回答于", self.reply.r_push_time]];
    
    // 加载约束
    CGFloat contentHeight = [TextUtil boundingRectWithText:self.reply.r_content lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 30, 0) Font:self.uiAnswerLab.font].height;
    self.conScrollViewHeight.constant = 220 + contentHeight;
}

#pragma mark - 点击事件
- (IBAction)clickReplyQuesBtnAction:(id)sender {
    Question* question = [Question new];
    question.qu_id = self.reply.in_id;
    [FlowUtil startToQuesDetailVCNav:self.navigationController question:question];
}

@end
