//
//  CTBaseTableController.h
//  CitrusTouch3
//
//  Created by take64 on 2017/05/21.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTBaseTableController : UITableViewController <CTTableViewDelegate>
{
    // header/footer cache
    BOOL cacheEnable;
    NSMutableDictionary *headerCaches;
    NSMutableDictionary *footerCaches;
}
//
// property
//
@property (nonatomic, assign) BOOL cacheEnable;
@property (nonatomic, retain) NSMutableDictionary *headerCaches;
@property (nonatomic, retain) NSMutableDictionary *footerCaches;


//
// method
//

// タイトル取得
- (NSString *)callTitle;

@end
