//
//  LayoutContainnerView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//


#import "LayoutContainerView.h"
#import "LayoutView.h"
#import "GridLayoutView.h"
#import "Comment.h"
#import "Constant.h"
#import "BlurCommentView.h"
#import "DOFavoriteButton.h"

@interface LayoutContainerView()

@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *timeLabel;
@property (nonatomic,strong) UIImageView  *headImageView;
@property (nonatomic,strong) UIButton     *uiReplyBtn;
@property (nonatomic,strong) DOFavoriteButton     *uiZanBtn;
@property (nonatomic,strong) Comment *model;

@end

@implementation LayoutContainerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)updateWithModelArray:(NSMutableArray *)sortedArray{
    
    int i = 0;
    id lastView = nil;
    float lastH = 0;
    
    Comment *lastModel = [sortedArray lastObject];
    
    if(sortedArray.count > MaxOverlapNumber ){
       
        NSMutableArray *tempArray =[[NSMutableArray alloc] initWithArray:sortedArray];
        [tempArray removeObjectsInRange:NSMakeRange(sortedArray.count - MaxOverlapNumber, MaxOverlapNumber)];
        
        CGRect r = CGRectMake(50+ MaxOverlapNumber*OverlapSpace, 60 + MaxOverlapNumber*OverlapSpace, ScreenWidth - 50 -10 - 2*(MaxOverlapNumber * OverlapSpace),  0);
        GridLayoutView  *gridView =[[GridLayoutView alloc] initWithFrame:r andModelArray:tempArray];
        lastH = gridView.frame.size.height;
        [self addSubview:gridView];
        lastView = gridView;
       
        [sortedArray removeObjectsInRange:NSMakeRange(0, sortedArray.count - MaxOverlapNumber)];
  
    }
        
    for (Comment *model in sortedArray) {
       
        i = lastModel.r_floor.intValue - model.r_floor.intValue;
        
        CGRect r = CGRectMake(50 + i*OverlapSpace, 60 + i*OverlapSpace, ScreenWidth - 50 -10 - 2*(i * OverlapSpace), 0);
        CGSize sz = [model sizeWithConstrainedToSize:CGSizeMake(r.size.width-10, MAXFLOAT)];
        r.size.height = sz.height +lastH + 55;
        
        LayoutView *vi =[[LayoutView alloc] initWithFrame:r model:model parentView:lastView isLast:[lastModel isEqual: model]];
        
        lastH =  r.size.height;
        
        if (lastView) {
            [self insertSubview:vi belowSubview:lastView];
        }else{
            [self addSubview:vi];
        }
        lastView = vi;
    }
    
    self.frame = CGRectMake(0, 0,ScreenWidth, lastH+44);
    
    
}
-(instancetype)initWithModelArray:(NSArray *)model{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = CellBackgroundColor;
        NSMutableArray *ar =[NSMutableArray arrayWithArray:model];
        self.model = [ar lastObject];
        
        self.backgroundColor = CellBackgroundColor;
        
        _headImageView  =[[UIImageView alloc] initWithFrame:CGRectMake(9, 15, 36, 36)];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.r_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        _headImageView.layer.cornerRadius = 18;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = TimeFont;
        _timeLabel.textColor =[UIColor colorWithHex:0x575757];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _nameLabel.text = self.model.r_name;
        _timeLabel.text = self.model.r_push_time;
        
        _uiReplyBtn = [UIButton new];
        [_uiReplyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_uiReplyBtn.titleLabel setFont:FONT_14];
        [_uiReplyBtn setTitleColor:[UIColor colorWithHex:0xb5b5b5] forState:UIControlStateNormal];
        [_uiReplyBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_uiReplyBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_uiReplyBtn addTarget:self action:@selector(didReplyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        _likeButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [_likeButton setBackgroundImage:[UIImage imageNamed:@"like_btn.png"] forState:UIControlStateNormal];
//
        CGFloat showWidth = kSCREEN_WIDTH;
        if (isIpad) {
            showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        }
        _uiZanBtn = [[DOFavoriteButton alloc] initWithFrame:CGRectMake(showWidth - 15 - 65, 9 ,30, 30) image:[UIImage imageNamed:@"zan"]];
        //_uiZanBtn.backgroundColor = [UIColor redColor];
        _uiZanBtn.imageColorOff = [UIColor colorWithHex:0xB5B5B5];
        _uiZanBtn.imageColorOn = [UIColor colorWithHex:0x33cfda];
        _uiZanBtn.circleColor = [UIColor colorWithHex:0xFFD700];
        _uiZanBtn.lineColor = [UIColor colorWithHex:0xFFD700];
        _uiZanBtn.duration = 1;
        [_uiZanBtn addTarget:self action:@selector(didZanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        _uiZanBtn.hidden = YES;
        
        [self addSubview:_uiReplyBtn];
        [self addSubview:_uiZanBtn];
        [self addSubview:_headImageView];
        [self addSubview:_nameLabel];
        [self addSubview:_timeLabel];

        [self updateWithModelArray:ar];
    }
    return self;
}

-(void)didReplyBtnAction{
    [BlurCommentView commentshowSuccess:^(NSString *commentText) {
        [SVProgressHUDUtil showWithStatus:@"正在回复..."];
        [[WebAccessManager sharedInstance]saveAndReplyCommentWithIn_id:nil commentContent:commentText parentCommentId:self.model.r_id completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"回复成功"];
                // 刷新新闻数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
                
                [self.delegate commentSuccessCallBack];
                
            }else{
                [SVProgressHUDUtil showInfoWithStatus:@"回复失败"];
            }
        }];
    } withTitle:@"回复"];
}

-(void)didZanBtnAction:(id)sender {
    // 进行点赞，或取消点赞操作
    DOFavoriteButton *button = (DOFavoriteButton *)sender;
    if (button.selected) {
        //[button deselect];
        [SVProgressHUDUtil showInfoWithStatus:@"您已经点过赞了"];
    } else {
        // 点赞
        [[WebAccessManager sharedInstance]saveWithR_id:self.model.r_id completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                self.model.r_id = @"1";
                [button select];
                [self refreshCommentStatusForZan];
            }
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(9, 15, 36, 36);
    _nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 9, 17,self.frame.size.width - 10, 17);
    _timeLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 9, _nameLabel.frame.origin.y + 17 + 5 ,self.frame.size.width - 10, 16);
    CGFloat showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    _uiReplyBtn.frame =  CGRectMake(showWidth - 15 - 60, 17 ,60, 40);
    if ([self.model.r_is_praise isEqualToString:@"0"]) {
        _uiZanBtn.selected = NO;
    }else{
        _uiZanBtn.selected = YES;
    }
}

// 点赞之后状态刷新
-(void)refreshCommentStatusForZan{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEODETIAL_INFO object:nil];
}

@end
