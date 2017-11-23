//
//  MusicDetialViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/11/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MusicDetialViewController.h"
#import "MusicDetialCollectionViewCell.h"

#import "DZPlayerToolBar.h"
#import "MJExtension.h"
#import "DZMusic.h"
#import "DZMusicTool.h"
//#import "AppDelegate.h"
#import "UIView+Frame.h"
#import "NSString+time.h"


@interface MusicDetialViewController ()<UIGestureRecognizerDelegate, DZPlayerToolBarDelegate, AVAudioPlayerDelegate>
{
    CGRect leftViewLeftFrame;//左视图在左边时位置
    CGRect leftViewRightFrame;//左视图在右边时位置
}

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* activity_list; // 数据

@property (nonatomic, strong)UIImageView *loadImageView;

@property (weak, nonatomic) IBOutlet UIImageView *UIimageView;
@property (weak, nonatomic) IBOutlet UILabel *UITitile;
@property (weak, nonatomic) IBOutlet UILabel *UIcollect;
@property (weak, nonatomic) IBOutlet UILabel *UIintro;
@property (weak, nonatomic) IBOutlet UIButton *UIdisBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIbottomConstraint;

/**
 *  当前播放音乐的索引
 */
@property (nonatomic, assign) NSInteger musicIndex;

/**
 *  音乐数据
 */
@property (nonatomic, strong) NSArray *musics;

/**
 *  播放工具条
 */
@property (nonatomic, weak) DZPlayerToolBar *playerToolBar;

@property (nonatomic, strong)ShareModel* shareModel;
@end

@implementation MusicDetialViewController

#pragma mark - 懒加载
-(NSArray *)musics{
    if (_musics == nil) {
        _musics = [DZMusic mj_objectArrayWithFilename:@"songs.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化数据
    [self initData];
    [self setupLoadingView];
    
    //    [self setupView];
    
    // 2、注册CollectionView
    [self initCollectionView];
    
    // 3、加载数据
    [self loadeData];
    
//    [self playMusic:nil];
    
    //设置appdelegate的block
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.myRemoteEventBlock = ^(UIEvent *event){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [[DZMusicTool sharedDZMusicTool] play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [[DZMusicTool sharedDZMusicTool] pause];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self previous];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self next];
                break;
                
            default:
                break;
        }
    };
    
//    [self.paceSlider setThumbImage:[UIImage imageNamed:@"Slider_控制点"] forState:UIControlStateNormal];
}

#pragma mark 播放
-(void)playMusic:(DZMusic *)music{
    //2.重新初始化一个"播放器"
    [[DZMusicTool sharedDZMusicTool] prepareToPlayWithMusic:music];
    //设置player的代理
//    [DZMusicTool sharedDZMusicTool].player.delegate = self;
    //3.更改"播放器工具条"的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
    
    //4.播放
    if (self.playerToolBar.isPlaying) {
        [[DZMusicTool sharedDZMusicTool] play];
    }
}

#pragma mark - DZPlayerToolBarDelegate methods
-(void)playerToolBar:(DZPlayerToolBar *)toolBar btnClickWithType:(BtnType)btnType{
    //实现播放,把播放功能操作放在一个工具类中
    switch (btnType) {
        case BtnTypePlay:
            [[DZMusicTool sharedDZMusicTool] play];
            NSLog(@"play");
            break;
        case BtnTypePause:
            [[DZMusicTool sharedDZMusicTool] pause];
            NSLog(@"pause");
            break;
        case BtnTypePrevious:
            [self previous];
            NSLog(@"pre");
            break;
        case BtnTypeNext:
            [self next];
            NSLog(@"next");
            break;
        default:
            break;
    }
}

#pragma mark 播放上一首
-(void)previous{
    //1.更改播放音乐的索引
    if (self.musicIndex == 0) {
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex--;
    }
    [self playMusic:nil];
}

#pragma mark 播放下一首
-(void)next{
    //1.更改播放音乐的索引
    if (self.musicIndex == self.musics.count - 1) {
        self.musicIndex = 0;
    }else{
        self.musicIndex++;
    }
    [self playMusic:nil];
}

