//
//  CTColor.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTColor.h"

@implementation CTColor

// カラーキャッシュ
+ (NSMutableDictionary *)callCacheColors
{
    static NSMutableDictionary *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [NSMutableDictionary dictionary];
    });
    return singleton;
}

// 16進数カラー からCTColor(UIColor) オブジェクトを取得
+ (UIColor *)colorWithHEXString:(NSString *)hexString
{
    NSMutableDictionary *cacheColors = [CTColor callCacheColors];
    UIColor *color = [cacheColors objectForKey:hexString];
    if (color == nil)
    {
        color = [CTColor colorWithHEXString:hexString alpha:1];
        [cacheColors setObject:color forKey:hexString];
    }
    return color;
}

// 16進数カラー からCTColor(UIColor) オブジェクトを取得(透過色付き)
+ (UIColor *)colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // 色文字列長
    long length = [hexString length];
    // 16進数値文字列から16進数値に変換( 'FFFFFF' => 0xFFFFFF )
    long long hexcolor = [self convertHex:hexString];
    // 色型に変更
    UIColor *uicolor;
    if (length == 6)
    {
        uicolor = [UIColor colorWithRed:((hexcolor>>16)&0xFF)/255.0
                                  green:((hexcolor>>8)&0xFF)/255.0
                                   blue:((hexcolor)&0xFF)/255.0
                                  alpha:alpha];
    }
    else if (length == 8)
    {
        uicolor = [UIColor colorWithRed:((hexcolor>>24)&0xFF)/255.0
                                  green:((hexcolor>>16)&0xFF)/255.0
                                   blue:((hexcolor>>8)&0xFF)/255.0
                                  alpha:((hexcolor)&0xFF)/255.0];
    }
    else
    {
        uicolor = [UIColor whiteColor];
    }
    return uicolor;
}

// 16進数カラー から補色CTColor(UIColor) オブジェクトを取得
+ (UIColor *)complementaryColorWithHEXString:(NSString *)hexString
{
    // 色文字列長
    long length = [hexString length];
    // 16進数値文字列から16進数値に変換( 'FFFFFF' => 0xFFFFFF )
    long long hexcolor = [self convertHex:hexString];
    // 色型に変更
    int red     = 1.0;
    int green   = 1.0;
    int blue    = 1.0;
    int alpha   = 1.0;
    if (length == 6)
    {
        red     = ((hexcolor>>16)&0xFF);
        green   = ((hexcolor>>8)&0xFF);
        blue    = ((hexcolor)&0xFF);
    }
    else if (length == 8)
    {
        red     = ((hexcolor>>24)&0xFF);
        green   = ((hexcolor>>16)&0xFF);
        blue    = ((hexcolor>>8)&0xFF);
        alpha   = ((hexcolor)&0xFF);
    }

    int max = MAX(MAX(red, green), blue);
    int min = MIN(MIN(red, green), blue);
    int total = max + min;
    total   = (total == 510 ? 0 : total);
    red     = total - red;
    green   = total - green;
    blue    = total - blue;
    UIColor *uicolor = [UIColor colorWithRed:red    / 255.0
                                       green:green  / 255.0
                                        blue:blue   / 255.0
                                       alpha:alpha];
    return uicolor;
}

// CTColor(UIColor) から 16進数文字列を取得
+ (NSString *)hexStringWithColor:(UIColor *)colorValue
{
    CGColorRef cgcolor = [colorValue CGColor];
    // 色を分解
    const CGFloat *colors;
    colors = CGColorGetComponents(cgcolor);
    int red     = colors[0] * 255.0;
    int green   = colors[1] * 255.0;
    int blue    = colors[2] * 255.0;
    int alpha   = colors[3] * 255.0;

    NSString *colorString = CTStringf(@"%02X%02X%02X%02X", red, green, blue, alpha);
    return colorString;
}

// table background color
+ (UIColor *)colorTableBackground
{
    return [CTColor colorWithHEXString:@"EBE9F0"];
}


#pragma mark - private
//
// private
//

// 16進数値文字列から16進数値に変換( 'FFFFFF' => 0xFFFFFF )
+ (long long)convertHex:(NSString *)hexString
{
    // 16進文字列変換( 'FFFFFF' => '0xFFFFFF' )
    NSString *color = CTStringf(@"0x%@", hexString);
    // 16進数値文字列から16進数値に変換( '0xFFFFFF' => 0xFFFFFF )
    const char *str = [color UTF8String];
    char *endptr;  // 変換不可能文字列の格納先
    int base = 0;  // 0: 8進(先頭0), 16進(先頭0x), 10進数モード
    return strtoll(str, &endptr, base);
}


@end
