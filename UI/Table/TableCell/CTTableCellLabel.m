//
//  CTTableCellLabel.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCellLabel.h"

@implementation CTTableCellLabel

//
// synthesize
//
@synthesize label;

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayouted] == NO)
    {
        [[self label] setFrame:[self contentFrame]];
        
        CGRect labelRect = [[self label] frame];
        labelRect.size.width -= 16;
        labelRect.origin.x += 8;
        [[self label] setFrame:labelRect];
        
        // レイアウト済み
        [self setSubLayouted:YES];
    }
}


#pragma mark - method
//
// method
//

// 初期化
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:nil reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}

// 初期化
- (instancetype)initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString content:nil suffix:nil reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}

// 初期化

- (instancetype)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // part
        CTLabel *_Label;
        
        // ラベル
        _Label = [[CTLabel alloc] initWithText:@""];
        [[_Label callStyle] addStyles:@{
                                       @"font-size" :@"14",
                                       @"color"     :@"000000",
                                       @"text-align":@"left",
                                       @"line-break":@"clipping",
                                       }];
        [_Label setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin |
                                     UIViewAutoresizingFlexibleWidth |
                                     UIViewAutoresizingFlexibleHeight)];
        if(textString == nil)
        {
            textString = @"";
        }
        [_Label setText:textString];
        [[self contentView] addSubview:_Label];
        [self setLabel:_Label];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // タッチイベントは透過
        [[self label] setUserInteractionEnabled:NO];
    }
    return self;
}

// テキスト取得
- (NSString *)contentText
{
    return [[self label] text];
}

// テキスト設定
- (void)setContentText:(NSString *)stringValue
{
    [[self label] setText:stringValue];
}

// 文字寄せ
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    NSString *textAlign = @"";
    switch(textAlignment)
    {
        case NSTextAlignmentLeft:   textAlign = @"left";    break;
        case NSTextAlignmentCenter: textAlign = @"center";  break;
        case NSTextAlignmentRight:  textAlign = @"right";   break;
        case NSTextAlignmentJustified:
        case NSTextAlignmentNatural:
        default:                    textAlign = @"left";    break;
    }
    
    [[[self label] callStyle] addStyleKey:@"text-align" value:textAlign];
}

@end
