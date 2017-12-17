//
//  CTControl.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTStyle.h"

// ステータス
typedef NS_OPTIONS(NSUInteger, CTControlState) {
    CTControlStateNormal,      // 標準
    CTControlStateHighlighted, // ハイライト
    CTControlStateDisabled,    // disable
};

@interface CTControl : UIControl
{
    // スタイルシート
    CTStyle *ctstyleNormal;
    CTStyle *ctstyleHighlighted;
    CTStyle *ctstyleDisabled;

    // 文字列
    NSString *text;

    // ステート
    CTControlState controlState;

    // 連携情報
    NSMutableDictionary *userInfo;
}



//
// property
//
@property (nonatomic, retain) CTStyle *ctstyleNormal;
@property (nonatomic, retain) CTStyle *ctstyleHighlighted;
@property (nonatomic, retain) CTStyle *ctstyleDisabled;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) CTControlState controlState;
@property (nonatomic, retain) NSMutableDictionary *userInfo;



//
// method
//

// 初期化
- (id)initWithText:(NSString *)textString;

// 状態変更
- (void)modifyControlState:(CTControlState)_controlState;

//// 再描画
//- (void)redraw;

// スタイル取得
- (CTStyle *)callStyle;
- (CTStyle *)callStyleNormal;
- (CTStyle *)callStyleHighlighted;
- (CTStyle *)callStyleDisabled;
// スタイル設定
- (void)setStyle:(CTStyle *)styleValue;
- (void)setStyleNormal:(CTStyle *)styleValue;
- (void)setStyleHighlighted:(CTStyle *)styleValue;
- (void)setStyleDisabled:(CTStyle *)styleValue;

// 自動テキストサイズ計算
- (CGSize)calcTextAutoSize;
// 自動テキストサイズ計算(パディング込み)
- (CGSize)calcTextAutoSizeWithPadding;

@end
