//
//  CTDrawerMenuSection.h
//  CitrusTouch3
//
//  Created by take64 on 2017/01/25.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTDrawerMenuItem;

@interface CTDrawerMenuSection : NSObject
{
    // title
    NSString *title;
    // menu items
    NSArray<CTDrawerMenuItem *> *menuItems;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray<CTDrawerMenuItem *> *menuItems;

//
// method
//

// init
- (id)initWithTitle:(NSString *)titleValue menuItems:(NSArray<CTDrawerMenuItem *> *)menuItemList;

// init
+ (CTDrawerMenuSection *)sectionWithTitle:(NSString *)titleValue menuItems:(NSArray<CTDrawerMenuItem *> *)menuItemList;


@end
