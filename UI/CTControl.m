//
//  CTControl.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//
#import "CTControl.h"

#import <objc/runtime.h>

#import "CTStyle.h"
#import "CTColor.h"

@implementation CTControl



//
// synthesize
//
@synthesize ctstyleNormal;
@synthesize ctstyleHighlighted;
@synthesize ctstyleDisabled;
@synthesize text;
@synthesize controlState;
@synthesize userInfo;


// init
- (id)initWithFrame:(CGRect)frame
{
    // デフォルト処理
    frame = (CGRectIsEmpty(frame) == YES ? CGRectMake(0, 0, 64, 48) : frame);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        // 初期設定
        [[self callStyleNormal] addStyles:@{
                                            @"background-color"    :@"00000000",
                                            @"left"                :@"0",
                                            @"top"                 :@"0",
                                            @"width"               :CTStr(frame.size.width),
                                            @"height"              :CTStr(frame.size.height),
                                            }];
        // 値監視
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"width" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"top" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"left" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

// キー値監視
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGRect _frame = [self frame];
    // width 変更時
    if ([keyPath isEqualToString:@"width"] == YES)
    {
        _frame.size.width = [[[self callStyleNormal] callStyleKey:@"width"] floatValue];
    }
    // height 変更時
    else if ([keyPath isEqualToString:@"height"] == YES)
    {
        _frame.size.height = [[[self callStyleNormal] callStyleKey:@"height"] floatValue];
    }
    // top 変更時
    else if ([keyPath isEqualToString:@"top"] == YES)
    {
        _frame.origin.y = [[[self callStyleNormal] callStyleKey:@"top"] floatValue];
    }
    // left 変更時
    else if ([keyPath isEqualToString:@"left"] == YES)
    {
        _frame.origin.x = [[[self callStyleNormal] callStyleKey:@"left"] floatValue];
    }
    [self setFrame:_frame];
}

