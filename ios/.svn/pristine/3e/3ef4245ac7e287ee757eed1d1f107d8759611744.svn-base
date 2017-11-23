//
//  CollectionReusableHeaderViewOnMy.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CollectionReusableHeaderViewOnMy.h"
#import "WaterView.h"
#import <Accelerate/Accelerate.h>
#import "UIImageView+LBBlurredImage.h"

@implementation CollectionReusableHeaderViewOnMy
{
    UIImageView *_backImageView; //大背景
    UIImageView *_headIcon; //用户头像
    UIImageView *_certificationMarkImage; //认证标志_用户头像右下角
    
    UILabel *_nameLabelUp;  //用户名_在头像之上的
    UILabel *_nameLabelDown;//用户名_在头像之下的
    
    UIButton *_rightNavBtn;
    UILabel *_monthIntegralNumLabel;//本月积分数_右上角显示
    
    UIView *_levelView;
    UIView *_bottomView;
    UIView *_integralNumView;//积分+积分数
    
    UIView *_starAndTitleView;// ✨✨✨ 博导
    UIImageView *_starsImageView;
    UILabel *_levelTitleLabel;//称谓：博导。。。
    UIButton *_minStar;
    UIButton *_maxStar;
    UIProgressView *_progress;//进度条
    //UILabel *_minStarNumLabel;//✨范围
    //UILabel *_maxStarNumLabel;//✨范围
    UILabel *_minIntegralLabel;//积分范围
    UILabel *_maxIntegralLabel;//积分范围
    
    UILabel *_collectNumLabel;//收藏数
    UILabel *_integralNumLabel;//积分数
    UILabel *_commentsNumLabel;//评论分数
}
+(NSString *)ID{
    return @"CollectionReusableHeaderViewOnMy";
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return  self;
}
-(void)setupView{
    
    UIFont *_textFont = [UIFont systemFontOfSize:15.0];
    UIColor *_textColor = [UIColor whiteColor];
    UIColor *_textColorYellow = [UIColor colorWithHex:0xfff100];
    CGFloat nameLabelUpY = 30;
    if (isIpad) {
        nameLabelUpY = 130;
    }
    
    //背景图
    _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backImageView.contentMode =  UIViewContentModeScaleAspectFill;
    
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.frame = _backImageView.bounds;
//    [_backImageView addSubview:effectView];
    
    //用户名
    _nameLabelUp = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLabelUpY, self.bounds.size.width, 20)];
    _nameLabelUp.font = _textFont;
    _nameLabelUp.textColor = _textColor;
    _nameLabelUp.textAlignment = NSTextAlignmentCenter;
    
    //用户头像
    CGFloat _iconW = 60;
    CGFloat _spaceBetweenUpNameAndIcon = 5.0;
    _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-_iconW)/2.0, _nameLabelUp.frame.origin.y+_nameLabelUp.frame.size.height+_spaceBetweenUpNameAndIcon, _iconW, _iconW)];
    //_headIcon.contentMode =  UIViewContentModeScaleAspectFit;
    _headIcon.layer.cornerRadius = _iconW/2.0;
    _headIcon.layer.borderWidth = 4.0;
    _headIcon.layer.borderColor = [UIColor colorWithHex:0xffffff alpha:0.5].CGColor;
    _headIcon.clipsToBounds = YES;
    _headIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapHeader = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapheader)];
    [_headIcon addGestureRecognizer:tapHeader];
    
    //认证标志
    CGFloat verIconW = 20.0;
    CGFloat verIconH = 22.0;
    _certificationMarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(_headIcon.frame.origin.x+_headIcon.frame.size.width-verIconW, _headIcon.frame.origin.y+_headIcon.frame.size.height-verIconH, verIconW, verIconH)];
    
    
    //用户名
    _nameLabelDown = [[UILabel alloc] initWithFrame:CGRectMake(0, _headIcon.frame.origin.y+_headIcon.frame.size.height+_spaceBetweenUpNameAndIcon, self.bounds.size.width, 20)];
    _nameLabelDown.font = _textFont;
    _nameLabelDown.textColor = _textColor;
    _nameLabelDown.textAlignment = NSTextAlignmentCenter;
    
    //左侧按钮
