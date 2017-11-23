//
//  ChannelCollectionViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/18.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChannelCollectionViewController.h"
#import "AddChannelCollectionViewController.h"
#import "CollectionDetailWebViewController.h"
//#import "ChannelCollectionCell.h"
#import "GroupListModel.h"
#import "LeftListViewController.h"
#import "WeChatPublicNumberViewController.h"
#import "ChannelCollectionViewCell.h"

@interface ChannelCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_itemArry;
    
    UICollectionView *_collectionView;
}
@end

@implementation ChannelCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initNavBar];
    // ========= UPDATE BY ELLISON FOR 3TH改版 ==========
    //    [self setupLeftNav];
    //    [self setupCenterView];
    // ========= UPDATE BY ELLISON FOR 3TH改版 END ==========
    [self setupview];
    [self writeFile];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loaddata];
}
-(void)initData{
    _itemArry = [[NSMutableArray alloc] initWithCapacity:0];
}

// 初始化导航栏
- (void)initNavBar{
    self.title = @"合作单位";
    return;
    
    UIImageView* titleView = [UIImageView new];
    titleView.frame = CGRectMake(0, 0, 149, 18);
    titleView.image = [UIImage imageNamed:@"Demo科普中国"];
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.layer.masksToBounds = YES;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = nil;
}
// ========= UPDATE BY ELLISON FOR 3TH改版 ==========
//-(void)setupLeftNav{
//    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
//    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
//    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
//    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
//    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
//}
// 左侧导航点击事件
//-(void)leftNavBtn{
//        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//        [menuController showLeftController:YES];
//
//}
// ========= UPDATE BY ELLISON FOR 3TH改版 END ==========
-(void)setupview{
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.view setBackgroundColor:[UIColor colorWithRed:(237.0/225.0) green:(238.0/255.0) blue:(240.0/255.0) alpha:1]];
    
    NSInteger _column = 3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;//横向item间距(最小值)
    layout.minimumLineSpacing = 0;//行间距
    NSLog(@"%f",self.showWidth/_column);
    layout.itemSize = CGSizeMake((self.showWidth)/_column, (self.showWidth)/_column);//每个UICollectionViewCell 的大小
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//每个UICollectionViewCell 的 margin
    //layout.headerReferenceSize = CGSizeMake(self.showWidth, 0);//分组头视图的size
    
    NSArray *arry = [self getFavouriteModelItems];
    [_itemArry addObjectsFromArray:arry];
    
    NSDictionary *addDic = @{@"title":@"添加",
                             @"url":@"",
                             @"image":@"Demo添加",
                             @"isattention":@"1",
                             @"si_id":@""};
//    GroupListDetailModel *model = [[GroupListDetailModel alloc] initWithDic:addDic];
//    [_itemArry addObject:model];
//    
//    NSInteger n=_itemArry.count/3;
//    if(_itemArry.count%3>0){
//        n+=1;
//    }
//    
//      NSLog(@"%lu",n);
//    
////    (self.showWidth-4)/_column
//    NSInteger height=((self.showWidth-4)/_column)*n+8;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64.0) collectionViewLayout:layout];
    //collectionView.width = 6;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
//    [_collectionView setBackgroundColor:[UIColor colorWithRed:(237.0/255.0) green:(238.0/255.0) blue:(240.0/255.0) alpha:1]];
    //_collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_collectionView];
    
    //    [_collectionView registerClass:[ChannelCollectionCell class] forCellWithReuseIdentifier:[ChannelCollectionCell ID]];
    
    [_collectionView registerClass:[ChannelCollectionViewCell class] forCellWithReuseIdentifier:[ChannelCollectionViewCell ID]];
}

