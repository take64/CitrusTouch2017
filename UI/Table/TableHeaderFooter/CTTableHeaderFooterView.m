//
//  CTTableHeaderFooterView.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/15.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableHeaderFooterView.h"

@implementation CTTableHeaderFooterView

//
// synthesize
//
@synthesize label;

// init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self)
    {
        // parts
        CTLabel *_label;
        
        // label
        _label = [[CTLabel alloc] initWithText:@""];
        [[_label callStyle] addStyles:@{
                                        @"text-align"   :@"left",
                                        @"color"        :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callTableCellHeadTextColor]],
                                        @"margin"       :@"4 8"
                                        }];
        [[self contentView] addSubview:_label];
        [self setLabel:_label];
        
        // theme
        [[self contentView] setBackgroundColor:[[CitrusTouchApplication callTheme] callTableCellHeadBackColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[[self label] callStyle] setFrame:rect];
}

#pragma mark - method

//
// method
//

// bind title
- (void)bindTitle:(NSString *)titleString
{
    [[self label] setText:titleString];
}

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CTTableHeaderFooterView_%03ld", (long)section];
}


@end
