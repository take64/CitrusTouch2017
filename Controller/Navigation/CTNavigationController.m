//
//  CTNavigationController.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/11.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTNavigationController.h"

@interface CTNavigationController ()

@end

@implementation CTNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        // ナヴィゲーション
        [[self navigationBar] setBarTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTintColor]];
        [[self navigationBar] setTitleTextAttributes:@{
                                                       NSForegroundColorAttributeName :[[CitrusTouchApplication callTheme] callNavigationBarTextColor]
                                                       }];
    }
    return self;
}


@end
