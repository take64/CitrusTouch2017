//
//  CTBaseSelectModal.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/19.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseSelectModal.h"

@interface CTBaseSelectModal ()

@end

@implementation CTBaseSelectModal

//
// synthesize
//
@synthesize _navigationController;
@synthesize modalComplete;
@synthesize selectedList;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // modal style
        [self setModalPresentationStyle:UIModalPresentationPageSheet];
        
        // part
        CTBarButtonItem *barButtonItem;
        
        // バーボタン(閉じる)
        barButtonItem = [[CTBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonClose)];
        [[self navigationItem] setLeftBarButtonItems:@[ barButtonItem ]];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate
//
// UIViewControllerTransitioningDelegate
//

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//
//}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    CTBasePresentationController *presentation = [[CTBasePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}



#pragma mark - method
//
// method
//

// 表示
- (void)showWithParent:(UIViewController *)parent
{
    if(parent != nil)
    {
        CTBasePresentationController *presentation NS_VALID_UNTIL_END_OF_SCOPE;
        presentation = [[CTBasePresentationController alloc] initWithPresentedViewController:[self callNavigationController] presentingViewController:parent];
        [[self callNavigationController] setTransitioningDelegate:presentation];
        [parent presentViewController:[self callNavigationController] animated:YES completion:nil];
    }
}

// 表示
- (void)showWithParent:(UIViewController *)parent complete:(CitrusTouchModalBlock)complete
{
    // 画面閉じ完了
    [self setModalComplete:complete];
    // 表示
    [self showWithParent:parent];
}

// 非表示
- (void)hide
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        // 画面閉じ完了がある場合
        if(self.modalComplete != nil)
        {
            self.modalComplete(self);
        }
    }];
}


#pragma mark - private
//
// private
//

// ボタン押下時(閉じる)
- (void)onTapBarButtonClose
{
    [self hide];
}


#pragma mark - extends
//
// extends
//


// 表示(選択ボタン)
- (BOOL)visibleSelectButton
{
    return YES;
}

// 編集時(移動可能)
- (BOOL)canMoveEditing
{
    return NO;
}


#pragma mark - singleton
//
// singleton
//

// call navigation controller
- (CTNavigationController *)callNavigationController
{
    if([self _navigationController] == nil)
    {
        CTNavigationController *navigation = [[CTNavigationController alloc] initWithRootViewController:self];
        [navigation setTransitioningDelegate:self];
        [self set_navigationController:navigation];
    }
    return [self _navigationController];
}

@end
