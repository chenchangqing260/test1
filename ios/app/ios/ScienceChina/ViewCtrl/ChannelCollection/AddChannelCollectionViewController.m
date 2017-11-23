//
//  AddChannelCollectionViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/12/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "AddChannelCollectionViewController.h"
#import "CollectionDetailWebViewController.h"
//#import "AddChannelCollectionCell.h"
#import "GroupListModel.h"
//#import "AccChannnelCollectionReusableView.h"
#import "AddChannelCollectionViewCell.h"
#import "AccChannnelReusableCollectionViewCell.h"

@interface AddChannelCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AddChannelCollectionViewCellDelegate>
{
    NSMutableArray *_itemArry;
    
    UICollectionView *_collectionView;
}
@end

@implementation AddChannelCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loaddata];
}
-(void)initData{
    _itemArry = [[NSMutableArray alloc] initWithCapacity:0];
}
#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return YES;
}
-(void)setupview{
    self.title = @"科普中国";
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setBackgroundColor:[UIColor colorWithRed:(237.0/225.0) green:(238.0/255.0) blue:(240.0/255.0) alpha:1]];
    
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 40, 25);
    [leftNavBtn setTitle:@"完成" forState:UIControlStateNormal];
    [leftNavBtn setTitle:@"完成" forState:UIControlStateHighlighted];
    [leftNavBtn.titleLabel setFont:FONT_14];
    [leftNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [leftNavBtn addTarget:self action:@selector(leftNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
        NSInteger _column = 3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;//横向item间距(最小值)
    layout.minimumLineSpacing = kSCREEN_WIDTH * 11 / kWIDTH_375;//行间距
    layout.itemSize = CGSizeMake(self.showWidth/_column, self.showWidth/_column);//每个UICollectionViewCell 的大小
    layout.sectionInset = UIEdgeInsetsMake(kSCREEN_WIDTH * 11 / kWIDTH_375, kSCREEN_WIDTH * 11 / kWIDTH_375, kSCREEN_WIDTH * 11 / kWIDTH_375, kSCREEN_WIDTH * 11 / kWIDTH_375);//每个UICollectionViewCell 的 margin
    layout.headerReferenceSize = CGSizeMake(self.showWidth, 33);//分组头视图的size
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64) collectionViewLayout:layout];
    //collectionView.width = 6;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    _collectionView.backgroundColor = [UIColor darkGrayColor];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:(237.0/255.0) green:(238.0/255.0) blue:(240.0/255.0) alpha:1]];
    //_collectionView.contentInset = UIEdgeInsetsMake(0, sapceWidth/2.0, 0, sapceWidth/2.0);
    [self.view addSubview:_collectionView];
    
    //    [_collectionView registerClass:[AddChannelCollectionCell class] forCellWithReuseIdentifier:[AddChannelCollectionCell ID]];
    
    [_collectionView registerClass:[AddChannelCollectionViewCell class] forCellWithReuseIdentifier:[AddChannelCollectionViewCell ID]];
    
    //    [_collectionView registerClass:[AccChannnelCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[AccChannnelCollectionReusableView ID]];
    
    [_collectionView registerClass:[AccChannnelReusableCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[AccChannnelReusableCollectionViewCell ID]];
    
}
-(void)leftNavBtnAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _itemArry.count;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    GroupListModel *model = _itemArry[section];
    NSInteger sec = model.sublist.count;
    return sec;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddChannelCollectionViewCell *cell = (AddChannelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[AddChannelCollectionViewCell ID] forIndexPath:indexPath];
    GroupListModel *model = _itemArry[indexPath.section];
    cell.indexPath = indexPath;
    cell.delegate = self;
    [cell setcellModel:model.sublist[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kSCREEN_WIDTH * 110 / kWIDTH_375, kSCREEN_WIDTH * 110 / kWIDTH_375 );
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //    AccChannnelCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[AccChannnelCollectionReusableView ID] forIndexPath:indexPath];
    //    GroupListModel *model = _itemArry[indexPath.section];
    //    [reusableView setTitle:model.title];
    //    return reusableView;
    
    AccChannnelReusableCollectionViewCell *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[AccChannnelReusableCollectionViewCell ID] forIndexPath:indexPath];
    GroupListModel *model = _itemArry[indexPath.section];
    [reusableView setTitle:model.title];
    return reusableView;
    
}

#pragma mark UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupListModel *model = _itemArry[indexPath.section];
    GroupListDetailModel *submodel = model.sublist[indexPath.row];
    [self showWebViewWithModel:submodel];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#define AddChannelCollectionCellDelegate
