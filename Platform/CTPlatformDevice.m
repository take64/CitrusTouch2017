//
//  CTPlatformDevice.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTPlatformDevice.h"

#include <sys/sysctl.h>

@implementation CTPlatformDevice

// Retinaディスプレイ
+ (BOOL)isRetinaDisplay
{
    if([UIScreen instanceMethodForSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f)
    {
        return YES;
    }
    return NO;
}

// iPhone?
+ (BOOL)isIPhone
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPhone"] == YES)
    {
        return YES;
    }
    return NO;
}

// iPad?
+ (BOOL)isIPad
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPad"] == YES)
    {
        return YES;
    }
    return NO;
}

// iPod touch?
+ (BOOL)isIPod
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPod"] == YES)
    {
        return YES;
    }
    return NO;
}

// プラットフォームを取得
+ (NSString *)platform
{
    return [[UIDevice currentDevice] model];
}

// モデルを取得
+ (NSString *)model
{
    return [[UIDevice currentDevice] model];
}

// システム情報取得
+ (NSString *)getSystemInfByName:(char *)typeSpecifier
{
    // バッファサイズ取得
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    // データ格納
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    // NSString型に変更
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

@end
