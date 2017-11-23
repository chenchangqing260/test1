//
//  FontResizableLabel.m
//  ScienceLife
//
//  Created by WangJensen on 3/22/16.
//  Copyright © 2016 WangJensen. All rights reserved.
//

#import "FontResizableLabel.h"
#import "MemberManager.h"

@interface FontResizableLabel()

@property (nonatomic) UIFont *originalFont;

@end

@implementation FontResizableLabel

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib
{
    self.originalFont = self.font;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* fontSize = [settings objectForKey:kUserDefaultKeyPreferedFontSize];
    if (!fontSize) {
        fontSize = @"Normal";
        [settings setObject:fontSize forKey:kUserDefaultKeyPreferedFontSize];
        [settings synchronize];
    }
    if ([fontSize isEqualToString:@"Small"]){
        [self resizeFontWithSize:Small];
    }else if([fontSize isEqualToString:@"Large"]){
        [self resizeFontWithSize:Large];
    }else{
        [self resizeFontWithSize:Normal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSettingChanged:) name:@"PreferedFontSizeChanged" object:nil];
}

- (void)fontSettingChanged:(NSNotification *)notification
{
    FontSize fontSize = (FontSize)((NSNumber *)[notification.userInfo objectForKey:@"fontSize"]).integerValue;
    [self resizeFontWithSize:fontSize];
}

- (void)resizeFontWithSize:(FontSize)fontSize
{
    if (fontSize == Large) {
        self.font = [UIFont fontWithName:self.originalFont.fontName size:self.originalFont.pointSize + 3];
    } else if (fontSize == Small) {
        self.font = [UIFont fontWithName:self.originalFont.fontName size:self.originalFont.pointSize - 2];
    } else{
        self.font = self.originalFont;
    }
}

@end
