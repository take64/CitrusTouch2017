//
//  CTBaseEditModal.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseEditController.h"

#import "CitrusTouchTypedef.h"

@class CTNavigationController;

@interface CTBaseEditModal : CTBaseEditController <UIViewControllerTransitioningDelegate>
{
    // navigation controller
    CTNavigationController *_navigationController;
    
    // block
    CitrusTouchModalBlock modalComplete;
}

//
// property
//
@property (nonatomic, retain) CTNavigationController *_navigationController;
@property (nonatomic, copy)   CitrusTouchModalBlock modalComplete;

//
// method
//

// 表示
- (void)showWithParent:(UIViewController *)parent;

// 表示
- (void)showWithParent:(UIViewController *)parent complete:(CitrusTouchModalBlock)completeBlock;

// 非表示
- (void)hide;


@end
