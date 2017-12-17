//
//  CTTableCell.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

#import "CTLabel.h"
#import "CTPlatformDevice.h"

@implementation CTTableCell



//
// synthesize
//
@synthesize entity;
@synthesize object;
@synthesize prefixLabel;
@synthesize suffixLabel;
@synthesize prefixWidth;
@synthesize suffixWidth;
@synthesize contentFrame;
@synthesize prefixPriority;
@synthesize contentPriority;
@synthesize suffixPriority;
@synthesize layouted;
@synthesize subLayouted;
@synthesize bgView;



#pragma mark - extends
//
// extends
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // parts
        CTLabel *label;

        // 優先度
        [self priorityPrefix:CTTableCellPartPriorityMiddle content:CTTableCellPartPriorityMiddle suffix:CTTableCellPartPriorityMiddle];

        // プレフィックス
        label = [[CTLabel alloc] initWithText:prefixString];
        [[label callStyle] addStyles:@{
                                       @"font-size"    :@"14",
                                       @"color"        :@"333333",
                                       @"text-align"   :@"left",
                                       @"font-weight"  :@"bold",
                                       }];
        [[self contentView] addSubview:label];
        [self setPrefixLabel:label];

        // サフィックス
        label = [[CTLabel alloc] initWithText:suffixString];
        [[label callStyle] addStyles:@{
                                       @"font-size"    :@"14",
                                       @"color"        :@"333333",
                                       @"text-align"   :@"center",
                                       }];
        [[self contentView] addSubview:label];
        [self setSuffixLabel:label];

        // レイアウト
        [self setLayouted:NO];
        [self setSubLayouted:NO];

        // 背景
        [self setBgView:[[CTControl alloc] initWithFrame:[self frame]]];
        [[self bgView] setUserInteractionEnabled:NO];
        [self addSubview:[self bgView]];
    }
    return self;
}

// 優先度設定
- (void)priorityPrefix:(CTTableCellPartPriority)prefix content:(CTTableCellPartPriority)content suffix:(CTTableCellPartPriority)suffix
{
    [self setPrefixPriority:prefix];
    [self setContentPriority:content];
    [self setSuffixPriority:suffix];
}

// レイアウト
- (void)layoutSubviews
{
    [super layoutSubviews];

    // 未レイアウトの場合
    if ([self isLayouted] == NO)
    {
        // コンテンツフレーム
        CGRect contentRect = [[self contentView] frame];

        // 背景
        [[self bgView] setFrame:contentRect];

        // アクセサリがある場合(アクセサリ分を縮める)
        if ([self accessoryType] != UITableViewCellAccessoryNone)
        {
            contentRect.size.width -= 8;
        }

        // プレフィックスサイズ
        if (([[self prefixLabel] text] != nil && [[[self prefixLabel] text] length] > 0) || [self prefixWidth] > 0)
        {
            // prefix優先度(非表示)
            if ([self prefixPriority] == CTTableCellPartPriorityHidden)
            {
                [self setPrefixWidth:0];
            }
            // prefix優先度(高)
            else if ([self prefixPriority] == CTTableCellPartPriorityHigh)
            {
                CGSize prefixFontSize = [[[self prefixLabel] text] sizeWithAttributes:@{ NSFontAttributeName :[[[self prefixLabel] callStyle] callFont] }];
                [self setPrefixWidth:prefixFontSize.width + 16];
            }
            // prefix優先度(中/低)
            else if ([self prefixPriority] == CTTableCellPartPriorityMiddle || [self prefixPriority] == CTTableCellPartPriorityLow)
            {
                [self setPrefixWidth:8];
                if ([CTPlatformDevice isIPad] == YES)
                {
                    [self setPrefixWidth:120];
                }
                else
                {
                    [self setPrefixWidth:80];
                }
            }
        }
        CGRect prefixRect = CGRectMake(16, 0, [self prefixWidth], contentRect.size.height);
        [[self prefixLabel] setFrame:prefixRect];

        // サフィックスサイズ
        if (([[self suffixLabel] text] != nil && [[[self suffixLabel] text] length] > 0) || [self suffixWidth] > 0)
        {
            // suffix優先度(高/中)
            if ([self suffixPriority] == CTTableCellPartPriorityHigh || [self suffixPriority] == CTTableCellPartPriorityMiddle)
            {
                CGSize suffixFontSize = [[[self suffixLabel] text] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont] }];
                [self setSuffixWidth:suffixFontSize.width + 16];
            }
            // suffix優先度(低)
            else if ([self suffixPriority] == CTTableCellPartPriorityLow)
            {
                CGSize suffixFontSize = [[[self suffixLabel] text] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont]}];
                [self setSuffixWidth:suffixFontSize.width];
            }
            // suffix優先度(非表示)
            else if ([self suffixPriority] == CTTableCellPartPriorityHidden)
            {
                [self setSuffixWidth:0];
            }
        }
        CGRect suffixRect = CGRectMake(contentRect.size.width - [self suffixWidth] , 0, [self suffixWidth], contentRect.size.height);
        [[self suffixLabel] setFrame:suffixRect];

        // コンテンツサイズ変更
        contentRect.origin.x += [self prefixWidth];
        contentRect.size.width -= [self prefixWidth];
        contentRect.size.width -= [self suffixWidth];
        [self setContentFrame:contentRect];

        // レイアウト済み
        [self setLayouted:YES];
    }
}



#pragma mark - method
//
// method
//

// bind entity
- (void)bindEntity:(NSManagedObject *)entityValue
{
    [self setEntity:entityValue];
    [self redraw];
}

// bind object
- (void)bindObject:(NSObject *)objectValue
{
    [self setObject:objectValue];
    [self redraw];
}

// redraw
- (void)redraw
{
}

@end
