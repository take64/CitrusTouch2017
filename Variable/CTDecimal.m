//
//  CTDecimal.m
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
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

@end
