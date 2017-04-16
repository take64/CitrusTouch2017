//
//  CitrusTouchCoreData.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#ifndef CitrusTouchCoreData_h
#define CitrusTouchCoreData_h

#import "CTString.h"

// coredata status 0
__attribute__((unused)) static NSNumber * CTCoreDataStatusNormal()
{
    return @0;
}

// coredata status 0
__attribute__((unused)) static NSNumber * CTCoreDataStatusRemove()
{
    return @9;
}

#import "CTCoreDataManager.h"
#import "CTCoreDataRequest.h"
#import "CTCoreDataService.h"

#endif /* CitrusTouchCoreData_h */
