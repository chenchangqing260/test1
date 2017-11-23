//
//  VolunteerApproveViewController.m
//  lingshixiangmu
//
//  Created by touf on 2016/12/8.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VolunteerApproveViewController.h"
#import "ZLPhoto.h"
#import "FSMediaPicker.h"
#import "Provice.h"
#import "AddCity.h"
#import "Country.h"
#import "Town.h"
#import "WebAccessManager.h"
#import "QNCustomUploadManager.h"
#import "QNKeyHelper.h"
#import "HXProvincialCitiesCountiesPickerview.h"
#import "SciencerTypes.h"
#import "AddressView.h"
#import "ChooseCompanyViewController.h"

@interface VolunteerApproveViewController ()<NSXMLParserDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChooseCompanyDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewWidth;
@property (weak, nonatomic) IBOutlet UITextField *uiNameTextField; // 科普员姓名
@property (weak, nonatomic) IBOutlet UITextField *uiAddressTextField; // 选择省市县区乡镇
@property (weak, nonatomic) IBOutlet UIButton *uiChooseAddressBtn; // 选择省市县区乡镇按钮
@property (weak, nonatomic) IBOutlet UITextField *uiDetailAddress; // 详细地址
@property (weak, nonatomic) IBOutlet UITextField *uiCompany; // 所属单位
@property (weak, nonatomic) IBOutlet UITextField *uiType; // 选择科普员类型
@property (weak, nonatomic) IBOutlet UIButton *uiChooseTypeBtn; // 选择科普员类型

@property (weak, nonatomic) IBOutlet UITextField *uiEmail; // 科普员邮箱
@property (weak, nonatomic) IBOutlet UITextField *uiRecommendPeoTelephoneTextField; // 可选、推荐人手机号

@property (weak, nonatomic) IBOutlet UITextField *uiCardIDTextField;

@property (weak, nonatomic) IBOutlet UITextField *uiTelephoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *uiVCCodeTextField;
//@property (weak, nonatomic) IBOutlet UITableView *uiCompanyTableView;

@property (weak, nonatomic) IBOutlet UIButton *uiGetVCBtn;

@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, strong) NSXMLParser *par;
//@property (nonatomic, strong) Province *province;
//@property (nonatomic, strong) City *city;
//@property (strong, nonatomic) NSMutableArray *provinceArray;
//@property (strong, nonatomic) NSMutableArray *cityArray;
//@property (strong, nonatomic) NSMutableArray *countyArray;
//@property (strong ,nonatomic) UIPickerView *pickerView;
//@property (strong, nonatomic) NSString *cityStr;
//@property (strong, nonatomic) NSString *provinceStr;
//@property (strong, nonatomic) NSString *countyStr;
@property (nonatomic, strong) Provice* provice;
@property (nonatomic, strong) AddCity* addCity;
@property (nonatomic, strong) Country* county;
@property (nonatomic, strong) Town* town;
@property (strong,nonatomic) NSTimer *timer;

@property (strong,nonatomic) NSMutableArray* orgYunArray; // 类型用户列表
@property (strong,nonatomic) NSMutableDictionary* orgYunDict; //类型用户数据
@property (nonatomic,strong) SciencerTypes *sType;

@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;
@property (nonatomic,strong) AddressView *addressView;

@end

@implementation VolunteerApproveViewController
{
    UIView *backGroundView;
    
    UIView *bacview;
    
    BOOL whichBtn;
    
    int validateFlag;
}
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"科普员或团体认证";
    [self initViews];
    [self initGetTypeData];
    
    // 4、加载地址
    self.addressView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.addressView xmlData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [self.addressView addTitleView];
        });
    });
}
- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化界面
- (void)initViews
{
    [_uiNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_uiCardIDTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_uiRecommendPeoTelephoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_uiTelephoneNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_uiVCCodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _conContentViewWidth.constant = kSCREEN_WIDTH;
    
    self.orgYunArray = [NSMutableArray new];
    self.orgYunDict = [NSMutableDictionary new];
    
    //    self.uiCompanyTableView.hidden = YES;
}

- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 获取网络数据(获取科普员类型)
- (void)initGetTypeData{
    [[WebAccessManager sharedInstance]getAllSciencerTypesWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            // 获取机构列表
            NSMutableArray* tempArray = response.data.sciencerTypeList;
            if (tempArray && tempArray.count > 0) {
                for (int i=0; i<tempArray.count; i++) {
                    SciencerTypes* types = [tempArray objectAtIndex:i];
                    [self.orgYunArray addObject:types.st_name];
                    [self.orgYunDict setObject:types forKey:types.st_name];
                }
            }
        }
    }];
}

