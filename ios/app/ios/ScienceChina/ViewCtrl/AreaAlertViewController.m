//
//  AreaAlertViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "AreaAlertViewController.h"

#import "AddChannelCollectionViewController.h"
#import "CollectionDetailWebViewController.h"
//#import "ChannelCollectionCell.h"
#import "Area.h"
#import "LeftListViewController.h"
#import "WeChatPublicNumberViewController.h"

#import "AreaAlertCollectionViewCell.h"

@interface AreaAlertViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
     UICollectionView *_collectionView;
//    NSMutableArray *_itemArry;
}

@property (nonatomic, strong)NSMutableArray* data_list; // 数据
@property (nonatomic, strong)NSMutableArray* temp_data_list; // 数据

@end

@implementation AreaAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initNavBar];
    // ========= UPDATE BY ELLISON FOR 3TH改版 ==========
    //    [self setupLeftNav];
    //    [self setupCenterView];
    // ========= UPDATE BY ELLISON FOR 3TH改版 END ==========
    [self setupview];
    [self loadeData];
    
}

-(void)initData{
    self.data_list = [NSMutableArray new];
    self.temp_data_list = [NSMutableArray new];
//    _itemArry = [[NSMutableArray alloc] initWithCapacity:0];
}

// 初始化导航栏
- (void)initNavBar{
    return;
    
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
    
    NSInteger _column = 2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;//横向item间距(最小值)
    layout.minimumLineSpacing = 10;//行间距
    NSLog(@"%f",self.showWidth/_column);
    layout.itemSize = CGSizeMake(45, 25);//每个UICollectionViewCell 的大小
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);//每个UICollectionViewCell 的 margin
    //layout.headerReferenceSize = CGSizeMake(self.showWidth, 0);//分组头视图的size
    
//    NSArray *arry = [self getFavouriteModelItems];
//    [_itemArry addObjectsFromArray:arry];
    //self.leftEdge
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 150-20, 150-45) collectionViewLayout:layout];
    //collectionView.width = 6;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:(237.0/255.0) green:(238.0/255.0) blue:(240.0/255.0) alpha:1]];
    //_collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_collectionView];
    
    //    [_collectionView registerClass:[ChannelCollectionCell class] forCellWithReuseIdentifier:[ChannelCollectionCell ID]];
    
    [_collectionView registerClass:[AreaAlertCollectionViewCell class] forCellWithReuseIdentifier:[AreaAlertCollectionViewCell ID]];
    
//    [self.uiCollectionView registerNib:[UINib nibWithNibName:[AreaAlertCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[AreaAlertCollectionViewCell ID]];
}

#pragma mark - 加载网络数据
-(void)loadeData{
    [[WebAccessManager sharedInstance]getActivityRegionList: ^(WebResponse *response, NSError *error) {
        [self.uiCollectionView.mj_footer endRefreshing];
        [self.uiCollectionView.mj_header endRefreshing];
        
        if (response.success) {
//                self.data_list = response.data.region_list;
            
            self.data_list = [NSMutableArray new];
            self.temp_data_list = [NSMutableArray new];
            
            for (int i = 0; i < response.data.region_list.count; i++)
            {
                Area* hm=[[Area alloc]init];
                hm =[response.data.region_list objectAtIndex:i];
                
                if([_select_id isEqualToString:@"0"]){
                    if(i == 0){
                        hm.isSelect = @"1";
                    }else{
                        hm.isSelect = @"0";
                    }
                }else{
                    if([hm.region_code isEqualToString:_select_id]){
                        hm.isSelect = @"1";
                    }else{
                        hm.isSelect = @"0";
                    }
                }

                [self.data_list addObject:hm];
            }
                
                [_collectionView reloadData];

        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger sec = self.data_list.count;
    return sec;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AreaAlertCollectionViewCell *cell = (AreaAlertCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[AreaAlertCollectionViewCell ID] forIndexPath:indexPath];
    
    Area* hm=[self.data_list objectAtIndex:indexPath.row];
    
    [cell setcellModel:hm];
    return cell;
}
#pragma mark UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    self.temp_data_list = [NSMutableArray new];
    
    for (int i = 0; i < self.data_list.count; i++)
    {
        Area* hm=[[Area alloc]init];
        hm =[self.data_list objectAtIndex:i];
        if(indexPath.row == i){
            hm.isSelect = @"1";
        }else{
            hm.isSelect = @"0";
        }
        
        Area* hms =[self.data_list objectAtIndex:i];
        
        hm.region_code = hms.region_code;
    }
    
    [_collectionView reloadData];
    
    Area* hm=[[Area alloc]init];
    hm =self.data_list[indexPath.row];
    [self.delegate clickBtn:hm];
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


//- (NSArray *)menuTitles
//{
//    return @[@"全国", @"北京", @"杭州", @"重庆", @"苏州", @"四川"];
//}

//-(void)loaddata{
//    [_itemArry removeAllObjects];
    
//    self.data_list = [NSMutableArray new];
//    self.temp_data_list = [NSMutableArray new];

//    NSArray *arry = [self getFavouriteModelItems];
//    [_itemArry addObjectsFromArray:arry];
//
//    NSDictionary *addDic = @{@"title":@"添加",
//                             @"url":@"",
//                             @"image":@"Demo添加",
//                             @"isattention":@"1",
//                             @"si_id":@""};
//    GroupListDetailModel *model = [[GroupListDetailModel alloc] initWithDic:addDic];
//    [_itemArry addObject:model];
    
//    for (int i = 0; i < self.menuTitles.count; i++)
//    {
//        Area* hm=[[Area alloc]init];
//        hm.region_name =self.menuTitles[i];
//        if(i == 0){
//            hm.isSelect = @"1";
//        }else{
//            hm.isSelect = @"0";
//        }
//        [_itemArry addObject:hm];
//    }
    
//    [_collectionView reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
