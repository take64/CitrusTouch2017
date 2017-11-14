//
//  CTTableHeaderFooterView.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/15.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableHeaderFooterView : UITableViewHeaderFooterView
{
    // label
    CTLabel *label;
    
    // view
    UIView *control;
    
    // is margin
    CGFloat margin;
}

//
// property
//
@property (nonatomic, retain) CTLabel *label;
@property (nonatomic, retain) UIView *control;
@property (nonatomic, assign) CGFloat margin;


//
// method
//

// bind title
- (void)bindTitle:(NSString *)titleString;

// bind view
- (void)bindView:(UIView *)viewValue;

// call reuse id
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section;

//// call reuse head id
//+ (NSString *)reuseHeaderIdentifierWithSection:(NSInteger)section;
//
//// call reuse head id
//+ (NSString *)reuseFooterIdentifierWithSection:(NSInteger)section;

@end
