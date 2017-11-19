//
//  CTBoolVL.m
//  CitrusTouch3
//
//  Created by take64 on 2017/05/25.
//  Copyright © 2017 citrus.tk. All rights reserved.
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
