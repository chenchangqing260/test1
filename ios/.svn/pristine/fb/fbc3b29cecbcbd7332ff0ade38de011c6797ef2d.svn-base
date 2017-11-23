//
//  EStationCertificationViewController.m
//  ScienceChina
//
//  Created by touf on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "EStationCertificationViewController.h"
#import "ChannelListModel.h"
#import "OrganizationTypeListModel.h"
#import "estationDataModel.h"
#import "AddChannelViewController.h"

@interface EStationCertificationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,returnDataDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *uiTextView;
@property (weak, nonatomic) IBOutlet UITextField *uiNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *uiUpLoadHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *uiChannelTypeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTextViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewWidth;

@property (strong, nonatomic) NSMutableArray *hadselectedArr;
@property (strong, nonatomic) NSMutableArray *allchannelArr;

@property (strong, nonatomic) UIImage *headImg;

@property (strong, nonatomic) IBOutlet UIView *uiChooseView;
@property (weak, nonatomic) IBOutlet UIView *uiChooseViewBackGroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *uiChooseScrollView;
@property (weak, nonatomic) IBOutlet UIView *uiChooseViewBtnView;

@property (strong, nonatomic) NSMutableArray *OrganizationTypesArr;
@end

@implementation EStationCertificationViewController
{
    NSString *selfot_id;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基站认证";
    
    [_uiNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _hadselectedArr = [NSMutableArray new];
    _allchannelArr = [NSMutableArray new];
    _OrganizationTypesArr = [NSMutableArray new];
    [self initView];
    [self getAllOrganizationTypes];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([_uiChannelTypeLabel.text isEqualToString:@"请选择基站分类"])
    {
        _uiChannelTypeLabel.textColor = [UIColor lightGrayColor];
    }
    else
    {
        _uiChannelTypeLabel.textColor = [UIColor blackColor];
    }
}
#pragma mark - initView
- (void)initView
{
    _conContentViewWidth.constant = kSCREEN_WIDTH;
    _conContentViewHeight.constant = 550;
    
    _uiChooseViewBackGroundView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:0.5];
    _uiChooseView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:0.5];
    _uiChooseViewBtnView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    _uiChooseScrollView.backgroundColor = [UIColor colorWithHex:0xffffff alpha:1];
    _uiChooseView.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [self.view addSubview:_uiChooseView];
    //_uiChooseView.hidden=1;
    
    _uiTextView.layer.borderColor=[UIColor colorWithHex:0xeeeeee].CGColor;
    _uiTextView.layer.borderWidth=0.5;
    _uiTextView.layer.cornerRadius = 1;
}

#pragma mark - loadData
- (void)getAllOrganizationTypes
{
    [[WebAccessManager sharedInstance]getAllOrganizationTypesWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success)
        {
            int i = 0;
            _OrganizationTypesArr = response.data.organizationTypeList;
            for (OrganizationTypeListModel *model in response.data.organizationTypeList) {
                UIButton *orbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, kSCREEN_WIDTH, 40)];
                [orbtn setTitle:model.ot_name forState:UIControlStateNormal];
                [orbtn addTarget:self action:@selector(orbtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [orbtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
                [orbtn setTitleColor:[UIColor lightGrayColor] forState:normal];
                orbtn.titleLabel.font = [UIFont systemFontOfSize:14];
                orbtn.tag=i+999;
                [_uiChooseScrollView addSubview:orbtn];
                i++;
            }
            _uiChooseScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 40*i+80);
        }
        else
        {
            [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
        }
    }];
}

#pragma mark - btnAction
- (void)orbtnAction:(UIButton *)sender
{
    DLog(@"%ld",(long)sender.tag-999);
    if (sender.selected)
    {
        sender.selected=NO;
    }
    else
    {
        sender.selected=YES;
    }
    
    for (UIView *v in _uiChooseScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *orbtn = (UIButton *)v;
            if (orbtn.tag != sender.tag) {
                orbtn.selected = NO;
            }
        }
    }
}

