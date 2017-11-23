//
//  AddChannelViewController.m
//  ScienceChina
//
//  Created by touf on 2016/12/26.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "AddChannelViewController.h"
#import "ChannelListModel.h"
#import "QNCustomUploadManager.h"
#import "QNKeyHelper.h"
#import "ChannelListModel.h"

@interface AddChannelViewController ()
@property (weak, nonatomic) IBOutlet UIView *uiMyChannelView;
@property (weak, nonatomic) IBOutlet UIView *uiMoreChannelView;
@property (weak, nonatomic) IBOutlet UIButton *uiSubmitBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *uiContentScrollView;
@property (weak, nonatomic) IBOutlet UIView *uiContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMyChannelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMoreChannelViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conContentViewWidth;

@property (strong, nonatomic) ChannelListModel *channelModel;
@end

@implementation AddChannelViewController
{
    int btnWidth;
    int btnHeight;
    int RowOne;
    int RowTwo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加频道";
    btnWidth = (kSCREEN_WIDTH-90)/4;//按钮宽度
    btnHeight = 30;//按钮高度
    [self initData];
    [self getAllChannels];
}

#pragma mark - 获取所有的频道
- (void)getAllChannels
{
    [SVProgressHUDUtil show];
    _AllChannel = [NSMutableArray new];
    [[WebAccessManager sharedInstance]getallChannelsWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success)
        {
            _AllChannel = response.data.channelList;
            [self initMoreChannelData];
            [SVProgressHUDUtil dismiss];
        }
        else
        {
            [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
        }
    }];
}

#pragma mark - 从已选择数组中循环创建button
- (void)initData
{
    RowOne = 1;
    int c=0;
    for (int i=0; i<_HadSelectChannel.count; i++)
    {
        NSObject *str = _HadSelectChannel[i];
        if ([str isKindOfClass:[ChannelListModel class]])
        {
            ChannelListModel *channel = (ChannelListModel *)str;
            if (c==4)
            {
                c=0;
                RowOne++;
            }
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(8*(c+1)+c*btnWidth, 7*(RowOne-1)+btnHeight*(RowOne-1), btnWidth, btnHeight)];
            btn.tag=1000+i;
            btn.backgroundColor=[UIColor whiteColor];
            [btn setTitle:channel.at_name forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor colorWithHex:0x7a7a7a] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(hadSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_uiMyChannelView addSubview:btn];
            [self updataFrame];
            c++;
        }
    }
}

#pragma mark - 遍历所有频道的数组，对比已选择数组中的item，剔除相同
- (void)initMoreChannelData
{
    for (int i=0; i<_AllChannel.count; i++)
    {
        NSObject *str1=_AllChannel[i];
        for (NSObject *str in _HadSelectChannel)
        {
            if ([str isKindOfClass:[ChannelListModel class]])
            {
                if ([str1 isKindOfClass:[ChannelListModel class]])
                {
                    ChannelListModel *channel = (ChannelListModel *)str1;
                    ChannelListModel *channel2 = (ChannelListModel *)str;
                    if ([channel.at_name isEqualToString:channel2.at_name])
                    {
                        _AllChannel[i]=@"nil";
                    }
                }
            }
        }
    }
    RowTwo = 1;
    int c=0;
    for (int i=0; i<_AllChannel.count; i++)
    {
        
        NSObject *str = _AllChannel[i];
        if ([str isKindOfClass:[ChannelListModel class]])
        {
            ChannelListModel *channel = (ChannelListModel *)str;
            if (c==4)
            {
                c=0;
                RowTwo++;
            }
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(8*(c+1)+c*btnWidth, 7*(RowTwo-1)+btnHeight*(RowTwo-1), btnWidth, btnHeight)];
            btn.tag=2000+i;
            btn.backgroundColor=[UIColor whiteColor];
            [btn setTitle:channel.at_name forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor colorWithHex:0x7a7a7a] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(hadSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_uiMoreChannelView addSubview:btn];
            [self updataFrame];
            c++;
        }
    }
}

#pragma mark - btn action

- (void)hadSelectBtnAction:(UIButton *)sender
{
    
    int tag = (int)sender.tag/1000;
    if (tag==1)//点击了我的频道上按钮
    {
        NSLog(@"%ld",sender.tag-1000);
        [self deleteMyChannelViewWithIndex:(int)sender.tag-1000];
    }
    if (tag==2)//点击了更多频道里的按钮
    {
        NSLog(@"2222=====%ld",sender.tag-2000);
        [self deleteMoreChannelViewWithIndex:(int)sender.tag-2000];
    }
    
}

- (void)deleteMyChannelViewWithIndex:(int)index
{
    [_AllChannel addObject:_HadSelectChannel[index]];
    _HadSelectChannel[index]=@"nil";
    UIButton *myButton = (UIButton *)[self.view viewWithTag:index+1000];
    [myButton removeFromSuperview];
    myButton.tag=_AllChannel.count-1+2000;
    [_uiMoreChannelView addSubview:myButton];
    int c=0;
    int c2=0;
    RowOne=1;
    RowTwo=1;
    for (UIView *view in _uiMyChannelView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (c==4)
            {
                c=0;
                RowOne++;
            }
            view.frame=CGRectMake(8*(c+1)+c*btnWidth, 7*(RowOne-1)+btnHeight*(RowOne-1), btnWidth, btnHeight);
            c++;
        }
    }
    
    for (UIView *view2 in _uiMoreChannelView.subviews)
    {
        if ([view2 isKindOfClass:[UIButton class]])
        {
            if (c2==4)
            {
                c2=0;
                RowTwo++;
            }
            view2.frame=CGRectMake(8*(c2+1)+c2*btnWidth, 7*(RowTwo-1)+btnHeight*(RowTwo-1), btnWidth, btnHeight);
            c2++;
        }
    }
    [self updataFrame];
    
}

