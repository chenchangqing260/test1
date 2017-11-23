//
//  IntegralRulesViewController.m
//  ScienceChina
//
//  Created by xuanyj on 2016/12/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "IntegralRulesViewController.h"
#import "JHChartHeader.h"

@interface IntegralRulesViewController ()

@end

@implementation IntegralRulesViewController
{
    CGFloat _contentLeft;
    UIScrollView *_contentScroll;
    UIView *_contentView;
    JHTableChart *table1;
    JHTableChart *table2;
    JHTableChart *table3;
    JHTableChart *table4;
    JHTableChart *table5;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
    [self loadData];
}
-(void)initData{
    _contentLeft = 15.0;
}
-(void)setupView{
    self.title = @"积分规则";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *greenColor = [UIColor colorWithHex:0x33cfdb];
    UIColor *blackColor = [UIColor blackColor];
    UIColor *grayColor = [UIColor colorWithHex:0x7a7a7a];
    
    
    NSArray *textArry = @[@"科普员在传播科普信息的同时可以提升科普员等级，等级越高可获得对应等级的绩效奖励。",
                          
                          @"一、等级区分",
                          @"认证成功的科普员和未认证的用户头像都会显示图标“☆”加以区分，等级由0-5逐步提高。科普员可以通过分享文章或基站、分享后带来的点击量和带来的新增注册量来提升科普员等级。",
                          @"注：科普员每天获得积分上限为300积分",
                          
                          @"二、积分如何获取",
                          @"1、每日首次登录app可获得1点积分；\n2、科普员认证审核成功可获得50点积分；\n3、用户生成基站分享被关注一次可获得1点积分；\n4、分享基站或文章：科普员可以通过分享基站或文章来获取积分。成功分享一个基站可以获得2个积分，成功分享一篇文章可以获得1个积分。\n5、 分享的基站或文章获得浏览量：科普员通过分享的基站或文章为科普中国带来了浏览量。\n6、为了防止恶意转发刷积分，每位科普员每天可获得上限为300积分；每日分享可获得积分上限为50分、每日被关注基站上限积分为100分、每日被浏览文章积分上限为150分。\n7、成功认证科普员推荐人可获得50积分。",
                          
                          @"三、奖励机制",
                          @"1、科普员",
                          @"2、未认证科普员",
                          
                          @"四、减分规则",
                          @"注意：2星级以上开始执行减分规则，扣除积分达到等级下限后可降级。"
                          ];
    
    NSArray *colors = @[blackColor,
                        greenColor,grayColor,grayColor,
                        greenColor,grayColor,
                        greenColor,grayColor,grayColor,
                        greenColor,grayColor];
    
    NSArray *fonts = @[ FONT_16,
                        FONT_16,FONT_14,FONT_14,
                        FONT_16,FONT_14,
                        FONT_16,FONT_14,FONT_14,
                        FONT_16,FONT_14];
    
    CGFloat labelW = self.showWidth-_contentLeft*2;
    
    _contentScroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH-self.showWidth)/2.0, 0, self.showWidth, 0)];
    
    CGFloat labelVerticalSpace =  19.0;
    CGFloat nextLabelY = 12.0;
    
    for (NSInteger i=0 ; i<textArry.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_contentLeft, 0, labelW, 0)];
        label.font = fonts[i];
        label.text = textArry[i];
        label.textColor = colors[i];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        
        CGSize textSize = [label boundingRectWithSize:CGSizeMake(labelW, 0)];
        CGRect labelRect = label.frame;
        labelRect.size.height = textSize.height;
        labelRect.origin.y =nextLabelY;
        label.frame = labelRect;
        
        [_contentView addSubview:label];
        
        if (i == 0) {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 1)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 2)  {
            
            nextLabelY += textSize.height + labelVerticalSpace;
            
            [self addFirstTableViewWithY:nextLabelY];
            
            CGFloat tableH = [table1 heightFromThisDataSource];
            nextLabelY += tableH + labelVerticalSpace;
        }
        else if (i == 3)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 4)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 5)  {
            nextLabelY += textSize.height + labelVerticalSpace;
            
            [self addSecondTableViewWithY:nextLabelY];
            
            CGFloat tableH = [table2 heightFromThisDataSource];
            nextLabelY += tableH + labelVerticalSpace;
        }
        else if (i == 6)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 7)  {
            nextLabelY += textSize.height + labelVerticalSpace;
            
            [self addThirdTableViewWithY:nextLabelY];
            
            CGFloat tableH = [table3 heightFromThisDataSource];
            nextLabelY += tableH + labelVerticalSpace;
        }
        else if (i == 8)  {
            
            nextLabelY += textSize.height + labelVerticalSpace;
            
            [self addFourthTableViewWithY:nextLabelY];
            
            CGFloat tableH = [table4 heightFromThisDataSource];
            nextLabelY += tableH + labelVerticalSpace;
        }
        else if (i == 9)  {
            nextLabelY += textSize.height + labelVerticalSpace;
            
            [self addFifthTableViewWithY:nextLabelY];
            CGFloat tableH = [table5 heightFromThisDataSource];
            nextLabelY += tableH + labelVerticalSpace;
        }
        else if (i == 10)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 11)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        else if (i == 12)  {
            nextLabelY += textSize.height + labelVerticalSpace;            
        }
        else if (i == 13)  {
            nextLabelY += textSize.height + labelVerticalSpace;
        }
        
        
        
    }
    
    CGFloat table5H = [table5 heightFromThisDataSource];
    CGRect contentViewRect = _contentView.frame;
    contentViewRect.size.height = nextLabelY+table5H+100;
    _contentView.frame = contentViewRect;
    
    _contentScroll.contentSize = CGSizeMake(_contentView.frame.size.width, _contentView.frame.size.height);
    [self.view addSubview:_contentScroll];
    [_contentScroll addSubview:_contentView];
    
    
    