// ========= UPDATE BY ELLISON FOR 3TH改版 ==========
//-(void)setupCenterView{
//    NSString *_centerBackMain;
//    NSString *_centerBackCollect;
//    _centerBackMain = @"centerButton_首页";
//    _centerBackCollect = @"centerButton_我的收藏";
//    CGFloat buttonW = 75.0;
//    CGFloat buttonH = 34.0;
//    UIButton *_centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _centerButton.frame = CGRectMake((MAIN_SCREEN_WIDTH-75)/2.0, MAIN_SCREEN_HEIGHT-buttonH, buttonW, buttonH);
//    [_centerButton setImage:[UIImage imageNamed:_centerBackMain] forState:UIControlStateNormal];
//    [_centerButton addTarget:self action:@selector(tapCenterButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.view addSubview:_centerButton];
//
//}
//-(void)tapCenterButton:(UIButton *)sender{
//        DDMenuController *menu = [AppDelegate appdelegate].menuController;
//        LeftListViewController *left = (LeftListViewController *)menu.leftViewController;
//        [left showMain];
//        [[AppDelegate appdelegate] transitionWithType:@"rippleEffect" WithSubtype:kCATransitionFromBottom ForView:[AppDelegate appdelegate].window];
//}
// ========= UPDATE BY ELLISON FOR 3TH改版 END ==========

#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger sec = _itemArry.count;
    return sec;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChannelCollectionViewCell *cell = (ChannelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[ChannelCollectionViewCell ID] forIndexPath:indexPath];
    [cell setcellModel:_itemArry[indexPath.row]];
    return cell;
}
#pragma mark UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _itemArry.count-1) {
        [self showAddView];
    } else {
        GroupListDetailModel *model = _itemArry[indexPath.row];
        [self showWebViewWithModel:model];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)showAddView{
    AddChannelCollectionViewController *vc = [[AddChannelCollectionViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:^{}];
}
-(void)showWebViewWithModel:(GroupListDetailModel *)model{
    if ([model.title isEqualToString:@"微信"]) {
        WeChatPublicNumberViewController *webVC = [[WeChatPublicNumberViewController alloc] init];
        webVC.isBackButton = YES;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else{
        if (model.si_id != nil && ![model.si_id isEqualToString:@""]) {
            [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:model.si_id];
        } else {
            if (model.url != nil && ![model.url isEqualToString:@""]) {
                CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC loadWebWithUrl:model.url];
            }
        }
    }
    
}
#pragma mark network
//确保文件在本地存在将文件写到本地
-(void)writeFile{
    NSString *allDataPath = DocumentFilePathForAllChannelData;
    NSMutableArray *allDataArry;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:allDataPath]) {
        allDataArry = [[NSMutableArray alloc] initWithContentsOfFile:BundleFilePathForChannelData];
        //将所有数据写入本地文件
        NSData *allData = [NSKeyedArchiver archivedDataWithRootObject:allDataArry];
        [fileManager createFileAtPath:allDataPath contents:allData attributes:nil];
        [allDataArry writeToFile:allDataPath atomically:YES];
    }
    
    NSString *favouritePath = DocumentFilePathForFavouriteChannelData;
    NSMutableArray *favoutiteArry;
    if ([fileManager fileExistsAtPath:favouritePath]) {
        favoutiteArry = [[NSMutableArray alloc] initWithContentsOfFile:favouritePath];
    }else{
        //将我收藏的频道写到本地文件
        favoutiteArry = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in allDataArry) {
            NSArray *sublist = dic[@"sublist"];
            for (NSDictionary *subdic in sublist) {
                if ([subdic[@"isattention"] integerValue] == 1) {
                    [favoutiteArry addObject:subdic];
                }
            }
        }
    }
    NSData *favouriteData = [NSKeyedArchiver archivedDataWithRootObject:favoutiteArry];
    [fileManager createFileAtPath:favouritePath contents:favouriteData attributes:nil];
    [favoutiteArry writeToFile:favouritePath atomically:YES];
}
-(NSArray *)getFavouriteModelItems{
    NSMutableArray *arry = [[NSMutableArray alloc]initWithContentsOfFile:DocumentFilePathForFavouriteChannelData];
    NSMutableArray *favouriteModelArry = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in arry) {
        GroupListDetailModel *submodel = [[GroupListDetailModel alloc] initWithDic:dic];
        [favouriteModelArry addObject:submodel];
    }
    return favouriteModelArry;
}


-(void)loaddata{
    [_itemArry removeAllObjects];
    
    NSArray *arry = [self getFavouriteModelItems];
    [_itemArry addObjectsFromArray:arry];
    
    NSDictionary *addDic = @{@"title":@"添加",
                             @"url":@"",
                             @"image":@"Demo添加",
                             @"isattention":@"1",
                             @"si_id":@""};
    GroupListDetailModel *model = [[GroupListDetailModel alloc] initWithDic:addDic];
    [_itemArry addObject:model];
    
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
