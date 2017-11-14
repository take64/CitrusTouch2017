//
//  CTArchiveGZip.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTArchiveGZip : NSObject

// 圧縮
+ (NSData *)archive:(NSData *)dataValue level:(int)level;

// 解凍
+ (NSData *)unarchive:(NSData *)dataValue;

@end
