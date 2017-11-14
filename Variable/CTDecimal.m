//
//  CTDecimal.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTDecimal.h"

#import "CTEmptyVL.h"

@implementation CTDecimal


// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue
{
    return [self formatWithDecimal:decimalValue prefix:nil suffix:nil];
}

// NSDecimalNumberから数値フォーマット文字列を生成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue scale:(int)scale
{
    return [self formatWithDecimal:decimalValue prefix:@"" suffix:@"" scale:scale];
}

// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;
{
    static NSNumberFormatter *numberFormat;
    if(numberFormat == nil)
    {
        numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
    }
    prefixString = [CTEmptyVL compare:prefixString replace:@""];
    suffixString = [CTEmptyVL compare:suffixString replace:@""];
    
    [numberFormat setPositivePrefix:prefixString];
    [numberFormat setPositiveSuffix:suffixString];
    [numberFormat setNegativePrefix:[NSString stringWithFormat:@"-%@", prefixString]];
    [numberFormat setNegativeSuffix:suffixString];
    
    return [numberFormat stringForObjectValue:decimalValue];
}


// NSDecimalNumberから数値フォーマット文字列を生成
+ (NSString *)formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(int)scale
{
    static NSNumberFormatter *numberFormat;
    if(numberFormat == nil)
    {
        numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
    }
    prefixString = [CTEmptyVL compare:prefixString replace:@""];
    suffixString = [CTEmptyVL compare:suffixString replace:@""];
    
    [numberFormat setPositivePrefix:prefixString];
    [numberFormat setPositiveSuffix:suffixString];
    [numberFormat setNegativePrefix:[NSString stringWithFormat:@"-%@", prefixString]];
    [numberFormat setNegativeSuffix:suffixString];
    
    [numberFormat setMinimumFractionDigits:scale];
    
    return [numberFormat stringForObjectValue:decimalValue];
}

// doubleからの変換
+ (NSDecimalNumber *)decimalWithDouble:(double)doubleValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:doubleValue] decimalValue]];
}

// NSStringからの変換
+ (NSDecimalNumber *)decimalWithString:(NSString *)stringValue
{
    NSDecimalNumber *decimalValue = [NSDecimalNumber zero];
    @try
    {
        decimalValue = [NSDecimalNumber decimalNumberWithString:stringValue];
    }
    @catch (NSException *exception)
    {
        decimalValue = [self decimalWithDouble:[stringValue doubleValue]];
    }
    @finally {}
    return decimalValue;
}

@end
