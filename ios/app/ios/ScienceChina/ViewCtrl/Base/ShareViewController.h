//
//  ShareViewController.h
//  passbook
//
//  Created by Ellison on 16/4/5.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "BaseViewController.h"
#import "ThirdShareHandler.h"
#import "ShareModel.h"

@interface ShareViewController : BaseViewController

@property (nonatomic, strong)ShareModel* shareModel;
@property (nonatomic, copy) dispatch_block_t completeBlock;

- (void)didShareWithShareMode:(ShareThirdPart)part;

@end
