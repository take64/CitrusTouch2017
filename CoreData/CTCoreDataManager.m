//
//  CTCoreDataManager.m
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTCoreDataManager.h"

static const NSString *NSManagedObjectContextThreadKey = @"NSManagedObjectContextThreadKey";

@implementation CTCoreDataManager



//
// synthesize
//
@synthesize context;
@synthesize model;
@synthesize coordinator;
@synthesize modelName;
@synthesize modelExtension;
@synthesize storePath;


#pragma mark - method
//
// method
//

// 初期化
- (id)initWithStorePath:(NSString *)_storePath modelName:(NSString *)_modelName modelExtension:(NSString *)_modelExtension
{
    self = [super init];
    if(self)
    {
        // 初期設定
        [self setModelName      :_modelName];
        [self setModelExtension :_modelExtension];
        [self setStorePath      :_storePath];
    }
    return self;
}




#pragma mark - caller method
//
// caller method
//

// コンテクスト
- (NSManagedObjectContext *)managedObjectContext:(NSThread *)thread
{
    // 対象スレッドからコンテキスト取得
    NSMutableDictionary *threadDictionary = [thread threadDictionary];
    NSManagedObjectContext *_context = [threadDictionary objectForKey:NSManagedObjectContextThreadKey];
    
    // 取得できない場合
    if(_context == nil)
    {
        // 生成
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        // ストア関連付け
        [_context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        // 現在スレッドに設定
        [[thread threadDictionary] setObject:_context forKey:NSManagedObjectContextThreadKey];
        // マージポリシー
        [_context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    
    return context;
}
// コンテクスト(メインスレッド)
- (NSManagedObjectContext *)managedObjectContextForMainThread
{
    return [self managedObjectContext:[NSThread mainThread]];
}
// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *)managedObjectContextForCurrentThread
{
    return [self managedObjectContext:[NSThread currentThread]];
}
// モデル
- (NSManagedObjectModel *)managedObjectModel
{
    if ([self model] != nil)
    {
        return [self model];
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:[self modelExtension]];
    [self setModel:[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]];
    
    return [self model];
}

// ストア
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if ([self coordinator] != nil)
    {
        return [self coordinator];
    }
    
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[self storePath]];
    
    
    NSDictionary *options = @{NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"},
                              NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              };
    
    NSError *error = nil;
    [self setCoordinator:
     [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]]
     ];
    if (![[self coordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        NSLog(@"Unresolved error %@", error);
        NSLog(@"%@", [error userInfo]);
        abort();
    }
    
    return [self coordinator];
}
// 保存
- (BOOL)saveContext
{
    NSManagedObjectContext *_context = [self managedObjectContextForCurrentThread];
    BOOL isMainThread = [[NSThread currentThread] isMainThread];
    
    // 返却値
    BOOL result;
    
    // メインスレッドでない場合は通知する
    if(isMainThread == NO)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(managedObjectContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:_context];
        
        
        // 保存処理
        NSError *error;
        result = [_context save:&error];
        if(error != nil)
        {
            NSLog(@"error : %@", error);
        }
        
        // 通知削除
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSManagedObjectContextDidSaveNotification
                                                      object:_context];
    }
    else
    {
        // 保存処理
        result = [_context save:nil];
    }
    
    return result;
}
// 保存&マージ
- (void)saveWithMergeObject:(NSManagedObject *)managedObject
{
    // 保存
    [self saveContext];
    
    // マージ
    [[self managedObjectContextForCurrentThread] refreshObject:managedObject mergeChanges:YES];
}
// 削除
- (BOOL)deleteWithSave:(NSManagedObject *)managedObject
{
    // 削除
    [[self managedObjectContextForCurrentThread] deleteObject:managedObject];
    
    // 保存
    return [self saveContext];
}
// 保存＆mainThread保存
- (void)saveComplete
{
    [self saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self saveContext];
    });
}
// ロールバック
- (void)rollbackContext
{
    NSManagedObjectContext *_context = [self managedObjectContextForCurrentThread];
    [_context rollback];
}
// 保存通知
- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *_context = [self managedObjectContextForMainThread];
    
    [_context performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                               withObject:notification
                            waitUntilDone:YES];
}
// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContextForCurrentThread]];
}

@end
