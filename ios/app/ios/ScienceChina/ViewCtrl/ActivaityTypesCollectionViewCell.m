//
//  ActivaityTypesCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/30.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivaityTypesCollectionViewCell.h"
#import "UIScrollView+LayoutHelper.h"

#define kTag 1001
@interface ActivaityTypesCollectionViewCell()<UIScrollViewDelegate>
{
     UIPageControl *_pageControl;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *UIScrollView;
@end


@implementation ActivaityTypesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat w = self.contentView.frame.size.width;
    CGFloat h = self.contentView.frame.size.height;
    
    NSInteger cfloat = ceil(20/5);
    
    // height == 0 代表 禁止垂直方向滚动
    self.UIScrollView.contentSize = CGSizeMake(cfloat * w, 0);
    self.UIScrollView.showsHorizontalScrollIndicator = NO;
    self.UIScrollView.pagingEnabled = YES;
    self.UIScrollView.delegate = self;
    
    // 添加PageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(w * 0.5, h - 10);
    pageControl.bounds = CGRectMake(0, 0, 150, 50);
    pageControl.numberOfPages = cfloat; // 一共显示多少个圆点（多少页）
    // 设置非选中页的圆点颜色
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    // 设置选中页的圆点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    // 禁止默认的点击功能
    pageControl.enabled = NO;
    
    [self.contentView addSubview:pageControl];
    _pageControl = pageControl;
 
    NSMutableArray *vSubviewsArray = [NSMutableArray array];
    [vSubviewsArray addObject:@{@"view": self.UIScrollView, @"padding" : @(5)}];
    
    NSMutableArray *hSubviewsArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
//        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//        lbl.text = [NSString stringWithFormat:@"我是第%d个", i+1];
//        lbl.backgroundColor = [UIColor colorWithRed:10*i/255.0 green:100/255.0 blue:25*i/255.0 alpha:1.0];
        
        UIView *rview = [[UIView alloc]initWithFrame:CGRectMake(2, 0 , kSCREEN_WIDTH/5-5, kSCREEN_WIDTH/5+20)];
        rview.backgroundColor = [UIColor whiteColor];
        
        UIView *roundview = [[UIView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH/5-5-50)/2, (kSCREEN_WIDTH/5-5-50)/2, 50, 50)];
        [roundview.layer setCornerRadius:CGRectGetHeight([roundview bounds]) / 2];
        roundview.layer.masksToBounds = YES;
        roundview.layer.borderWidth = 1;//边框width
        roundview.layer.borderColor = [[UIColor grayColor] CGColor];//边框color
        roundview.layer.contents = (id)[[UIImage imageNamed:@"资讯默认图"] CGImage];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, (kSCREEN_WIDTH/5-5)/2, 80,  80)];
        lbl.textAlignment = NSTextAlignmentCenter;
//        lbl.text = [NSString stringWithFormat:@"我是第%d个", i+1];
        lbl.text = @"地方活动";
        [lbl setFont:[UIFont systemFontOfSize:12.0]];
        
        [rview addSubview:roundview];
        [rview addSubview:lbl];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [rview addGestureRecognizer:tap];
        rview.tag = kTag + i;
        rview.userInteractionEnabled = YES;
        
        [hSubviewsArray addObject:@{ @"view": rview, @"padding" : (i==0?@(0):@(5)) }];

    }
    [UIScrollView layoutScrollView:self.UIScrollView withSubViews:hSubviewsArray isVertical:NO];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
        NSLog(@"%ld", tap.view.tag - kTag);
}

#pragma mark - UIScrollView的代理方法
#pragma mark 当scrollView正在滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = ceil(scrollView.contentOffset.x / scrollView.frame.size.width);
//        NSLog(@"%d----", page);
    
    // 设置页码
    _pageControl.currentPage = page;
}

+(NSString*)ID{
    return @"ActivaityTypesCollectionViewCell";
}

@end
