//
//  CTTask.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTTaskItem.h"

@interface CTTask : NSObject
{
    // task list
    NSMutableArray<CTTaskItem *> *taskItems;
    
    // progress
    CitrusTouchProgressBlock progressBlock;
    
    double delay;
}

//
// property
//
@property (nonatomic, retain) NSMutableArray<CTTaskItem *> *taskItems;
@property (nonatomic, copy)   CitrusTouchProgressBlock progressBlock;
@property (nonatomic, assign) double delay;


//
// method
//

// 開始
- (void)start;

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block;

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart;

// シンプルなタスクの実行
+ (void)task:(CitrusTouchTaskBlock)block delay:(double)_delay;

@end
