//
//  CTNVL.h
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/03/31.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTNVL : NSObject

// NVL関数
+ (id) compare:(id)compare replace:(id)replace;

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2;

@end
