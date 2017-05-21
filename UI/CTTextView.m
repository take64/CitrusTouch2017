//
//  CTTextView.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTextView.h"

@implementation CTTextView


//
// synthesize
//
@synthesize enableMenu;


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // メニュー表示ON
        [self setEnableMenu:YES];
    }
    return self;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if([self enableMenu] == NO)
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
        [self resignFirstResponder];
    }
    return [super canPerformAction:action withSender:sender];
}

@end
