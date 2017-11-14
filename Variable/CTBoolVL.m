//
//  CTBoolVL.m
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/05/25.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBoolVL.h"

@implementation CTBoolVL

// NVL2関数
+ (id)compare:(BOOL)compare value1:(id)value1 value2:(id)value2
{
    if(compare == YES)
    {
        return value1;
    }
    else
    {
        return value2;
    }
}

@end
