//
//  CTArchiveGZip.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, CTArchiveGZipMode) {
    CTArchiveGZipModeDeflate,   // 圧縮
    CTArchiveGZipModeInflate,   // 解答
};

@interface CTArchiveGZip : NSObject

// 圧縮
+ (NSData *)archive:(NSData *)dataValue level:(int)level;

// 解凍
+ (NSData *)unarchive:(NSData *)dataValue;

@end