// 描画
- (void)drawRect:(CGRect)rect
{
    // コンテクスト
    CGContextRef context = UIGraphicsGetCurrentContext();

    // スタイルシート
    CTStyle *stylesheet = [self callControlStateStylesheet];

    // 文字列要素
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];

    CGContextSaveGState(context);

    CGRect contentRect = rect;

    // マージン
    CTMargin margin = [stylesheet callMargin];
    contentRect = CGRectMake((contentRect.origin.x + margin.left),
                             (contentRect.origin.y + margin.top),
                             (contentRect.size.width  - (margin.left + margin.right)),
                             (contentRect.size.height - (margin.top + margin.bottom)));

    // パッディング
    CGRect paddedContentRect = contentRect;
    CTPadding padding = [stylesheet callPadding];
    paddedContentRect = CGRectMake((contentRect.origin.x + padding.left),
                                   (contentRect.origin.y + padding.top),
                                   (contentRect.size.width  - (padding.left + padding.right)),
                                   (contentRect.size.height - (padding.top + padding.bottom)));

    // 背景描画
    NSString *_backgroundColorString = [stylesheet callStyleKey:@"background-color"];
    if (_backgroundColorString != nil)
    {
        UIColor *_ctcolor = [CTColor colorWithHEXString:_backgroundColorString];
        CGColorRef _colorref = [_ctcolor CGColor];
        const CGFloat *_colors = CGColorGetComponents(_colorref);
        CGContextSetRGBFillColor(context, _colors[0], _colors[1], _colors[2], _colors[3]);
    }

    // ボーダー角丸
    CTRadius borderRadius = [stylesheet callBorderRadius];
    [self addPathRadius:borderRadius rect:contentRect];
    CGContextFillPath(context);
    CGContextRestoreGState(context);

    // 影設定
    NSString *_boxShadowString = [stylesheet callStyleKey:@"box-shadow"];
    if (_boxShadowString != nil)
    {
        CGContextSaveGState(context);
        [self addPathRadius:borderRadius rect:contentRect];

        NSArray *_boxShadowComponents = [_boxShadowString componentsSeparatedByString:@" "];
        CGFloat  _boxShadowLeft    = [[_boxShadowComponents objectAtIndex:0] floatValue];
        CGFloat  _boxShadowTop     = [[_boxShadowComponents objectAtIndex:1] floatValue];
        CGFloat  _boxShadowShading = [[_boxShadowComponents objectAtIndex:2] floatValue];
        UIColor *_boxShadowColor   = [CTColor colorWithHEXString:[_boxShadowComponents objectAtIndex:3]];

        // 背景色処理
        if (_backgroundColorString != nil)
        {
            CGColorRef colorRef = [[CTColor colorWithHEXString:_backgroundColorString] CGColor];
            const CGFloat *colors = CGColorGetComponents(colorRef);
            CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
        }

        CGContextSetShadowWithColor(context, CGSizeMake(_boxShadowLeft, _boxShadowTop), _boxShadowShading, [_boxShadowColor CGColor]);
        CGContextFillPath(context);

        CGContextRestoreGState(context);
    }

    // グラデーション
    NSString *_backgroundImageString = [stylesheet callStyleKey:@"background-image"];
    if ([_backgroundImageString hasPrefix:@"linear-gradient"] == YES)
    {
        // 描画範囲
        CGContextSaveGState(context);
        [self addPathRadius:borderRadius rect:contentRect];
        CGContextClip(context);

        // トリム
        _backgroundImageString = [_backgroundImageString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        // 文字列置換
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"linear-gradient(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"rgba(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@")" withString:@","];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@" " withString:@""];

        // 要素数の取得
        NSArray *component = [_backgroundImageString componentsSeparatedByString:@","];
        NSInteger size = [component count] - 1;

        const long locationSize = (size / 5);
        const long componentSize = ((size / 5) * 4);

        // 要素
        CGFloat locations[locationSize];
        CGFloat components[componentSize];

        // 設定
        NSInteger count = 0;
        NSInteger locationCount = 0;
        NSInteger componentCount = 0;
        for (NSString *column in component)
        {
            if (count >= size)
            {
                break;
            }

            if (((count + 1) % 5) == 0)
            {
                locations[locationCount] = [column floatValue];
                locationCount++;
            }
            else
            {
                components[componentCount] = [column floatValue];
                componentCount++;
            }
            count++;
        }
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationSize);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, contentRect.origin.y), CGPointMake(0, contentRect.origin.y + contentRect.size.height), 0);

        CGContextRestoreGState(context);

        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }

    // 枠線
    NSString *_borderWidthString = [stylesheet callStyleKey:@"border-width"];
    CGFloat _borderWidth = 0;
    if (_borderWidthString != nil)
    {
        // 枠線幅
        _borderWidth = [_borderWidthString floatValue];

        CGContextSaveGState(context);

        // 枠線色
        NSString *_borderColorString = [stylesheet callStyleKey:@"border-color"];
        UIColor *_borderColor;
        if (_borderColorString == nil)
        {
            _borderColorString = @"000000";
        }
        _borderColor = [CTColor colorWithHEXString:_borderColorString];
        CGColorRef _colorref = [_borderColor CGColor];
        const CGFloat *_colors = CGColorGetComponents(_colorref);

        CGContextSetRGBStrokeColor(context, _colors[0], _colors[1], _colors[2], _colors[3]);
        CGContextSetLineWidth(context, _borderWidth);
        CGContextSetLineCap(context, kCGLineCapRound);

        // 描画範囲
        CGRect _drawRect = CGRectInset(contentRect, (_borderWidth / 2), (_borderWidth / 2));
        [self addPathRadius:borderRadius rect:_drawRect offset:(_borderWidth / -1)];
        CGContextStrokePath(context);

        CGContextRestoreGState(context);
    }

    // テキストレンダリング
    if ([self text] != nil)
    {
        CGContextSaveGState(context);

        // テキスト影
        NSString *_textShadowString = [stylesheet callStyleKey:@"text-shadow"];
        if (_textShadowString != nil)
        {
            NSArray *_textShadowComponents = [_textShadowString componentsSeparatedByString:@" "];
            CGFloat  _textShadowLeft    = [[_textShadowComponents objectAtIndex:0] floatValue];
            CGFloat  _textShadowTop     = [[_textShadowComponents objectAtIndex:1] floatValue];
            CGFloat  _textShadowShading = [[_textShadowComponents objectAtIndex:2] floatValue];
            UIColor *_textShadowColor   = [CTColor colorWithHEXString:[_textShadowComponents objectAtIndex:3]];
            CGContextSetShadowWithColor(context, CGSizeMake(_textShadowLeft, _textShadowTop), _textShadowShading, [_textShadowColor CGColor]);
        }

        // 文字色
        NSString *_colorString = [stylesheet callStyleKey:@"color"];
        UIColor *_ctcolor;
        if (_colorString != nil)
        {
            _ctcolor = [CTColor colorWithHEXString:_colorString];
        }
        else
        {
            _ctcolor = [CTColor colorWithHEXString:@"FFFFFF"];
        }
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName:_ctcolor}];

        // ラインブレイク
        NSLineBreakMode lineBreakMode = [stylesheet callLineBreakMode];
        [paragraph setLineBreakMode:lineBreakMode];

        // フォント計算
        UIFont *font;
        CGSize fontBounds;
        if ([[stylesheet callStyleKey:@"adjust-font"] isEqualToString:@"true"] == YES)
        {
            BOOL adjust = NO;
            while (adjust == NO)
            {
                font = [stylesheet callFont];
                [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
                fontBounds = [[self text] boundingRectWithSize:CGSizeMake(paddedContentRect.size.width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
                fontBounds.width = paddedContentRect.size.width;
                double fontSize = [[stylesheet callStyleKey:@"font-size"] doubleValue];
                if (fontBounds.height > paddedContentRect.size.height && fontSize > 1)
                {
                    fontBounds.height = paddedContentRect.size.height;

                    [stylesheet addStyleKey:@"font-size" value:[@(fontSize - 0.5) stringValue]];
                }
                else
                {
                    adjust = YES;
                }
            }
        }
        else
        {
            font = [stylesheet callFont];
            [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
            fontBounds = [[self text] boundingRectWithSize:paddedContentRect.size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
            fontBounds.width = paddedContentRect.size.width;
            if (fontBounds.height > paddedContentRect.size.height)
            {
                fontBounds.height = paddedContentRect.size.height;
            }
        }

        // 文字寄せ
        CGRect titleFrame = CGRectMake(0, 0, (fontBounds.width), (fontBounds.height));

        // text-align
        NSTextAlignment textAlignment = [stylesheet callTextAlignment];

        // vertical-align
        CTStyleVerticalAlignment verticalAlignment = [stylesheet callVerticalAlignment];

        // 横位置
        CGFloat titleFrameX = 0;
        if (textAlignment == NSTextAlignmentCenter)
        {
            titleFrameX = (paddedContentRect.size.width / 2 - fontBounds.width / 2) + paddedContentRect.origin.x;
        }
        else if (textAlignment == NSTextAlignmentLeft)
        {
            titleFrameX = paddedContentRect.origin.x;
        }
        else if (textAlignment == NSTextAlignmentRight)
        {
            titleFrameX = (paddedContentRect.origin.x + paddedContentRect.size.width) - fontBounds.width;
        }

        // 縦位置
        CGFloat titleFrameY = 0;
        if (verticalAlignment == CTStyleVerticalAlignmentTop)
        {
            titleFrameY = paddedContentRect.origin.y;
        }
        else if (verticalAlignment == CTStyleVerticalAlignmentMiddle)
        {
            titleFrameY = (paddedContentRect.size.height / 2 - fontBounds.height / 2) + paddedContentRect.origin.y;
        }
        else if (verticalAlignment == CTStyleVerticalAlignmentBottom)
        {
            titleFrameY = (paddedContentRect.size.height - fontBounds.height) + paddedContentRect.origin.y;
        }

        titleFrame.origin = CGPointMake(titleFrameX, titleFrameY);

        [paragraph setAlignment:textAlignment];

        [[self text] drawInRect:titleFrame withAttributes:attributes];

        CGContextRestoreGState(context);
    }
}

// 強制描画
- (void)setNeedsDisplay
{
    [super setNeedsDisplay];

    for (id childView in [self subviews])
    {
        if ([childView isKindOfClass:[CTControl class]] == YES)
        {
            [(CTControl *)childView setNeedsDisplay];
        }
    }
}



#pragma mark - method
//
// method
//

// 初期化
- (id)initWithText:(NSString *)textString
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        // タイトル
        [self setText:textString];
    }
    return self;
}

- (void)dealloc
{
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"left"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"top"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"width"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"height"];
}

