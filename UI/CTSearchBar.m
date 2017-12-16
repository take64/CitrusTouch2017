//
//  CTSearchBar.m
//  CitrusTouch3
//
//  Created by take64 on 2017/12/16.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTSearchBar.h"

@implementation CTSearchBar



//
// synthesize
//
@synthesize toolbar;

#pragma mark - method
//
// method
//

// init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // ツールバー
        [self setToolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)]];
        [[self toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self toolbar] setBarTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTintColor]];
        [[self toolbar] setTranslucent:YES];

        // ツールバーパーツ
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        CTButtonGroup *buttonGroup = [[CTButtonGroup alloc] initWithFrame:CGRectZero];
        [buttonGroup addButtonWithTitle:@"閉じる" complete:^(CTButton *buttonValue) {
            [self onTapBarButtonClose];
        }];
        [[self toolbar] setItems:@[ barSpacer, [buttonGroup toBarButtonItem] ]];

        // ツールバー(配置)
        [self setInputAccessoryView:[self toolbar]];
    }
    return self;
}



#pragma mark - private
//
// private
//

// ボタン押下時(閉じる)
- (void)onTapBarButtonClose
{
    [self resignFirstResponder];
}

@end
