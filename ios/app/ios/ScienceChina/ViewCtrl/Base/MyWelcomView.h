//
//  MyWelcomView.h

#import <UIKit/UIKit.h>

@interface MyWelcomView : UIView

@property (nonatomic, copy) void(^dismissBlock)(UIButton *);

@end
