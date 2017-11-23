//
//  JHTableChart.h
//  JHChartDemo
//
//  Created by 简豪 on 16/8/24.
//  Copyright © 2016年 JH. All rights reserved.
//
/************************************************************
 *                                                           *
 *                                                           *
                            表格
 *                                                           *
 *                                                              *
 ************************************************************/


#import "JHChart.h"

@interface JHTableChart : JHChart
/**
 *  Table name, if it is empty, does not display a table name
 */
@property (nonatomic, copy) NSString * tableTitleString;

/**
 *  Table header row height, default 50
 */
@property (nonatomic, assign) CGFloat tableChartTitleItemsHeight;


/**
 *  Table header text font size (default 15), color (default depth)
 */
@property (nonatomic, strong) UIFont * tableTitleFont;//第一行标题的字体
@property (nonatomic, strong) UIColor * tableTitleColor;

@property (nonatomic, strong) UIFont * tableBodyTitleFont;//表格中 除了第一行标题以外 的 单元格 的字体


/**
 *  Table line color
 */
@property (nonatomic, strong) UIColor  * lineColor;


/**
 *  Data Source Arrays
 */
@property (nonatomic, strong) NSArray * dataArr;


/**
 *  Width of each column
 */
@property (nonatomic, strong) NSArray * colWidthArr;

/**
 *  The smallest line is high, the default is 50
 */
@property (nonatomic, assign) CGFloat minHeightItems;


/**
 *  Table data display color
 */
@property (nonatomic, strong) UIColor * bodyTextColor;


/**
 *  The column header name, the first column horizontal statement, need to use | segmentation
 */
@property (nonatomic, strong) NSArray * colTitleArr;

/**
 *  Anyway, the ranks of name statement, if it is necessary to fill out a two data
 */
@property (nonatomic, strong) NSArray * rowAndColTitleArr;


/**
 *  Offset value of start point
 */
@property (nonatomic, assign) CGFloat beginSpace;



/**
 *  According to the current data source to determine the desired table view
 */
- (CGFloat)heightFromThisDataSource;

@end
