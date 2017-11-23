//
//  PicturesDetailViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "PicturesDetailViewController.h"
#import "PicDetailCollectionViewCell.h"
#import "RecCollectionViewCell.h"
#import "InfoObj.h"
#import "BottomOperationView.h"
#import "TextUtil.h"

#define BaseBottomViewHeight 167.0f

@interface PicturesDetailViewController ()<BottomOperationViewDelegate,PicDetailCollectDelegate, RecPicCollectionDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *uiPicCollectionView;
@property (weak, nonatomic) IBOutlet UIView *uiOperationView;
@property (weak, nonatomic) IBOutlet UIView *uiBottomView;
@property (weak, nonatomic) IBOutlet UIView *uiDownloadView;

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiContentLab;
@property (weak, nonatomic) IBOutlet UILabel *uiImgCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiOtherImgCountLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conOperationViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conBottomViewBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiBottomViewHeight;

@property (nonatomic, strong)NSString* commentCount;
@property (nonatomic, strong)NSMutableArray* imgArray;
@property (nonatomic, strong)NSMutableArray* recArray; // 推荐图集列表，后台默认传过来5个
@property (nonatomic, strong)BottomOperationView* operationView;
@property (nonatomic, strong)ShareModel* shareModel;
@property BOOL isHeightShow; // 底部视图是否适配字体高度显示
@property BOOL isShowBottomView; // 底部视图是否心事
@property NSInteger lastIndex; // 上次显示的图片索引

@end

@implementation PicturesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、初始化CollectionView和数组
    [self initCollectionView];
    _recArray = [NSMutableArray new];
    
    // 1.1、默认描述文字底部视图是显示的
    self.isShowBottomView = YES;
    self.isHeightShow = NO;
    self.lastIndex = 0;
    
    // 2、网络加载数据
    [self loadNetWorkData:NO];
    
    // 3. 添加评论界面
    self.operationView = [BottomOperationView newNib];
    self.operationView.delegate = self;
    [self.uiOperationView addSubview:self.operationView];
    [self.uiOperationView layoutIfNeeded];
    
    // 4、注册通知
    [self registerNotice];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 获取当前ScrollView的偏移量
    int page = self.uiPicCollectionView.contentOffset.x / kSCREEN_WIDTH;
    if (page == _imgArray.count && _imgArray.count != 0 ) {
        // 进来的时候是最后一个页面也就是推荐页面，则不显示底部视图
        self.uiBottomView.hidden = YES;
        self.uiDownloadView.hidden = YES;
        self.isShowBottomView = NO;
        self.lastIndex = page;
    }
}

#pragma mark - 重写父类方法
- (BOOL)showNavBar{
    return NO;
}

#pragma mark - 注册通知
-(void)registerNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData:) name:kNOTOICE_REFRESH_PICVIEW_INFO object:nil];
}

- (void)refreshData:(NSNotification*)notification{
    [self loadNetWorkData:YES];
}

