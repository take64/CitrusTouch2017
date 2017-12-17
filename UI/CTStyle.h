//
//  CKStyle.h
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

// vertical allignment
typedef NS_ENUM(NSInteger, CTStyleVerticalAlignment) {
    CTStyleVerticalAlignmentTop,
    CTStyleVerticalAlignmentMiddle,
    CTStyleVerticalAlignmentBottom,
};

// sizing
typedef struct {
    CGFloat left;
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
} CTSizing;

// padding
typedef CTSizing CTPadding;

// margin
typedef CTSizing CTMargin;

// CTRectの差分加算
__attribute__((unused)) static CGRect CGRectDiff(CGRect source, CGRect diff)
{
    CGRect rect = CGRectZero;
    rect.origin.x   = source.origin.x     + diff.origin.x;
    rect.origin.y   = source.origin.y     + diff.origin.y;
    rect.size.width = source.size.width   + diff.size.width;
    rect.size.height= source.size.height  + diff.size.height;
    return rect;
}

// radius
typedef struct {
    CGFloat left_top;
    CGFloat right_top;
    CGFloat right_bottom;
    CGFloat left_bottom;
} CTRadius;


@interface CTStyle : NSObject <NSCopying>
{
    // スタイル
    NSMutableDictionary *_styles;
}

//
// property
//
@property (nonatomic, retain) NSMutableDictionary *_styles;



//
// method
//

// 初期化
- (id)initWithStyles:(NSDictionary *)dictionaryValue;

// 初期化
- (id)initWithStyleDictionary:(NSDictionary *)dictionaryValue __attribute__ ((deprecated));

// 追加
- (void)addStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// 追加
- (void)addStyles:(NSDictionary *)dictionaryValue;

// 追加
- (void)addStyleDictionary:(NSDictionary *)dictionaryValue __attribute__ ((deprecated));

// 削除
- (void)removeStyleKey:(NSString *)keyValue;

// 取得
- (NSString *)callStyleKey:(NSString *)keyValue;

// 設定
- (void)setStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// 設定
- (void)setStyleDictionary:(NSDictionary *)dictionaryValue __attribute__ ((deprecated));

// 全取得
- (NSMutableDictionary *)callAllStyles;

// フォント取得
- (UIFont *)callFont;

// フォント要素取得
- (NSMutableDictionary *)callFontAttributes;

// サイズ取得
- (CGSize)callSize;

// サイズ設定
- (void)setSize:(CGSize)size;

// ポイント取得
- (CGPoint)callPoint;

// ポイント設定
- (void)setPoint:(CGPoint)point;

// パディング取得
- (CTPadding)callPadding;

// パディング設定
- (void)setPadding:(CTPadding)padding;

// マージン取得
- (CTMargin)callMargin;

// マージン設定
- (void)setMargin:(CTMargin)margin;

// 角丸取得
- (CTRadius)callBorderRadius;

// 角丸設定
- (void)setBorderRadius:(CTRadius)radius;

// 横文字寄せ取得
- (NSTextAlignment)callTextAlignment;

// 縦文字寄せ取得
- (CTStyleVerticalAlignment)callVerticalAlignment;

// フレーム取得
- (CGRect)callFrame;

// フレーム設定
- (void)setFrame:(CGRect)frame;

// マージン取得(右)
- (CGFloat)callMarginRight;
// マージン取得(下)
- (CGFloat)callMarginBottom;

// ボーダー幅取得
- (CGFloat)callBorderWidth;

// 改行モードの取得
- (NSLineBreakMode)callLineBreakMode;

@end
