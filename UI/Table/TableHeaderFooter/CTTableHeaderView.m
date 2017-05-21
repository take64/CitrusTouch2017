//
//  CTTableHeaderView.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/05/13.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableHeaderView.h"

@implementation CTTableHeaderView

// init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self)
    {
        // style
        [[[self label] callStyle] addStyles:@{
                                              @"color"              :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellHeadTextColor]],
                                              @"background-color"   :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellHeadBackColor]]
                                              }];
    }
    return self;
}

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CTTableHeaderView_%03ld", (long)section];
}

@end
