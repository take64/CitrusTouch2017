//
//  CitrusTouchApplication.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/31.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusTouchTheme.h"
#import "CitrusTouchCoreData.h"

@interface CitrusTouchApplication : NSObject
{
    // theme
    CTTheme *theme;
    
    // coredata
    CTCoreDataManager *coreDataManager;
    NSManagedObjectContext * coreDataContext;
}

//
// property
//
@property (nonatomic, retain) CTTheme *theme;
@property (nonatomic, retain) CTCoreDataManager *coreDataManager;
@property (nonatomic, retain) NSManagedObjectContext * coreDataContext;


//
// method
//

// call theme
+ (CTTheme *)callTheme;

// CoreData manager
+ (CTCoreDataManager *)callCoreDataManager;

// CoreData context
+ (NSManagedObjectContext *)callCoreDataContext;

// singleton
+ (instancetype)sharedApplication;

@end
