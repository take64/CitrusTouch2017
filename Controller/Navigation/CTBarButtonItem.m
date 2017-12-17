//
//  CTBarButtonItem.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/11.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTBarButtonItem.h"

@implementation CTBarButtonItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTextColor]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// カスタムビューの生成/取得
+ (CTBarButtonItem *)customView:(UIView *)viewValue
{
    return [[[self class] alloc] initWithCustomView:viewValue];
}

// スペーサーの取得
+ (CTBarButtonItem *)flexibleSpacerItem
{
    return [[[self class] alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
