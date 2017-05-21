//
//  CTDecimal.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTDecimal : NSObject

// NSDecimalNumberからフォーマット文字列を作成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue;

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue scale:(int)scale;

// NSDecimalNumberからフォーマット文字列を作成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(int)scale;


// doubleからの変換
+ (NSDecimalNumber *)decimalWithDouble:(double)doubleValue;

// NSStringからの変換
+ (NSDecimalNumber *)decimalWithString:(NSString *)stringValue;

@end
