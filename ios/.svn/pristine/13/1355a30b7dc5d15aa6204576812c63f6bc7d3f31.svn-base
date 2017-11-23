//
//  AddressView.m
//  AddressTest
//
//  Created by weizhongming on 2017/2/15.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE6_SIZE SCREEN_WIDTH/375
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "AddressView.h"
#import "MJExtension.h"
#import "AppUtils.h"
#import "Provice.h"
#import "AddCity.h"
#import "Country.h"
#import "Town.h"

@interface AddressView()

@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, strong) NSXMLParser *par;

@property (nonatomic, strong) NSMutableArray* provinceArray;
@property (nonatomic, strong) NSMutableArray* cityArray;
@property (nonatomic, strong) NSMutableArray* countryArray;
@property (nonatomic, strong) NSMutableArray* townArray;

@property (nonatomic, strong)Provice *provice;
@property (nonatomic, strong)AddCity *city;
@property (nonatomic, strong)Country* country;
@property (nonatomic, strong)Town* town;

// 记录第一个省份
@property (nonatomic, strong) Provice* firstProvince;
// 记录第二个城市
@property (nonatomic, strong) AddCity* secondCity;
// 记录第三个县市区
@property (nonatomic, strong) Country* thirdCountry;
// 记录第四个街道乡镇
@property (nonatomic, strong) Town* fourthTown;

@end

@implementation AddressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -400 *IPHONE6_SIZE)];
        tapView.userInteractionEnabled = YES;
        [self addSubview:tapView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [tapView addGestureRecognizer:tap];
        
        self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400 *IPHONE6_SIZE)];
        self.myView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.myView];
        
        [self addTitleView];
    }
    return self;
}

//===============================XML获取数据源================================

#pragma mark - 地址xml解析
- (void)xmlData
{
    //获取事先准备好的XML文件
    NSBundle *b = [NSBundle mainBundle];
    NSString *path = [b pathForResource:@"region" ofType:@".xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    self.par = [[NSXMLParser alloc]initWithData:data];
    //添加代理
    self.par.delegate = self;
    //初始化数组，存放解析后的数据
    self.provinceArray = [NSMutableArray new];
    [self.par parse];
}

#pragma mark - xml地址数据文件解析,模拟器上解析会很慢，真机不会
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    //NSLog(@"准备节点-%@",elementName);
    
    if ([self.currentElement isEqualToString:@"province"]){
        self.provice = [Provice new];
        self.provice.code = [attributeDict objectForKey:@"code"];
        self.provice.name = [attributeDict objectForKey:@"name"];
        self.provice.cityArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"city"]){
        self.city = [AddCity new];
        self.city.code = [attributeDict objectForKey:@"code"];
        self.city.name = [attributeDict objectForKey:@"name"];
        self.city.countryArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"county"]){
        self.country = [Country new];
        self.country.code = [attributeDict objectForKey:@"code"];
        self.country.name = [attributeDict objectForKey:@"name"];
        self.country.townArray = [NSMutableArray new];
    }
    
    if ([self.currentElement isEqualToString:@"town"]){
        self.town = [Town new];
        self.town.code = [attributeDict objectForKey:@"code"];
        self.town.name = [attributeDict objectForKey:@"name"];
    }
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //NSLog(@"获取节点内容-%@",string);
    
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    //NSLog(@"解析完一个节点-%@",elementName);
    
    if ([elementName isEqualToString:@"province"]){
        [self.provinceArray addObject:self.provice];
    }
    
    if ([elementName isEqualToString:@"city"]){
        [self.provice.cityArray addObject:self.city];
    }
    
    if ([elementName isEqualToString:@"county"]){
        [self.city.countryArray addObject:self.country];
    }
    
    if ([elementName isEqualToString:@"town"]){
        [self.country.townArray addObject:self.town];
    }
    
    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}
//===============================XML获取数据源结束=================================

