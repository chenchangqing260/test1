//
//  BaseWebViewController.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/14.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>
{
    UIImageView *_loadImageView;
}
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSString *webUrl;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self setupView];
    [self.webView reload];
}
-(void)initData{
    self.leftEdge = 0;
    self.showWidth = kSCREEN_WIDTH;
    if (isIpad) {
        self.leftEdge = (kSCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        self.showWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
}
-(void)setupView{
    self.title = @"科普中国";
    [self setupDefaultLeftNavBtn];
    
    
    
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    _loadImageView.hidden = YES;
    [self.view addSubview:_loadImageView];
    [self.view insertSubview:_loadImageView atIndex:0];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    
}
-(void)setupDefaultLeftNavBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(defaulLeftNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)resetLeftNavBtn{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@"返回白色"] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [leftNavBtn addTarget:self action:@selector(webGoback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
// 左侧导航点击事件
-(void)defaulLeftNavBtnAction{
    // 改版
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController showLeftController:YES];
}
-(void)webGoback{
    [self.webView goBack];
}

-(UIWebView *)webView{
    if (!_webView) {
        self.leftEdge = 0;
        self.showWidth = kSCREEN_WIDTH;
        if (isIpad) {
            self.leftEdge = (kSCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
            self.showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        }
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        _webView.clipsToBounds = YES;
        [_webView setScalesPageToFit:YES];//网页自适应屏幕
        [_webView.scrollView setContentInset:UIEdgeInsetsMake(0, self.leftEdge, 0, self.leftEdge)];
        [self.view addSubview:_webView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadWeb)];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        // 设置 Header
        _webView.scrollView.mj_header = header;
        
        _webView.scrollView.mj_header.frame = CGRectMake(0, 0, self.showWidth, header.frame.size.height);
    }
    return _webView;
}
-(void)setWebViewHeight:(NSInteger)webViewHeight{
    _webViewHeight = webViewHeight;
    
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.size.height = _webViewHeight;
    self.webView.frame = webViewFrame;
}
-(void)setWebUrl:(NSString *)webUrl{
    _webUrl = webUrl;
    [self reloadWeb];
}
-(void)loadWeiChatUrl{
    self.webUrl = @"http://www.kepuchina.cn/mobile-index/list.html";
}
-(void)loadWeiBoUrl{
    self.webUrl = @"http://m.weibo.cn/p/1005055104880035";
}
-(void)reloadWeb{
    [self.webView reload];
    NSURL *_url = [NSURL URLWithString:self.webUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
    
    //[self.webView.scrollView setContentInset:UIEdgeInsetsMake(0, self.leftEdge, 0, self.leftEdge)];
}
#pragma mark UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
     //[SVProgressHUDUtil showWithStatus:@"正在加载..."];
    _loadImageView.hidden = NO;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取网页标题
    //self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //[SVProgressHUDUtil dismiss];
    if ([self.webView canGoBack]) {
        [self resetLeftNavBtn];
    }else{
        [self setupDefaultLeftNavBtn];
    }
    
    _loadImageView.hidden = YES;
    [self.webView.scrollView.mj_header endRefreshing];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //[SVProgressHUDUtil dismiss];
    _loadImageView.hidden = NO;
    [self.webView.scrollView.mj_header endRefreshing];
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
