//
//  CategoryVCLayout.m
//  ScienceChina
//
//  Created by Ellison on 16/5/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CategoryVCLayout.h"
#import "InfoCategory.h"

@interface CategoryVCLayout()

@property (nonatomic, assign)CGFloat viewHeight;
// 所有item的属性的数组
@property (nonatomic, strong) NSArray *layoutAttributesArray;

@end

@implementation CategoryVCLayout


-(void)awakeFromNib{
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionViewContentSize{
    // 49为底部tabbar高度
    return CGSizeMake(kSCREEN_WIDTH, self.viewHeight + 49);
}

/**
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    [self computeAttributesWithItem];
}

// 根据itemWidth计算布局属性
- (void)computeAttributesWithItem{
    if (_itemList) {
        NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.itemList.count];
        CGFloat itemY = 0;
        
        NSInteger loopCount = _itemList.count / 6; // 6的循环数量
        NSInteger remainCount = _itemList.count - loopCount * 6;
        
        for (int i=0; i<_itemList.count; i++) {
            // 建立布局属性
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGFloat itemWidth = 0;
            CGFloat itemHeight = 0;
            
            if (i < loopCount * 6) {
                // 循环布局
                if (i % 6 == 0) {
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 0;
                    
                    itemWidth = kSCREEN_WIDTH;
                    itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                    
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                    
                    itemY = itemY + itemHeight + 1;
                }
                
                if (i % 6 == 1) {
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 2;
                    itemWidth = (kSCREEN_WIDTH - 1) / 2;
                    itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 307;
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                }
                
                if (i % 6 == 2){
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 1;
                    itemWidth = (kSCREEN_WIDTH - 1) / 2;
                    itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                    
                    itemY = itemY + itemHeight + 1;
                }
                
                if (i % 6 == 3) {
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 1;
                    itemWidth = (kSCREEN_WIDTH - 1) / 2;
                    itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                    
                    itemY = itemY + itemHeight + 1;
                }
                
                if (i % 6 == 4 ){
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 1;
                    itemWidth = (kSCREEN_WIDTH - 1) / 2;
                    itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                }
                
                if (i % 6 == 5) {
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 1;
                    itemWidth = (kSCREEN_WIDTH - 1) / 2;
                    itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 153;
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                    itemY = itemY + itemHeight + 1;
                }
            }else{
                // 剩余布局
                if (remainCount == 1) {
                    InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                    infoCategory.tag = 0;
                    
                    itemWidth = kSCREEN_WIDTH;
                    itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                    
                    
                    self.itemSize = CGSizeMake(itemWidth, itemHeight);
                    attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                    [attributesArray addObject:attributes];
                    
                    itemY = itemY + itemHeight + 1;
                }
                
                if (remainCount == 2) {
                    if (i % 6 == 1 ){
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                    }
                    
                    if (i % 6 == 2) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        itemY = itemY + itemHeight + 1;
                    }
                }
                
                if (remainCount == 3) {
                    if (i % 6 == 0) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 0;
                        
                        itemWidth = kSCREEN_WIDTH;
                        itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                        
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 1 ){
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                    }
                    
                    if (i % 6 == 2) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        itemY = itemY + itemHeight + 1;
                    }
                }else if(remainCount == 4){
                    if (i % 6 == 0) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 0;
                        
                        itemWidth = kSCREEN_WIDTH;
                        itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                        
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 1) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 2;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 307;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                    }
                    
                    if (i % 6 == 2){
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 3) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                }else if(remainCount == 5){
                    if (i % 6 == 0) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 0;
                        
                        itemWidth = kSCREEN_WIDTH;
                        itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                        
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 1) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 2;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1) / (kWIDTH_375 - 1) * 307;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                    }
                    
                    if (i % 6 == 2){
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 3) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 1;
                        itemWidth = (kSCREEN_WIDTH - 1) / 2;
                        itemHeight = (kSCREEN_WIDTH - 1)/ (kWIDTH_375 - 1) * 153;
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(itemWidth + 1, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                    
                    if (i % 6 == 4) {
                        InfoCategory* infoCategory = [_itemList objectAtIndex:i];
                        infoCategory.tag = 0;
                        
                        itemWidth = kSCREEN_WIDTH;
                        itemHeight = kSCREEN_WIDTH / kWIDTH_375 * 223;
                        
                        
                        self.itemSize = CGSizeMake(itemWidth, itemHeight);
                        attributes.frame = CGRectMake(0, itemY, itemWidth, itemHeight);
                        [attributesArray addObject:attributes];
                        
                        itemY = itemY + itemHeight + 1;
                    }
                }
            }
            
            _viewHeight = itemY;
        }
        
        // 给属性数组设置数值
        self.layoutAttributesArray = attributesArray.copy;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 直接返回计算好的布局属性数组
    return self.layoutAttributesArray;
}

@end
