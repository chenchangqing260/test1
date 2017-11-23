//
//  MyWelcomView.m

#import "MyWelcomView.h"

@interface MyWelcomView()
@property (weak, nonatomic) IBOutlet UIImageView *UIimage;

@end

@implementation MyWelcomView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [[WebAccessManager sharedInstance]getLatestLauncher:^(WebResponse *response, NSError *error) {
            if (response.success) {
    
//                NSString *urlStr = [NSString stringWithFormat:@"%@", response.data.image_url];
//                urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSLog(@"%@---03030---",urlStr);
                NSURL *_url = [NSURL URLWithString:response.data.image_url];
                
                [self.UIimage sd_setImageWithURL:_url placeholderImage:nil];
            }

    }];
    
//[self.UIimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505989232542&di=82b794539e8a5e4a24122d3ed307534b&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2Fuploadfile%2F2014%2F1014%2F20141014104708278.jpg"] placeholderImage:nil];
}

- (IBAction)dismissClick:(UIButton *)sender {
    self.dismissBlock(sender);
}

@end