// スタイル設定
- (CTStyle *)callStyle
{
    return [self callStyleNormal];
}
- (CTStyle *)callStyleNormal
{
    if ([self ctstyleNormal] == nil)
    {
        [self setCtstyleNormal:[[CTStyle alloc] init]];
    }
    return [self ctstyleNormal];
}
- (CTStyle *)callStyleHighlighted
{
    if ([self ctstyleHighlighted] == nil)
    {
        [self setCtstyleHighlighted:[[self callStyleNormal] copy]];
    }
    return [self ctstyleHighlighted];
}
- (CTStyle *)callStyleDisabled
{
    if ([self ctstyleDisabled] == nil)
    {
        [self setCtstyleDisabled:[[self callStyleNormal] copy]];
    }
    return [self ctstyleDisabled];
}
// スタイル設定
- (void)setStyle:(CTStyle *)styleValue
{
    [[self callStyle] addStyles:[styleValue callAllStyles]];
}
- (void)setStyleNormal:(CTStyle *)styleValue
{
    [[self callStyleNormal] addStyles:[styleValue callAllStyles]];
}
- (void)setStyleHighlighted:(CTStyle *)styleValue
{
    [[self callStyleHighlighted] addStyles:[styleValue callAllStyles]];
}
- (void)setStyleDisabled:(CTStyle *)styleValue
{
    [[self callStyleDisabled] addStyles:[styleValue callAllStyles]];
}

