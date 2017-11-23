//
//  SelectQuesCategoryViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "SelectQuesCategoryViewController.h"
#import "QuesCategoryCell.h"
#import "QuestionCategory.h"

@interface SelectQuesCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *uiCategoryTableView;

@property (nonatomic, strong)NSMutableArray* categoryArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trallingEdge_table;

@end

@implementation SelectQuesCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择分类";
    
    // 1、初始化数据
    [self initViewAndConAttribute];
    
    // 2、加载数据
    [self loadCategoryArray];
}

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    self.categoryArray = [NSMutableArray new];
    self.leadingEdge_table.constant = self.trallingEdge_table.constant = self.leftEdge;
}

#pragma mark - 网络数据加载
- (void)loadCategoryArray{
    [[WebAccessManager sharedInstance]getQuesCategoryListWithcompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            _categoryArray = response.data.territoryList;
            [self.uiCategoryTableView reloadData];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.categoryArray.count) {
        QuestionCategory* category = [self.categoryArray objectAtIndex:indexPath.row];
        QuesCategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:[QuesCategoryCell ID]];
        if (!cell) {
            cell = [QuesCategoryCell newCell];
        }
        
        [cell.uiImageView sd_setImageWithURL:[NSURL URLWithString:category.te_images_url ] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
        cell.uiNameLab.text = category.te_title;
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.categoryArray.count) {
        QuestionCategory* category = [self.categoryArray objectAtIndex:indexPath.row];
        [self.delegate selectCategory:category];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
