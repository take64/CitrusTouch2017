//
//  CTNVL.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/31.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTNVL.h"

@implementation CTNVL

// NVL関数
+ (id)compare:(id)compare replace:(id)replace
{
    return [self compare:compare value1:compare value2:replace];
}

// NVL2関数
+ (id)compare:(id)compare value1:(id)value1 value2:(id)value2
{
    if (compare == nil || [compare isEqual:[NSNull null]] == YES)
    {
        return value2;
    }
    else
    {
        return value1;
    }
}

@end
