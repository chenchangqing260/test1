//
//  ActivityIndexWebViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityIndexWebViewController.h"
#import "SpecialDetailListActivityViewController.h"

@interface ActivityIndexWebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@property (nonatomic,strong) NSString *weiChatUrl;

@property (nonatomic,strong) NSString *weiBoUrl;

@property (nonatomic, strong)UIImageView *loadImageView;

@end

@implementation ActivityIndexWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    [self setupLoadingView];
//    if (self.shareModel) {
//        // 显示右侧分享按钮
//        [self setupRightNav];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
}

-(void)setupView{
    if (_titleStr && ![_titleStr isEmptyOrWhitespace]) {
        self.title = _titleStr;
    }else{
        self.title = @"科普中国";
    }
    [self resetLeftNavBtn];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    if (isIpad) {
        CGFloat _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        [self.webView.scrollView setContentInset:UIEdgeInsetsMake(0, _leftEdge, 0, _leftEdge)];;
    }
}

-(void)setupLoadingView{
    CGFloat loadW = 150.0;
    CGFloat loadH = 107.0;
    _loadImageView = [[UIImageView alloc] init];
    _loadImageView.frame = CGRectMake((MAIN_SCREEN_WIDTH-loadW)/2.0, (self.view.frame.size.height-loadH)/2.0, loadW, loadH);
    //_loadImageView.hidden = YES;
    [self.view addSubview:_loadImageView];
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"loadingIcon_gif.gif" ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:imgPath];
    _loadImageView.image = [UIImage sd_animatedGIFWithData:imageData];
}

-(void)setupRightNav{
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 25);
    [rightNavBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [rightNavBtn addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)setupEditRightNav{
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 25);
    [rightNavBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightNavBtn.titleLabel setFont:FONT_14];
    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [rightNavBtn addTarget:self action:@selector(rightEditNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

// 左侧导航点击事件
-(void)rightNavBtn{
    [FlowUtil presentToHomeShareWithNav:self.navigationController shareModel:_shareModel completion:nil];
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
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
        _webView.delegate = self;
        [_webView setScalesPageToFit:YES];//网页自适应屏幕
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(void)loadWebWithUrl:(NSString *)url{
    [self.webView reload];
    //    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    //    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *_url = [NSURL URLWithString:url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}
-(void)writeHtmlToWebview:(NSString *)html{
    //html = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", html];
    [self.webView loadHTMLString:html baseURL:nil];
}
#pragma mark UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //[SVProgressHUDUtil showWithStatus:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取网页标题
    //self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //[SVProgressHUDUtil dismiss];
    self.loadImageView.hidden = YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //[SVProgressHUDUtil dismiss];
}

//-(void)web
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
