//
//  CTBaseSelectModal.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/19.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTBaseListController.h"

@interface CTBaseSelectModal : CTBaseListController <UIViewControllerTransitioningDelegate>
{
    // navigation controller
    CTNavigationController *_navigationController;

    // block
    CitrusTouchModalBlock modalComplete;

    // 選択リスト
    NSMutableArray *selectedItems;
}



//
// property
//
@property (nonatomic, retain) CTNavigationController *_navigationController;
@property (nonatomic, copy)   CitrusTouchModalBlock modalComplete;
@property (nonatomic, retain) NSMutableArray *selectedItems;



//
// method
//

// 表示
- (void)showWithParent:(UIViewController *)parent;

// 表示
- (void)showWithParent:(UIViewController *)parent complete:(CitrusTouchModalBlock)completeBlock;

// 表示
- (void)showWithParent:(UIViewController *)parent selectedItems:(NSMutableArray *)_selectedItems complete:(CitrusTouchModalBlock)completeBlock;

// 非表示
- (void)hide;

@end
