//
//  ChannelListCell.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/2.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChannelListCell.h"
#import "TextUtil.h"

@interface ChannelListCell ()
{
    HomeModel *_homeModel;
    
    CGFloat _leftEdge;
    CGFloat _contentViewWidth;
    CGFloat _footViewHeight;
    
    UILabel *_titleLabel;//标题
    UILabel *_subTitleLabel;//副标题
    
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    
    //footer view
    UIView *_footerView;//评论数 收藏数 浏览量  时间&类型
    UIView *_numView;//评论数 收藏数 浏览量
    UIView *_timeAndTypeView;//时间&类型 视图
    
    UILabel *_timeLabel;//时间 “10分钟前”
    UILabel *_typeLabel;//#图文  #视频
    
    UIButton *_commentButton;//评论
    UIButton *_collectionButton;//收藏
    UIButton *_browseButton; //浏览量
    
    //video
    UIView *_videoView;//视频视图 放播放按钮与视频时长
    UIButton *_playButton;//播放按钮
    UILabel *_videoTime;// #视频 44：12
    
    //标题
    CGRect _titleFrame_onGraphicView_multiplePic;//图集
    CGRect _titleFrame_onGraphicView;            //图文
    CGRect _titleFrame_onVideoViewOrText;        //视频或文字
    CGRect _subTitleFrame_zero;
    CGRect _subTitleFrame_onText;                //文字-副标题
    //评论数 收藏数 浏览量  时间&类型
    CGRect _footerFrame_onGraphicView_multiplePic;
    CGRect _footerFrame_onGraphicView;
    CGRect _footerFrame_onVideoView;
    //图片1frame
    CGRect _image1Frame_onGraphicView_multiplePic;
    CGRect _image1Frame_onGraphicView;
    CGRect _image1Frame_onVideoView;
    //图片2frame
    CGRect _image2Frame_onGraphicView_multiplePic;
    CGRect _image2Frame_onGraphicView;
    CGRect _image2Frame_onVideoView;
    
    CGRect _leftNumViewFrame;
    CGRect _rightNumViewFrame;
    
