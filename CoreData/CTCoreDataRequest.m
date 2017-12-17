//
//  CTCoreDataRequest.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTCoreDataRequest.h"

@implementation CTCoreDataRequest

#pragma mark - method
//
// method
//

// データ取得
+ (NSArray *)requestWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;
{
    // リクエスト
    NSFetchRequest *request = [self generateFetchRequestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters];

    // ソート
    [self bindSortRequest:request sortColumns:sortColumns];

    // フェッチオフセット
    [request setFetchOffset:fetchOffset];

    // フェッチリミット
    if (fetchLimit > 0)
    {
        [request setFetchLimit:fetchLimit];
    }

    // 実取得
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];

    // エラー
    if (error)
    {
        NSLog(@"ERROR! CTCoreDataRequest.requestWithContext - %@",error);
        return nil;
    }
    else if ([results count] == 0)
    {
        results = nil;
    }
    return results;
}

// データ取得(1件)
+ (NSManagedObject *)objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self objectWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:nil];
}

// データ取得(1件)
+ (NSManagedObject *)objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:1 fetchOffset:0];
    //　取得できない場合はnil
    return [results objectAtIndex:0];
}

// データ取得(全件)
+ (NSArray *)listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:0 fetchOffset:0];
    //　取得できない場合はnil
    return results;
}

// フェッチ取得
+ (NSFetchedResultsController *)fetchWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    if (whereParameters != nil && ([whereParameters isKindOfClass:[NSArray class]] == YES || [whereParameters isKindOfClass:[NSMutableArray class]] == YES) && [whereParameters count] == 0)
    {
        whereParameters = nil;
    }

    // リクエスト
    NSFetchRequest *request = [self generateFetchRequestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters];

    // ソート
    [self bindSortRequest:request sortColumns:sortColumns];

    // 実取得
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:sectionNameKeyPath cacheName:nil];

    return fetchedResultsController;
}

// count取得(1件)
+ (id)countWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// count取得(1件)(group by)
+ (id)countWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:groupby];
}

// max取得(1件)
+ (id)maxWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"max:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// min取得(1件)
+ (id)minWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"min:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// average取得(1件)
+ (id)averageWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"average:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// sum取得(1件)
+ (id)sumWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [CTCoreDataRequest functionWithContext:context entityName:entityName functionName:@"sum:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// 件数取得(1件)
+ (id)functionWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName functionName:(NSString *)functionName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    // リクエスト
    NSFetchRequest *request = [self generateFetchRequestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters];

    // expression
    NSString *resultName = @"result";
    NSExpressionDescription *expressionDescription = [self generateExpressionDescriptionWithFunction:functionName column:columnName result:resultName];

    // result properties
    [request setResultType:NSDictionaryResultType];
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];

    // groupby
    if (groupby != nil)
    {
        [request setPropertiesToGroupBy:groupby];
    }

    // データ取得
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSNumber *result;

    // エラー
    if (error)
    {
        NSLog(@"ERROR! CTCoreDataRequest.function - %@",error);
        result = @0;
    }
    else
    {
        result = [[results objectAtIndex:0] valueForKey:resultName];
    }
    return result;
}



#pragma mark - private
//
// private
//

// ソート情報の追加
+ (void)bindSortRequest:(NSFetchRequest *)request sortColumns:(NSArray *)sortColumns
{
    // ソート情報がなければ終了
    if (sortColumns == nil || [sortColumns count] == 0)
    {
        return;
    }

    // ソート情報の追加
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
    NSSortDescriptor *sort;
    for (NSDictionary *sortColumn in sortColumns)
    {
        for (NSString *keyString in sortColumn)
        {
            sort = [NSSortDescriptor sortDescriptorWithKey:keyString
                                                 ascending:[(NSNumber *)[sortColumn objectForKey:keyString] boolValue]
                    ];
            [sortDescriptors addObject:sort];
        }
    }
    [request setSortDescriptors:sortDescriptors];
}

// 関数用 expression の生成
+ (NSExpressionDescription *)generateExpressionDescriptionWithFunction:(NSString *)functionName column:(NSString *)columnName result:(NSString *)resultName
{
    // expression
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:columnName];
    NSExpression *expression = [NSExpression expressionForFunction:functionName arguments:@[ keyPathExpression ]];
    // expression description
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:resultName];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger16AttributeType];
    return expressionDescription;
}

// 汎用的な FetchRequest の生成
+ (NSFetchRequest *)generateFetchRequestWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    // リクエスト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    // 取得用 Entity 生成
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];

    // 取得条件
    [request setPredicate:[NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters]];

    return request;
}

@end
