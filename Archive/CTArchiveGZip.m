//
//  CTArchiveGZip.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTArchiveGZip.h"

#import <zlib.h>

@implementation CTArchiveGZip

// 圧縮
+ (NSData *)archive:(NSData *)dataValue level:(int)level
{
    return [self compress:dataValue mode:CTArchiveGZipModeDeflate level:level];
}

// 解凍
+ (NSData *)unarchive:(NSData *)dataValue
{
    return [self compress:dataValue mode:CTArchiveGZipModeInflate level:0];
}

// 圧縮/解凍
+ (NSData *)compress:(NSData *)dataValue mode:(CTArchiveGZipMode)mode level:(int)level
{
    Bytef buffer[131072];

    // 初期化
    z_stream zStream;
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;

    // 圧縮/解凍 モード
    switch (mode) {
        case CTArchiveGZipModeDeflate: // 圧縮
            deflateInit2(&zStream, level, Z_DEFLATED, MAX_WBITS|16, 5, Z_DEFAULT_STRATEGY);
            break;
        case CTArchiveGZipModeInflate: // 解凍
            inflateInit2(&zStream, MAX_WBITS|16|16);
            break;
    }

    zStream.avail_in = (uInt)[dataValue length];
    zStream.next_in = (Bytef *)[dataValue bytes];

    // 圧縮/解凍
    NSMutableData *resultValue = [NSMutableData dataWithCapacity:0];
    do
    {
        zStream.next_out = buffer;
        zStream.avail_out = sizeof(buffer);
        // 圧縮/解凍 モード
        switch (mode) {
            case CTArchiveGZipModeDeflate: // 圧縮
                deflate(&zStream, Z_FINISH);
                break;
            case CTArchiveGZipModeInflate: // 解凍
                inflate(&zStream, Z_FINISH);
                break;
        }
        size_t length = sizeof(buffer) - zStream.avail_out;
        if (length > 0)
        {
            [resultValue appendBytes:buffer length:length];
        }
    }
    while(zStream.avail_out != sizeof(buffer));

    // 圧縮/解凍 モード
    switch (mode) {
        case CTArchiveGZipModeDeflate: // 圧縮
            deflateEnd(&zStream);
            break;
        case CTArchiveGZipModeInflate: // 解凍
            inflateEnd(&zStream);
            break;
    }

    return [resultValue copy];
}

@end