    CGRect _leftTimeAndTypeViewFrame;
    CGRect _rightTimeAndTypeViewFrame;
}
@end
@implementation ChannelListCell
+(NSString*)ID{
    return @"ChannelListCell";
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setFrameData];
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.contentView.clipsToBounds = YES;
    
    //    if (isIpad) {
    ////        self.contentView.frame = CGRectMake((MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0, 0, MAIN_SCREEN_WIDTH_ONIpad, self.contentView.frame.size.height);
    //        
    //        self.frame = CGRectMake((MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0, 0, MAIN_SCREEN_WIDTH_ONIpad, self.contentView.frame.size.height);
    //        self.contentView.backgroundColor = [UIColor yellowColor];
    //    }
    
    
    UIFont *_titleFont  = [UIFont systemFontOfSize:20.0];  //标题字体
    UIFont *_subTitleFont  = [UIFont systemFontOfSize:15.0];  //副标题字体
    UIFont *_footerFont = [UIFont systemFontOfSize:10.0];  //底部视图的字体
    
    UIColor *_titleColor  = [UIColor colorWithHex:0x2c2c2c]; //标题颜色
    UIColor *_subTitleColor  =[UIColor lightGrayColor];//副标题颜色
    UIColor *_footerNumColor = [UIColor colorWithHex:0xa6a6a6]; //底部视图 评论数 收藏数 浏览量 文本颜色
    UIColor *_footerTimeColor = [UIColor colorWithHex:0x7c7c7c]; //底部视图时间文本颜色
    UIColor *_typeColor   = [UIColor colorWithHex:0x33cfda]; //类型文本颜色 #图文  #视频
    UIColor *_videoTimeColor   = [UIColor whiteColor]; //
        
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = _titleFont;
    _titleLabel.textColor = _titleColor;
    _titleLabel.numberOfLines = 0;
    
    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.font = _subTitleFont;
    _subTitleLabel.textColor = _subTitleColor;
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.hidden  = YES;
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(_leftEdge, 0, _contentViewWidth, 27.0)];
    _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewWidth, 195)];
    
    _numView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170, _footerView.frame.size.height)];
    _timeAndTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, _footerView.frame.size.height)];
    
    CGFloat _buttonW = 55.0;
    //评论
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.frame = CGRectMake(0, 0, _buttonW, _footerView.frame.size.height);
    _commentButton.titleLabel.textAlignment = NSTextAlignmentRight;
    _commentButton.titleLabel.font = _footerFont;
    [_commentButton setImage:[UIImage imageNamed:@"home_icon_comment"] forState:UIControlStateNormal];
    [_commentButton setTitleColor:_footerNumColor forState:UIControlStateNormal];
    [_commentButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_commentButton addTarget:self action:@selector(tapComment) forControlEvents:UIControlEventTouchUpInside];
    //收藏
    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.frame = CGRectMake(_buttonW, 0, _buttonW, _footerView.frame.size.height);
    _collectionButton.titleLabel.textAlignment = NSTextAlignmentRight;
    _collectionButton.titleLabel.font = _footerFont;
    [_collectionButton setImage:[UIImage imageNamed:@"home_icon_like"] forState:UIControlStateNormal];
    [_collectionButton setTitleColor:_footerNumColor forState:UIControlStateNormal];
    [_collectionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_collectionButton addTarget:self action:@selector(tapLike) forControlEvents:UIControlEventTouchUpInside];
    //浏览量
    _browseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _browseButton.frame = CGRectMake(_buttonW*2, 0, _buttonW, _footerView.frame.size.height);
    _browseButton.titleLabel.textAlignment = NSTextAlignmentRight;
    _browseButton.titleLabel.font = _footerFont;
    [_browseButton setImage:[UIImage imageNamed:@"home_icon_look"] forState:UIControlStateNormal];
    [_browseButton setTitleColor:_footerNumColor forState:UIControlStateNormal];
    [_browseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_browseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    CGFloat _typeLabelW = 30;
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _leftTimeAndTypeViewFrame.size.width-_typeLabelW, _timeAndTypeView.frame.size.height)];
    _timeLabel.font = _footerFont;
    _timeLabel.textColor = _footerTimeColor;
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width, 0, _typeLabelW, _timeAndTypeView.frame.size.height)];
    _typeLabel.font = _footerFont;
    _typeLabel.textColor = _typeColor;
    _typeLabel.textAlignment = NSTextAlignmentRight;
    
    [_numView addSubview:_commentButton];
    [_numView addSubview:_collectionButton];
    [_numView addSubview:_browseButton];
    
    [_timeAndTypeView addSubview:_timeLabel];
    [_timeAndTypeView addSubview:_typeLabel];
    
    [_footerView addSubview:_numView];
    [_footerView addSubview:_timeAndTypeView];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _imageView1.clipsToBounds = YES;
    _imageView2.clipsToBounds = YES;
    
    _imageView1.contentMode =  UIViewContentModeScaleAspectFit;
    _imageView2.contentMode =  UIViewContentModeScaleAspectFit;
   
    /**视频**/
    _videoView = [[UIView alloc] initWithFrame:_image1Frame_onVideoView];
    _videoView.backgroundColor = [UIColor clearColor];
    
    _videoTime = [[UILabel alloc] initWithFrame:CGRectMake(_videoView.frame.size.width-80, _videoView.frame.size.height-40, 80, 30)];
    _videoTime.font = _footerFont;
    _videoTime.textColor = _videoTimeColor;
    _videoTime.textAlignment = NSTextAlignmentLeft;
    [_videoView addSubview:_videoTime];
    
    UIButton *_videoImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoImage.userInteractionEnabled = NO;
    _videoImage.frame = CGRectMake((_videoView.frame.size.width-44)/2.0,(_videoView.frame.size.height-44)/2.0, 44, 44);
    [_videoImage setImage:[UIImage imageNamed:@"home_icon_play"] forState:UIControlStateNormal];
    [_videoView addSubview:_videoImage];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_subTitleLabel];
    [self.contentView addSubview:_imageView1];
    [self.contentView addSubview:_imageView2];
    [self.contentView addSubview:_footerView];
    [self.contentView addSubview:_videoView];
}
//设置默认的frame
-(void)setFrameData{
    
    _leftEdge = 15.0;
    _contentViewWidth = MAIN_SCREEN_WIDTH-_leftEdge*2;
    if (isIpad) {
        _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        _contentViewWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    
    _footViewHeight = 27.0;
    
    CGFloat _topEdge = 11.0;
    CGFloat _edgeOnVideo = 10.0;
    CGFloat _minLabelHeight = 15.0;
    CGFloat _image1W = 115.0;
    _titleFrame_onGraphicView = CGRectMake(_leftEdge, _topEdge, _contentViewWidth-_image1W-17, 40);
    _titleFrame_onGraphicView_multiplePic = CGRectMake(_leftEdge, _topEdge, _contentViewWidth, _minLabelHeight);
    _titleFrame_onVideoViewOrText = CGRectMake(_leftEdge, _topEdge, _contentViewWidth, _minLabelHeight);
    
    _subTitleFrame_zero = CGRectZero;
    _subTitleFrame_onText = CGRectMake(_leftEdge, _titleFrame_onVideoViewOrText.origin.y+_titleFrame_onVideoViewOrText.size.height+10, _contentViewWidth, 40);
    
    _footerFrame_onGraphicView = CGRectMake(_leftEdge, ChannelListCellHeight_graphic-_footViewHeight, _contentViewWidth, _footViewHeight);
    _footerFrame_onGraphicView_multiplePic = CGRectMake(_leftEdge, ChannelListCellHeight_graphic_MultiplePictures-_footViewHeight, _contentViewWidth, _footViewHeight);
    _footerFrame_onVideoView = CGRectMake(_leftEdge, ChannelListCellHeight_video-_footViewHeight, _contentViewWidth, _footViewHeight);
    
    CGFloat _numW = 170;
    CGFloat _timeAndTypeW = 75;
    _leftNumViewFrame = CGRectMake(0, 0, _numW, _footViewHeight);
    _rightNumViewFrame = CGRectMake(_contentViewWidth-_numW, 0, _numW, _footViewHeight);
    _leftTimeAndTypeViewFrame = CGRectMake(0, 0, _timeAndTypeW, _footViewHeight);
    _rightTimeAndTypeViewFrame = CGRectMake(_contentViewWidth-_timeAndTypeW, 0, _timeAndTypeW, _footViewHeight);
    
    _image1Frame_onGraphicView = CGRectMake(MAIN_SCREEN_WIDTH-_image1W-_leftEdge, _topEdge, _image1W, 65);
    _image2Frame_onGraphicView = CGRectZero;

    _image1Frame_onVideoView = CGRectMake(_leftEdge, 40, _contentViewWidth, 195);
    _image2Frame_onVideoView = CGRectZero;
    
    CGFloat imagew = (_contentViewWidth-4)/2.0;
    _image1Frame_onGraphicView_multiplePic = CGRectMake(_leftEdge, _titleFrame_onVideoViewOrText.origin.y+_titleFrame_onVideoViewOrText.size.height+_edgeOnVideo, imagew, 97);
    _image2Frame_onGraphicView_multiplePic = CGRectMake(MAIN_SCREEN_WIDTH-imagew-_leftEdge, _image1Frame_onGraphicView_multiplePic.origin.y, imagew, 97);
    
}
//设置数据
-(void)setCellWithModel:(HomeModel *)model{
    _homeModel = model;
    
    NSString *_imageUrl = @"";
    NSString *_imageUrl2 = @"";
    if (model.in_img_url && model.in_img_url != nil && ![model.in_img_url isEqualToString:@""]) {
        _imageUrl = [NSString stringWithFormat:@"%@?%@",model.in_img_url,@"imageView2/1/w/230/h/131/interlace/1/q/100"];
    }
    if (model.in_img_url2 && model.in_img_url2 != nil && ![model.in_img_url2 isEqualToString:@""]) {
        _imageUrl2 = [NSString stringWithFormat:@"%@?%@",model.in_img_url2,@"imageView2/1/w/230/h/131/interlace/1/q/100"];
    }
    _titleLabel.text = model.in_title;
    [_commentButton setTitle:[self resetNumWithOriginalNum:model.in_reviewCount] forState:UIControlStateNormal];
    [_collectionButton setTitle:[self resetNumWithOriginalNum:model.in_collectCount] forState:UIControlStateNormal];
    [_browseButton setTitle:[self resetNumWithOriginalNum:model.in_hits] forState:UIControlStateNormal];
    _timeLabel.text = model.in_publish_date_str;
    
    // 资讯类别（0-图文资讯，1-图片资讯，2-视频资讯，3-专题资讯 ，4-文字资讯）
    // 根据类型显示不同的数据
    if ([model.in_classify isEqualToString:@"0"]) {
        _typeLabel.text = @"# 图文";
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    else if([model.in_classify isEqualToString:@"1"]){
        _typeLabel.text = @"# 图集";
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        if (model.in_img_url2 && ![model.in_img_url2 isEqualToString:@""]) {
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:_imageUrl2] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        }
    }
    else if([model.in_classify isEqualToString:@"2"]){
        _typeLabel.text = @"# 视频";
        _videoTime.text = [NSString stringWithFormat:@"# 视频 %@", model.in_video_duration];//@"#视频 33:22:11";
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    else if([model.in_classify isEqualToString:@"3"]){
        _typeLabel.text = @"# 专题";
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
    else if([model.in_classify isEqualToString:@"4"]){
        _typeLabel.text = @"# 文字";
        _subTitleLabel.text = model.in_desc;
        _imageView1.hidden = YES;
        _imageView2.hidden = YES;
        _subTitleLabel.hidden  = NO;
    }
    [self resetTimeWithDate:model.in_publish_date_str];
    [self resetSubViewFrameWithModel:model];

    
}

//重置frame
-(void)resetSubViewFrameWithModel:(HomeModel *)model{
    if ([model.in_classify isEqualToString:@"0"]) {
        _videoView.hidden = YES;
        _titleLabel.frame = _titleFrame_onGraphicView;
        _subTitleLabel.frame = _subTitleFrame_zero;
        _footerView.frame = _footerFrame_onGraphicView;
        _numView.frame = _leftNumViewFrame;
        _timeAndTypeView.frame = _rightTimeAndTypeViewFrame;
        _imageView1.frame = _image1Frame_onGraphicView;
        _imageView2.frame = _image2Frame_onGraphicView;
        
        CGRect _titleF = _titleFrame_onGraphicView;
        _titleF.size.height = [TextUtil boundingRectWithText:_titleLabel.text lineSpace:0 size:CGSizeMake(_titleFrame_onGraphicView.size.width, 0) Font:_titleLabel.font].height;
        _titleF.size.height = _titleF.size.height>50 ? 50 : _titleF.size.height;
        _titleLabel.frame = _titleF;
    }
    else if ([model.in_classify isEqualToString:@"1"]) {
        _videoView.hidden = YES;
        _subTitleLabel.frame = _subTitleFrame_zero;
        if (model.in_img_url2 && ![model.in_img_url2 isEqualToString:@""]) {
            _titleLabel.frame = _titleFrame_onGraphicView_multiplePic;
            _footerView.frame = _footerFrame_onGraphicView_multiplePic;
            _numView.frame = _leftNumViewFrame;
            _timeAndTypeView.frame = _rightTimeAndTypeViewFrame;
            _imageView1.frame = _image1Frame_onGraphicView_multiplePic;
            _imageView2.frame = _image2Frame_onGraphicView_multiplePic;
        }else{
            _titleLabel.frame = _titleFrame_onGraphicView;
            _footerView.frame = _footerFrame_onGraphicView;
            _numView.frame = _leftNumViewFrame;
            _timeAndTypeView.frame = _rightTimeAndTypeViewFrame;
            _imageView1.frame = _image1Frame_onGraphicView;
            _imageView2.frame = _image2Frame_onGraphicView;
            
            //只有一张图时，按图文的方式展示，所以，要重新计算title‘s frame
            CGRect _titleF = _titleFrame_onGraphicView;
            _titleF.size.height = [TextUtil boundingRectWithText:_titleLabel.text lineSpace:0 size:CGSizeMake(_titleFrame_onGraphicView.size.width, 0) Font:_titleLabel.font].height;
            _titleF.size.height = _titleF.size.height>50 ? 50 : _titleF.size.height;
            _titleLabel.frame = _titleF;
        }
        
    }
    else if ([model.in_classify isEqualToString:@"2"]) {
        _videoView.hidden = NO;
        _titleLabel.frame = _titleFrame_onVideoViewOrText;
        _subTitleLabel.frame = _subTitleFrame_zero;
        _footerView.frame = _footerFrame_onVideoView;
        _numView.frame = _rightNumViewFrame;
        _timeAndTypeView.frame = _leftTimeAndTypeViewFrame;
        _imageView1.frame = _image1Frame_onVideoView;
        _imageView2.frame = _image2Frame_onVideoView;
    }
    else if ([model.in_classify isEqualToString:@"3"]) {
        _videoView.hidden = YES;
        _titleLabel.frame = _titleFrame_onGraphicView;
        _subTitleLabel.frame = _subTitleFrame_zero;
        _footerView.frame = _footerFrame_onGraphicView;
        _numView.frame = _leftNumViewFrame;
        _timeAndTypeView.frame = _rightTimeAndTypeViewFrame;
        _imageView1.frame = _image1Frame_onGraphicView;
        _imageView2.frame = _image2Frame_onGraphicView;
        
        CGRect _titleF = _titleLabel.frame;
        _titleF.size.height = [TextUtil boundingRectWithText:_titleLabel.text lineSpace:0 size:CGSizeMake(_titleFrame_onGraphicView.size.width, 0) Font:_titleLabel.font].height;
        _titleF.size.height = _titleF.size.height>50 ? 50 : _titleF.size.height;
        _titleLabel.frame = _titleF;
    }
    else if ([model.in_classify isEqualToString:@"4"]){
        _videoView.hidden = YES;
        _titleLabel.frame = _titleFrame_onVideoViewOrText;
        _subTitleLabel.frame = _subTitleFrame_onText;
        _footerView.frame = _footerFrame_onGraphicView;
        _numView.frame = _leftNumViewFrame;
        _timeAndTypeView.frame = _rightTimeAndTypeViewFrame;
        _imageView1.frame = CGRectZero;
        _imageView2.frame = CGRectZero;
    }
}
-(NSString *)resetNumWithOriginalNum:(NSString *)originalNumStr{
    
    NSString *originalNumString = [NSString stringWithFormat:@"%@",originalNumStr];
    NSString *newNumString;
    NSInteger originalNum = [originalNumString integerValue];
    /** 数字显示规则
     范围          显示
     0-9999	      0-9999 个数9999以下显示完全
     10000-19999  1万	 超过10000小于100000显示整数位
     20000-29999  2万	 超过10000小于100000显示整数位
     大于10万	      	 大于10万显示10万+
     */
    if (originalNum>=0 && originalNum<=9999) {
        newNumString = [NSString stringWithFormat:@"%ld",originalNum];
    } else if (originalNum>=10000 && originalNum<100000) {
        newNumString = [NSString stringWithFormat:@"%@万",[originalNumString substringWithRange:NSMakeRange(0, 1)]];
    } else if (originalNum>=100000) {
        newNumString = @"10万+";
    }
    return newNumString;
}
//8小时时间差
-(NSDate *)disposeTimeDifferenceWithDate:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *realDate = [date  dateByAddingTimeInterval: interval];
    return realDate;
}
/**
 实际发布时间	     前端展示	     备注
 1、0-30分钟	     刚刚	    10分钟以内显示刚刚
 2、31-60分钟	     30分钟前
 3、1小时-2小时	 1小时前
 4、2小时-12小时	 2小时前
 5、12小时-24小时  半天前
 6、24小时-48小时  1天前
 7、48小时-72小时  2天前
 8、大于三天	     更早
 */
-(void)resetTimeWithDate:(NSString *)dateString{
    NSString *_showTime;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    NSDate *nowDate = [self disposeTimeDifferenceWithDate:[NSDate date]];
    NSDate *beforeDate = [self disposeTimeDifferenceWithDate:inputDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    unsigned int unitFlags = NSCalendarUnitMinute;
    NSDateComponents *compts = [calendar components:unitFlags fromDate:beforeDate toDate:nowDate options:0];
    NSInteger minutes = [compts minute];
    //1、0-30分钟
    if (minutes>0 && minutes<=30) {
        _showTime = @"刚刚";
    }
    //2、31-60分钟	     30分钟前
    else if (minutes>31 && minutes <= 60){
        _showTime = [NSString stringWithFormat:@"%d分钟前",(int)30];
    }
    //3、1小时-2小时	 1小时前
    else if (minutes>60 && minutes <= 60*2){
        _showTime = [NSString stringWithFormat:@"%d小时前",(int)1];
    }
    //4、2小时-12小时	 2小时前
    else if (minutes>60*2 && minutes <= 60*12){
        _showTime = [NSString stringWithFormat:@"%d小时前",(int)2];
    }
    //5、12小时-24小时  半天前
    else if (minutes>60*12 && minutes <= 60*24){
        _showTime = [NSString stringWithFormat:@"%@前",@"半天"];
    }
    //6、24小时-48小时  1天前
    else if (minutes>60*24 && minutes <= 60*48){
        _showTime = [NSString stringWithFormat:@"%d天前",(int)1];
    }
    //7、48小时-72小时  2天前
    else if (minutes>60*48 && minutes <= 60*72){
        _showTime = [NSString stringWithFormat:@"%d天前",(int)2];
    }
    //大于三天	     更早
    else if (minutes>60*24*3 ){
        _showTime = @"更早";
    }
    _timeLabel.text = _showTime;
    //NSLog(@"======== %@ : %@",dateString,_showTime);
}

-(void)tapComment{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCommentWithModel:)]) {
        [self.delegate didSelectCommentWithModel:_homeModel];
    }
}
-(void)tapLike{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectLikeWithModel:)]) {
        [self.delegate didSelectLikeWithModel:_homeModel];
    }
}

@end
