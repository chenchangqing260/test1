//
//  SDCursorView.m
//  SDPagesSelector
//
//  Created by 宋东昊 on 16/7/15.
//  Copyright © 2016年 songdh. All rights reserved.
//

#import "SDCursorView.h"
#import "SDSelectorCell.h"

static NSString *const SDCursorViewCellIdentifier = @"selectorCell";
static CGFloat   kAddButtonWidth = 40;

@interface SDCursorView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation SDCursorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //设置颜色默认值
        _normalFont = [UIFont systemFontOfSize:13];
        _selectedFont = [UIFont systemFontOfSize:16];
        _normalColor = [UIColor colorWithHex:0x505050];
        _selectedColor = [UIColor colorWithHex:0x33cfda];
        _currentIndex = 0;
        _lineEdgeInsets = UIEdgeInsetsMake(0, 3, 2, 3);
        _cursorEdgeInsets = UIEdgeInsetsMake(0,0, 0, kAddButtonWidth);
        self.showAddButton = YES;
        
        
    }
    return self;
}


-(NSMutableArray *)controllers{
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _controllers;
}
-(void)tapAdd{
    if (self.tapAddChannelBlock) {
        self.tapAddChannelBlock();
    }
}
#pragma mark - SETUP UI
-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(self.bounds.size.width-kAddButtonWidth, 0, kAddButtonWidth, self.bounds.size.height);
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(tapAdd) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
        [self bringSubviewToFront:_addButton];
    }
    return _addButton;
}
-(UIScrollView*)rootScrollView
{
    if (!_rootScrollView) {
        _rootScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), self.contentViewHeight)];
        _rootScrollView.backgroundColor = [UIColor whiteColor];
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.delegate = self;
        _rootScrollView.alwaysBounceHorizontal = YES;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.scrollsToTop = NO;
        _rootScrollView.bounces = YES;
        [self.parentViewController.view addSubview:_rootScrollView];
        
        [self bringSubviewToFront:self.addButton];
        
        NSAssert(self.parentViewController, @"self.parentViewController must has a value");
        
    }
    return _rootScrollView;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = _selectedColor;
        [self.collectionView addSubview:_lineView];
        _lineView.hidden = YES;
    }
    return _lineView;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGRect rect = CGRectMake(_cursorEdgeInsets.left, _cursorEdgeInsets.top, CGRectGetWidth(self.bounds)-_cursorEdgeInsets.left-_cursorEdgeInsets.right, CGRectGetHeight(self.bounds)-_cursorEdgeInsets.top-_cursorEdgeInsets.bottom);
        _collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:_layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SDSelectorCell class] forCellWithReuseIdentifier:SDCursorViewCellIdentifier];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


-(void)reloadPages
{
    for (UIView *v in self.rootScrollView.subviews) {
        [v removeFromSuperview];
    }
    NSAssert(_titles.count == _controllers.count, @"titles' count is not equal to controllerNames' count");
    [self.collectionView reloadData];
    
    [self addChildViewController];
}
-(void)setShowAddButton:(BOOL)isShowAddButton{
    _showAddButton = isShowAddButton;
    self.addButton.hidden = !isShowAddButton;
    CGFloat _leftEdge = isIpad ? (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0 : 0.0;
    if (isShowAddButton) {
        _cursorEdgeInsets = UIEdgeInsetsMake(0, _leftEdge+10, 0, kAddButtonWidth+_leftEdge);
    }else{
        _cursorEdgeInsets = UIEdgeInsetsMake(0, _leftEdge+10, 0, _leftEdge);
    }
}
-(void)setTitles:(NSMutableArray *)titles
{
    _titles = titles;
    self.rootScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*self.titles.count, 100);
}

/**
 *  将子viewController添加到scrollView上
 */
