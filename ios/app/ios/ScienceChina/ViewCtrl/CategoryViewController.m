//
//  CategoryViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/4/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCollectionViewCell.h"
#import "SpecifyCategoryViewController.h"
#import "CategoryVCLayout.h"
#import "KYCuteView.h"
#import "XHTwitterPaggingViewer.h"
#import "SubCategoryViewController.h"
#import "MRFlipTransition.h"

@interface CategoryViewController ()<KYCuteViewDelegate>

@property (nonatomic, strong)NSMutableArray* categoryArray;

@property (weak, nonatomic) IBOutlet CategoryVCLayout *uiCategoryLayout;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPress;
@property (weak, nonatomic) IBOutlet UIView *uiGuideView;

@property (strong, nonatomic)KYCuteView *cuteView;
@property (strong, nonatomic)CategoryCollectionViewCell *longPressCell;
@property (nonatomic,retain)CALayer     *layer;
@property (nonatomic, assign) BOOL isAnmitate;
@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic, assign)CGFloat y; // SCROLLVIEW 偏移量
@property (nonatomic, strong)   MRFlipTransition    *animator;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LStr(@"category");
    self.animator = [[MRFlipTransition alloc] initWithPresentingViewController:self];
    [self initCollectionView];
    [self loadeData];
    
    NSUserDefaults* setting = [NSUserDefaults standardUserDefaults];
    NSString* categoryguide = [setting objectForKey:@"categoryguide"];
    if (!categoryguide) {
        [self.view bringSubviewToFront:self.uiGuideView];
        [setting setObject:@"show" forKey:@"categoryguide"];
        [setting synchronize];
    }
    
    [self initCuteView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionData:) name:@"refreshCollectionData" object:nil];
}

- (void)refreshCollectionData:(NSNotification*)notification{
    [[WebAccessManager sharedInstance]getCollectCategoryListWithcompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 1、设置已经定制的数量
            self.cuteView.bubbleLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)response.data.atCollectList.count];
            
            // 2、获取有无可定制的分类
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray* collectArray = nil;
            if ([MemberManager sharedInstance].isLogined) {
                collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
            }else{
                collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategory];
            }
            
            if (!collectArray || response.data.atCollectList.count != collectArray.count) {
                NSMutableArray* tempArray = [NSMutableArray new];
                NSMutableArray* tempList = response.data.atCollectList;
                // 将数据处理成为可以存储的NSString数据
                for (InfoCategory* category in tempList) {
                    NSString* categoryStr = [NSString stringWithFormat:@"%@~-%@~-%@~-%@", category.at_id, category.at_name_ch, category.at_img_url, category.at_type];
                    [tempArray addObject:categoryStr];
                }
                
                // 网络数据和本地数据不一致，则进行数据同步
                if ([MemberManager sharedInstance].isLogined) {
                    [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
                }else{
                    [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategory];
                }

                [defaults synchronize];
                
                // 刷新首页数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_RELOADHOMEPAGE object:nil];
            }
        }
    }];
}

#pragma mark - 初始化界面对象
-(void)initCuteView{
    self.cuteView = [[KYCuteView alloc]initWithPoint:CGPointMake(kSCREEN_WIDTH - 80, kSCREEN_HEIGHT - kNAV_HEIGHT - 49 - 85) superView:self.view];
    self.cuteView.delegate = self;
    self.cuteView.viscosity  = 20;
    self.cuteView.bubbleWidth = 60;
    self.cuteView.bubbleColor = [UIColor colorWithHex:0x33cfda];
    [self.cuteView setUp];
    [self.cuteView addGesture];
    
    //注意：设置 'bubbleLabel.text' 一定要放在 '-setUp' 方法之后
    //Tips:When you set the 'bubbleLabel.text',you must set it after '-setUp'
    self.cuteView.bubbleLabel.text = @"0";
    [self.view bringSubviewToFront:self.cuteView];
}

