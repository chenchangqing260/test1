//
//  ChannelListViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChannelListViewController.h"
#import "CollectionDetailWebViewController.h"
#import "GroupLeftListCell.h"
#import "GroupRightListCell.h"
#import "GroupListModel.h"

@interface ChannelListViewController () <UITableViewDataSource,UITableViewDelegate,GroupRightListCellDelete>
{
    NSMutableArray *_mainArry;
    NSMutableArray *_subArry;
    
    UITableView *_leftTable;
    UITableView *_rightTable;
    NSInteger _leftSelectIndex;
}
@end

@implementation ChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initNavBar];
    [self setupview];
    [self loaddata];
}
-(void)initData{
    _mainArry = [[NSMutableArray alloc] initWithCapacity:0];
    _subArry = [[NSMutableArray alloc] initWithCapacity:0];
}

// 初始化导航栏
- (void)initNavBar{
    UIImageView* titleView = [UIImageView new];
    titleView.frame = CGRectMake(0, 0, 149, 18);
    titleView.image = [UIImage imageNamed:@"Demo科普中国"];
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.layer.masksToBounds = YES;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = nil;
}
-(void)setupview{
    
    self.navigationItem.leftBarButtonItem = nil;
    
    UIView *_contentView = [[UIView alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.showWidth, MAIN_SCREEN_HEIGHT-64-49)];
    [self.view addSubview:_contentView];
    
    _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableWidth, _contentView.frame.size.height)];
    _leftTable.delegate = self;
    _leftTable.dataSource = self;
    _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_leftTable];
    _leftTable.backgroundColor = RGBCOLOR(245, 245, 245);
    
    _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(LeftTableWidth, 0, self.showWidth-LeftTableWidth, _contentView.frame.size.height)];
    _rightTable.delegate = self;
    _rightTable.dataSource = self;
    _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_rightTable];
}

-(void)loaddata{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GroupList" ofType:@"plist"];
    NSArray *arry = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for (NSDictionary *dic in arry) {
        GroupListModel *model = [[GroupListModel alloc] initWithDic:dic];
        [_mainArry addObject:model];
    }
    GroupListModel *model = _mainArry[0];
    [_subArry removeAllObjects];
    [_subArry addObjectsFromArray:model.sublist];
    
    [_leftTable reloadData];
    [_rightTable reloadData];
    
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [_leftTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#define GroupRightListCellDelete
-(void)saveDataWithMainMdel:(GroupListModel *)mainmodel subMdel:(GroupListDetailModel *)submodel leftSelectedIndex:(NSInteger)leftselectindex rightSelectedIndex:(NSInteger)rightselectindex isAttention:(BOOL)isAttention{
    if (isAttention) {
        submodel.isattention = YES;
    }else{
        submodel.isattention = NO;
    }
    [_subArry replaceObjectAtIndex:rightselectindex withObject:submodel];
    mainmodel.sublist = _subArry;
    
    [_mainArry replaceObjectAtIndex:leftselectindex withObject:mainmodel];
    
    //plist 文件读写
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GroupList" ofType:@"plist"];
    //写到plist文件里
    [_mainArry writeToFile:filePath atomically:YES];
    
    [_rightTable reloadData];
}
#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (tableView == _leftTable) {
        rows = _mainArry.count;
    }
    else if (tableView == _rightTable){
        rows = _subArry.count;
    }
    return rows;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTable) {
        GroupLeftListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GroupLeftListCell ID]];
        if (!cell) {
            cell = [[GroupLeftListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GroupLeftListCell ID]];
        }
        [cell setcellWithModel:_mainArry[indexPath.row]];
        return cell;
    }
    else if (tableView == _rightTable){
        GroupRightListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GroupRightListCell ID]];
        if (!cell) {
            cell = [[GroupRightListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GroupRightListCell ID]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        //[cell setcellWithModel:_subArry[indexPath.row]];
        [cell setcellWithMainMdel:_mainArry[_leftSelectIndex] subMdel:_subArry[indexPath.row] leftSelectedIndex:_leftSelectIndex rightSelectedIndex:indexPath.row];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTable) {
        GroupListModel *model = _mainArry[indexPath.row];
        _subArry = model.sublist;
        [_rightTable reloadData];
        _leftSelectIndex = indexPath.row;
    }
    else if (tableView == _rightTable){
        GroupListDetailModel *model = _subArry[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if (tableView == _leftTable) {
        cellHeight = 70;
    }else if (tableView == _rightTable){
        cellHeight = 70;
    }
    return cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
