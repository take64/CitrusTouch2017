//
//  CTStyle.m
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import "CTStyle.h"

@implementation CTStyle

//
// synthesize
//
@synthesize _styles;



#pragma mark - extends
//
// extends
//

// init
- (id) init
{
    self = [super init];
    if (self)
    {
        [self set_styles:[NSMutableDictionary dictionaryWithCapacity:2]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// 初期化
- (id) initWithStyles:(NSDictionary *)dictionaryValue
{
    self = [self init];
    if (self)
    {
        [self addStyles:dictionaryValue];
    }
    return self;
}

// 初期化
- (id) initWithStyleDictionary:(NSDictionary *)dictionaryValue
{
    self = [self init];
    if (self)
    {
        [self setStyleDictionary:dictionaryValue];
    }
    return self;
}

// 追加
- (void)addStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
    if ([[self _styles] objectForKey:keyValue] == nil)
    {
        [[self _styles] setValue:dataValue forKey:keyValue];
    }
    else if ([[[self _styles] objectForKey:keyValue] isEqualToString:dataValue] == YES)
    {
        // 同じなら変更しない
    }
    else
    {
        [[self _styles] willChangeValueForKey:keyValue];
        [[self _styles] setValue:dataValue forKey:keyValue];
        [[self _styles] didChangeValueForKey:keyValue];
    }
}

// 追加
- (void)addStyles:(NSDictionary *)dictionaryValue
{
    for (NSString *keyValue in [[dictionaryValue copy] allKeys])
    {
        id valueValue = [dictionaryValue objectForKey:keyValue];
        if (valueValue == [NSNull null])
        {
            [self removeStyleKey:keyValue];
        }
        else
        {
            [self addStyleKey:keyValue value:valueValue];
        }
    }
}

// 追加
- (void)addStyleDictionary:(NSDictionary *)dictionaryValue
{
    for (NSString *keyValue in [dictionaryValue allKeys])
    {
        [self addStyleKey:keyValue value:[dictionaryValue objectForKey:keyValue]];
    }
}

// 削除
- (void)removeStyleKey:(NSString *)keyValue
{
    if ([[self _styles] objectForKey:keyValue] != nil)
    {
        [[self _styles] willChangeValueForKey:keyValue];
        [[self _styles] removeObjectForKey:keyValue];
        [[self _styles] didChangeValueForKey:keyValue];
    }
    else
    {
        [[self _styles] removeObjectForKey:keyValue];
    }
}

// 取得
- (NSString *)callStyleKey:(NSString *)keyValue
{
    return [[self _styles] objectForKey:keyValue];
}

// 設定
- (void)setStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
    [self addStyleKey:keyValue value:dataValue];
}

// 設定
- (void)setStyleDictionary:(NSDictionary *)dictionaryValue
{
    [self addStyleDictionary:dictionaryValue];
}

// 全取得
- (NSMutableDictionary *)callAllStyles
{
    return [self _styles];
}

// フォント取得
- (UIFont *)callFont
{
    // フォントサイズ
    NSString *fontSizeString = [self callStyleKey:@"font-size"];
    CGFloat fontSize = (fontSizeString == nil ? 12 : [fontSizeString floatValue]);

    // フォントボールド
    NSString *fontWeightString = [self callStyleKey:@"font-weight"];
    BOOL isFontBold = NO;
    if (fontWeightString != nil && [fontWeightString isEqualToString:@"bold"] == YES)
    {
        isFontBold = YES;
    }

    // 生成
    UIFont *font = (isFontBold == YES ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize]);
    return font;
}

// フォント要素取得
- (NSMutableDictionary *)callFontAttributes
{
    // 文字列要素
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];
    // ラインブレイク
    NSLineBreakMode lineBreakMode = [self callLineBreakMode];
    [paragraph setLineBreakMode:lineBreakMode];
    // フォント計算
    UIFont *font = [self callFont];
    [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];

    return attributes;
}

// サイズ取得
- (CGSize)callSize
{
    NSString *_widthString = [[self _styles] objectForKey:@"width"];
    NSString *_heightString = [[self _styles] objectForKey:@"height"];

    CGFloat _width = 0;
    CGFloat _height = 0;
    if (_widthString != nil)
    {
        _width = [_widthString floatValue];
    }
    if (_heightString != nil)
    {
        _height = [_heightString floatValue];
    }

    return CGSizeMake(_width, _height);
}

// サイズ設定
- (void)setSize:(CGSize)size
{
    [self addStyles:@{
                      @"width"  :CTStr(size.width),
                      @"height" :CTStr(size.height),
                      }];
}

