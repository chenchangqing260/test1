//
//  ChooseCompanyViewController.m
//  ScienceChina
//
//  Created by Ellison on 2017/6/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ChooseCompanyViewController.h"
#import "CompanyTableViewCell.h"

@interface ChooseCompanyViewController ()

@property (strong,nonatomic) NSMutableArray* companyArray; // 单位列表
@property (weak, nonatomic) IBOutlet UITableView *uiCompanyTableView;
@property (weak, nonatomic) IBOutlet UITextField *uiCompanyTF;

@end

@implementation ChooseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewData];
}

// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

- (void)initViewData{
    self.companyArray = [NSMutableArray new];
    [self initCompanyDataWithTownCode:_town_code];
    [self.uiCompanyTF becomeFirstResponder];
}

- (void)initCompanyDataWithTownCode:(NSString*)town_code{
    if ([town_code isEmptyOrWhitespace]) {
        // 提示选择城市
        [SVProgressHUDUtil showInfoWithStatus:@"请先选择省市/区县/象征" completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        return;
    }
    
    [[WebAccessManager sharedInstance]getCompanyListByTownWithTownCode:town_code completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 城市列表
            self.companyArray = response.data.companyList;
            // 刷新表格
            [self.uiCompanyTableView reloadData];
        }
    }];
}

- (IBAction)clickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 事件
- (IBAction)confirmBtnAction:(id)sender {
    if ([self.uiCompanyTF.text isEmptyOrWhitespace]) {
        // 提示选择城市
        [SVProgressHUDUtil showInfoWithStatus:@"请输入所属单位名称"];
        return;
    }
    
    [self.delegate setCompanyData:self.uiCompanyTF.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView DataSource, Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _companyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CompanyTableViewCell ID]];
    if (!cell) {
        cell = [CompanyTableViewCell newCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SciencerCompany* company = [_companyArray objectAtIndex:[indexPath row]];
    [cell setCellWithTypeModel:company];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SciencerCompany* company = [self.companyArray objectAtIndex:[indexPath row]];
    [self.delegate setCompanyData:company.cp_name];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
@end
