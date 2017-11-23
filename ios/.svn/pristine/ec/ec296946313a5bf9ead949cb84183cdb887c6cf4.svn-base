//
//  PieCollorCollectionView.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PieCollorCollectionView.h"
#import "PieColorCollectionCell.h"
#import "OneMonthIntegralModel.h"

@interface PieCollorCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation PieCollorCollectionView
{
    NSArray *_colors;
    NSArray *_itemArry;
    NSInteger _column;
    CGFloat verticalLineSpacing;//行间距
    UICollectionView *_collectionView;
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
//-(id)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
//    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        [self setupView];
//    }
//    return self;
//}
-(void)setupView{
    
    _column = 2;
    //CGFloat cellHeight = 20.0;
    verticalLineSpacing = 5.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;//横向item间距(最小值)
    layout.minimumLineSpacing = verticalLineSpacing;//行间距
    layout.itemSize = CGSizeMake(self.bounds.size.width/_column, PieColorCollectionCellHeight);//每个UICollectionViewCell 的大小
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//每个UICollectionViewCell 的 margin
    layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 0);//分组头视图的size
    
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
    //collectionView.width = 6;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView.contentInset = UIEdgeInsetsMake(0, sapceWidth/2.0, 0, sapceWidth/2.0);
    _collectionView.collectionViewLayout = layout;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[PieColorCollectionCell class] forCellWithReuseIdentifier:[PieColorCollectionCell ID]];
}
-(void)setViewWithClolos:(NSArray *)colors items:(NSArray *)items{
    _colors = colors;
    _itemArry = items;
    if (items) {
        
        NSInteger _rows = _itemArry.count/_column + (_itemArry.count%_column?1:0);
        NSInteger rowSpace = _rows>0?(_rows-1):0;
        _collectionView.frame = CGRectMake(0, 0, _collectionView.frame.size.width, PieColorCollectionCellHeight*_rows+ verticalLineSpacing*rowSpace);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _collectionView.frame.size.height);
        
        [_collectionView reloadData];
    }
}

#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger items = _itemArry.count;
    return items;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PieColorCollectionCell *cell = (PieColorCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[PieColorCollectionCell ID] forIndexPath:indexPath];
    OneMonthIntegralModel *model = _itemArry[indexPath.row];
    [cell setCellWithColor:_colors[indexPath.row] data:model];
    return cell;
}


@end
