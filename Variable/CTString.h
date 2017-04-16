//
//  CTString.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

// simple format
__attribute__((unused)) static NSString * CTStringf(NSString *format, ...)
{
    va_list ap;
    va_start(ap, format);
    
    NSString *value = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end(ap);
    
    return value;
}


@interface CTString : NSObject

// MD5ハッシュを取得する
+ (NSString *)md5FromString:(NSString *)stringValue;

@end