#pragma mark - 按钮点击事件
- (IBAction)uiSubmitBtnAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    if ([self checkSubMitInput])
    {
        [SVProgressHUDUtil show];
        [[WebAccessManager sharedInstance]submitSceAuthInfoWithOperatorV2:_uiNameTextField.text
                                                                 province:self.provice.name
                                                                     city:self.addCity.name
                                                                   county:self.county.name
                                                                     town:self.town.name
                                                            province_code:self.provice.code
                                                                city_code:self.addCity.code
                                                              county_code:self.county.code
                                                                town_code:self.town.code
                                                                  company:self.uiCompany.text
                                                                    it_id:nil
                                                                  sc_type:self.sType.st_no
                                                           operator_email:self.uiEmail.text
                                                         operator_card_no:_uiCardIDTextField.text
                                                       operator_telephone:_uiTelephoneNumTextField.text
                                                             referrer_tel:_uiRecommendPeoTelephoneTextField.text
                                                                     code:_uiVCCodeTextField.text
                                                               completion:^(WebResponse *response, NSError *error) {
                                                                   if (response.success){
                                                                       [SVProgressHUDUtil showSuccessWithStatus:@"提交成功"];
                                                                       [self.navigationController popViewControllerAnimated:1];
                                                                       // 设置用户状态
                                                                   }else{
                                                                       [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
                                                                   }
                                                               }];
    }
    
}

- (void)uiBackUpMethod{
    [self.view endEditing:YES];
    if ([self checkSubMitInput])
    {
        [SVProgressHUDUtil show];
        //上传图片
        /**
         if (_frontIDimg) {
         // 上传七牛云
         [QNCustomUploadManager uploadImage:_frontIDimg imgKey:[QNKeyHelper getQNKey:[NSString stringWithFormat:@"%@%@", @"QU",[[MemberManager sharedInstance]memberId]]  suffix:nil] maxSize:CGSizeMake(1080, 1920) success:^(NSString *imageName) {
         
         _frontImgStr = imageName;
         // 上传第二张图片
         if (_backIDimg) {
         // 上传七牛云
         [QNCustomUploadManager uploadImage:_backIDimg imgKey:[QNKeyHelper getQNKey:[NSString stringWithFormat:@"%@%@", @"QU",[[MemberManager sharedInstance]memberId]]  suffix:nil] maxSize:CGSizeMake(1080, 1920) success:^(NSString *imageName) {
         
         _backImgStr = imageName;
         //上传完成 开始保存表单数据
         
         [[WebAccessManager sharedInstance]submitSceAuthInfoWithOperator_name:_uiNameTextField.text province:_provinceStr city:_cityStr area:_countyStr detialAddress:_uiDetialAddressTextField.text operator_email:_uiEmailAddressTextField.text operator_tel:_uiTelephoneNumTextField.text operator_card_imag:_frontImgStr operator_card_imag_back:_backImgStr referrer_tel:_uiRecommendPeoTelephoneTextField.text code:_uiVCCodeTextField.text completion:^(WebResponse *response, NSError *error) {
         if (response.success)
         {
         [SVProgressHUDUtil showSuccessWithStatus:@"提交成功"];
         [self.navigationController popViewControllerAnimated:1];
         }
         else
         {
         [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
         }
         }];
         
         } failure:^{
         [SVProgressHUDUtil showErrorWithStatus:@"网络不太顺畅！"];
         }];
         }else{
         return;
         }
         
         } failure:^{
         [SVProgressHUDUtil showErrorWithStatus:@"网络不太顺畅！"];
         }];
         
         }else{
         return;
         } */
    }
    
}

- (IBAction)uiGetVCBtnAction:(id)sender
{
    [self.view endEditing:YES];
    // 验证是否输入手机号
    if ([_uiTelephoneNumTextField.text isEmptyOrWhitespace])
    {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return;
    }
    if (_uiTelephoneNumTextField.text.length!=11)
    {
        [CRToastUtil showAttentionMessageWithText:@"手机号必须为11位!"];
        return;
    }
    if (![self valiMobile:_uiTelephoneNumTextField.text]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入正确的科普员手机号!"];
        return;
    }
    [[WebAccessManager sharedInstance]getVerifyCodeNewWithTelephone:_uiTelephoneNumTextField.text type:@"2" completion:^(WebResponse *response, NSError *error) {
//        if (!error) {
//            [CRToastUtil showPublicMessageWithText:@"验证码已发送到你的手机"];
//            validateFlag = 60; // 重置倒计时
//            _uiGetVCBtn.enabled = NO;
//            NSTimeInterval timeInterval = 1.0;
//            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setTitle) userInfo:nil repeats:YES];
//        }else{
//            NSString* errorMsg = [error.userInfo objectForKey:@"getVerificationCode"];
//            [CRToastUtil showAttentionMessageWithText:errorMsg];
//        }
        
        if (response.success) {
            [CRToastUtil showPublicMessageWithText:@"验证码已发送到你的手机"];
            validateFlag = 60; // 重置倒计时
            _uiGetVCBtn.enabled = NO;
            NSTimeInterval timeInterval = 1.0;
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setTitle) userInfo:nil repeats:YES];
        }else{
            [CRToastUtil showAttentionMessageWithText:response.errorMsg];
        }
    }];
}

