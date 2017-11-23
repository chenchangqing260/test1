//
//  AddChannelCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "AddChannelCollectionViewCell.h"

@interface AddChannelCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UIlable;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn;
@property (weak, nonatomic) IBOutlet UILabel *UITable;


@end

@implementation AddChannelCollectionViewCell

{
   GroupListDetailModel *_model;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"AddChannelCollectionViewCell" owner:self options:nil].lastObject;
    }
    return self;
}

+(NSString *)ID{
    return @"AddChannelCollectionViewCell";
}

-(void)setcellModel:(GroupListDetailModel *)model{
     _model = model;
    _UIImage.image = [UIImage imageNamed:model.image];
    self.UIlable.text = model.title;

    [_UITable setBackgroundColor:[UIColor clearColor]];
    if (model.isattention) {
        [_UITable setBackgroundColor:[UIColor colorWithRed:(162.0/255.0) green:(163.0/255.0) blue:(165.0/255.0) alpha:1]];
        [_UITable setText:@"已关注"];
    } else {
        [_UITable setBackgroundColor:[UIColor colorWithRed:(58.0/255.0) green:(227.0/255.0) blue:(206.0/255.0) alpha:1]];
        [_UITable setText:@"关注"];
    }
    
    //CGSize titleSize = [_titleLabel boundingRectWithSize:CGSizeMake(_titleLabel.frame.size.width, 0)];
}

- (IBAction)clickBtn:(id)sender {
    _UIBtn.selected = !_model.isattention;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectIndex:isattention:)]) {
        [self.delegate didSelectIndex:self.indexPath isattention:!_model.isattention];
    }
}


@end