//    [self addFirstTableView];
//    [self addSecondTableView];
//    [self addThirdTableView];
//    [self addFourthTableView];
//    [self addFifthTableView];
}

/**
 *  创建表格视图
 */
- (void)addFirstTableViewWithY:(CGFloat)y{
    
    CGFloat tableY = y;
    NSArray *colWidthArr = @[@40.0,@100.0,@60,@100];
    CGFloat tableW = 0;
    for (NSNumber *object in colWidthArr) {
        
        NSInteger w = (NSInteger)[object integerValue];
        tableW += w;
    }
    
    CGFloat tableLeft = (_contentView.frame.size.width-tableW)/2.0;
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(tableLeft, tableY, tableW, 0)];
    table.tableTitleFont = FONT_14;
    table.tableBodyTitleFont = FONT_14;
    /*       Table name         */
    //    table.tableTitleString = @"全选jeep自由光";
    /*        Each column of the statement, one of the first to show if the rows and columns that can use the vertical segmentation of rows and columns         */
    table.colTitleArr = @[@"等级",@"显示",@"头衔",@"需要积分"];
    /*        The width of the column array, starting with the first column         */
    table.colWidthArr = colWidthArr;
    //    table.beginSpace = 30;
    /*        Text color of the table body         */
    table.bodyTextColor = [UIColor blackColor];
    /*        Minimum grid height         */
    table.minHeightItems = 35;
    /*        Table line color         */
    table.lineColor = [UIColor blackColor];
    
    table.backgroundColor = [UIColor whiteColor];
    /*       Data source array, in accordance with the data from top to bottom that each line of data, if one of the rows of a column in a number of cells, can be stored in an array of         */
    table.dataArr = @[
                      @[@"0",@"image:0xingOnIntegralRuels",@[@"学士"],@"0"],
                      @[@"1",@"image:1xingOnIntegralRuels",@[@"硕士"],@"100"],
                      @[@"2",@"image:2xingOnIntegralRuels",@[@"博士"],@"1000"],
                      @[@"3",@"image:3xingOnIntegralRuels",@[@"博导"],@"5000"],
                      @[@"4",@"image:4xingOnIntegralRuels",@[@"专家"],@"10000"],
                      @[@"5",@"image:5xingOnIntegralRuels",@[@"教授"],@"30000"],
                      @[@"5+",@"image:5xing+OnIntegralRuels",@[@"院士"],@"40000"],
                      ];
    /*        Automatic calculation table height        */
    CGRect tableRect = table.frame ;
    tableRect.size.height = [table heightFromThisDataSource];
    table.frame = tableRect;
    
    /*        show                            */
    [table showAnimation];
    [_contentView addSubview:table];
    
    table1 = table;
}

