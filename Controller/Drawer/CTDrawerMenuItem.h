//
//  CTDrawerMenuItem.h
//  CitrusTouch3
//
//  Created by take64 on 2017/01/24.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTDrawerMenuItem : NSObject
{
    // title
    NSString *title;
    // controller
    UIViewController *controller;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIViewController *controller;

//
// method
//

// init
- (id)initWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue;

// init
+ (CTDrawerMenuItem *)menuWithController:(UIViewController *)controllerValue;

// init
+ (CTDrawerMenuItem *)menuWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue;

@end
