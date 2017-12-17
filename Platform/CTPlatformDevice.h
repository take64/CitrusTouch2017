//
//  CTPlatformDevice.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTPlatformDevice : NSObject

// Retinaディスプレイ
+ (BOOL)isRetinaDisplay;

// iPhone?
+ (BOOL)isIPhone;

// iPad?
+ (BOOL)isIPad;

// iPod touch?
+ (BOOL)isIPod;

// プラットフォームを取得
+ (NSString *)platform;

// モデルを取得
+ (NSString *)model;

// システム情報取得
+ (NSString *)getSystemInfByName:(char *)typeSpecifier;

@end