// ポイント取得
- (CGPoint)callPoint
{
    NSString *_topString = [[self _styles] objectForKey:@"top"];
    NSString *_leftString = [[self _styles] objectForKey:@"left"];

    CGFloat _top = 0;
    CGFloat _left = 0;
    if (_topString != nil)
    {
        _top = [_topString floatValue];
    }
    if (_leftString != nil)
    {
        _left = [_leftString floatValue];
    }

    return CGPointMake(_left, _top);
}

// ポイント設定
- (void)setPoint:(CGPoint)point
{
    [self addStyles:@{
                      @"left"   :CTStr(point.x),
                      @"top"    :CTStr(point.y),
                      }];
}

// パディング取得
- (CTPadding)callPadding
{
    return [self callSizing:@"padding"];
}

// パディング設定
- (void)setPadding:(CTPadding)padding
{
    [self addStyles:@{
                      @"padding" :[self callSizingFormat:padding],
                      }];
}

// マージン取得
- (CTMargin)callMargin
{
    return [self callSizing:@"margin"];
}

// マージン設定
- (void)setMargin:(CTMargin)margin
{
    [self addStyles:@{
                      @"margin" :[self callSizingFormat:margin],
                      }];
}

// 角丸取得
- (CTRadius)callBorderRadius
{
    return [self callRadius:@"border-radius"];
}

// 角丸設定
- (void)setBorderRadius:(CTRadius)radius
{
    [self addStyles:@{
                      @"border-radius" :[self callRadiusFormat:radius],
                      }];
}

// 横文字寄せ取得
- (NSTextAlignment)callTextAlignment
{
    NSString *textAlignString = [self callStyleKey:@"text-align"];
    NSTextAlignment textAlignment;
    if (textAlignString == nil && [textAlignString isEqualToString:@"center"] == YES)
    {
        textAlignment = NSTextAlignmentCenter;
    }
    else if ([textAlignString isEqualToString:@"left"] == YES)
    {
        textAlignment = NSTextAlignmentLeft;
    }
    else if ([textAlignString isEqualToString:@"right"] == YES)
    {
        textAlignment = NSTextAlignmentRight;
    }
    // AnalyzeのLogic error対策
    else
    {
        textAlignment = NSTextAlignmentCenter;
    }
    return textAlignment;
}

// 縦文字寄せ取得
- (CTStyleVerticalAlignment)callVerticalAlignment
{
    NSString *verticalAlignString = [self callStyleKey:@"vertical-align"];
    CTStyleVerticalAlignment verticalAlignment;
    if (verticalAlignString == nil && [verticalAlignString isEqualToString:@"middle"] == YES)
    {
        verticalAlignment = CTStyleVerticalAlignmentMiddle;
    }
    else if ([verticalAlignString isEqualToString:@"top"] == YES)
    {
        verticalAlignment = CTStyleVerticalAlignmentTop;
    }
    else if ([verticalAlignString isEqualToString:@"bottom"] == YES)
    {
        verticalAlignment = CTStyleVerticalAlignmentBottom;
    }
    // AnalyzeのLogic error対策
    else
    {
        verticalAlignment = CTStyleVerticalAlignmentMiddle;
    }
    return verticalAlignment;
}

// フレーム取得
- (CGRect)callFrame
{
    CGPoint _point = [self callPoint];
    CGSize _size = [self callSize];

    CGRect _rect = CGRectZero;
    _rect.origin = _point;
    _rect.size = _size;
    return _rect;
}

// フレーム設定
- (void)setFrame:(CGRect)frame
{
    [self setSize:frame.size];
    [self setPoint:frame.origin];
}

// マージン取得(右)
- (CGFloat)callMarginRight
{
    return [self callMargin].right;
}

// マージン取得(下)
- (CGFloat)callMarginBottom
{
    return [self callMargin].bottom;
}

// ボーダー幅取得
- (CGFloat)callBorderWidth
{
    NSString *_borderWidthString = [self callStyleKey:@"border-width"];
    CGFloat _borderWidth = 0;
    if (_borderWidthString != nil)
    {
        // 枠線幅
        _borderWidth = [_borderWidthString floatValue];
    }
    return _borderWidth;
}

