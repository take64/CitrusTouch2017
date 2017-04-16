//
//  CTEntityEditModal.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBaseEditModal.h"

@interface CTEntityEditModal : CTBaseEditModal
{
    // entity
    NSManagedObject *entity;
    
    // controller
    CTBaseEditController *editController;
    
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;
@property (nonatomic, retain) CTBaseEditController *editController;


//
// method
//

// データ読み込み
- (void)loadEntity:(NSManagedObject *)entityValue;

@end
