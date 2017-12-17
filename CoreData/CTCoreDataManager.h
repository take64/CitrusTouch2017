//
//  CTCoreDataManager.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CTCoreDataManager : NSObject
{
    // コンテクスト
    NSManagedObjectContext *context;

    // モデル
    NSManagedObjectModel *model;

    // ストア
    NSPersistentStoreCoordinator *coordinator;

    // モデル名
    NSString *modelName;

    // モデル名拡張子
    NSString *modelExtension;

    // ストアパス
    NSString *storePath;
}



//
// property
//
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectModel *model;
@property (nonatomic, retain) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, retain) NSString *modelName;
@property (nonatomic, retain) NSString *modelExtension;
@property (nonatomic, retain) NSString *storePath;



//
// method
//

// 初期化
- (id) initWithStorePath:(NSString *)storePath modelName:(NSString *)modelName modelExtension:(NSString *)modelExtension;

// コンテクスト
- (NSManagedObjectContext *)managedObjectContext:(NSThread *)thread;

// コンテクスト(メインスレッド)
- (NSManagedObjectContext *)managedObjectContextForMainThread;

// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *)managedObjectContextForCurrentThread;

// 保存＆mainThread保存
- (void) saveComplete;

// ロールバック
- (void) rollbackContext;

// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName;

@end