- (void)addTitleView{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48 *IPHONE6_SIZE)];
    titleLabel.text = @"所在地区";
    titleLabel.textColor = RGB(142, 143, 148);
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.backgroundColor = [UIColor redColor];
    [self.myView addSubview:titleLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -48 *IPHONE6_SIZE, 0, 48 *IPHONE6_SIZE, 48 *IPHONE6_SIZE)];
    [button setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:button];
    
    self.selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), 75, 30 *IPHONE6_SIZE)];
    self.selectLabel.textColor = RGB(242, 36, 36);
    //self.selectLabel.backgroundColor = [UIColor blueColor];
    self.selectLabel.text = @"请选择";
    self.selectLabel.font = [UIFont systemFontOfSize:14.f];
    self.selectLabel.textAlignment = NSTextAlignmentCenter;
    self.selectLabel.userInteractionEnabled = YES;
    [self.myView addSubview:self.selectLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLabelTapClick)];
    [self.selectLabel addGestureRecognizer:tap];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectLabel.frame), SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGB(229, 229, 229);
    [self.myView addSubview:lineView];
    
    self.redLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.selectLabel.frame) + 15, CGRectGetMaxY(self.selectLabel.frame), 45, 1)];
    self.redLineView.backgroundColor = RGB(242, 36, 36);
    [self.myView addSubview:self.redLineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.redLineView.frame), SCREEN_WIDTH, self.myView.frame.size.height - CGRectGetMaxY(self.redLineView.frame))];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.myView addSubview:self.scrollView];
    
    self.tableView1 = [[AddressTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.provinceArray];
    
    __weak __typeof(self)weakSelf = self;
    
    
    self.tableView1.block = ^(NSInteger row){
        
        [weakSelf.cityLabel removeFromSuperview];
        [weakSelf.townLabel removeFromSuperview];
        weakSelf.cityLabel = nil;
        weakSelf.townLabel = nil;
        
        weakSelf.firstProvince = weakSelf.provinceArray[row];
        
        //weakSelf.stateLabel.backgroundColor = [UIColor redColor];
        //weakSelf.selectLabel.backgroundColor = [UIColor blueColor];
        
        weakSelf.proviceLabel.frame = CGRectMake(0, 48 *IPHONE6_SIZE, 30 + [AppUtils widthOfString:weakSelf.firstProvince.name font:14 height:30 *IPHONE6_SIZE], 30 *IPHONE6_SIZE);
        
        weakSelf.proviceLabel.text = weakSelf.firstProvince.name;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.proviceLabel.frame), CGRectGetMaxY(titleLabel.frame), 75, 30 *IPHONE6_SIZE);
            weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
        } completion:^(BOOL finished) {
            
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.proviceLabel.frame), CGRectGetMaxY(titleLabel.frame), 75, 30 *IPHONE6_SIZE);
            weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
        } completion:^(BOOL finished) {
            
        }];
        
        weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, weakSelf.scrollView.frame.size.height);
        
        [weakSelf.tableView2 removeFromSuperview];
        weakSelf.tableView2 = nil;
        
        [weakSelf.tableView3 removeFromSuperview];
        weakSelf.tableView3 = nil;
        
        [weakSelf.tableView4 removeFromSuperview];
        weakSelf.tableView4 = nil;
        
        weakSelf.cityArray = weakSelf.firstProvince.cityArray;
        weakSelf.tableView2.hidden = NO;
        
        [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    };
    [self.scrollView addSubview:self.tableView1];
}

