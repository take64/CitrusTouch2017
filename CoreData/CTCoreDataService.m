//
//  CTCoreDataService.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTCoreDataService.h"

@implementation CTCoreDataService

// entity用ユニークID
+ (NSString *)uniqueID
{
    NSString *half01 = [CTString md5FromString:[NSString stringWithFormat:@"%d", rand()]];
    NSString *half02 = [CTString md5FromString:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]]];
    NSString *generateID = [NSString stringWithFormat:@"%@%@", half01, half02];
    return generateID;
}

// entity配列のdictionary配列化
+ (NSArray *)dictionariesWithEntities:(NSArray *)entities
{
    if(entities == nil)
    {
        return [NSArray array];
    }
    if([entities count] == 0)
    {
        return [NSArray array];
    }
    
    // entity
    NSManagedObject *firstEntity = [entities firstObject];
    // カラム名リスト
    NSDictionary *columns = [[firstEntity entity] attributesByName];
    // 返却値
    NSMutableArray *results = [NSMutableArray array];
    
    // 変換
    for(NSManagedObject *entity in entities)
    {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        for(NSString *column in [columns allKeys])
        {
            // Transient は保存しなくても良い
            NSAttributeDescription *attribute = [columns objectForKey:column];
            if([attribute isTransient] == YES)
            {
                continue;
            }
            
            
            id value = [entity valueForKey:column];
            if (value == nil)
            {
                value = [NSNull null];
            }
            if([value isKindOfClass:[NSDate class]] == YES)
            {
                value = [CTDate stringWithDate:value format:@"yyyyMMddHHmmss"];
            }
            [result setObject:value forKey:column];
        }
        [results addObject:result];
    }
    
    return [results copy];
}

// dictionary配列からentityに変換
+ (NSManagedObject *)entityWithEntity:(NSManagedObject *)entityValue withDictionary:(NSDictionary *)dicValue
{
    if(dicValue == nil)
    {
        return entityValue;
    }
    
    // カラム名リスト
    NSDictionary *columns = [[entityValue entity] propertiesByName];
    for(NSString *column in columns)
    {
        NSPropertyDescription *property = [columns objectForKey:column];
        if([property isKindOfClass:[NSAttributeDescription class]] == YES)
        {
            if([(NSAttributeDescription *)property isTransient] == NO)
            {
                NSString *className = [(NSAttributeDescription *)property attributeValueClassName];
                id value = [dicValue objectForKey:column];
                if([value isEqual:[NSNull null]] == YES)
                {
                    continue;
                }
                if([className isEqualToString:@"NSDate"] == YES)
                {
                    [entityValue setValue:
                     [CTDate dateWithString:value format:@"yyyyMMddHHmmss"]
                                   forKey:column];
                }
                else
                {
                    [entityValue setValue:value forKey:column];
                }
            }
        }
    }
    return entityValue;
}


@end
