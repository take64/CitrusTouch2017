//
//  CitrusTouchApplication.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/31.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CitrusTouchApplication.h"

@implementation CitrusTouchApplication

//
// synthesize
//
@synthesize theme;
@synthesize coreDataManager;
@synthesize coreDataContext;


// init
- (id)init
{
    self = [super init];
    if (self)
    {
        [self setTheme:[[CTTheme alloc] init]];
    }
    return self;
}

// call theme
+ (CTTheme *)callTheme
{
    CTTheme *_theme = [[CitrusTouchApplication sharedApplication] theme];
    if (_theme == nil)
    {
        _theme = [[CTTheme alloc] init];
    }
    return _theme;
}


// CoreData manager
+ (CTCoreDataManager *)callCoreDataManager
{
    CTCoreDataManager *_coreDataManager = [[CitrusTouchApplication sharedApplication] coreDataManager];
    if (_coreDataManager == nil)
    {
        CTLog(@"error : CitrusTouchApplication.callCoreDataManager");
    }
    return _coreDataManager;
}

// CoreData context
+ (NSManagedObjectContext *)callCoreDataContext
{
    NSManagedObjectContext *_coreDataContext = [[CitrusTouchApplication sharedApplication] coreDataContext];
    if (_coreDataContext == nil)
    {
        CTLog(@"error : CitrusTouchApplication.callCoreDataContext");
    }
    return _coreDataContext;
}



#pragma mark - singleton
//
// singleton
//
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