//    UIImage *leftImg = [UIImage imageNamed:@"showLeftViewicon"];
//    CGFloat leftBtnW = 35.0;
//    CGFloat leftBtnH = 35.0;
//    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftNavBtn.frame = CGRectMake(10, 30, leftBtnW, leftBtnH);
//    [leftNavBtn setImage:leftImg forState:UIControlStateNormal];
//    [leftNavBtn setImage:leftImg forState:UIControlStateHighlighted];
//    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake((leftBtnW-leftImg.size.height)/2.0, (leftBtnW-leftImg.size.width)/2.0, (leftBtnW-leftImg.size.height)/2.0, (leftBtnW-leftImg.size.width)/2.0)];
//    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //右侧按钮 本月积分+本月积分数
    _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightNavBtn.frame = CGRectMake(self.bounds.size.width-70-15, 30, 70, 40);
    [_rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *_monthIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _rightNavBtn.frame.size.width, 20)];
    _monthIntegralLabel.font = FONT_12;
    _monthIntegralLabel.text = @"本月积分>";
    _monthIntegralLabel.textColor = _textColor;
    _monthIntegralLabel.textAlignment = NSTextAlignmentCenter;
    _monthIntegralLabel.layer.cornerRadius = _monthIntegralLabel.frame.size.height/2.0;
    _monthIntegralLabel.clipsToBounds = YES;
    _monthIntegralLabel.backgroundColor = [UIColor colorWithHex:0xffffff alpha:0.2];
    
    _monthIntegralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _monthIntegralLabel.frame.size.height, _rightNavBtn.frame.size.width, 20)];
    _monthIntegralNumLabel.font = FONT_12;
    _monthIntegralNumLabel.text = @"0";
    _monthIntegralNumLabel.textColor = _textColorYellow;
    _monthIntegralNumLabel.textAlignment = NSTextAlignmentCenter;

    [_rightNavBtn addSubview:_monthIntegralLabel];
    [_rightNavBtn addSubview:_monthIntegralNumLabel];
    
    
    CGFloat _bottomViewH = 60;
    WaterView *waterView=[[WaterView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100)];
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(30, self.bounds.size.height-_bottomViewH, self.bounds.size.width-30*2, _bottomViewH)];
    _levelView = [[UIView alloc] initWithFrame:CGRectMake(0, _headIcon.frame.origin.y+_headIcon.frame.size.height+_spaceBetweenUpNameAndIcon, self.bounds.size.width, 100)];
    
    UIColor *_clearColor = [UIColor clearColor];
    _bottomView.backgroundColor = _clearColor;
    _levelView.backgroundColor = _clearColor;
    
    _starAndTitleView = [[UIView alloc] initWithFrame:CGRectMake((_bottomView.bounds.size.width-30)/2.0, 0, 30, 15)];
    
    _starsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _levelTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, _starAndTitleView.frame.size.height)];
    _levelTitleLabel.font = _textFont;
    _levelTitleLabel.text = @"";
    _levelTitleLabel.textColor = _textColor;
    _levelTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_starAndTitleView addSubview:_starsImageView];
    [_starAndTitleView addSubview:_levelTitleLabel];
    
    CGFloat spaceBetweenStarAndPregress = 15;
    CGFloat progresLeft = 40;
    CGFloat progressY = _starAndTitleView.frame.origin.y+_starAndTitleView.frame.size.height+spaceBetweenStarAndPregress;
    if (isIpad) {
        progressY = _starAndTitleView.frame.origin.y+_starAndTitleView.frame.size.height+spaceBetweenStarAndPregress+30;//self.bounds.size.height/2.0;
        progresLeft = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0+40;
    }
    _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress.frame = CGRectMake(progresLeft, progressY, (_levelView.bounds.size.width-progresLeft*2), 20);
    _progress.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    _progress.trackTintColor = [UIColor whiteColor];//背景色
    _progress.progressTintColor = [UIColor yellowColor];//进度色
    _progress.backgroundColor = [UIColor whiteColor];
    
    CGFloat spaceBetweenProgressAndIntegral = 5;
    CGFloat btnW = 35;
    CGFloat btnH = 20;
    CGFloat up = _progress.frame.origin.y-btnH-spaceBetweenProgressAndIntegral;
    CGFloat down = _progress.frame.origin.y+_progress.frame.size.height + spaceBetweenProgressAndIntegral;
    
    CGFloat iconAndTitleSpace = 5;
    UIImage *star = [UIImage imageNamed:@"baixing"];
    _minStar = [UIButton buttonWithType:UIButtonTypeCustom];
    _minStar.frame = CGRectMake(_progress.frame.origin.x-btnW/2.0, up, btnW, btnH);
    _minStar.titleLabel.font = _textFont;
    [_minStar setImage:star forState:UIControlStateNormal];
    [_minStar setTitle:@"0" forState:UIControlStateNormal];
    [_minStar setImageEdgeInsets:UIEdgeInsetsMake(0, -iconAndTitleSpace, 0, 0)];
    [_minStar setTitleEdgeInsets:UIEdgeInsetsMake(0, iconAndTitleSpace, 0, iconAndTitleSpace)];
    
    _maxStar = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxStar.frame = CGRectMake(_progress.frame.origin.x+_progress.frame.size.width-btnW/2.0, up, btnW, btnH);
    _maxStar.titleLabel.font = _textFont;
    [_maxStar setImage:star forState:UIControlStateNormal];
    [_maxStar setTitle:@"0" forState:UIControlStateNormal];
    [_maxStar setImageEdgeInsets:UIEdgeInsetsMake(0, -iconAndTitleSpace, 0, 0)];
    [_maxStar setTitleEdgeInsets:UIEdgeInsetsMake(0, iconAndTitleSpace, 0, iconAndTitleSpace)];
    
    CGFloat _integralLabelW = 48;
    CGFloat _integralLabelH = 20;
    _minIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_progress.frame.origin.x-_integralLabelW/2.0, down, _integralLabelW, _integralLabelH)];
    _minIntegralLabel.font = _textFont;
    _minIntegralLabel.text = @"0";
    _minIntegralLabel.textColor = _textColor;
    _minIntegralLabel.textAlignment = NSTextAlignmentCenter;
    
    _maxIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(_progress.frame.origin.x+_progress.frame.size.width-_integralLabelW/2.0, down, _integralLabelW, _integralLabelH)];
    _maxIntegralLabel.font = _textFont;
    _maxIntegralLabel.text = @"0";
    _maxIntegralLabel.textColor = _textColor;
    _maxIntegralLabel.textAlignment = NSTextAlignmentCenter;

    
    [_levelView addSubview:_starAndTitleView];
    [_levelView addSubview:_progress];
    
    [_levelView addSubview:_minStar];
    [_levelView addSubview:_maxStar];
    [_levelView addSubview:_minIntegralLabel];
    [_levelView addSubview:_maxIntegralLabel];
    
    CGFloat _itemViewW = _bottomView.frame.size.width/3;
    CGFloat _imageW = 15.0;
    CGFloat titleLabelH  =  _imageW;//30; //标题的高度
    CGFloat titleLabelW = 40; //标题的高度
    CGFloat spaceBetweenTitleAndNum = 5; //标题和数据之间的距离
    CGFloat spaceBetweenTitleAndImg = 5; //标题和图标之间的距离
    CGFloat bottomSpace = 5; //图片距离底部的距离
    
    NSArray *titles = @[@"收 藏",@"积 分",@"评 论"];
    NSArray *images = @[@"icon_my_header_collection",@"icon_my_header_integral",@"icon_my_header_comments"];
    for (int i=0; i<3; i++) {
        UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(_itemViewW*i, 0, _itemViewW, _bottomView.frame.size.height)];
        
        CGFloat titleLabelY = subview.frame.size.height-titleLabelH-bottomSpace;
        CGFloat imageX = (subview.frame.size.width-_imageW-titleLabelW-spaceBetweenTitleAndImg)/2.0;
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        image.frame = CGRectMake(imageX, titleLabelY, _imageW, _imageW);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.origin.x+_imageW+spaceBetweenTitleAndImg, titleLabelY, titleLabelW, titleLabelH)];
        titleLabel.font = _textFont;
        titleLabel.text = titles[i];
        titleLabel.textColor = _textColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        CGFloat numLabelY = titleLabel.frame.origin.y-titleLabelH-spaceBetweenTitleAndNum;
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, numLabelY, subview.frame.size.width, titleLabelH)];
        numLabel.font = _textFont;
        numLabel.text = @"0";
        numLabel.textColor = _textColor;
        numLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(subview.frame.size.width-0.5, subview.frame.size.height-10.0-25.0, 0.5, 25.0)];
        line.backgroundColor = [UIColor whiteColor];
        
        [subview addSubview:numLabel];
        [subview addSubview:image];
        [subview addSubview:titleLabel];
        [_bottomView addSubview:subview];
        
        
        
        SEL selector;
        if (i == 0) {
            _collectNumLabel = numLabel;
            selector = @selector(tapcollect);
            
            [subview addSubview:line];
            
        } else if (i == 1) {
            _integralNumLabel = numLabel;
            _integralNumView = subview;
            
            [subview addSubview:line];
            
            selector = @selector(tapintegral);
        } else if (i == 2) {
            _commentsNumLabel = numLabel;
            selector = @selector(tapcomment);
        }
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
       [subview addGestureRecognizer:tap];
        
    }
    
    
    [self addSubview:_backImageView];

    [self addSubview:waterView];
    [self addSubview:_bottomView];
    [self addSubview:_levelView];
    
    [self addSubview:_nameLabelUp];
