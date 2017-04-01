//
//  CTNVL.m
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/03/31.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTNVL.h"

@implementation CTNVL

// NVL関数
+ (id) compare:(id)compare replace:(id)replace
{
    if(compare == nil || [compare isEqual:[NSNull null]] == YES)
    {
        return replace;
    }
    else
    {
        return compare;
    }
}

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2
{
    if(compare == nil || [compare isEqual:[NSNull null]] == YES)
    {
        return value2;
    }
    else
    {
        return value1;
    }
}

@end