- (void)deleteMoreChannelViewWithIndex:(int)index
{
    [_HadSelectChannel addObject:_AllChannel[index]];
    _AllChannel[index]=@"nil";
    UIButton *myButton = (UIButton *)[self.view viewWithTag:index+2000];
    [myButton removeFromSuperview];
    myButton.tag=_HadSelectChannel.count-1+1000;
    [_uiMyChannelView addSubview:myButton];
    int c=0;
    int c2=0;
    RowOne=1;
    RowTwo=1;
    for (UIView *view in _uiMyChannelView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (c==4)
            {
                c=0;
                RowOne++;
            }
            view.frame=CGRectMake(8*(c+1)+c*btnWidth, 7*(RowOne-1)+btnHeight*(RowOne-1), btnWidth, btnHeight);
            c++;
        }
    }
    
    for (UIView *view2 in _uiMoreChannelView.subviews)
    {
        if ([view2 isKindOfClass:[UIButton class]])
        {
            if (c2==4)
            {
                c2=0;
                RowTwo++;
            }
            view2.frame=CGRectMake(8*(c2+1)+c2*btnWidth, 7*(RowTwo-1)+btnHeight*(RowTwo-1), btnWidth, btnHeight);
            c2++;
        }
    }
    [self updataFrame];
}

#pragma mark - 更新界面尺寸
- (void)updataFrame
{
    _conMyChannelHeight.constant=btnHeight*RowOne+7*(RowOne-1);
    _conMoreChannelViewHeight.constant=btnHeight*RowTwo+7*(RowTwo-1);
    _conContentViewWidth.constant=kSCREEN_WIDTH;
    _conContentViewHeight.constant = _conMyChannelHeight.constant+_conMoreChannelViewHeight.constant+350;
    _uiContentScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _conContentViewHeight.constant);
    
}
#pragma mark - 父类方法重写
// 左侧返回点击事件
-(void)leftNavBtnAction{
    [self.view endEditing:YES];
    if (_saveDataTag==1)
    {
        //将已选择频道的model数组整理后返回给上个界面
        NSMutableArray *returnArr  =[NSMutableArray new];
        for (NSObject *str in _HadSelectChannel)
        {
            if ([str isKindOfClass:[ChannelListModel class]])
            {
                [returnArr addObject:str];
            }
        }
        [self.delegate returnWithArr:returnArr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交

- (IBAction)submitBtnAction:(UIButton *)sender
{
    NSMutableArray *returnArr  =[NSMutableArray new];
    for (NSObject *str in _HadSelectChannel)
    {
        NSLog(@"%@",str);
        if ([str isKindOfClass:[ChannelListModel class]])
        {
            [returnArr addObject:str];
        }
    }
    if (returnArr.count==0)
    {
        [CRToastUtil showAttentionMessageWithText:@"请添加频道!"];
        return;
    }
    NSMutableString *channelID = [NSMutableString new];
    for (ChannelListModel *model in returnArr)
    {
        [channelID appendFormat:@"%@", [NSString stringWithFormat:@"%@,",model.at_id]];
    }
    //删除最后的逗号
    NSString *channelidstr = [channelID substringToIndex:(channelID.length-1)];

    if (_saveDataTag == 1)//基站认证的提交
    {
        [SVProgressHUDUtil show];
        
        // 上传七牛云
        [QNCustomUploadManager uploadImage:_estationmodel.headImg imgKey:[QNKeyHelper getQNKey:[NSString stringWithFormat:@"%@%@", @"QU",[[MemberManager sharedInstance]memberId]]  suffix:nil] maxSize:CGSizeMake(1080, 1920) success:^(NSString *imageName) {
            // 提交
            [[WebAccessManager sharedInstance]submitOrgAuthInfoWithor_name:_estationmodel.name or_desc:_estationmodel.estationTextView or_image_url:imageName ot_id:_estationmodel.otid at_ids:channelidstr Completion:^(WebResponse *response, NSError *error) {
                if (response.success)
                {
                    [SVProgressHUDUtil showSuccessWithStatus:@"提交成功!"];
                    [self.navigationController popToRootViewControllerAnimated:1];
                }
                else
                {
                    [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
                    [SVProgressHUDUtil dismiss];
                }
            }];
        } failure:^{
            [SVProgressHUDUtil showErrorWithStatus:@"网络不太顺畅！"];
        }];
    }
    else//基站修改的提交
    {
        if (_or_id)
        {
            [SVProgressHUDUtil show];
            //保存频道变更
            [[WebAccessManager sharedInstance]updateOrgChannelsWithor_id:_or_id at_ids:channelidstr Completion:^(WebResponse *response, NSError *error) {
                if (response) {
                    if (response.success)
                    {
                        [SVProgressHUDUtil showSuccessWithStatus:@"提交成功!"];
                        [self.navigationController popViewControllerAnimated:1];
                    }
                    else
                    {
                        [SVProgressHUDUtil showErrorWithStatus:response.errorMsg];
                    }
                }else{
                    NSString *erroemsg = error.userInfo[@"errorMessage"];
                    [SVProgressHUDUtil showErrorWithStatus:erroemsg];
                }
                
            }];
        }
    }
    
    
}


@end
