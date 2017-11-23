//
//  TiwenTableViewCell.m
//  ScienceChina
//
//  Created by 三川薛 on 16/6/14.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TiwenTableViewCell.h"
#import "TextUtil.h"
#import "LabelUtil.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


@implementation TiwenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    // Initialization code
}

+(NSString*)ID{
    return @"TiwenTableViewCell";
}

//不加载xib
+(TiwenTableViewCell *)newCell{
    //return [[NSBundle mainBundle]loadNibNamed:@"TiwenTableViewCell" owner:nil options:nil][0];
    TiwenTableViewCell * cell = [[TiwenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self ID]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
//设置控件
-(void)setSubviews:(NSString *)contentStr andRepNumStr:(NSString*)pinglun
{
    
    _backgroundViewbase = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 500)];//最后再设置下size
    
    _backgroundViewbase.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    
    [self addSubview:_backgroundViewbase];
    
    _backgroundview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 490)];
    
    _backgroundview.backgroundColor = [UIColor colorWithHex:0xFFFFFF];
    
    [_backgroundViewbase addSubview:_backgroundview];
    
    _touxiangImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13, 37, 37)];
    
    [_backgroundview addSubview:_touxiangImg];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(67, 21.5, SCREENWIDTH-67, 20)];
    
    _nameLab.font = FONT_13;
    
    _nameLab.textColor = [UIColor colorWithHex:0x707070];
    
    [_backgroundview addSubview:_nameLab];
    
    _biaotiLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 66, SCREENWIDTH-20, 20)];
    
    _biaotiLab.textColor = [UIColor colorWithHex:0x121212];
    
    _biaotiLab.font = FONT_16;
    
    [_backgroundview addSubview:_biaotiLab];
    
    // 获取数据，计算内容高度
    CGSize size = [TextUtil boundingRectWithText:contentStr lineSpace:3 size:CGSizeMake(SCREENWIDTH - 40, 0) Font:FONT_14];
    NSLog(@"%g",size.height);
    float actualHeight = 0 + size.height;
    _contentTextview = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, SCREENWIDTH-40, actualHeight)];
    
    _contentTextview.numberOfLines=0;
    
    _contentTextview.attributedText=[LabelUtil getNSAttributedStringWithLabel:_contentTextview lineSpace:3 text:contentStr] ;
        
    [_contentTextview sizeToFit];
    
    _contentTextview.textColor = [UIColor colorWithHex:0x707070];
    
    [_backgroundview addSubview:_contentTextview];
    
    _contentImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100+_contentTextview.frame.size.height+10, SCREENWIDTH-40, SCREENWIDTH/(375-40)*208)];
    
    [_backgroundview addSubview:_contentImg];
    
    _backgroundLab = [[UILabel alloc]initWithFrame:CGRectMake(20, _contentImg.frame.origin.y+_contentImg.frame.size.height+13, SCREENWIDTH-40, 0.5)];
    
    _backgroundLab.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    
    [_backgroundview addSubview:_backgroundLab];
    
    _liulanImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, _backgroundLab.frame.origin.y+0.5+18, 15, 15)];
    
    _liulanImg.image = [UIImage imageNamed:@"liulan"];
    
    _liulanImg.contentMode=UIViewContentModeCenter;
    
    [_backgroundview addSubview:_liulanImg];
    
    _liulanLab = [[UILabel alloc]initWithFrame:CGRectMake(48, _liulanImg.frame.origin.y, SCREENWIDTH/4, 15)];
    
    _liulanLab.font = FONT_12;
    
    _liulanLab.textColor = [UIColor colorWithHex:0x707070];
    
    [_backgroundview addSubview:_liulanLab];
    
    //根据计算文字的大小
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGFloat width = [pinglun boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    NSLog(@"%f",width);
    
    _pinglunLab = [[UITextField alloc]initWithFrame:CGRectMake(SCREENWIDTH-20-width-13-18, _liulanImg.frame.origin.y, 18+13+width, 10)];
    
    _pinglunLab.font = FONT_12;
    
    _pinglunLab.textColor = [UIColor colorWithHex:0x707070];
    
    _pinglunLab.textAlignment = UITextAlignmentRight;
    
    UIImageView * leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huifu"]];
    leftView.frame=CGRectMake(3, 0, 15, 15);
    leftView.contentMode=UIViewContentModeCenter;//图片居中显示
    _pinglunLab.leftView=leftView;
    _pinglunLab.leftViewMode=UITextFieldViewModeAlways;
    
    _pinglunLab.userInteractionEnabled=NO;
    
    [_backgroundview addSubview:_pinglunLab];
    
    //_pinglunImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH-20-Pinglunsize.width-5-13-15, _liulanImg.frame.origin.y, 15, 10)];
    
   // _pinglunImg.image = [UIImage imageNamed:@"huifu"];
    
    //[_backgroundview addSubview:_pinglunImg];
    
    [_backgroundview setFrame:CGRectMake(0, 0, SCREENWIDTH, _pinglunLab.frame.origin.y+10+15)];
    
    [_backgroundViewbase setFrame:CGRectMake(0, 0, SCREENWIDTH, _backgroundview.frame.size.height+10)];

    //返回计算出的单元格高度
    _heigh =_backgroundViewbase.frame.size.height;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
