//
//  ChoseStationViewController.m
//  ScienceChina
//
//  Created by Ellison on 2016/11/15.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChoseStationViewController.h"
#import "CollectionDetailWebViewController.h"
#import "LeftListViewController.h"

@interface ChoseStationViewController ()

@property (weak, nonatomic) IBOutlet UIView *uiContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_view;

@property (nonatomic, strong)NSMutableArray* categoryTitle;
@property (nonatomic, strong)NSMutableArray* countArray;
@property (nonatomic, strong)NSMutableArray* nameArray;
@property (nonatomic, strong)NSMutableArray* descArray;
@property (nonatomic, strong)NSMutableArray* idArray;
@property (nonatomic, strong)NSMutableArray* imageArry;
@property (nonatomic, strong)NSMutableArray* eStationArray;

@end

@implementation ChoseStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化界面
    [self initNavBar];
    
    // 2.初始化变量
    _eStationArray = [NSMutableArray new];
    _categoryTitle = [NSMutableArray arrayWithObjects:
                      @"公众号",@"e站",@"科普信息化建设单位",@"信息化建设试点单位",@"基站",@"微博", nil];
    _countArray = [NSMutableArray arrayWithObjects:
                   @"3",@"3",@"17",@"3",
                   @"3",
                   @"1",nil];
    //    _countArray = [NSMutableArray arrayWithObjects:
    //                   @"6",@"3",@"17", nil];
    _nameArray = [NSMutableArray arrayWithObjects:
                  @"科技名家风采录",@"科技前沿大师谈",@"科技创新里程碑",
                  @"社区e站",@"乡村e站",@"学校e站",
                  @"科技前沿大师谈",@"科学原理一点通",@"玩转科学",
                  @"科技点亮智慧生活",@"健康伴我行",@"科学为你解疑释惑",
                  @"军事科技前沿",@"科技名家风采录",@"科技创新里程碑",
                  @"科普创客空间",@"科学大观园",@"科普中国传播之道",
                  @"科普影视厅",@"科普中国头条推送",@"科普重大选题融合创作与传播",
                  @"科学答人",@"科普中国百科",
                  @"上海科技报",@"济南市科学技术学会",@"广东省科学技术学会",
                  @"王府井社区", @"回龙观社区",@"西单社区",
                  @"微博",nil];
    _descArray = [NSMutableArray arrayWithObjects:
                 @"科技前沿大师谈",@"科技创新里程碑",@"科技名家风采录",
                 @"社区e站",@"乡村e站",@"学校e站",
                 @"科技前沿大师谈",@"科学原理一点通",@"玩转科学",@"科技点亮智慧生活",@"健康伴我行",@"科学为你解疑释惑",@"军事科技前沿",
                 @"科技名家风采录",@"科技创新里程碑",@"科普创客空间",@"科学大观园",@"科普中国传播之道",
                 @"科普影视厅",@"科普中国头条推送",@"科普重大选题融合创作与传播",@"科学答人",@"科普中国百科",
                  @"上海科技报",@"济南市科学技术学会",@"广东省科学技术学会",
                  @"中国数学学会",@"中国声学学会",@"中国气象学会",
                  @"微博",nil];
    _idArray = [NSMutableArray arrayWithObjects:
                @"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",
                @"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",
                @"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",
                @"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",@"OR201605241740321022",
                @"OR201605241740321022",nil];
    
    _imageArry = [NSMutableArray arrayWithObjects:
                  @"科技名家风采录",@"科技前沿大师谈",@"lichengbei",
                  @"DemoLogo",@"DemoLogo",@"DemoLogo",
                  @"科学原理一点通",@"科学原理一点通",@"玩转科学",
                  @"科技点亮智慧生活",@"科技点亮智慧生活",@"科技点亮智慧生活",
                  @"军事科技前沿",@"科学原理一点通",@"科学原理一点通",
                  @"玩转科学",@"baidu",@"科学原理一点通",
                  @"玩转科学",@"玩转科学",@"zhongkeyuan",
                  @"kejibao",@"baidu",
                  @"上海科技报",@"济南市科学技术学会",@"广东省科学技术学会",
                  @"王府井社区", @"回龙观社区",@"西单社区",
                  @"DemoLogo",nil];
    
    [self initStationView];
}

