//
//  CTBasePresentationController.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTBasePresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>
{
    UIView *shadowView;
    UIView *wrappingView;
}



//
// property
//
@property (nonatomic, retain) UIView *shadowView;
@property (nonatomic, retain) UIView *wrappingView;

@end