#pragma mark -- UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"%f",scrollView.contentOffset.x /SCREEN_WIDTH);
    
    if (scrollView.contentOffset.x /SCREEN_WIDTH == 0) {
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.redLineView.frame = CGRectMake(15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.proviceLabel.text font:15 height:30 *IPHONE6_SIZE], 1);
            
        }];
        
    }else if (scrollView.contentOffset.x /SCREEN_WIDTH ==1){
        
        if (_cityLabel) {
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.proviceLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.cityLabel.text font:14 height:30 *IPHONE6_SIZE], 1);
            }];
        }else{
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.proviceLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
            }];
        }
    }else if (scrollView.contentOffset.x /SCREEN_WIDTH ==2){
        
        if (_townLabel) {
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.cityLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.townLabel.text font:14 height:30 *IPHONE6_SIZE], 1);
            }];
        }else{
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.cityLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
            }];
        }
    }else{
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.redLineView.frame = CGRectMake(CGRectGetMinX(self.selectLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
        }];
    }
}

- (UILabel *)proviceLabel{
    
    if (!_proviceLabel) {
        
        _proviceLabel = [[UILabel alloc] init];
        _proviceLabel.font = [UIFont systemFontOfSize:14.f];
        _proviceLabel.textAlignment = NSTextAlignmentCenter;
        _proviceLabel.userInteractionEnabled = YES;
        _proviceLabel.backgroundColor = [UIColor colorWithHex:0xffffff];
        [self.myView addSubview:_proviceLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelTapClick)];
        [_proviceLabel addGestureRecognizer:tap];
    }
    return _proviceLabel;
}

- (void)stateLabelTapClick{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.proviceLabel.text font:14 height:30 *IPHONE6_SIZE], 1);
        
    }];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (UILabel *)cityLabel{
    
    if (!_cityLabel) {
        
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:14.f];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.userInteractionEnabled = YES;
        [self.myView addSubview:_cityLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityLabelTapClick)];
        [_cityLabel addGestureRecognizer:tap];
    }
    return _cityLabel;
}

- (void)cityLabelTapClick{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.proviceLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.cityLabel.text font:14 height:30 *IPHONE6_SIZE], 1);
    }];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

- (UILabel *)townLabel{
    
    if (!_townLabel) {
        
        _townLabel = [[UILabel alloc] init];
        _townLabel.font = [UIFont systemFontOfSize:14.f];
        _townLabel.textAlignment = NSTextAlignmentCenter;
        _townLabel.userInteractionEnabled = YES;
        [self.myView addSubview:_townLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(townLabelTapClick)];
        [_townLabel addGestureRecognizer:tap];
    }
    return _townLabel;
}

- (void)townLabelTapClick{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(CGRectGetMaxX(self.cityLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), [AppUtils widthOfString:self.townLabel.text font:14 height:30 *IPHONE6_SIZE], 1);
    }];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0) animated:YES];
}

- (void)selectLabelTapClick{
    
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.redLineView.frame = CGRectMake(CGRectGetMinX(self.selectLabel.frame) +15, CGRectGetMaxY(self.selectLabel.frame), 45, 1);
    }];
    
    if (_townLabel){
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 3, 0) animated:YES];
    }else if (_cityLabel) {
        
        
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *2, 0) animated:YES];
    }else if (_proviceLabel){
        
        
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

- (AddressTableView *)tableView2{
    
    if (!_tableView2) {
        
        __weak __typeof(self)weakSelf = self;

        
        _tableView2 = [[AddressTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.cityArray];
        _tableView2.block = ^(NSInteger row){
            
            [weakSelf.townLabel removeFromSuperview];
            weakSelf.townLabel = nil;
            weakSelf.secondCity = weakSelf.cityArray[row];
            
            weakSelf.cityLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.proviceLabel.frame), 48 *IPHONE6_SIZE, 30 + [AppUtils widthOfString:weakSelf.secondCity.name font:14 height:30 *IPHONE6_SIZE], 30 *IPHONE6_SIZE);
            weakSelf.cityLabel.text = weakSelf.secondCity.name;
            [UIView animateWithDuration:0.5 animations:^{
                
                weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.cityLabel.frame), CGRectGetMinY(weakSelf.proviceLabel.frame), 75, 30 *IPHONE6_SIZE);
                weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
            } completion:^(BOOL finished) {
                
            }];
            
            weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *3, weakSelf.scrollView.frame.size.height);
            [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *2, 0) animated:YES];
            
            
            weakSelf.countryArray = weakSelf.secondCity.countryArray;
            
            [weakSelf.tableView3 removeFromSuperview];
            weakSelf.tableView3 = nil;
            
            weakSelf.tableView3.hidden = NO;
            
        };
        [self.scrollView addSubview:_tableView2];
    }
    
    return _tableView2;
}