-(void)didSelectIndex:(NSIndexPath *)index isattention:(BOOL)isattention{
    [self saveDataWithIndex:index isAttention:isattention];
}
-(void)showAddView{
    AddChannelCollectionViewController *vc = [[AddChannelCollectionViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:^{}];
}
-(void)showWebViewWithModel:(GroupListDetailModel *)model{
    
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
#pragma mark network
-(NSArray *)getAllData{
    NSString *allDataPath = DocumentFilePathForAllChannelData;
    NSMutableArray *allDataArry;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:allDataPath]) {
        allDataArry = [[NSMutableArray alloc]initWithContentsOfFile:allDataPath];
    }else{
        allDataArry = [[NSMutableArray alloc] initWithContentsOfFile:BundleFilePathForChannelData];
        //将所有数据写入本地文件
        NSData *allData = [NSKeyedArchiver archivedDataWithRootObject:allDataArry];
        [fileManager createFileAtPath:allDataPath contents:allData attributes:nil];
        [allDataArry writeToFile:allDataPath atomically:YES];
        
        
        //将我收藏的频道写到本地文件
        NSString *favouritePath = DocumentFilePathForFavouriteChannelData;
        NSMutableArray *favoutiteArry;
        if ([fileManager fileExistsAtPath:favouritePath]) {
            favoutiteArry = [[NSMutableArray alloc] initWithContentsOfFile:favouritePath];
        }else{
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
    return allDataArry;
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
    NSArray *arry = [self getAllData];
    
    for (NSDictionary *dic in arry) {
        GroupListModel *model = [[GroupListModel alloc] initWithDic:dic];
        [_itemArry addObject:model];
    }
    [_collectionView reloadData];
    
}

-(void)saveDataWithIndex:(NSIndexPath *)index isAttention:(BOOL)isAttention{
    
    
    
    GroupListModel *model = _itemArry[index.section];
    NSMutableArray *subarry = [NSMutableArray arrayWithArray:model.sublist];
    GroupListDetailModel *selectModel = subarry[index.row];
    selectModel.isattention = isAttention;
    
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        /******刷新本地的所有数据*****/
        [subarry replaceObjectAtIndex:index.row withObject:selectModel];
        model.sublist = subarry;
        
        [_itemArry replaceObjectAtIndex:index.section withObject:model];
        
        NSArray *dictArrayForAll = [GroupListModel mj_keyValuesArrayWithObjectArray:_itemArry];// 将模型数组转为字典数组
        [dictArrayForAll writeToFile:DocumentFilePathForAllChannelData atomically:YES];
    });
    dispatch_barrier_async(queue, ^{
        /******刷新本地收藏的数据*****/
        NSArray *arry = [self getFavouriteModelItems];
        NSMutableArray *dictArrayForFavourite = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *favouriteModelArry = [NSMutableArray arrayWithArray:arry];
        if (isAttention) {
            [favouriteModelArry addObject:selectModel];
        } else {
            for (int i=0; i<arry.count; i++) {
                GroupListDetailModel *subModel = arry[i];
                if ([selectModel.title isEqualToString:subModel.title]) {
                    [favouriteModelArry removeObject:subModel];
                    [favouriteModelArry removeObject:selectModel];
                }
            }
        }
        // 将模型数组转为字典数组
        dictArrayForFavourite = [GroupListModel mj_keyValuesArrayWithObjectArray:favouriteModelArry];
        [dictArrayForFavourite writeToFile:DocumentFilePathForFavouriteChannelData atomically:YES];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView reloadData];
    });
    
    return;
}


//-(void)saveDataWithIndex:(NSIndexPath *)index isAttention:(BOOL)isAttention{
//
//    GroupListModel *model = _itemArry[index.section];
//    NSMutableArray *subarry = [NSMutableArray arrayWithArray:model.sublist];
//    GroupListDetailModel *submodel = subarry[index.row];
//
//    submodel.isattention = isAttention;
//
//    [subarry replaceObjectAtIndex:index.row withObject:submodel];
//    model.sublist = subarry;
//
//    [_itemArry replaceObjectAtIndex:index.section withObject:model];
//
//    // 将模型数组转为字典数组
//    NSArray *dictArray = [GroupListModel mj_keyValuesArrayWithObjectArray:_itemArry];
//
//    [dictArray writeToFile:DocumentFilePathForChannelData atomically:YES];
//    [_collectionView reloadData];
//    return;
//}

#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