- (IBAction)cancleBtnaction:(UIButton *)sender
{
    
    for (UIView *v in _uiChooseScrollView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *orbtn = (UIButton *)v;
            orbtn.selected = NO;
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        _uiChooseView.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        //_uiChooseView.hidden=1;
    }];
}
- (IBAction)uiSureBtnAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _uiChooseView.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        //_uiChooseView.hidden=1;
    }];
    NSMutableArray *idarr = [NSMutableArray new];
    for (UIView *btn in _uiChooseScrollView.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]])
        {
            UIButton *btn2 = (UIButton *)btn;
            if (btn2.selected)
            {
                [idarr addObject:_OrganizationTypesArr[btn2.tag-999]];
            }
        }
    }
    NSMutableString *mutablestr= [NSMutableString new];
    NSMutableString *mutablestr2= [NSMutableString new];
    for (OrganizationTypeListModel *model in idarr)
    {
        [mutablestr appendString:[NSString stringWithFormat:@"%@,",model.ot_id]];
        [mutablestr2 appendString:[NSString stringWithFormat:@"%@,",model.ot_name]];
    }
    if (mutablestr.length>0)
    {
        selfot_id = [mutablestr substringToIndex:mutablestr.length-1];
    }
    if (mutablestr2.length>0)
    {
        _uiChannelTypeLabel.text = [mutablestr2 substringToIndex:mutablestr2.length-1];
        _uiChannelTypeLabel.textColor = [UIColor blackColor];
    }
    else
    {
        _uiChannelTypeLabel.text = @"请选择基站分类";
        _uiChannelTypeLabel.textColor = [UIColor lightGrayColor];
    }
    NSLog(@"%@",selfot_id);
    
}


- (IBAction)chooseBtnAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    UIActionSheet *actionsheet = [[UIActionSheet alloc]initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册",nil];
    [actionsheet showInView:self.view];
}
- (IBAction)uiNextStepBtnAction:(UIButton *)sender
{
    if ([_uiNameTextField.text isEmptyOrWhitespace])
    {
        [CRToastUtil showAttentionMessageWithText:@"请输入基站名称!"];
        return;
    }
    
    if ([_uiChannelTypeLabel.text isEqualToString:@"请选择基站分类"])
    {
        [CRToastUtil showAttentionMessageWithText:@"请选择基站分类!"];
        return;
    }
    
    if ([_uiTextView.text isEmptyOrWhitespace])
    {
        [CRToastUtil showAttentionMessageWithText:@"请填写基站简介!"];
        return;
    }
    if (!_headImg)
    {
        [CRToastUtil showAttentionMessageWithText:@"请选择基站头像!"];
        return;
    }
    estationDataModel *Stationmodel = [estationDataModel new];
    Stationmodel.name = _uiNameTextField.text;
    Stationmodel.otid = selfot_id;
    Stationmodel.estationTextView = _uiTextView.text;
    Stationmodel.headImg = _headImg;
    
    AddChannelViewController *addChannelVC = [[AddChannelViewController alloc]initWithNibName:nil bundle:nil];
    addChannelVC.delegate = self;
    addChannelVC.estationmodel = Stationmodel;
    addChannelVC.saveDataTag=1;
    addChannelVC.HadSelectChannel = _hadselectedArr;
    [self.navigationController pushViewController:addChannelVC animated:1];
    NSLog(@"%@",_hadselectedArr);
}
- (IBAction)uiCancleBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:1];
}
- (IBAction)uiChooseChannelBtnAction:(UIButton *)sender
{
    [_uiNameTextField resignFirstResponder];
    [_uiTextView resignFirstResponder];
    [UIView animateWithDuration:1 animations:^{
        _uiChooseView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        //_uiChooseView.hidden=0;
    }];
}

#pragma mark - photoPickerDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==0)
    {
        if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * picker=[[UIImagePickerController alloc]init];
            picker.delegate=self;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:1 completion:nil];
        }
    }
    if (buttonIndex==1)
    {
        if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController * picker=[[UIImagePickerController alloc]init];
            picker.delegate=self;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:1 completion:nil];
        }
    }
}
#pragma mark - PhotoPickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
        UIImage * img=(UIImage *)info[UIImagePickerControllerOriginalImage];
        _headImg=img;
        [picker dismissViewControllerAnimated:1 completion:^{
            [_uiUpLoadHeadImg setImage:_headImg forState:UIControlStateNormal];
        }];
}
    
#pragma mark - addchannelView dataCallBackDelegate
-(void)returnWithArr:(NSMutableArray *)arr
{
    [_hadselectedArr removeAllObjects];
    _hadselectedArr = arr;
}

#pragma mark - scrollviewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"aoaoao");
    if (textView.text.length > 200)
    {
        textView.text = [textView.text substringToIndex:200];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 100) {
        textField.text = [textField.text substringToIndex:100];
    }
}

@end