#pragma mark - 点击事件
- (IBAction)handleLongPressGesture:(id)sender {
    if (!self.isAnmitate) {
        self.isAnmitate = YES;
        
        UILongPressGestureRecognizer* longGes = (UILongPressGestureRecognizer*)sender;
        NSIndexPath *indexPath = [self.uiCollectionView indexPathForItemAtPoint:[longGes locationInView:self.uiCollectionView]];
        self.longPressCell = (CategoryCollectionViewCell *)[self.uiCollectionView cellForItemAtIndexPath:indexPath];
        
        InfoCategory* category = [_categoryArray objectAtIndex:indexPath.row];
        // 进行定制操作
        [[WebAccessManager sharedInstance]collectCategoryWithAtId:category.at_id completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                // 加入定制数组
                NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                NSMutableArray* collectArray = nil;
                if ([MemberManager sharedInstance].isLogined) {
                    collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
                }else{
                    collectArray = [defaults objectForKey:kUserDefaultKeyCollectCategory];
                }
                
                NSMutableArray* tempArray = [collectArray mutableCopy];
                NSString* categoryStr = [NSString stringWithFormat:@"%@~-%@~-%@~-%@",category.at_id, category.at_name_ch, category.at_img_url_s, category.at_type];
                [tempArray addObject:categoryStr];
                
                // 网络数据和本地数据不一致，则进行数据同步
                if ([MemberManager sharedInstance].isLogined) {
                    [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
                }else{
                    [defaults setObject:[tempArray copy] forKey:kUserDefaultKeyCollectCategory];
                }

                [defaults synchronize];
                
                // 刷新首页数据
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_RELOADHOMEPAGE object:nil];
                
                // 定制成功
                CGPoint point = self.longPressCell.center;
                CGFloat centerX = point.x;
                CGFloat centerY = point.y;
                point = CGPointMake(centerX, centerY - self.y);
                
                self.path = [UIBezierPath bezierPath];
                [_path moveToPoint:point];
                [_path addQuadCurveToPoint:self.cuteView.center controlPoint:point];
                
                if (!_layer) {
                    //_btn.enabled = NO;
                    _layer = [CALayer layer];
                    _layer.contents = (__bridge id)self.longPressCell.uiImageView.image.CGImage;
                    _layer.contentsGravity = kCAGravityResizeAspectFill;
                    _layer.bounds = CGRectMake(0, 0, 50, 50);
                    [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
                    _layer.masksToBounds = YES;
                    _layer.position =CGPointMake(50, 150);
                    [self.view.layer addSublayer:_layer];
                }
                [self groupAnimation];
            }else{
                self.isAnmitate = NO;
                [SVProgressHUDUtil showInfoWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

// 长按guideview
- (IBAction)clickGuideViewGes:(id)sender {
    [self.view sendSubviewToBack:self.uiGuideView];
}

#pragma mark - 网络数据加载
-(void)loadeData{
    [[WebAccessManager sharedInstance]getInfoCategoryWithCompletion:^(WebResponse *response, NSError *error) {
        [self.uiCollectionView.mj_header endRefreshing];
        if (response.success) {
            _categoryArray = response.data.informationTypeList;
            _uiCategoryLayout.itemList = _categoryArray;
            [self.uiCollectionView reloadData];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
    
    [self refreshCollectionData:nil];
}


#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[CategoryCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[CategoryCollectionViewCell ID]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _categoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < _categoryArray.count) {
        CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CategoryCollectionViewCell ID] forIndexPath:indexPath];
        [cell initCellData:[_categoryArray objectAtIndex:[indexPath row]]];
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _categoryArray.count) {
        InfoCategory* category = [_categoryArray objectAtIndex:[indexPath row]];
        
        if ([category.at_type isEqualToString:@"2"]) {
            // 专题分类
            [FlowUtil startToTopicListVCNav:self.navigationController at_id:category.at_id];
        }else{
            // 普通分类
            [[WebAccessManager sharedInstance]getSubCategoryWithAtId:category.at_id completion:^(WebResponse *response, NSError *error) {
                if (response.success) {
                    // 1、得到子分类
                    NSMutableArray* subArray = response.data.pullDowninforTypeList;
                    
                    // 2、将大分类放在最先的位置
                    NSMutableArray* allArray = subArray;
                    category.at_name = category.at_name_ch;
                    [allArray insertObject:category atIndex:0];
                    
                    // 3、处理数据得到所有的标题
                    NSMutableArray *titles = [NSMutableArray new];
                    for (InfoCategory* category in allArray) {
                        [titles addObject:category.at_name];
                    }
                    
                    XHTwitterPaggingViewer* twitterPaggingViewer = [[XHTwitterPaggingViewer alloc] init];
                    
                    // 3.1、设置滑动视图
                    NSMutableArray *viewControllers = [NSMutableArray new];
                    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
                        SubCategoryViewController *vc = [[SubCategoryViewController alloc] init];
                        vc.title = title;
                        vc.category = [allArray objectAtIndex:idx];
                        [viewControllers addObject:vc];
                    }];
                    
                    twitterPaggingViewer.viewControllers = viewControllers;
                    twitterPaggingViewer.didChangedPageCompleted = ^(NSInteger cuurentPage, NSString *title) {
                        SubCategoryViewController *vc = viewControllers[cuurentPage];
                        [vc loadeDataForSubView];
                    };
                    
                    // 3.2、设置右侧弹出视图
                    twitterPaggingViewer.subCategoryItemArray = subArray;
                    
                    [self.navigationController pushViewController:twitterPaggingViewer animated:YES];
                }
            }];
        }
    }
}

-(BOOL)showMJHeader{
    return YES;
}

- (void)collectionViewRefreshHeaderData{
    [self loadeData];
}

-(BOOL)showMJFooter{
    return NO;
}

#pragma mark - 自定义业务方法
// 长按手势添加分类
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
        self.isAnmitate = NO;
        [_layer removeFromSuperlayer];
        _layer = nil;
        self.cuteView.bubbleLabel.text = [NSString stringWithFormat:@"%ld",[self.cuteView.bubbleLabel.text integerValue] + 1];
        CATransition *animation = [CATransition animation];
        animation.duration = 0.15f;
    }
}


