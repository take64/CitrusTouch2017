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

@end