// 改行モードの取得
- (NSLineBreakMode)callLineBreakMode
{
    NSString *lineBreak = [self callStyleKey:@"line-break"];
    NSLineBreakMode lineBreakMode = NSLineBreakByWordWrapping;
    // 定義されていなければデフォルト返却
    if (lineBreak == nil)
    {
        return lineBreakMode;
    }

    if ([lineBreak rangeOfString:@"truncating-middle"].location != NSNotFound)
    {
        lineBreakMode |= NSLineBreakByTruncatingMiddle;
    }
    // 改行モード一覧
    NSDictionary *lineBreakModes = @{
                                     @"word-wrapping"       :@(NSLineBreakByWordWrapping),      // Wrap at word boundaries, default
                                     @"char-wrapping"       :@(NSLineBreakByCharWrapping),      // Wrap at character boundaries
                                     @"clipping"            :@(NSLineBreakByClipping),          // Simply clip
                                     @"truncating-head"     :@(NSLineBreakByTruncatingHead),    // Truncate at head of line: "...wxyz"
                                     @"truncating-tail"     :@(NSLineBreakByTruncatingTail),    // Truncate at tail of line: "abcd..."
                                     @"truncating-middle"   :@(NSLineBreakByTruncatingMiddle),  // Truncate middle of line:  "ab...yz"
                                     };
    return [[lineBreakModes objectForKey:lineBreak] integerValue];
}



#pragma mark - private
//
// private
//

// サイズ構造体の取得
- (CTSizing)callSizing:(NSString *)keyName
{
    CTSizing element = {0, 0, 0, 0};
    NSString *_string = [self callStyleKey:keyName];
    if (_string != nil)
    {
        NSArray *_components = [_string componentsSeparatedByString:@" "];
        NSUInteger count = [_components count];
        if (count == 4)
        {
            element.top     = [[_components objectAtIndex:0] floatValue];
            element.right   = [[_components objectAtIndex:1] floatValue];
            element.bottom  = [[_components objectAtIndex:2] floatValue];
            element.left    = [[_components objectAtIndex:3] floatValue];
        }
        else if (count == 3)
        {
            element.top     = [[_components objectAtIndex:0] floatValue];
            element.right   = [[_components objectAtIndex:1] floatValue];
            element.bottom  = [[_components objectAtIndex:2] floatValue];
            element.left    = element.top;
        }
        else if (count == 2)
        {
            element.top     = [[_components objectAtIndex:0] floatValue];
            element.right   = [[_components objectAtIndex:1] floatValue];
            element.bottom  = element.top;
            element.left    = element.right;
        }
        else if (count == 1)
        {
            element.top     = [[_components objectAtIndex:0] floatValue];
            element.right   = element.top;
            element.bottom  = element.top;
            element.left    = element.top;
        }
    }
    return element;
}

// サイズ構造体文字列の取得
- (NSString *)callSizingFormat:(CTSizing)sizing
{
    return CTStringf(@"%f %f %f %f", sizing.top, sizing.right, sizing.bottom, sizing.left);
}

// 角丸構造体の取得
- (CTRadius)callRadius:(NSString *)keyName
{
    CTRadius element = {0, 0, 0, 0};
    NSString *_string = [self callStyleKey:keyName];
    if (_string != nil)
    {
        NSArray *_components = [_string componentsSeparatedByString:@" "];
        NSUInteger count = [_components count];
        if (count == 4)
        {
            element.left_top    = [[_components objectAtIndex:0] floatValue];
            element.right_top   = [[_components objectAtIndex:1] floatValue];
            element.right_bottom= [[_components objectAtIndex:2] floatValue];
            element.left_bottom = [[_components objectAtIndex:3] floatValue];
        }
        else if (count == 3)
        {
            element.left_top    = [[_components objectAtIndex:0] floatValue];
            element.right_top   = [[_components objectAtIndex:1] floatValue];
            element.right_bottom= [[_components objectAtIndex:2] floatValue];
            element.left_bottom = element.right_top;
        }
        else if (count == 2)
        {
            element.left_top    = [[_components objectAtIndex:0] floatValue];
            element.right_top   = [[_components objectAtIndex:1] floatValue];
            element.right_bottom= element.left_top;
            element.left_bottom = element.right_top;
        }
        else if (count == 1)
        {
            element.left_top    = [[_components objectAtIndex:0] floatValue];
            element.right_top   = element.left_top;
            element.right_bottom= element.left_top;
            element.left_bottom = element.right_top;
        }
    }
    return element;
}

// 角丸構造体文字列の取得
- (NSString *)callRadiusFormat:(CTRadius)radius
{
    return CTStringf(@"%f %f %f %f", radius.left_top, radius.right_top, radius.right_bottom, radius.left_bottom);
}


#pragma mark - NSCopying
//
// NSCopying
//
- (id)copyWithZone:(NSZone *)zone
{
    CTStyle *result = [[self class] allocWithZone:zone];
    if (result)
    {
        [result set_styles:[[self _styles] mutableCopyWithZone:zone]];
    }
    return result;
}

@end
