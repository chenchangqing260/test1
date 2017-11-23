//
//  DailyInfoView.m
//  ScienceChina
//
//  Created by Ellison on 16/5/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "DailyInfoView.h"
#import "DailyCollectionViewCell.h"
#import "DailyFreeCollectionViewCell.h"
#import "HomeModel.h"

@interface DailyInfoView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *uiCollectionView;
@property (weak, nonatomic) IBOutlet UIView *uiLeftView;
@property (weak, nonatomic) IBOutlet UIView *uiCenterView;
@property (weak, nonatomic) IBOutlet UIView *uiRightView;

@end

@implementation DailyInfoView

- (void)awakeFromNib{
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[DailyCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[DailyCollectionViewCell ID]];
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[DailyFreeCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[DailyFreeCollectionViewCell ID]];
    self.uiCollectionView.delegate = self;
    self.uiCollectionView.dataSource = self;
}

- (void)setDailyInfoArray:(NSMutableArray *)dailyInfoArray{
    _dailyInfoArray = dailyInfoArray;
    [self.uiCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        DailyCollectionViewCell *cell = (DailyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[DailyCollectionViewCell ID] forIndexPath:indexPath];
        [cell initDataModel:[_dailyInfoArray objectAtIndex:indexPath.section]];
        return cell;
    }else{
        DailyFreeCollectionViewCell *cell = (DailyFreeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[DailyFreeCollectionViewCell ID] forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < _dailyInfoArray.count) {
        HomeModel* model = [_dailyInfoArray objectAtIndex:indexPath.section];
        [self.delegate clickDailyInfoWithHomeModel:model];
    }
}

#pragma mark - 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    //DLog(@"========================%f",offSetX);
    int page = offSetX / kSCREEN_WIDTH;
    
    if (offSetX >= (kSCREEN_WIDTH * 2 + kSCREEN_WIDTH / 2)) {
        // 滑动距离大于了一半，则跳转到首页，把当前页面删除
        [self.delegate closeDailyInfoView];
    }else if((kSCREEN_WIDTH * 2 < offSetX) && (offSetX < (kSCREEN_WIDTH * 2 + kSCREEN_WIDTH / 2))){
        //DLog(@"%f", (kSCREEN_WIDTH * 2 + kSCREEN_WIDTH / 2));
        self.alpha = ((kSCREEN_WIDTH * 2 + kSCREEN_WIDTH / 2) - offSetX) / (kSCREEN_WIDTH / 2);
        //DLog(@"%f", self.alpha);
    }else{
        self.alpha = 1;
        if (page == 0) {
            [self.uiLeftView setBackgroundColor:[UIColor colorWithHex:0x2d3a4b]];
            [self.uiLeftView setAlpha:1];
            [self.uiCenterView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiCenterView setAlpha:0.4];
            [self.uiRightView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiRightView setAlpha:0.4];
        }else if(page == 1){
            [self.uiLeftView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiLeftView setAlpha:0.4];
            [self.uiCenterView setBackgroundColor:[UIColor colorWithHex:0x2d3a4b]];
            [self.uiCenterView setAlpha:1];
            [self.uiRightView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiRightView setAlpha:0.4];
        }else if(page == 2){
            [self.uiLeftView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiLeftView setAlpha:0.4];
            [self.uiCenterView setBackgroundColor:[UIColor colorWithHex:0xFFFFFF]];
            [self.uiCenterView setAlpha:0.4];
            [self.uiRightView setBackgroundColor:[UIColor colorWithHex:0x2d3a4b]];
            [self.uiRightView setAlpha:1];
        }
    }
}

- (IBAction)clickCloseBtn:(id)sender {
    [self.delegate closeDailyInfoView];
}


@end