//    [self addSubview:leftNavBtn];
    [self addSubview:_rightNavBtn];
    [self addSubview:_headIcon];
    [self addSubview:_certificationMarkImage];
    [self addSubview:_nameLabelDown];
}

//左导航按钮
//-(void)leftNavBtn{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(tapLeftButton)]) {
//        [self.delegate tapLeftButton];
//    }
//}
//本月积分
-(void)rightNavBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapMonthIntegral)]) {
        [self.delegate tapMonthIntegral];
    }
}
//头像
-(void)tapheader{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapUserHeader)]) {
        [self.delegate tapUserHeader];
    }
}
//收藏
-(void)tapcollect{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCollectViewDelegateFun)]) {
        [self.delegate tapCollectViewDelegateFun];
    }
}
//积分
-(void)tapintegral{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapIntegralViewDelegateFun)]) {
        [self.delegate tapIntegralViewDelegateFun];
    }
}
//评论
-(void)tapcomment{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCommentViewDelegateFun)]) {
        [self.delegate tapCommentViewDelegateFun];
    }
}
//设置评论数、收藏数量
-(void)setNumsWithWebResponse:(WebResponse *)response{
    _collectNumLabel.text = response.data.m_collectCount;
    _commentsNumLabel.text = response.data.m_reviewCount;
}
-(void)refreshHeaderView{
    //是否已登录
    if ([[MemberManager sharedInstance] isLogined]) {
        
        // 1、设置头像、姓名
        [_backImageView setImage:[UIImage imageNamed:@"loginAfterbg"]];
        //[_backImageView setImageToBlur:[UIImage imageNamed:@"loginAfterbg"] blurRadius:5 completionBlock:nil];// 模糊图片

        [_headIcon      sd_setImageWithURL:[NSURL URLWithString:[[MemberManager sharedInstance] getMember].img_url] placeholderImage:nil];
        //        [_backImageView sd_setImageWithURL:[NSURL URLWithString:[[MemberManager sharedInstance] getMember].img_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //            if (image) {
        //                UIImage *newImage = [self blurryImage:image withBlurLevel:0.1];
        //                if (newImage) {
        //                    [_backImageView setImage:newImage];
        //                }
        //            }
        //        }];
        [_nameLabelUp   setText:[[MemberManager sharedInstance] getMember].member_name];
        [_nameLabelDown setText:[[MemberManager sharedInstance] getMember].member_name];
        
        Score *score = [MemberManager sharedInstance].getScore;
        if (score) {
            CGFloat percent = ([score.totalScore floatValue]-[score.fromScore floatValue])/([score.toScore floatValue]-[score.fromScore floatValue]);
            NSInteger minGrade = [score.grade integerValue] > 0 ? ([score.grade integerValue]) : 0;
            _monthIntegralNumLabel.text = score.currentMonthScore;
            _integralNumLabel.text = score.totalScore;
            _minIntegralLabel.text = score.fromScore;
            _maxIntegralLabel.text = score.toScore;
            
            NSString *minGradeStr = [NSString stringWithFormat:@"%ld",minGrade];
            NSString *maxGradeStr = [NSString stringWithFormat:@"%ld",[score.grade integerValue]+1];
            [_minStar setTitle:minGradeStr forState:UIControlStateNormal];
            [_maxStar setTitle:maxGradeStr forState:UIControlStateNormal];
            
            UIImage *starWhite  = [UIImage imageNamed:@"baixing"];
            UIImage *starYellow = [UIImage imageNamed:@"huangxinxin"];

            if ([minGradeStr integerValue] == 0) {
                [_minStar setImage:starWhite forState:UIControlStateNormal];
            }else{
                [_minStar setImage:starYellow forState:UIControlStateNormal];
            }
            if ([maxGradeStr integerValue] == 0) {
                [_maxStar setImage:starWhite forState:UIControlStateNormal];
            }else{
                [_maxStar setImage:starYellow forState:UIControlStateNormal];
            }

            
            
            [_progress setProgress:percent animated:YES];
            NSString *imageName = [NSString stringWithFormat:@"%@xingOnIntegralRuels",score.grade];
            
            UIImage *star = [UIImage imageNamed:imageName];
            _starsImageView.image = star;
            _rightNavBtn.hidden = NO;
            _levelView.hidden = NO;
            _nameLabelUp.hidden = NO;
            _nameLabelDown.hidden = YES;
            
            //只有科普员才有称谓
            if ([[MemberManager sharedInstance].getMember.isKepu isEqualToString:@"0"])
            {
                _certificationMarkImage.image = [UIImage imageNamed:@"已认证标志"];
                _levelTitleLabel.text = score.gradeName;
            }
            else
            {
                _certificationMarkImage.image = [UIImage imageNamed:@"未认证标志"];
                _levelTitleLabel.text = @"";
            }
            CGFloat starW = star.size.width/star.size.height*_levelTitleLabel.frame.size.height;
            CGSize levelSize = [_levelTitleLabel boundingRectWithSize:CGSizeMake(2000, _levelTitleLabel.frame.size.height)];
            CGFloat gradeAndGradeNameSpace = 5;//星星&称谓之间的间距
            CGFloat levelW = levelSize.width+starW+gradeAndGradeNameSpace;
            //            _starsImageView.frame = CGRectMake(0, 0, starW, _levelTitleLabel.frame.size.height);
            //            _levelTitleLabel.frame = CGRectMake(_starsImageView.frame.size.width, _levelTitleLabel.frame.origin.y, levelSize.width, _levelTitleLabel.frame.size.height);
            
            _levelTitleLabel.frame = CGRectMake(0, _levelTitleLabel.frame.origin.y, levelSize.width, _levelTitleLabel.frame.size.height);
            _starsImageView.frame = CGRectMake(_levelTitleLabel.frame.size.width+gradeAndGradeNameSpace, 0, starW, _levelTitleLabel.frame.size.height);
            
            _starAndTitleView.frame = CGRectMake((_levelView.bounds.size.width-levelW)/2.0, _starAndTitleView.frame.origin.y, levelW, _starAndTitleView.frame.size.height);
        }else{
            _nameLabelUp.hidden = YES;
            _nameLabelDown.hidden = NO;
            _rightNavBtn.hidden=YES;
            _levelView.hidden=YES;
        }
        
        
    }
    else{
        [_backImageView setImage:[UIImage imageNamed:@"loginbg"]];
        [_headIcon      setImage:[UIImage imageNamed:@"header"]];
        [_backImageView setImage:[self blurryImage:_backImageView.image withBlurLevel:0.5]];
        [_nameLabelDown setText:@"登录 / 注册"];
        _collectNumLabel.text = @"0";
        _commentsNumLabel.text = @"0";
        _integralNumLabel.text = @"0";
        
        _rightNavBtn.hidden=YES;
        _levelView.hidden=YES;
        _nameLabelUp.hidden = YES;
        _nameLabelDown.hidden = NO;
        
        _certificationMarkImage.image = [UIImage imageNamed:@"未认证标志"];
        _levelTitleLabel.text = @"";
    }
    
    
    
    
    /************** test **/
    
//    _rightNavBtn.hidden=NO;
//    _levelView.hidden=NO;
//    _nameLabelUp.hidden = NO;
//    _nameLabelDown.hidden = YES;
//    UIImage *star = [UIImage imageNamed:@"0xingOnIntegralRuels"];
//    _starsImageView.image = star;
//    _levelTitleLabel.text = @"博导";
//    CGFloat starW = star.size.width/star.size.height*_levelTitleLabel.frame.size.height;
//    CGSize levelSize = [_levelTitleLabel boundingRectWithSize:CGSizeMake(2000, _levelTitleLabel.frame.size.height)];
//    CGFloat levelW = levelSize.width+starW;
//    //    _starsImageView.frame = CGRectMake(0, 0, starW, _levelTitleLabel.frame.size.height);
//    //    _levelTitleLabel.frame = CGRectMake(_starsImageView.frame.size.width, _levelTitleLabel.frame.origin.y, levelSize.width, _levelTitleLabel.frame.size.height);
//    
//    _levelTitleLabel.frame = CGRectMake(0, _levelTitleLabel.frame.origin.y, levelSize.width, _levelTitleLabel.frame.size.height);
//    _starsImageView.frame = CGRectMake(_levelTitleLabel.frame.size.width, 0, starW, _levelTitleLabel.frame.size.height);
//    
//    _starAndTitleView.frame = CGRectMake((_levelView.bounds.size.width-levelW)/2.0, _starAndTitleView.frame.origin.y, levelW, _starAndTitleView.frame.size.height);
//    _certificationMarkImage.image = [UIImage imageNamed:@"未认证标志"];
}
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        DLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    if (returnImage) {
        return returnImage;
    }else{
        return image;
    }

}

@end
