//
//  CTTableFooterView.m
//  CitrusTouch3
//
//  Created by take64 on 2017/05/13.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableFooterView.h"

@implementation CTTableFooterView


// init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self)
    {
        // style
        [[[self label] callStyle] addStyles:@{
                                              @"color"              :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellFootTextColor]],
                                              @"background-color"   :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellFootBackColor]]
                                              }];
    }
    return self;
}

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CTTableFooterView_%03ld", (long)section];
}

@end