// 弹出地址选择框
- (IBAction)uiChooseAddressBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (!self.addressView) {
        self.addressView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height)];
        [self.addressView xmlData];
        [self.addressView addTitleView];
    }
    
    __weak __typeof(self)weakSelf = self;
    weakSelf.addressView.block = ^(Provice* _Nullable provice, AddCity* _Nullable city, Country* _Nullable county, Town* _Nonnull town){
        weakSelf.provice = provice;
        weakSelf.addCity = city;
        weakSelf.county = county;
        weakSelf.town = town;
        [weakSelf.uiAddressTextField setText:[NSString stringWithFormat:@"%@ %@ %@ %@",provice.name,city.name,county.name,town.name]];
        weakSelf.sType = nil;
        [weakSelf.uiType setText:@""];
        
    };
    [self.addressView showView:self.view];
}

// 弹出机构用户选择框
- (IBAction)uiChooseTypeBtnAction:(id)sender {
    // 选择地址
    [self.view endEditing:YES];
    if (!self.town){
        [CRToastUtil showAttentionMessageWithText:@"请先选择所在单位的省市/区县/乡镇!"];
    }else{
        NSMutableArray* tempArray = [NSMutableArray new];
        for (int i=0; i<self.orgYunArray.count; i++) {
            NSString* tname = [self.orgYunArray objectAtIndex:i];
            if ([tname isEqualToString:@"市级管理员"] &&([self.provice.name isEqualToString:@"北京市"]
                || [self.provice.name isEqualToString:@"上海市"]
                || [self.provice.name isEqualToString:@"天津市"]
                || [self.provice.name isEqualToString:@"重庆市"])) {
                // 删除市级
                continue;
            }
            [tempArray addObject:tname];
        }
        
        [self.regionPickerView showPickerWithSelectName:_uiType.text selectArray:tempArray];
    }
}

- (IBAction)uiChooseCompanyBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (!self.town){
        [CRToastUtil showAttentionMessageWithText:@"请先选择所在单位的省市/区县/乡镇!"];
    }else{
        ChooseCompanyViewController* ccVC = [ChooseCompanyViewController new];
        ccVC.town_code = self.town.code;
        ccVC.delegate = self;
        [self.navigationController pushViewController:ccVC animated:YES];
    }
}

- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName) {
            __strong typeof(wself) self = wself;
            self.uiType.text = provinceName;
            self.sType = [self.orgYunDict objectForKey:provinceName];
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}

// 检查登录输入
-(BOOL)checkSubMitInput{
    if ([_uiNameTextField.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入科普员姓名!"];
        return NO;
    }
    if ([_uiAddressTextField.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请选择所在单位的省市/区县/乡镇!"];
        return NO;
    }
//    if ([_uiDetailAddress.text isEmptyOrWhitespace]) {
//        [CRToastUtil showAttentionMessageWithText:@"请输入所在单位详细地址!"];
//        return NO;
//    }
    if ([_uiCompany.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入所属单位名称!"];
        return NO;
    }
    if ([_uiType.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请选择科普员类型!"];
        return NO;
    }
    //    if ([_uiEmail.text isEmptyOrWhitespace]) {
    //        [CRToastUtil showAttentionMessageWithText:@"请输入科普员邮箱!"];
    //        return NO;
    //    }
    //    if ([_uiCardIDTextField.text isEmptyOrWhitespace]) {
    //        [CRToastUtil showAttentionMessageWithText:@"请输入身份证号码!"];
    //        return NO;
    //    }
    //===========
    //    if (_uiRecommendPeoTelephoneTextField.text.length!=0)
    //    {
    //        if (![self valiMobile:_uiRecommendPeoTelephoneTextField.text]) {
    //            [CRToastUtil showAttentionMessageWithText:@"请输入正确的推荐人手机号!"];
    //            return NO;
    //        }
    //    }
    //    //============
    //    if (![self valiMobile:_uiTelephoneNumTextField.text]) {
    //        [CRToastUtil showAttentionMessageWithText:@"请输入正确的科普员手机号!"];
    //        return NO;
    //    }
    //    if ([_uiVCCodeTextField.text isEmptyOrWhitespace]) {
    //        [CRToastUtil showAttentionMessageWithText:@"请输入验证码!"];
    //        return NO;
    //    }
    return YES;
}
//邮箱验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//判断手机号码格式是否正确
-(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
// 倒计时
-(void)setTitle{
    validateFlag --;
    NSString *title = [NSString stringWithFormat:@"剩余%d秒",validateFlag];
    if (validateFlag == 0) {
        //停止定时器
        [timer invalidate];
        
        [_uiGetVCBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        //按钮可用
        _uiGetVCBtn.enabled = YES;
    }else{
        [_uiGetVCBtn setTitle:title forState:UIControlStateNormal];
        _uiGetVCBtn.enabled = NO;
    }
}

#pragma mark - textFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.uiNameTextField) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
    if (textField == self.uiCardIDTextField) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == self.uiRecommendPeoTelephoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.uiTelephoneNumTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.uiVCCodeTextField) {
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)setCompanyData:(NSString*)companyName{
    [self.uiCompany setText:companyName];
}
@end