#pragma mark - 加载网络数据
-(void)loadNetWorkData:(BOOL)isRefreshComment{
    if (!isRefreshComment) {
        self.uiPicCollectionView.hidden = YES;
        self.uiBottomView.hidden = YES;
        self.uiDownloadView.hidden = YES;
    }
    // 1、加载图集资讯
    [[WebAccessManager sharedInstance]getPicInfoDetailWithIn_id:self.in_id completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.uiPicCollectionView.hidden = NO;
            self.uiBottomView.hidden = NO;
            self.uiDownloadView.hidden = NO;
            // 获取图集详情
            if (isRefreshComment) {
                self.commentCount = response.data.informationImgsInfo.in_reviewCount;
                [self.operationView initViewDataWithInfo:response.data.informationImgsInfo];
            }else{
                // 1、刷新CollectionView(图片视图+推荐视图)
                self.imgArray = response.data.informationImgsInfo.imgList;
                self.recArray = response.data.recommendList;
                [self.uiPicCollectionView reloadData];
                
                // 2、刷新底部视图
                self.commentCount = response.data.informationImgsInfo.in_reviewCount;
                [self.operationView initViewDataWithInfo:response.data.informationImgsInfo];
                
                // 3、初始化首次显示的内容
                if (self.imgArray.count > 0) {
                    InfoObj* firstObj = [self.imgArray objectAtIndex:0];
                    [_uiTitleLab setText:firstObj.in_title];
                    [_uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:firstObj.in_content]];
                    [_uiImgCountLab setText:[NSString stringWithFormat:@"%d /%ld", 1, (unsigned long)self.imgArray.count]];
                    [_uiOtherImgCountLab setText:[NSString stringWithFormat:@"%d /%ld", 1, (unsigned long)self.imgArray.count]];
                }
            }
            
            // 4、设置分享对象
            self.shareModel = [ShareModel new];
            self.shareModel.in_share_contentURL = response.data.informationImgsInfo.in_share_contentURL;
            self.shareModel.in_share_imageURL  = response.data.informationImgsInfo.in_share_imageURL;
            self.shareModel.in_share_title  = response.data.informationImgsInfo.in_share_title;
            self.shareModel.in_share_desc  = response.data.informationImgsInfo.in_share_desc;
            self.shareModel.share_type = @"05";
            self.shareModel.ar_id = self.in_id;
        }else{
            // 加载失败，调用默认加载失败页面
        }
    }];
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiPicCollectionView registerNib:[UINib nibWithNibName:[PicDetailCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[PicDetailCollectionViewCell ID]];
    [self.uiPicCollectionView registerNib:[UINib nibWithNibName:[RecCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[RecCollectionViewCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // 最后一个为推荐图集
    if (self.recArray && self.recArray.count > 0) {
        return _imgArray.count + 1;
    }else{
        return _imgArray.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] < _imgArray.count) {
        InfoObj* info = [_imgArray objectAtIndex:[indexPath section]];
        PicDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PicDetailCollectionViewCell ID] forIndexPath:indexPath];
        cell.delegate = self;
        [cell initCellData:info index:indexPath.section totalCount:_imgArray.count];
        return cell;
    }else{
        RecCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecCollectionViewCell ID] forIndexPath:indexPath];
        cell.delegate = self;
        cell.recArray = self.recArray;
        cell.commentCount = self.commentCount;
        return cell;
    }
    
    return  nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] < _imgArray.count) {
        [self showOrHiddlenBottomView];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT - self.conOperationViewHeight.constant);
}

#pragma mark - 自定义方法
// 点击图片之后显示和隐藏底部视图
- (void)showOrHiddlenBottomView{
    if (self.uiBottomView.hidden) {
        // 原来隐藏的话则显示底部视图
        self.uiBottomView.hidden = NO;
        [self.view setBackgroundColor:[UIColor colorWithHex:0x222222]];
        _isShowBottomView = YES;
    }else{
        // 原来显示的话则隐藏底部视图
        self.uiBottomView.hidden = YES;
        [self.view setBackgroundColor:[UIColor colorWithHex:0x000000]];
        _isShowBottomView = NO;
    }
}

// 保存图片
- (void)saveImage{
    // 1、获取Image
    NSInteger currentIndex = [[self.uiPicCollectionView indexPathsForVisibleItems][0] section];
    InfoObj* info = [_imgArray objectAtIndex:currentIndex];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[info.in_img_urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (!image) {
        // 图片不存在，下载之后保存
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:info.in_img_urls] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }];
    }else{
        // 图片存在，直接保存
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

// 保存图片到相册的回调方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUDUtil showInfoWithStatus:@"保存失败"];
    }else{
        [SVProgressHUDUtil showSuccessWithStatus:@"保存成功"];
    }
}

#pragma mark - PicDetailCollectDelegate - 点击某个图片的回调方法
- (void)showPhotoBrowserIndex:(NSInteger)index{
    // 点击某个图片可进行隐藏或者显示底部视图
    [self showOrHiddlenBottomView];
}

#pragma mark - BottomOperationViewDelegate - 操作视图的代理
- (void)didBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didToCommentList{
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:self.in_id completion:nil];
}

- (void)didToLoginView{
    [FlowUtil presentToLoginAndRegisterVCWithNav:self.navigationController  toRegister:false isShowAlertYinDao:NO  completion:nil];
}