- (AddressTableView *)tableView3{
    
    if (!_tableView3) {
        
        __weak __typeof(self)weakSelf = self;
        
        _tableView3 = [[AddressTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.countryArray];
        _tableView3.block = ^(NSInteger row){
            
            weakSelf.thirdCountry = weakSelf.countryArray[row];
            
            weakSelf.townLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.cityLabel.frame), 48 *IPHONE6_SIZE, 30 + [AppUtils widthOfString:weakSelf.thirdCountry.name font:14 height:30 *IPHONE6_SIZE], 30 *IPHONE6_SIZE);
            weakSelf.townLabel.text = weakSelf.thirdCountry.name;
            [UIView animateWithDuration:0.5 animations:^{
                
                weakSelf.selectLabel.frame = CGRectMake(CGRectGetMaxX(weakSelf.townLabel.frame), CGRectGetMinY(weakSelf.cityLabel.frame), 75, 30 *IPHONE6_SIZE);
                weakSelf.redLineView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectLabel.frame) +15, CGRectGetMaxY(weakSelf.selectLabel.frame), 45, 1);
            } completion:^(BOOL finished) {
                
            }];
            
            weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *4, weakSelf.scrollView.frame.size.height);
            [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH *3, 0) animated:YES];
            
            
            weakSelf.townArray = weakSelf.thirdCountry.townArray;
            
            [weakSelf.tableView4 removeFromSuperview];
            weakSelf.tableView4 = nil;
            
            weakSelf.tableView4.hidden = NO;
            
        };
        
        [self.scrollView addSubview:_tableView3];
    }
    
    return _tableView3;
}

- (AddressTableView *)tableView4{
    
    if (!_tableView4) {
        
        __weak __typeof(self)weakSelf = self;
        
        _tableView4 = [[AddressTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *3, 0, SCREEN_WIDTH, self.scrollView.frame.size.height) withParmas:self.townArray];
        _tableView4.block = ^(NSInteger row){
            weakSelf.fourthTown = weakSelf.townArray[row];
            [weakSelf tapClick];
            //            weakSelf.block([NSString stringWithFormat:@"%@ %@ %@ %@",weakSelf.firstProvince.name,weakSelf.secondCity.name,weakSelf.thirdCountry.name,weakSelf.fourthTown.name]);
            weakSelf.block(weakSelf.firstProvince, weakSelf.secondCity, weakSelf.thirdCountry, weakSelf.fourthTown);
        };
        [self.scrollView addSubview:_tableView4];
    }
    
    return _tableView4;
}


#pragma mark -- 点击空白处触发
- (void)tapClick{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.myView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400 *IPHONE6_SIZE);
        //        [self.fatherView.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        //        [UIView animateWithDuration:0.5 animations:^{
        //            self.fatherView.transform = CGAffineTransformMakeScale(1, 1);
        //        }];
    }];
}

#pragma mark -- 弹出选择地址view
- (void)showView:(UIView *)supView{
    
    self.fatherView = supView;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.myView.frame = CGRectMake(0, SCREEN_HEIGHT -400 *IPHONE6_SIZE, SCREEN_WIDTH, 400 *IPHONE6_SIZE);
        //        [supView.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        //        [UIView animateWithDuration:0.5 animations:^{
        //            supView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        //        }];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

// 后靠效果
- (CATransform3D)firstTransform{
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
}

@end
