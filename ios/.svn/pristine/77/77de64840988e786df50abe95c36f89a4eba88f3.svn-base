//
//  AskQuesViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#define MAX_STARWORDS_LENGTH 22.0f

#import "AskQuesViewController.h"
#import "BRPlaceholderTextView.h"
#import "ZLPhoto.h"
#import "FSMediaPicker.h"
#import "QNCustomUploadManager.h"
#import "QNKeyHelper.h"
#import "SelectQuesCategoryViewController.h"

@interface AskQuesViewController ()<ZLPhotoPickerBrowserViewControllerDelegate,FSMediaPickerDelegate,SelectQuesCategoryDelegate>

@property (weak, nonatomic) IBOutlet UIView *uiTitleBgView;
@property (weak, nonatomic) IBOutlet UIView *uiCategoryBgView;
@property (weak, nonatomic) IBOutlet UIView *uiDescBgView;
@property (weak, nonatomic) IBOutlet UITextField *uiTitleFD;
@property (weak, nonatomic) IBOutlet UILabel *uiCategoryLab;
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *uiDescTextView;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_scroll;

@property (nonatomic, strong) NSMutableArray* imageViewArray;
@property (nonatomic, strong) NSMutableArray* showImgArray;
@property (nonatomic, strong) QuestionCategory* category;

@end

@implementation AskQuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提问";
    
    // 1、初始化界面和变量属性
    [self initViewAndConAttribute];
    
    // 2、控制字数输入限制的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.uiTitleFD];
}

#pragma mark - 初始化界面和变量属性
- (void)initViewAndConAttribute{
    // 1、界面元素设置
    self.uiTitleBgView.layer.borderColor = [UIColor colorWithHex:0xE5E5E5].CGColor;
    self.uiTitleBgView.layer.borderWidth = 0.5;
    
    self.uiCategoryBgView.layer.borderColor = [UIColor colorWithHex:0xE5E5E5].CGColor;
    self.uiCategoryBgView.layer.borderWidth = 0.5;
    
    self.uiDescBgView.layer.borderColor = [UIColor colorWithHex:0xE5E5E5].CGColor;
    self.uiDescBgView.layer.borderWidth = 0.5;
    
    self.uiDescTextView.placeholder = @"提问内容";
    [self.uiDescTextView setPlaceholderFont:FONT_15];

    self.leadingEdge_scroll.constant = self.leftEdge;
    self.conScrollViewWidth.constant = self.showWidth;
    self.conScrollViewHeight.constant = 504;
    
    // 2、初始化常量
    _imageViewArray = [NSMutableArray new];
    _showImgArray = [NSMutableArray new];
    
    
}

#pragma mark - 点击事件(手势和按钮)
- (IBAction)clickSelectImgGesAction:(id)sender {
    [self.view endEditing:YES];
    if (_imageViewArray.count > 0) {
        [_showImgArray removeAllObjects];
        for ( int i=0; i<_imageViewArray.count; i++) {
            NSObject* obj = [_imageViewArray objectAtIndex:i];
            if (![obj isKindOfClass:[NSString class]]) {
                ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                if([obj isKindOfClass:[UIImage class]]){
                    photo.photoImage = (UIImage*)obj;
                }
                
                [_showImgArray addObject:photo];
            }
        }
        
        [self setupPhotoBrowser:[NSIndexPath indexPathForRow:0 inSection:0]];
    }else{
        FSMediaPicker *picker = [[FSMediaPicker alloc] init];
        picker.delegate = self;        
        if (isIpad) {
            [picker showFromView:self.uiImageView];
        } else {
            [picker showFromView:self.view];
        }
        
    }
}

- (IBAction)clickSelectCategoryGesAction:(id)sender {
    [self.view endEditing:YES];
    SelectQuesCategoryViewController* selectQuesCategory = [SelectQuesCategoryViewController new];
    selectQuesCategory.delegate = self;
    [self.navigationController pushViewController:selectQuesCategory animated:YES];
}

- (IBAction)clickSumbitBtnAction:(id)sender {
    [self.view endEditing:YES];
    if ([self checkData]) {
        // 数据验证合适，保存数据
        [SVProgressHUDUtil showWithStatus:@"正在提交..."];
        if (self.imageViewArray.count > 0) {
            UIImage* image = [self.imageViewArray objectAtIndex:0];
            // 上传七牛云
            [QNCustomUploadManager uploadImage:image imgKey:[QNKeyHelper getQNKey:[NSString stringWithFormat:@"%@%@", @"QU",[[MemberManager sharedInstance]memberId]]  suffix:nil] maxSize:CGSizeMake(1080, 1920) success:^(NSString *imageName) {
                // 保存提问
                [self saveQues:imageName];
            } failure:^{
                [SVProgressHUDUtil showErrorWithStatus:@"网络不太顺畅！"];
            }];
        }else{
            [self saveQues:nil];
        }
    }
}

- (void)saveQues:(NSString*)qu_img{
    [[WebAccessManager sharedInstance]saveQuestionsWithQu_title:self.uiTitleFD.text qu_content:self.uiDescTextView.text qu_img:qu_img te_id:self.category.te_id completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            [SVProgressHUDUtil showSuccessWithStatus:@"提交问题成功！" completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [SVProgressHUDUtil showErrorWithStatus:@"提交问题失败，请稍后重试！"];
        }
    }];
}

#pragma mark - 自定义方法
- (BOOL)checkData{
    if ([self.uiTitleFD.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入提问标题!"];
        return NO;
    }
    
    if (!self.category) {
        [CRToastUtil showAttentionMessageWithText:@"请选择问题分类!"];
        return NO;
    }
    
    if ([self.uiTitleFD.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入问题描述!"];
        return NO;
    }
    
    return YES;
}

#pragma mark - FSMediaPickerDelegate
- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    [self.imageViewArray removeAllObjects];
    [self.imageViewArray addObject:mediaInfo.editedImage];
    [self.uiImageView setImage:mediaInfo.editedImage];
}

#pragma mark - ZLPhotoPickerBrowserViewController,ZLPhotoPickerBrowserViewControllerDelegate
- (void) setupPhotoBrowser:(NSIndexPath *)indexPath{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    pickerBrowser.delegate = self;
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = _showImgArray;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser didCurrentPage:(NSUInteger)page{
    //[self.view setContentOffset:CGPointMake(0, 95 * page)];
}

// 删除调用
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    // 删除照片时调用
    if (indexPath.row > [_showImgArray count])
        return;
    // 删除调用的照片
    [_imageViewArray removeAllObjects];
    
    [self.uiImageView setImage:[UIImage imageNamed:@"上传图片"]];
}

#pragma mark - SelectQuesCategoryDelegate
- (void)selectCategory:(QuestionCategory*)category{
    self.category = category;
    [self.uiCategoryLab setText:category.te_title];
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

// - Notification Method
-(void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - TextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        // 判断输入的字是否是回车，即按下return
        [self.view endEditing:YES];
        
        return NO;
    }else{
        if (range.location>=200)
        {
            return  NO;
        }
        else
        {
            return YES;
        }
    }
}

@end