- (void)addSecondTableViewWithY:(CGFloat)y{
    
    CGFloat tableY = y;
    NSArray *colWidthArr = @[@120.0,@150.0];
    CGFloat tableW = 0;
    for (NSNumber *object in colWidthArr) {
        
        NSInteger w = (NSInteger)[object integerValue];
        tableW += w;
    }
    CGFloat tableLeft = (self.showWidth-tableW)/2.0;
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(tableLeft, tableY, tableW, 0)];
    table.tableTitleFont = FONT_14;
    table.tableBodyTitleFont = FONT_14;
    table.colTitleArr = @[@"操作（1次）",@"积分增长（分）"];
    table.colWidthArr = colWidthArr;
    table.bodyTextColor = [UIColor blackColor];
    table.minHeightItems = 35;
    table.lineColor = [UIColor blackColor];
    table.backgroundColor = [UIColor whiteColor];
    table.dataArr = @[
                      @[@"每日登录",  @"1"],
                      @[@"科普员认证",@"50"],
                      @[@"基站被关注",@"1"],
                      @[@"分享基站",  @"2"],
                      @[@"分享文章",  @"1"],
                      @[@"文章被浏览", @"2"]
                      ];
    
    CGRect tableRect = table.frame ;
    tableRect.size.height = [table heightFromThisDataSource];
    table.frame = tableRect;
    
    [table showAnimation];
    [_contentView addSubview:table];
    
    table2 = table;
}
- (void)addThirdTableViewWithY:(CGFloat)y{
    
    CGFloat tableY = y;
    NSArray *colWidthArr = @[@120.0,@150.0];
    CGFloat tableW = 0;
    for (NSNumber *object in colWidthArr) {
        
        NSInteger w = (NSInteger)[object integerValue];
        tableW += w;
    }
    CGFloat tableLeft = (self.showWidth-tableW)/2.0;
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(tableLeft, tableY, tableW, 0)];
    table.tableTitleFont = FONT_14;
    table.tableBodyTitleFont = FONT_14;
    table.colTitleArr = @[@"达到积分/月",@"流量包"];
    table.colWidthArr = colWidthArr;
    table.bodyTextColor = [UIColor blackColor];
    table.minHeightItems = 35;
    table.lineColor = [UIColor blackColor];
    table.backgroundColor = [UIColor whiteColor];
    table.dataArr = @[
                      @[@"1500",@"20M流量包"],
                      @[@"3000",@"30M流量包"],
                      @[@"5000",@"50M流量包"],
                      @[@"7000",@"80M流量包"],
                      @[@"9000",@"100M流量包"],
                      ];
    
    CGRect tableRect = table.frame ;
    tableRect.size.height = [table heightFromThisDataSource];
    table.frame = tableRect;
    
    [table showAnimation];
    [_contentView addSubview:table];
    
    table3 = table;
}
- (void)addFourthTableViewWithY:(CGFloat)y{
    
    CGFloat tableY = y;
    NSArray *colWidthArr = @[@120.0,@150.0];
    CGFloat tableW = 0;
    for (NSNumber *object in colWidthArr) {
        
        NSInteger w = (NSInteger)[object integerValue];
        tableW += w;
    }
    CGFloat tableLeft = (self.showWidth-tableW)/2.0;
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(tableLeft, tableY, tableW, 0)];
    table.tableTitleFont = FONT_14;
    table.tableBodyTitleFont = FONT_14;
    table.colTitleArr = @[@"达到积分/月",@"流量包"];
    table.colWidthArr = colWidthArr;
    table.bodyTextColor = [UIColor blackColor];
    table.minHeightItems = 35;
    table.lineColor = [UIColor blackColor];
    table.backgroundColor = [UIColor whiteColor];
    table.dataArr = @[
                      @[@"1500",@"10M流量包"],
                      @[@"3000",@"20M流量包"],
                      @[@"5000",@"30M流量包"],
                      @[@"7000",@"50M流量包"],
                      @[@"9000",@"80M流量包"],
                      ];
    
    CGRect tableRect = table.frame ;
    tableRect.size.height = [table heightFromThisDataSource];
    table.frame = tableRect;
    
    [table showAnimation];
    [_contentView addSubview:table];
    
    table4 = table;
}
- (void)addFifthTableViewWithY:(CGFloat)y{
    
    CGFloat tableY = y;
    NSArray *colWidthArr = @[@120.0,@150.0];
    CGFloat tableW = 0;
    for (NSNumber *object in colWidthArr) {
        
        NSInteger w = (NSInteger)[object integerValue];
        tableW += w;
    }
    CGFloat tableLeft = (self.showWidth-tableW)/2.0;
    
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(tableLeft, tableY, tableW, 0)];
    table.tableTitleFont = FONT_14;
    table.tableBodyTitleFont = FONT_14;
    table.colTitleArr = @[@"达到积分/月",@"扣除（分）"];
    table.colWidthArr = colWidthArr;
    table.bodyTextColor = [UIColor blackColor];
    table.minHeightItems = 35;
    table.lineColor = [UIColor blackColor];
    table.backgroundColor = [UIColor whiteColor];
    table.dataArr = @[
                      @[@"300",@"500"],
                      @[@"1000",@"300"]
                      ];
    
    CGRect tableRect = table.frame ;
    tableRect.size.height = [table heightFromThisDataSource];
    table.frame = tableRect;
    
    [table showAnimation];
    [_contentView addSubview:table];
    
    table5 = table;
}
-(void)loadData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
