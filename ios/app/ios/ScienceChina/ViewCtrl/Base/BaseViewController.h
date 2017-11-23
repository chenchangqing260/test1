//
//  BaseViewController.h
//  passbook
//
//  Created by Ellison on 16/2/16.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *uiTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *uiCollectionView;

//uiTableView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge;

//uiCollectionView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_collection;

@property (assign, nonatomic) CGFloat leftEdge;
@property (assign, nonatomic) CGFloat showWidth;

@end
