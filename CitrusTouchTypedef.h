//
//  CitrusTouchTypedef.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTProgress;

#ifndef CitrusTouchTypedef_h
#define CitrusTouchTypedef_h

// logger
//#ifdef DEBUG
#define CTLog(...) NSLog(__VA_ARGS__)
//#else
//#define CTLog(...)
//#endif

typedef void (^CitrusTouchBlock)(void);
typedef void (^CitrusTouchProgressBlock)(CTProgress *progress, NSError *error);
typedef void (^CitrusTouchModalBlock)(NSObject *object);

#endif /* CitrusTouchTypedef_h */
