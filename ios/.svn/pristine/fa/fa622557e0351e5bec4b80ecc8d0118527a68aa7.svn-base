//
//  BottomOperationView.m
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BottomOperationView.h"
#import "BlurCommentView.h"
#import "AFWaveView.h"

@interface BottomOperationView()

@property (weak, nonatomic) IBOutlet UIButton *uiShowInputViewBtn;
@property (weak, nonatomic) IBOutlet UIImageView *uiLikeImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;
@property (weak, nonatomic) IBOutlet UIView *uiLikeView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLikeImgViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLikeImgViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conShareViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLikeViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conShowInputBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conShareViewLeftSpace;

@property (nonatomic, strong)InfoObj* info;

@end

@implementation BottomOperationView

- (void)awakeFromNib{
    self.uiShowInputViewBtn.layer.borderColor = [UIColor colorWithHex:0xD8D8D8].CGColor;
    self.uiShowInputViewBtn.layer.borderWidth = 0.5;
    self.uiShowInputViewBtn.layer.cornerRadius = 3;
    self.uiShowInputViewBtn.layer.masksToBounds = YES;
    
    if (kSCREEN_WIDTH < kWIDTH_375) {
        self.conShareViewWidth.constant = 45;
        self.conLikeViewWidth.constant = 45;
        self.conShareViewLeftSpace.constant = 5;
        self.conShowInputBtnWidth.constant = 120;
    }else if(kSCREEN_WIDTH > kWIDTH_375){
        self.conShowInputBtnWidth.constant = 170;
        self.conShareViewLeftSpace.constant = 20;
        self.conShareViewWidth.constant = 50;
        self.conLikeViewWidth.constant = 55;
    }else{
        self.conShareViewWidth.constant = 50;
        self.conLikeViewWidth.constant = 50;
        self.conShareViewLeftSpace.constant = 15;
        self.conShowInputBtnWidth.constant = 150;
    }
}

+(BottomOperationView *)newNib{
    return [[NSBundle mainBundle]loadNibNamed:@"BottomOperationView" owner:nil options:nil][0];
}

- (CGFloat)height{
    return 52.0f;
}

-(void)initViewDataWithInfo:(InfoObj*)info{
    self.info = info;
    if ([self.info.in_is_collect integerValue] == Collect) {
        // 已收藏
        [_uiLikeImgView setImage:[UIImage imageNamed:@"已喜欢"]];
    }else{
        // 未收藏
        [_uiLikeImgView setImage:[UIImage imageNamed:@"喜欢"]];
    }
    self.uiCommentCountLab.text = self.info.in_reviewCount;
}

#pragma  mark - 按钮操作事件
- (IBAction)clickBackBtnAction:(id)sender {
    [self.delegate didBackAction];
}

- (IBAction)clickShowInputCommentBtnAction:(id)sender {
    [BlurCommentView commentshowSuccess:^(NSString *commentText) {
        [SVProgressHUDUtil showWithStatus:@"正在评论..."];
        [[WebAccessManager sharedInstance]saveAndReplyCommentWithIn_id:self.info.in_id commentContent:commentText parentCommentId:nil completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"评论成功"];
                // 刷新新闻数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
            }else{
                [SVProgressHUDUtil showInfoWithStatus:response.errorMsg];
            }
        }];
    } withTitle:nil];
}

- (IBAction)clickShareGesAction:(id)sender {
    [self.delegate didShare];
}

- (IBAction)clickLickGesAction:(id)sender {
    if ([MemberManager sharedInstance].isLogined) {
        if ([self.info.in_is_collect integerValue] == Collect) {
            self.uiLikeView.userInteractionEnabled = NO;
            [[WebAccessManager sharedInstance]removeCollectInfo:self.info.in_id completion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    // 收藏成功
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                    [[NSNotificationCenter  defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
                    
                    AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
                    
                    waveView.maxR=30;
                    waveView.duration=1;
                    waveView.waveDelta=4;
                    waveView.waveCount=3;
                    waveView.maxAlpha=1;
                    waveView.minAlpha=0;
                    waveView.waveStyle = Heart;
                    //    waveView.waveStyle = Heart;
                    waveView.mainColor = [UIColor colorWithHex:0xcccccc];
                    //    waveView.boundaryAlpha = 0.8;
                    [self.uiLikeView addSubview:waveView];
                    
                    [_uiLikeImgView setImage:[UIImage imageNamed:@"喜欢"]];
                    self.info.in_is_collect = [NSString stringWithFormat:@"%d", NotCollect];
                    dispatch_main_after(1.2, ^{
                        [SVProgressHUDUtil showSuccessWithStatus:@"取消成功"];
                        self.uiLikeView.userInteractionEnabled = YES;
                    });
                }else{
                    dispatch_main_after(1.2, ^{
                        [SVProgressHUDUtil showErrorWithStatus:@"取消失败"];
                        self.uiLikeView.userInteractionEnabled = YES;
                    });
                }
            }];
        }else{
            self.uiLikeView.userInteractionEnabled = NO;
            [[WebAccessManager sharedInstance]saveCollectInfo:self.info.in_id completion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    // 收藏成功
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICANDTEXTVIEW_INFO object:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_VIDEOVIEW_INFO object:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
                    // 未收藏，进行收藏操作
                    AFWaveView *waveView = [[AFWaveView alloc]initWithPoint:self.uiLikeImgView.center];
                    
                    waveView.maxR=30;
                    waveView.duration=1;
                    waveView.waveDelta=4;
                    waveView.waveCount=3;
                    waveView.maxAlpha=1;
                    waveView.minAlpha=0;
                    waveView.waveStyle = Heart;
                    //    waveView.waveStyle = Heart;
                    waveView.mainColor = [UIColor colorWithHex:0x33cfda];
                    //[UIColor colorWithRed:0 green:0.7 blue:1 alpha:1];
                    //    waveView.boundaryAlpha = 0.8;
                    
                    [self.uiLikeView addSubview:waveView];
                    [_uiLikeImgView setImage:[UIImage imageNamed:@"已喜欢"]];
                    self.info.in_is_collect = [NSString stringWithFormat:@"%d", Collect];
                    
                    dispatch_main_after(1.2, ^{
                        [SVProgressHUDUtil showSuccessWithStatus:@"收藏成功"];
                        self.uiLikeView.userInteractionEnabled = YES;
                    });
                }else{
                    dispatch_main_after(1.2, ^{
                        [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
                        self.uiLikeView.userInteractionEnabled = YES;
                    });
                }
            }];
        }
    }else{
        [self.delegate didToLoginView];
    }
}

- (IBAction)clickToCommentVCGesAction:(id)sender {
    [self.delegate didToCommentList];
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end