#pragma mark - KYCuteView Delegate
- (void)clickView{
    if([self.cuteView.bubbleLabel.text integerValue] == 0){
        MMPopupItemHandler block = ^(NSInteger index){
        };
        // 提示
        NSArray *items =
        @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
        [[[MMAlertView alloc] initWithTitle:@"提示"
                                     detail:@"长按图片添加自己喜欢的分类"
                                      items:items]
         showWithBlock:nil];
    }else{
        SpecifyCategoryViewController* vc = [SpecifyCategoryViewController new];
        JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:vc];
        [self.animator present:navigationController from:MRFlipTransitionPresentingFromInfinityAway completion:nil];
    }
    //    UIView *materialView = ({
    //        CGRect viewFrame = self.cuteView.frame;
    //        CGFloat width = 50;
    //        viewFrame.size = CGSizeMake(width, width);
    //        UIView *view = [[UIView alloc] initWithFrame:viewFrame];
    //        view.backgroundColor = [UIColor colorWithHex:0xffffff];
    //        view.layer.cornerRadius = width/2.0;
    //        view;
    //    });
    //
    //    [[UIApplication sharedApplication].keyWindow addSubview:materialView];
    //
    //    CGFloat size = MAX(CGRectGetHeight(navigationController.view.frame),
    //                       CGRectGetWidth(navigationController.view.frame)) * 2.0;
    //    CGFloat scale = size / CGRectGetWidth(materialView.frame);
    //    CGAffineTransform finalTransform = CGAffineTransformMakeScale(scale, scale);
    //
    //    [UIView animateWithDuration:0.5 animations:^{
    //        materialView.transform = finalTransform;
    //        materialView.center = navigationController.view.center;
    //        materialView.backgroundColor = navigationController.view.backgroundColor;
    //    } completion:^(BOOL finished) {
    //        //显示ViewController
    //        [self.navigationController presentViewController:navigationController animated:NO completion:nil];
    //        [UIView animateWithDuration:0.25 animations:^{
    //            materialView.alpha = 0.0;
    //        } completion:^(BOOL finished) {
    //            [materialView removeFromSuperview];
    //        }];
    //    }];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.y = scrollView.contentOffset.y; // 获取纵向滑动的距离
}

@end