- (void)didShare{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

#pragma mark - 点击按钮手势事件
- (IBAction)clickDescView:(id)sender {
    // 获取当前有效的CollectionViewCell的index
    NSInteger currentIndex = [[self.uiPicCollectionView indexPathsForVisibleItems][0] section];
    
    InfoObj* info = [_imgArray objectAtIndex:currentIndex];
    // 获取数据，计算内容高度
    CGSize size = [TextUtil boundingRectWithText:info.in_content lineSpace:3 size:CGSizeMake(kSCREEN_WIDTH - 20, 0) Font:_uiContentLab.font];
    // 52为底部操作视图 40为顶部Title 15的字体加上上下间距, 20为底部留出的距离
    CGFloat actualHeight = 52 + 40 + size.height + 20;
    
    if (_isHeightShow) {
        self.uiBottomViewHeight.constant = BaseBottomViewHeight;
        [UIView animateWithDuration:0.5 animations:^{
            [self.uiBottomView layoutIfNeeded];
        } completion:^(BOOL finished) {
            _isHeightShow = NO;
        }];
    }else{
        if (actualHeight < BaseBottomViewHeight) {
            return;
        }
        self.uiBottomViewHeight.constant = actualHeight;
        [UIView animateWithDuration:0.5 animations:^{
            [self.uiBottomView layoutIfNeeded];
        } completion:^(BOOL finished) {
            _isHeightShow = YES;
        }];
    }
}

- (IBAction)clickDownloadImage:(id)sender {
    [self saveImage];
}

#pragma mark - RecCollectionCell Delegate
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRecViewWithInfo:(InfoObj*)info{
    // 跳转
    if ([info.in_classify isEqualToString:@"0"] || [info.in_classify isEqualToString:@"4"]) {
        // 图文、文字
        [FlowUtil startToPicTextInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
    }else if([info.in_classify isEqualToString:@"1"]){
        // 图集
        [FlowUtil startToPicDetailInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
    }else if([info.in_classify isEqualToString:@"2"]){
        // 视频
        [FlowUtil startToVideoInfoDetailVCNav:self.navigationController in_id:info.in_id completion:nil];
    }else if([info.in_classify isEqualToString:@"3"]){
        // 专题
        // TODO ELLISON
        DLog(@"===========专题跳转============");
        [FlowUtil startToTopicSubListVCNav:self.navigationController in_id:info.in_id];
    }
}

- (void)clickShareBtn{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:self.shareModel completion:nil];
}

- (void)clickCommentCountBtn{
    [FlowUtil startToCommentListVCNav:self.navigationController in_id:self.in_id completion:nil];
}

#pragma mark - UIScrollView Delegate
// 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

// 滑动停止代理
- ( void )scrollViewDidEndDecelerating:( UIScrollView  *)scrollView
{
    int page = scrollView.contentOffset.x / kSCREEN_WIDTH;
    if (page < _imgArray.count) {
        // 1、当前滑动的页数为正常图片显示
        if (self.lastIndex == _imgArray.count) {
            // 1.1、当前一次所属的页数为推荐图集的时候，根据前面图片显示的模式，设置之前的显示模式
            self.uiDownloadView.hidden = NO; // 显示底部下载视图
            if (_isShowBottomView) {
                // 若滑动到推荐视图之前，底部描述视图是显示的，则继续显示，并设置背景色为222222
                self.uiBottomView.hidden = NO;
                [self.view setBackgroundColor:[UIColor colorWithHex:0x222222]];
            }else{
                // 若滑动到推荐视图之前，底部描述视图是不现实的，则说明之前只显示下载视图，则将底部视图隐藏，并设置显示背景色为000000
                self.uiBottomView.hidden = YES;
                [self.view setBackgroundColor:[UIColor colorWithHex:0x000000]];
            }
        }
        
        // 2、设置描述视图的内容
        InfoObj* info = [_imgArray objectAtIndex:page];
        [_uiTitleLab setText:info.in_title];
        [_uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:info.in_content]];
        [_uiImgCountLab setText:[NSString stringWithFormat:@"%d /%ld", (page + 1), (unsigned long)self.imgArray.count]];
        [_uiOtherImgCountLab setText:[NSString stringWithFormat:@"%d /%ld", (page + 1), (unsigned long)self.imgArray.count]];
        
        // 3、每次滚动将BottomView的高度设置为基本的高度，并设置底部视图是否适配高度显示为不适配
        self.uiBottomViewHeight.constant = BaseBottomViewHeight;
        _isHeightShow = NO;
    }else{
        // 滑动为推荐视图，则隐藏底部所有视图，并设置背景色为000000
        self.uiBottomView.hidden = YES;
        self.uiDownloadView.hidden = YES;
        [self.view setBackgroundColor:[UIColor colorWithHex:0x000000]];
    }
    
    // 设置当前页数为之前页数的代理
    self.lastIndex = page;
}

@end
