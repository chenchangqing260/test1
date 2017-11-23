//
//  EStationCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationCell.h"
#import "EStation.h"

typedef enum{Attented = 1, NoAttent = 0} stationAttent;

@interface EStationCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;
@property (weak, nonatomic) IBOutlet UIButton *uiAttentBtn;

@property (nonatomic, copy)EStation* station;
@property (nonatomic, strong)NSIndexPath* indexPath;

@end

@implementation EStationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"EStationCell";
}

+(EStationCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"EStationCell" owner:nil options:nil][0];
    
}

-(void)initCellData:(EStation*)station indexPath:(NSIndexPath*)indexPath{
    _station = station;
    _indexPath = indexPath;
    
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:station.si_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiNameLab setText:station.si_name];
    [self.uiDescLab setText:station.si_desc];
    
    // 根据是否关注现实不同的按钮样式
    if ([station.si_is_concern intValue] == Attented) {
        // 已关注
        [self.uiAttentBtn setBackgroundColor:[UIColor colorWithHex:0x33CFDA]];
        [self.uiAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
        [self.uiAttentBtn setTitleColor:[UIColor colorWithHex:0xFFFFFF] forState:UIControlStateHighlighted];
        [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.uiAttentBtn setTitle:@"已关注" forState:UIControlStateHighlighted];
    }else{
        // 未关注
        [self.uiAttentBtn setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
        [self.uiAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateNormal];
        [self.uiAttentBtn setTitleColor:[UIColor colorWithHex:0x33CFDA] forState:UIControlStateHighlighted];
        [self.uiAttentBtn.layer setBorderColor:[UIColor colorWithHex:0x33CFDA].CGColor];
        [self.uiAttentBtn.layer setBorderWidth:0.5];
        [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.uiAttentBtn setTitle:@"关注" forState:UIControlStateHighlighted];
    }
}

#pragma mark - 按钮事件
- (IBAction)clickAttentBtn:(id)sender {
    if ([_station.si_is_concern intValue] == Attented) {
        // 已关注的，取消关注
        [[WebAccessManager sharedInstance]delStationWithSiId:_station.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                _station.si_is_concern = [NSString stringWithFormat:@"%d", NoAttent];
                // 刷新TableView
                [self.delegate refreshStationTableViewCellWithIndexPath:_indexPath];
            }
        }];
    }else{
        // 未关注的，进行关注操作
        [[WebAccessManager sharedInstance]saveStationWithSiId:_station.si_id Completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                _station.si_is_concern = [NSString stringWithFormat:@"%d", Attented];
                // 刷新TableView
                [self.delegate refreshStationTableViewCellWithIndexPath:_indexPath];
            }
        }];
    }
}
            

@end
