//
//  CTCoreDataService.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/02.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCoreDataService : NSObject

// entity用ユニークID
+ (NSString *)uniqueID;

// entity配列のdictionary配列化
+ (NSArray *)dictionariesWithEntities:(NSArray *)entities;

// dictionary配列からentityに変換
+ (NSManagedObject *)entityWithEntity:(NSManagedObject *)entityValue withDictionary:(NSDictionary *)dicValue;

@end