// ステート
- (void)modifyControlState:(CTControlState)_controlState
{
    // ステート設定
    [self setControlState:_controlState];

    // 強制描画
    [self setNeedsDisplay];
}

// ステート変更(enable)
- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled == YES)
    {
        [self modifyControlState:CTControlStateNormal];
    }
    else
    {
        [self modifyControlState:CTControlStateDisabled];
    }
    [self setNeedsDisplay];
}
// ステート変更(highlighted)
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted == YES)
    {
        [self modifyControlState:CTControlStateHighlighted];
    }
    else
    {
        [self modifyControlState:CTControlStateNormal];
    }
}

// 自動テキストサイズ計算
- (CGSize)calcTextAutoSize
{
    CGSize bounds = CGSizeZero;
    CTStyle *stylesheet = [self callStyle];
    CGFloat width = [stylesheet callSize].width;

    // フォント要素
    NSMutableDictionary *attributes = [stylesheet callFontAttributes];

    // サイズ計算
    CGSize fontBounds = [[self text] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
    bounds.width = ceil(fontBounds.width);
    bounds.height = ceil(fontBounds.height);

    return bounds;
}

// 自動テキストサイズ計算(パディング込み)
- (CGSize)calcTextAutoSizeWithPadding
{
    CGSize bounds = [self calcTextAutoSize];
    CTStyle *stylesheet = [self callStyle];

    // パディング追加
    CTPadding padding = [stylesheet callPadding];
    bounds.width += (padding.left + padding.right);
    bounds.height += (padding.top + padding.bottom);

    return bounds;
}


#pragma mark - private
//
// private
//

// 角丸のパスを生成
- (void)addPathRadius:(CTRadius)radius rect:(CGRect)rect
{
    [self addPathRadius:radius rect:rect offset:0];
}

// 角丸のパスを生成
- (void)addPathRadius:(CTRadius)radius rect:(CGRect)rect offset:(CGFloat)offset
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 角丸rect
    CGRect cornerCircleRect  = rect;

    // get points
    CGFloat minx = CGRectGetMinX(cornerCircleRect);
    CGFloat midx = CGRectGetMidX(cornerCircleRect);
    CGFloat maxx = CGRectGetMaxX(cornerCircleRect);
    CGFloat miny = CGRectGetMinY(cornerCircleRect);
    CGFloat midy = CGRectGetMidY(cornerCircleRect);
    CGFloat maxy = CGRectGetMaxY(cornerCircleRect);

    // 黒下地
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius.left_top     + offset);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius.right_top    + offset);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius.right_bottom + offset);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius.left_bottom  + offset);
    CGContextClosePath(context);
}

// コントロールステートに基づくスタイルシートの取得
- (CTStyle *)callControlStateStylesheet
{
    CTStyle *stylesheet = [[self callStyleNormal] copy];
    switch ([self controlState])
    {
        case CTControlStateNormal:
            break;
        case CTControlStateHighlighted:
            stylesheet = [self callStyleHighlighted];
            break;
        case CTControlStateDisabled:
            stylesheet = [self callStyleDisabled];
            break;
        default:
            break;
    }
    return stylesheet;
}

@end
