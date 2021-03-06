//
//  CTTackItem.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CitrusTouchTaskState) {
    CitrusTouchTaskStateWait,
    CitrusTouchTaskStateProcessing,
    CitrusTouchTaskStateComplete,
};

typedef void (^CitrusTouchTaskBlock)(void);

@interface CTTaskItem : NSObject
{
    // 状態
    CitrusTouchTaskState state;
    
    // タスク
    CitrusTouchTaskBlock taskBlock;
    
    // 次のタスクを自動実行するか
    BOOL nextTaskAutoStart;
}

//
// property
//
@property (nonatomic, assign) CitrusTouchTaskState state;
@property (nonatomic, copy)   CitrusTouchTaskBlock taskBlock;
@property (nonatomic, assign) BOOL nextTaskAutoStart;


//
// method
//

// 初期化
- (id)initWithBlock:(CitrusTouchTaskBlock)block;

// 初期化
- (id)initWithBlock:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart;

// タスク実行
- (void)start;

// 初期化
+ (instancetype)taskWithBlock:(CitrusTouchTaskBlock)block;

// 初期化
+ (instancetype)taskWithBlock:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart;

@end
