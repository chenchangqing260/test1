//
//  PicDetailCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PicDetailCollectionViewCell.h"
#import "PicDetialView.h"
#import "TextUtil.h"
#import "SVProgressHUD.h"

@interface PicDetailCollectionViewCell()

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conDescViewHeight;
//@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
//@property (weak, nonatomic) IBOutlet UILabel *uiImgCountLab;
//@property (weak, nonatomic) IBOutlet UILabel *uiContentLab;
//@property (weak, nonatomic) IBOutlet UIView *uiDescView;
@property (weak, nonatomic) IBOutlet UIImageView *uiTopImageView;

@property (nonatomic, strong) PicDetialView* picView;

@property (nonatomic, assign)CGFloat height;

@property BOOL isShow;

@end

@implementation PicDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    UITapGestureRecognizer* singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDescView)];
//    singleFingerOne.numberOfTouchesRequired = 1; //手指数
//    singleFingerOne.numberOfTapsRequired = 1; //tap次数
//    singleFingerOne.delegate = self;
//    [self.uiDescView addGestureRecognizer:singleFingerOne];
}

+(NSString*)ID{
    return @"PicDetailCollectionViewCell";
}

//-(void)clickDescView{
//    if (_isShow) {
//        self.conDescViewHeight.constant = descHeight;
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.uiDescView layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            _isShow = NO;
//        }];
//    }else{
//        if (self.height < descHeight) {
//            return;
//        }
//        self.conDescViewHeight.constant = self.height;
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.uiDescView layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            _isShow = YES;
//        }];
//    }
//}

-(void)initCellData:(InfoObj*)model index:(NSInteger)index totalCount:(NSInteger)totalCount{
    if (self.picView) {
        [self.picView removeFromSuperview];
    }
    
    self.picView = [[PicDetialView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 52)];
    [self.contentView addSubview:self.picView];
    
    self.picView.userInteractionEnabled = YES;
    self.picView.isDoubleTapEnabled = YES;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[model.in_img_urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (image) {
        self.picView.imageView.image = image;
        [self.picView reloadData];
    }else{
        [SVProgressHUDUtil show];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.in_img_urls] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [SVProgressHUDUtil dismiss];
            self.picView.imageView.image = image;
            [self.picView reloadData];
        }];
    }
    
    __block PicDetailCollectionViewCell* blockSelf = self;
    self.picView.singleTapBlock = ^(UIGestureRecognizer * recognizer) {
        [blockSelf.delegate showPhotoBrowserIndex:index];
    };
    
//    [_uiTitleLab setText:model.in_title];
//    [_uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:model.in_content]];
//    [_uiImgCountLab setText:[NSString stringWithFormat:@"%ld /%ld", index + 1, totalCount]];
//    [self.contentView bringSubviewToFront:self.uiDescView];
    [self.contentView bringSubviewToFront:self.uiTopImageView];
    
//    // 计算内容的高度
//    CGSize size = [TextUtil boundingRectWithText:model.in_content lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 20, 0) Font:_uiContentLab.font];
//    // 40为顶部Title 15的字体加上上下间距
//    self.conDescViewHeight.constant = descHeight;
//    self.height = 40 + size.height + 20;
//    self.isShow = NO;
}

@end