#pragma mark - 重写父类方法属性
- (BOOL)showNavBar{
    return NO;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化界面和数据
-(void)initData{
    
    //添加播放的工具条
    DZPlayerToolBar *toolBar = [DZPlayerToolBar playerToolBar];
    toolBar.delegate = self;
    //设置toolBar的尺寸
//    toolBar.bounds = self.bottomView.bounds;
    [self.bottomView addSubview:toolBar];
    [self.bottomView layoutIfNeeded];
    self.playerToolBar.playing = false;
    self.playerToolBar = toolBar;
    
    self.page = 1;
    self.activity_list = [NSMutableArray new];
    self.musicIndex = -1;
    
    [self.UIimageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
}

#pragma mark - 初始化界面和数据
-(void)setupView{
    
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 20);
    [rightNavBtn setTitle:@"分 享" forState:UIControlStateNormal];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

// 右侧导航点击事件
-(void)rightNavBtn{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:_shareModel completion:nil];
}

-(void)setupLoadingView{
    self.uiCollectionView.hidden=YES;
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    //_loadImageView.hidden = YES;
    [self.view addSubview:_loadImageView];
    [self.view insertSubview:_loadImageView atIndex:0];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
}
#pragma mark - 加载网络数据
-(void)loadeData{
    self.UIbottomConstraint.constant = 0;
    self.uiCollectionView.hidden=NO;
     [self.uiCollectionView reloadData];
//    [[WebAccessManager sharedInstance]fourthGetActivitySpecialListWithPage:self.page completion:^(WebResponse *response, NSError *error) {
//        self.uiCollectionView.hidden=NO;
//        self.loadImageView.hidden=YES;
//        [self.uiCollectionView.mj_footer endRefreshing];
//        [self.uiCollectionView.mj_header endRefreshing];
//
//        if (response.success) {
//            if (self.page == 1) {
//
//                if (response.data.share_info) {
//                    // 设置分享对象
//                    self.shareModel = [ShareModel new];
//                    self.shareModel.in_share_contentURL = response.data.share_info.share_url;
//                    self.shareModel.in_share_imageURL  = response.data.share_info.share_image_url;
//                    self.shareModel.in_share_title  = response.data.share_info.share_title;
//                    self.shareModel.in_share_desc  = response.data.share_info.share_desc;
//                }
//
//                self.activity_list = response.data.special_activity_list;
//
//                [self.uiCollectionView reloadData];
//            }else{
//                if (response.data.activity_list.count > 0) {
//
//                    [self.activity_list addObjectsFromArray:[response.data.activity_list copy]];
//
//                    [self.uiCollectionView reloadData];
//                }else{
//                    // 没有数据了
//                    self.page -= 1;
//                    [SVProgressHUDUtil showInfoWithStatus:@"暂无更多信息"];
//                }
//            }
//        }else{
//            self.page -= 1;
//            [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
//        }
//    }];
}

#pragma mark - UICollectionView Datasource, Delegate
- (void)initCollectionView{
    // 1. 设置Collection 的 CollectionViewCell
    [self.uiCollectionView registerNib:[UINib nibWithNibName:[MusicDetialCollectionViewCell ID] bundle:nil] forCellWithReuseIdentifier:[MusicDetialCollectionViewCell ID]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.musics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ScienceActivity* spsa = [self.activity_list objectAtIndex:indexPath.row];
    MusicDetialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MusicDetialCollectionViewCell ID] forIndexPath:indexPath];
    if(self.musicIndex == indexPath.row){
        [cell setCellWithHomeModel:nil isShow:YES];
    }else{
        [cell setCellWithHomeModel:nil isShow:NO];
    }
   
    return cell;
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    if (self.playerToolBar.isPlaying == NO) {
    //        self.playerToolBar.playing = YES;
    //    }
    //播放音乐
//    self.musics[self.musicIndex]
    self.UIbottomConstraint.constant = 70;
    [UIView animateWithDuration:10 animations:^{
        [self.bottomView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    if(!self.playerToolBar.isPlaying||self.musicIndex!=indexPath.row){
        
        //更改索引
        self.musicIndex = indexPath.row;
        
        DZMusic *music= [[DZMusic alloc] init];
        music =self.musics[self.musicIndex];
        [self playMusic:music];
    }
    
//    if (currentPlayTime!=nil&&[[NSString convertTime:currentPlayTime] isEqualToString:@"00:00"] ) {
//        DZMusic *music= [[DZMusic alloc] init];
//        music =self.musics[self.musicIndex];
//        [self playMusic:music];
//    }

    [self.uiCollectionView reloadData];
    
//     [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_MUSIC_PLAY object:nil];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   return CGSizeMake(kSCREEN_WIDTH,60);
}

- (void)collectionViewRefreshHeaderData{
    _page = 1;
    [self loadeData];
}

- (void)collectionViewRefreshFooterData{
    _page += 1;
    [self loadeData];
}

#pragma mark - 工具类


#pragma mark - Deleate
- (IBAction)clickBtn:(id)sender {
    [[DZMusicTool sharedDZMusicTool] pause];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - AVAudioPlayerDelegate methods
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //自动播放下一首
    [self next];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //    [self setRotatingViewFrame];
}

//隐藏播放工具栏
-(void)hidebottom{
    self.UIbottomConstraint.constant = 0;
    [UIView animateWithDuration:10 animations:^{
        [self.bottomView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

-(void)endNowMusicPlay:(DZMusic*)playingMusic{
    [self playMusic:playingMusic];
}

@end
