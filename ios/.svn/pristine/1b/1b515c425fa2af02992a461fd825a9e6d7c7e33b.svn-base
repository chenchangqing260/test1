//
//  XHTwitterPaggingViewer.m
//  XHTwitterPagging
//
//  Created by 曾 宪华 on 14-6-20.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHTwitterPaggingViewer.h"
#import "YALContextMenuTableView.h"
#import "XHPaggingNavbar.h"
#import "ContextMenuCell.h"
#import "UIImage+UIImageExtras.h"
#import "InfoCategory.h"

static NSString *const menuCellIdentifier = @"rotationCell";

typedef NS_ENUM(NSInteger, XHSlideType) {
    XHSlideTypeLeft = 0,
    XHSlideTypeRight = 1,
};

@interface XHTwitterPaggingViewer () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,YALContextMenuTableViewDelegate>

/**
 *  显示内容的容器
 */
@property (nonatomic, strong) UIView *centerContainerView;
@property (nonatomic, strong) UIScrollView *paggingScrollView;

/**
 *  显示title集合的容器
 */
@property (nonatomic, strong) XHPaggingNavbar *paggingNavbar;

/**
 *  标识当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;


@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;

#pragma mark - 自定义方法
@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;

@end

@implementation XHTwitterPaggingViewer

#pragma mark - 自定义方法
-(BOOL)showRightNavItem{
    return YES;
}

-(void)rightNavBtnAction{
    if (self.subCategoryItemArray && self.subCategoryItemArray.count > 0) {
        // init YALContextMenuTableView tableView
        if (!self.contextMenuTableView) {
            self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
            self.contextMenuTableView.bounces =  NO;
            self.contextMenuTableView.tableHeaderView = [UIView new];
            self.contextMenuTableView.animationDuration = 0.1;
            //optional - implement custom YALContextMenuTableView custom protocol
            self.contextMenuTableView.yalDelegate = self;
            //optional - implement menu items layout
            self.contextMenuTableView.menuItemsSide = Right;
            self.contextMenuTableView.menuItemsAppearanceDirection = FromTopToBottom;
            
            //register nib
            UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
            [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
        }
        
        // it is better to use this method only for proper animation
        [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
    }
}

- (void)setSubCategoryItemArray:(NSMutableArray *)subCategoryItemArray{
    _subCategoryItemArray = subCategoryItemArray;
    [self.contextMenuTableView reloadData];
}

#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        [self setCurrentPage:indexPath.row animated:YES];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 64;
    }else{
        return 75;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subCategoryItemArray.count;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        InfoCategory* category = [self.subCategoryItemArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 0) {
            cell.menuTitleLabel.text = @"";
            cell.menuImageView.image = [UIImage imageNamed:@"icn_close"];
        }else{
            cell.menuTitleLabel.text = category.at_name;
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:category.at_click_imgurl] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [cell.menuImageView setImage:[image imageBy2xImage]];
            }];
        }
    }
    
    return cell;
}


#pragma mark - DataSource
- (NSInteger)getCurrentPageIndex {
    return self.currentPage;
}

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    self.paggingNavbar.currentPage = currentPage;
    self.currentPage = currentPage;
    
    CGFloat pageWidth = CGRectGetWidth(self.paggingScrollView.frame);
    
    [self.paggingScrollView setContentOffset:CGPointMake(currentPage * pageWidth, 0) animated:animated];
}

- (void)reloadData {
    if (!self.viewControllers.count) {
        return;
    }
    
    [self.paggingScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        CGRect contentViewFrame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNAV_HEIGHT);
        contentViewFrame.origin.x = idx * CGRectGetWidth(self.view.bounds);
        viewController.view.frame = contentViewFrame;
        [self.paggingScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
    [self setCurrentPage:0 animated:YES];
    
    [self.paggingScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds) * self.viewControllers.count, 0)];
    
    self.paggingNavbar.titles = [self.viewControllers valueForKey:@"title"];
    [self.paggingNavbar reloadData];
    
    [self setupScrollToTop];
    
    [self callBackChangedPage];
}

#pragma mark - Propertys

- (UIView *)centerContainerView {
    if (!_centerContainerView) {
        _centerContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _centerContainerView.backgroundColor = [UIColor whiteColor];
        
        [_centerContainerView addSubview:self.paggingScrollView];
        [self.paggingScrollView.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerHandle:)];
    }
    return _centerContainerView;
}

- (UIScrollView *)paggingScrollView {
    if (!_paggingScrollView) {
        _paggingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _paggingScrollView.bounces = NO;
        _paggingScrollView.pagingEnabled = YES;
        [_paggingScrollView setScrollsToTop:NO];
        _paggingScrollView.delegate = self;
        _paggingScrollView.showsVerticalScrollIndicator = NO;
        _paggingScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _paggingScrollView;
}

- (XHPaggingNavbar *)paggingNavbar {
    if (!_paggingNavbar) {
        _paggingNavbar = [[XHPaggingNavbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) / 2.0, 44)];
        _paggingNavbar.backgroundColor = [UIColor clearColor];
    }
    return _paggingNavbar;
}

- (UIViewController *)getPageViewControllerAtIndex:(NSInteger)index {
    if (index < self.viewControllers.count) {
        return self.viewControllers[index];
    } else {
        return nil;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage)
        return;
    _currentPage = currentPage;
    
    self.paggingNavbar.currentPage = currentPage;
    
    [self setupScrollToTop];
    [self callBackChangedPage];
}

#pragma mark - Life Cycle

- (void)setupTargetViewController:(UIViewController *)targetViewController withSlideType:(XHSlideType)slideType {
    if (!targetViewController)
        return;
    
    [self addChildViewController:targetViewController];
    CGRect targetViewFrame = targetViewController.view.frame;
    switch (slideType) {
        case XHSlideTypeLeft: {
            targetViewFrame.origin.x = -CGRectGetWidth(self.view.bounds);
            break;
        }
        case XHSlideTypeRight: {
            targetViewFrame.origin.x = CGRectGetWidth(self.view.bounds) * 2;
            break;
        }
        default:
            break;
    }
    targetViewController.view.frame = targetViewFrame;
    [self.view insertSubview:targetViewController.view atIndex:0];
    [targetViewController didMoveToParentViewController:self];
}

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController {
    return [self initWithLeftViewController:leftViewController rightViewController:nil];
}

- (instancetype)initWithRightViewController:(UIViewController *)rightViewController {
    return [self initWithLeftViewController:nil rightViewController:rightViewController];
}

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController {
    self = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        
        self.rightViewController = rightViewController;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    
    [self setupViews];
    
    [self reloadData];
    
    // 根据前面传入的是否显示右侧菜单显示
    if (!self.isShowRightItem) {
        if (!self.subCategoryItemArray || self.subCategoryItemArray.count < 1) {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
}

- (void)setupNavigationBar {
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.navigationItem.titleView = self.paggingNavbar;
}

- (void)setupViews {
    [self.view addSubview:self.centerContainerView];
    
    [self setupTargetViewController:self.leftViewController withSlideType:XHSlideTypeLeft];
    [self setupTargetViewController:self.rightViewController withSlideType:XHSlideTypeRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.paggingScrollView.delegate = nil;
    self.paggingScrollView = nil;
    
    self.paggingNavbar = nil;
    
    self.viewControllers = nil;
    
    self.didChangedPageCompleted = nil;
}

#pragma mark - PanGesture Handle Method

- (void)panGestureRecognizerHandle:(UIPanGestureRecognizer *)panGestureRecognizer {
    /*
     CGPoint contentOffset = self.paggingScrollView.contentOffset;
     
     CGSize contentSize = self.paggingScrollView.contentSize;
     
     CGFloat baseWidth = CGRectGetWidth(self.paggingScrollView.bounds);
     
     switch (panGestureRecognizer.state) {
     case UIGestureRecognizerStateBegan:
     
     break;
     case UIGestureRecognizerStateChanged: {
     CGPoint translationPoint = [panGestureRecognizer translationInView:panGestureRecognizer.view];
     if (contentOffset.x <= 0) {
     // 滑动到最左边
     
     CGRect centerContainerViewFrame = self.centerContainerView.frame;
     centerContainerViewFrame.origin.x += translationPoint.x;
     self.centerContainerView.frame = centerContainerViewFrame;
     
     CGRect leftMenuViewFrame = self.leftViewController.view.frame;
     leftMenuViewFrame.origin.x += translationPoint.x;
     self.leftViewController.view.frame = leftMenuViewFrame;
     
     [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
     } else if (contentOffset.x >= contentSize.width - baseWidth) {
     // 滑动到最右边
     [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
     }
     break;
     }
     case UIGestureRecognizerStateFailed:
     case UIGestureRecognizerStateEnded:
     case UIGestureRecognizerStateCancelled: {
     // 判断是否打开或关闭Menu
     break;
     }
     default:
     break;
     }
     */
}

#pragma mark - Block Call Back Method

- (void)callBackChangedPage {
    if (self.didChangedPageCompleted) {
        self.didChangedPageCompleted(self.currentPage, [[self.viewControllers valueForKey:@"title"] objectAtIndex:self.currentPage]);
    }
}

#pragma mark - TableView Helper Method

- (void)setupScrollToTop {
    for (int i = 0; i < self.viewControllers.count; i ++) {
        UITableView *tableView = (UITableView *)[self subviewWithClass:[UITableView class] onView:[self getPageViewControllerAtIndex:i].view];
        if (tableView) {
            if (self.currentPage == i) {
                [tableView setScrollsToTop:YES];
            } else {
                [tableView setScrollsToTop:NO];
            }
        }
    }
}

#pragma mark - View Helper Method

- (UIView *)subviewWithClass:(Class)cuurentClass onView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:cuurentClass]) {
            return subView;
        }
    }
    return nil;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.paggingNavbar.contentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 得到每页宽度
    CGFloat pageWidth = CGRectGetWidth(self.paggingScrollView.frame);
    
    // 根据当前的x坐标和页宽度计算出当前页数
    self.currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

@end
