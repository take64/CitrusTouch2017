//
//  CTTableCellButton.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCellButton.h"

#import "CTButton.h"

@implementation CTTableCellButton


//
// synthesize
//
@synthesize button;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayouted] == NO)
    {
        [[self button] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
        
        // レイアウト済み
        [self setSubLayouted:YES];
    }
}




#pragma mark - method
//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:prefixString content:textString suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // part
        CTButton *_button;
        
        // ボタン
        _button = [[CTButton alloc] initWithText:@""];
        [[_button callStyle] addStyles:@{
                                         @"font-size"       :@"16",
                                         @"font-weight"     :@"bold",
                                         @"text-shadow"     :@"0 -1 1 333333",
                                         @"background-color":@"0000FF",
                                         @"border-color"    :@"FFFFFF",
                                         @"border-width"    :@"1",
                                         @"border-radius"   :@"4",
                                         @"margin"          :@"4 12 4 12",
                                         @"box-shadow"      :@"0 1 4 000000",
                                         @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
                                         }];
        [[_button callStyleHighlighted] addStyles:@{
                                                    @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                    }];
        [[_button callStyleDisabled] addStyles:@{
                                                 @"background-color":@"666666",
                                                 }];
        if(textString != nil)
        {
            [_button setText:textString];
        }
        [[self contentView] addSubview:_button];
        [self setButton:_button];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

// テキスト取得
- (NSString *)contentText
{
    return [[self button] text];
}

// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self button] setText:stringValue];
}


@end
