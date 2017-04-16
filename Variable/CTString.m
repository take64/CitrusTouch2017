//
//  CTString.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTString.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation CTString

// MD5ハッシュを取得する
+ (NSString *)md5FromString:(NSString *)stringValue
{
    NSData *dataValue = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataValue bytes], (CC_LONG)[dataValue length], digest);
    char md5cstring[CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        sprintf(md5cstring+i*2, "%02x", digest[i]);
    }
    
    return [NSString stringWithCString:md5cstring encoding:NSUTF8StringEncoding];
}

@end
