//
//  VideoRecLayout.m
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VideoRecLayout.h"
#import "InfoObj.h"
#import "TextUtil.h"

@interface VideoRecLayout()

@property (nonatomic, assign)CGFloat contentHeight;
@property (nonatomic, strong) NSArray *layoutAttributesArray; //所有item的属性的数组
@property (nonatomic, assign)CGFloat columnSpace; // 列间距
@property (nonatomic, assign)CGFloat cellSpace; // 行间距

@end

@implementation VideoRecLayout

-(void)awakeFromNib{
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.columnSpace = 0;
    self.cellSpace = 0;;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(kSCREEN_WIDTH, self.contentHeight);
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
        
        // 顶部为初始化的视图，从顶部加载视图开始加载
        CGFloat itemY = self.baseHeight;
        // 减去的13为第一个数据顶部的距离
        if (kSCREEN_WIDTH < kWIDTH_375) {
            // 5
            itemY -= 8;
        }else{
            itemY -= 13;
        }
        
        for (int i=0; i<_itemList.count; i++) {
            // 获取数据
            InfoObj* info = [_itemList objectAtIndex:i];
            
            // 建立布局属性
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            // 每行的内容不一致，根据每行的内容，计算每个Cell的高度
            CGFloat textHeight = 0;
            if (info.in_desc) {
                textHeight = [TextUtil boundingRectWithText:info.in_desc lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 40, 0) Font:FONT_14].height;
            }
            
            if (textHeight < 20) {
                textHeight = 18;
            }else{
                textHeight = 36;
            }
            
            CGFloat itemHeight = 30 + kSCREEN_WIDTH * 175 / kWIDTH_375 + 22 + 20 + 17 + 18 + 16 + 13 + textHeight;
            
            if (kSCREEN_WIDTH < kWIDTH_375) {
                // 5
                itemHeight -= 34;
            }else{
                itemHeight -= 8;
            }
            
            attributes.frame = CGRectMake(0, itemY, kSCREEN_WIDTH, itemHeight);
            self.itemSize = CGSizeMake(kSCREEN_WIDTH, itemHeight);
            [attributesArray addObject:attributes];
            
            // 增加itemY,每两个增加一次
            itemY += itemHeight;
            
            _contentHeight = itemY;
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
