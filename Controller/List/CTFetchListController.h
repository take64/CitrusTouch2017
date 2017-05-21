//
//  CTFetchListController.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseListController.h"

#import "CTTableCell.h"

@interface CTFetchListController : CTBaseListController <NSFetchedResultsControllerDelegate>
{
    // フェッチ
    NSFetchedResultsController *fetchedResultsController;
}

//
// property
//
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


//
// method
//

// セルデータ設定
- (void)bindCell:(CTTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;

//
// singleton
//

// fetch
- (NSFetchedResultsController *)callFetchedResultsController;


@end
