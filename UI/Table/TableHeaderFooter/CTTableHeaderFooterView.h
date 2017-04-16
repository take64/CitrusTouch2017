//
//  CTTableHeaderFooterView.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/15.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableHeaderFooterView : UITableViewHeaderFooterView
{
    // label
    CTLabel *label;
}

//
// property
//
@property (nonatomic, retain) CTLabel *label;


//
// method
//

// bind title
- (void)bindTitle:(NSString *)titleString;

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section;

@end
