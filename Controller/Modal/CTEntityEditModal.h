//
//  CTEntityEditModal.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseEditModal.h"

@interface CTEntityEditModal : CTBaseEditModal
{
    // entity
    NSManagedObject *entity;
    
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;


//
// method
//

// データ読み込み
- (void)loadEntity:(NSManagedObject *)entityValue;

@end
