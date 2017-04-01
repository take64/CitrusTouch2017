//
//  CTColor.h
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTColor : NSObject

// 16進数カラー からCTColor(UIColor) オブジェクトを取得
+ (UIColor *)colorWithHEXString:(NSString *)hexString;

// 16進数カラー からCTColor(UIColor) オブジェクトを取得(透過色付き)
+ (UIColor *)colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha;

// 16進数カラー から補色CTColor(UIColor) オブジェクトを取得
+ (UIColor *)complementaryColorWithHEXString:(NSString *)hexString;

// CTColor(UIColor) から 16進数文字列を取得
+ (NSString *)hexStringWithColor:(UIColor *)colorValue;

@end