#pragma mark - 初始化界面
// 初始化导航栏
- (void)initNavBar{
    UIImageView* titleView = [UIImageView new];
    titleView.frame = CGRectMake(0, 0, 149, 18);
    titleView.image = [UIImage imageNamed:@"Demo科普中国"];
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.layer.masksToBounds = YES;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = nil;
    
//    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightNavBtn.frame = CGRectMake(0, 0, 40, 25);
//    [rightNavBtn setTitle:@"完成" forState:UIControlStateNormal];
//    [rightNavBtn setTitle:@"完成" forState:UIControlStateHighlighted];
//    [rightNavBtn.titleLabel setFont:FONT_14];
//    [rightNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    [rightNavBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightNavBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initStationView{
    
    CGFloat _leftEdge = 0;
    CGFloat _scrollWidth = kSCREEN_WIDTH;
    if (isIpad) {
        _leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
        _scrollWidth = MAIN_SCREEN_WIDTH_ONIpad;
    }
    self.leadingEdge_view.constant  = self.trailingEdge_view.constant = _leftEdge;
    
    // 1、初始化数据
    for (int i=0; i<_nameArray.count; i++) {
        EStation* es = [EStation new];
        [es setSi_id:_idArray[i]];
        [es setSi_name:_nameArray[i]];
        [es setSi_desc:_descArray[i]];
        [es setSi_img_url:_imageArry[i]];//@"DemoLogo"];
        [_eStationArray addObject:es];
    }
    
    // 2、初始化界面
    NSInteger columnCount = 3;
    
    // 3、初始化界面
    CGFloat titleHeight = 40;
    int width = 70;
    int height = 70;
    CGFloat Y  = 0;
    int currentIdx = 0;
    
    for (int i = 0; i < _categoryTitle.count; i++) {
        Y += 20;
        // 1、画TitleLabel
        UILabel *textlabel = [UILabel new];
        textlabel.text = _categoryTitle[i];
        textlabel.frame = CGRectMake(0, Y, _scrollWidth, titleHeight);
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.font = FONT_18;
        textlabel.textColor = [UIColor colorWithHex:0x222222];
        [self.uiContentView addSubview:textlabel];
        
        // 2、画按钮集合
        // 2.1、获取数量
        NSInteger currentCount = [_countArray[i] integerValue];
        Y += titleHeight;
        
        if (currentCount != 0) {
            for (int j = 0; j < currentCount; j++) {
                CGFloat itemSpace = (_scrollWidth - width * columnCount) / 4;
                CGFloat X = itemSpace + (itemSpace + width) * (j % 3);
                
                UIButton *imgBtn = [UIButton new];
                //NSString *image = @"DemoLogo";
                NSString *image = _imageArry[currentIdx];
                [imgBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
                [imgBtn setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
                imgBtn.frame = CGRectMake(X, Y, width, height);
                imgBtn.tag = currentIdx;
                [imgBtn addTarget:self action:@selector(clickToStation:) forControlEvents:UIControlEventTouchUpInside];
                [self.uiContentView addSubview:imgBtn];
                
                UILabel *label = [UILabel new];
                EStation *station = _eStationArray[currentIdx];
                label.text = station.si_name;
                label.frame = CGRectMake(X-10, Y + height + 5, width + 20, 15);
                label.textAlignment = NSTextAlignmentCenter;
                label.font = FONT_11;
                label.textColor = [UIColor colorWithHex:0x222222];
                [self.uiContentView addSubview:label];
                
//                UIButton *clickBtn = [UIButton new];
//                [clickBtn setImage:[UIImage imageNamed:@"Demo+"] forState:UIControlStateNormal];
//                [clickBtn setImage:[UIImage imageNamed:@"Demo勾"] forState:UIControlStateSelected];
//                clickBtn.frame = CGRectMake(X + 15, Y + height + 5 + 15 + 5, 40, 20);
//                clickBtn.tag = currentIdx + 100;
//                [clickBtn addTarget:self action:@selector(clickToShow:) forControlEvents:UIControlEventTouchUpInside];
//                [self.uiContentView addSubview:clickBtn];
                
//                if (j % 3 != 2) {
//                    clickBtn.selected = YES;
//                }
                
                if (j % 3 == 2) {
                    Y += height + 5 + 15 + 5 + 20 + 10;
                }
                
                currentIdx += 1;
            }
        }else{
            UIImageView* imgView = [UIImageView new];
            imgView.image = [UIImage imageNamed:@"Demo空"];
            imgView.layer.masksToBounds = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            CGFloat height = (_scrollWidth - 56) / 638 * 228;
            imgView.frame = CGRectMake(28, Y, _scrollWidth - 56, height);
            Y += height;
            [self.uiContentView addSubview:imgView];
        }
        if (currentCount % 3 != 0) {
            Y += height + 5 + 15 + 5 + 20 + 10;
        }
    }
    
    Y = Y + 20;
    
    self.conContentViewWidth.constant = _scrollWidth;
    self.conContentViewHeight.constant = Y;
}


- (void)clickToStation:(UIButton*)sender{
    NSInteger idx = sender.tag;
    // 跳转基站首页
    EStation* station = [_eStationArray objectAtIndex:idx];
    //[FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:station.si_id];
    
//    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:station.si_name,@"title", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowFirstPage" object:nil userInfo:info];
//    [self dismissViewControllerAnimated:YES completion:^{}];
    
    [self jumpWithTitle:station.si_name];
    
}

- (void)clickToShow:(UIButton*)sender{
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}

/*----------------*/
-(void)gotoMainWithTitle:(NSString *)title{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowChannel" object:nil userInfo:info];
    // 改版
//    DDMenuController *menuController = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    if (!menuController) {
//        ChannelContainerViewController *rootVC = [[ChannelContainerViewController alloc] init];
//        LeftListViewController *leftController = [[LeftListViewController alloc] init];
//        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
//        
//        menuController = [[DDMenuController alloc] init];
//        menuController.rootViewController =rootNav;
//        menuController.leftViewController = leftController;
//        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController =  menuController;
//    }
//    [self.navigationController pushViewController:menuController animated:YES];
}

-(void)gotoMathWithTitle:(NSString *)title{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:@"中国数学学会",@"title", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowEStationMath" object:nil userInfo:info];
    
    // 改版
//    DDMenuController *menuController = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    if (!menuController) {
//        ChannelContainerViewController *rootVC = [[ChannelContainerViewController alloc] init];
//        LeftListViewController *leftController = [[LeftListViewController alloc] init];
//        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
//        
//        menuController = [[DDMenuController alloc] init];
//        menuController.rootViewController =rootNav;
//        menuController.leftViewController = leftController;
//        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController =  menuController;
//    }
//    [self.navigationController pushViewController:menuController animated:YES];
//    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController setRootController:menuController.estationNav animated:YES];
    
}

-(void)jumpWithTitle:(NSString *)title{
//    if ([title isEqualToString:@"社区e站"] || [title isEqualToString:@"乡村e站"] || [title isEqualToString:@"学校e站"]) {
//
//        [self gotoMainWithTitle:title];
//    }
//    else if ([title isEqualToString:@"中国数学学会"]) {
//        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:@"OR201605241747111034"];
//        //[self gotoMathWithTitle:title];
//    }
//    else{
//        
//        NSString *url;
//        if ([title isEqualToString:@"社区e站"]) {
//            url = @"http://www.kepuchina.cn/demon/index.html";
//        }
//        if ([title isEqualToString:@"科技名家风采录"]) {
//            url = @"http://www.kepuchina.cn/demon/index.html";
//        }
//        else if ([title isEqualToString:@"科技前沿大师谈"]) {
//            url = @"http://www.xinhuanet.com/science/dst.htm";
//        }
//        else if ([title isEqualToString:@"科学原理一点通"]) {
//            url = @"http://www.xinhuanet.com/science/kxylydt.htm ";
//        }
//        else if ([title isEqualToString:@"微博"]) {
//            url = @"http://m.weibo.cn/p/1005055104880035";
//        }
//        else{
//            return;
//        }
//        CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
//        [webVC loadWebWithUrl:url];
//        
//        [self.navigationController pushViewController:webVC animated:YES];
//        
//    }
    
    
   if ([title isEqualToString:@"王府井社区"]) {
        [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:@"OR201611151132472669"];
        //[self gotoMathWithTitle:title];
   }
   else if ([title isEqualToString:@"社区e站"]) {
       [FlowUtil startToEStationPersonalVCNav:self.navigationController si_id:@"OR201611152239043370"];
   }
   else{
        
        NSString *url;
        if ([title isEqualToString:@"科技名家风采录"]) {
            url = @"http://www.xinhuanet.com/science/kjmjfcl/index.htm";
        }
        else if ([title isEqualToString:@"科技前沿大师谈"]) {
            url = @"http://www.xinhuanet.com/science/dst.htm";
        }
        else if ([title isEqualToString:@"科学原理一点通"]) {
            url = @"http://www.xinhuanet.com/science/kxylydt.htm";
        }
//        else if ([title isEqualToString:@"科技点亮智慧生活"]) {
//            url = @"http://kpzg.people.com.cn/GB/404389/index.html";
//        }
//        else if ([title isEqualToString:@"健康伴我行"]) {
//            url = @"http://health.people.com.cn/GB/404177/index.html";
//        }
//        else if ([title isEqualToString:@"科学为你解疑释惑"]) {
//            url = @"http://kpzg.people.com.cn/GB/404390/index.html";
//        }
        else if ([title isEqualToString:@"微博"]) {
            url = @"http://m.weibo.cn/p/1005055104880035";
        }
        else if ([title isEqualToString:@"乡村e站"]) {
            url = @"http://kpzg.cnncty.com";
        }
        else if ([title isEqualToString:@"军事科技前沿"]) {
            url = @"http://tech.gmw.cn/mil/index.htm";
        }
        else if ([title isEqualToString:@"科技创新里程碑"]) {
            url = @"http://www.xinhuanet.com/science/kjcxlcb/index.htm";
        }
//        else if ([title isEqualToString:@"科普创客空间"]) {
//            url = @"http://bj.jjj.qq.com/zt2/2015kpck/0826ymp/index.htm";
//        }
//        else if ([title isEqualToString:@"玩转科学"]) {
//            url = @"http://kepuchina.cn/wzkx";
//        }
//        else if ([title isEqualToString:@"科学大观园"]) {
//            url = @"http://www.kexuedaguanyuan.cn";
//        }
//        else if ([title isEqualToString:@"科普中国传播之道"]) {
//            url = @"http://www.news.cn/science/cbzd.htm";
//        }
//        else if ([title isEqualToString:@"科普影视厅"]) {
//            url = @"http://v.qq.com/topic/2015/kpyst.html";
//        }
//        else if ([title isEqualToString:@"科普中国头条推送"]) {
//            url = @"http://news.qq.com/zt2015/toutiao";
//        }
        else if ([title isEqualToString:@"科普重大选题融合创作与传播"]) {
            url = @"http://www.kepu.net.cn/gb/ydrhcz/ydrhcz_wap/index.html";
        }
        else if ([title isEqualToString:@"科学答人"]) {
            url = @"http://kxdr.bkweek.com/chuangguan/main?v=1";
        }
//        else if ([title isEqualToString:@"科普中国百科"]) {
//            url = @"http://baike.baidu.com/science";
//        }
        else{
            return;
        }
        CollectionDetailWebViewController *webVC = [[CollectionDetailWebViewController alloc] init];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
       
       [webVC loadWebWithUrl:url];
        
    }
}


@end
