//
//  CitrusTouchApplication.m
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/03/31.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CitrusTouchApplication.h"

@implementation CitrusTouchApplication

//
// synthesize
//
@synthesize theme;


// init
- (id)init
{
    self = [super init];
    if(self)
    {
        [self setTheme:[[CTTheme alloc] init]];
    }
    return self;
}

// call theme
- (CTTheme *)callTheme
{
    if([self theme] == nil)
    {
        [self setTheme:[[CTTheme alloc] init]];
    }
    return [self theme];
}



#pragma mark - singleton
// singleton
+ (instancetype)sharedApplication
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CitrusTouchApplication alloc] init];
    });
    return singleton;
}
@end
