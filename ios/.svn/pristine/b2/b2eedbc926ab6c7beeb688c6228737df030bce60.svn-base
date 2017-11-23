//
//  ActivityIndexTitleCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityIndexTitleCollectionViewCell.h"
#import "HomeModel.h"

@interface ActivityIndexTitleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UITitle;

@property (weak, nonatomic) IBOutlet UILabel *UIContent;
@property (weak, nonatomic) IBOutlet UIButton *UIBtn;

@property (weak, nonatomic) IBOutlet UILabel *UIPingNum;
@property (nonatomic, strong)HomeModel* sa;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIJoinConstrint;

@end

@implementation ActivityIndexTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+(NSString*)ID{
    return @"ActivityIndexTitleCollectionViewCell";
}

-(void)setCellWithScienceActivity:(HomeModel*)sa indexPath:(NSIndexPath*)indexPath showSpace:(BOOL)showSpace{
    
    self.sa = sa;
    self.indexPath = indexPath;
    [self.UITitle setText:sa.ni_title];
    [self.UIPingNum setText:sa.ni_publish_date_str];
    [self.UIContent setText:sa.ni_desc];
    
     if(![sa.ni_av_type isEqualToString:@"05"]&&![sa.ni_av_type isEqualToString:@"06"]){
        
        self.UIBtn.hidden = NO;
        [self.UIBtn setTitle:sa.ni_av_name forState:UIControlStateNormal];
        
        [self.UIBtn.layer setMasksToBounds:YES];
        [self.UIBtn.layer setCornerRadius:2.0];
        [self.UIBtn.layer setBorderWidth:1.0];
        [self.UIBtn.layer  setBorderColor: RGBCOLOR(54.0, 205.0, 224.0).CGColor];
         self.UIBtn.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 5);
         self.UIBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
         
    }else{
        self.UIBtn.hidden = YES;
//        self.UIJoinConstrint.constant = 15;
    }
  
     [self layoutIfNeeded];
}

- (IBAction)clickBtn:(id)sender {
    [self.delegate clickBtn:self.sa indexPath:_indexPath];
    
}

@end
