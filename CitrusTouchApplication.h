//
//  CitrusTouchApplication.h
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/03/31.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusTouchTheme.h"

@interface CitrusTouchApplication : NSObject
{
    // theme
    CTTheme *theme;
}

//
// property
//
@property (nonatomic, retain) CTTheme *theme;


//
// method
//

// call theme
- (CTTheme *)callTheme;

// singleton
+ (instancetype)sharedApplication;

@end
