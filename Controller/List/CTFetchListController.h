//
//  CTFetchListController.h
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBaseListController.h"

@interface CTFetchListController : CTBaseListController
{
    // フェッチ
    NSFetchedResultsController *fetchedResultsController;
}

//
// property
//
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


//
// singleton
//

// fetch
- (NSFetchedResultsController *)callFetchedResultsController;


@end
