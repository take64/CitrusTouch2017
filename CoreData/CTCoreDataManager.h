//
//  CTCoreDataManager.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
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



//
// caller method
//

// コンテクスト
- (NSManagedObjectContext *)managedObjectContext:(NSThread *)thread;

// コンテクスト(メインスレッド)
- (NSManagedObjectContext *)managedObjectContextForMainThread;

// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *)managedObjectContextForCurrentThread;

//// モデル
//- (NSManagedObjectModel *)managedObjectModel;
//
//// ストア
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//// 保存
//- (BOOL) saveContext;
//
//// 保存&マージ
//- (void) saveWithMergeObject:(NSManagedObject *)managedObject;

// 保存＆mainThread保存
- (void) saveComplete;

//// 削除
//- (BOOL) deleteWithSave:(NSManagedObject *)managedObject;

// ロールバック
- (void) rollbackContext;

//// 保存通知
//- (void) managedObjectContextDidSave:(NSNotification *)notification;

// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName;


@end