-(void)addChildViewController
{
    //viewController
    UIViewController *controller = _controllers[_currentIndex];
    
    CGFloat startX = CGRectGetWidth(self.rootScrollView.bounds)*_currentIndex;
    //if (!controller.parentViewController) {
        [self.parentViewController addChildViewController:controller];
        CGRect rect = self.rootScrollView.bounds;
        rect.origin.x = startX;
        controller.view.frame = rect;
        [self.rootScrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self.parentViewController];
    //}

    [self.rootScrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
    
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    [self deselectItemAtIndex:self.currentIndex];
    self.currentIndex = selectedIndex;
    [self selectItemAtIndex:self.currentIndex];
}

/**
 *  设置collectionView的偏移量，使得选中的项目居中
 *
 *  @param frame cellFrame
 */
-(void)setContentOffsetWithCellFrame:(CGRect)frame
{
    CGFloat width = CGRectGetWidth(self.collectionView.frame)/2;
    CGFloat offsetX = 0;
    
    //if (CGRectGetMidX(frame) <= width) {
    if (CGRectGetMidX(frame) <= CGRectGetWidth(self.collectionView.frame)) {
        
        offsetX = 0;
        
    }else if (CGRectGetMidX(frame) + width >= self.collectionView.contentSize.width) {
        
        offsetX = self.collectionView.contentSize.width - CGRectGetWidth(self.collectionView.frame);
        
    }else{
        offsetX = CGRectGetMidX(frame)-CGRectGetWidth(self.collectionView.frame)/2;
    }
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
/**
 *  设置标识线的frame
 *
 *  @param frame cellFrame
 */
-(void)resizeLineViewWihtCellFrame:(CGRect)frame animated:(BOOL)animated
{
    CGFloat height = 3.0f;
    CGRect rect = CGRectMake(CGRectGetMinX(frame)+_lineEdgeInsets.left,
                             CGRectGetHeight(self.collectionView.frame)-height-_lineEdgeInsets.bottom,
                             CGRectGetWidth(frame)-_lineEdgeInsets.left*2, height-_lineEdgeInsets.top);
    
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            self.lineView.frame = rect;
        }];
    }else{
        self.lineView.frame = rect;
    }

}
/**
 *  主动设置cursor选中item
 *
 *  @param index index
 */
-(void)selectItemAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath
                                      animated:YES
                                scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self selectItemAtIndexPath:indexPath];

}
/**
 *  设置计算选中的item状态
 *
 *  @param indexPath indexPath
 */
-(void)selectItemAtIndexPath:(NSIndexPath*)indexPath
{
    SDSelectorCell *cell = (SDSelectorCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    CGRect rect = cell.frame;
    if (!cell) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        rect = attributes.frame;
    }
    
    [self setContentOffsetWithCellFrame:rect];
    [self resizeLineViewWihtCellFrame:rect animated:YES];
    
    [self addChildViewController];
    
    self.didSelectedIndexBlock(indexPath.row);
}
/**
 *  主动设置使item变为不可选
 *
 *  @param index index
 */
-(void)deselectItemAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    SDSelectorCell *cell = (SDSelectorCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = NO;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.rootScrollView isEqual:scrollView]) {
        CGFloat offsetX = scrollView.contentOffset.x;
        if (offsetX >= 0) {
            NSInteger index = offsetX / CGRectGetWidth(self.bounds);
            if (self.currentIndex != index) {
                [self deselectItemAtIndex:self.currentIndex];
                self.currentIndex = index;
                [self selectItemAtIndex:self.currentIndex];
            }
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _rootScrollView) {
        CGFloat offSetX = scrollView.contentOffset.x;
        //NSLog(@"~~offSetX：%f",offSetX);
        if (offSetX <= -50) {
            // 滑动距离大于了100，则跳转到左侧视图
            // 改版
//            DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//            [menuController showLeftController:YES];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDCursorViewCellIdentifier forIndexPath:indexPath];
    
    if (_titles && _titles.count > 0 && indexPath.item < _titles.count) {
        NSString *title = _titles[indexPath.item];
        cell.title = title;
    }
    cell.normalFont = self.normalFont;
    cell.selectedFont = self.selectedFont;
    cell.normalColor = self.normalColor;
    cell.selectedColor = self.selectedColor;
    
    cell.selected = (indexPath.item == _currentIndex);
    
    
    if (collectionView.indexPathsForSelectedItems.count <= 0) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]
                                          animated:NO
                                    scrollPosition:UICollectionViewScrollPositionNone];
        
        [self resizeLineViewWihtCellFrame:cell.frame animated:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == indexPath.item) {
        return;
    }
    
    self.currentIndex = indexPath.item;
    
    [self selectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDSelectorCell *cell = (SDSelectorCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = NO;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _titles[indexPath.item];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    size = CGSizeMake(size.width+15, CGRectGetHeight(self.bounds));
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
