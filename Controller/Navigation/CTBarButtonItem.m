//
//  CTBarButtonItem.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/11.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBarButtonItem.h"

@implementation CTBarButtonItem

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTextColor]];
    }
    return self;
}

@end
