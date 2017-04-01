//
//  CTFetchListController.m
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFetchListController.h"

@interface CTFetchListController ()

@end

@implementation CTFetchListController

//
// synthesize
//
@synthesize fetchedResultsController;


// init
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
        // NavigationBar color
        //        [[self navigationItem] set]
        
    }
    return self;
}


#pragma mark - singleton
//
// singleton
//

// fetch
- (NSFetchedResultsController *)callFetchedResultsController;
{
    return nil;
}

@end
