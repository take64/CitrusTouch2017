//
//  CTBasePresentationController.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTBasePresentationController.h"

@implementation CTBasePresentationController



//
// synthesize
//
@synthesize shadowView;
@synthesize wrappingView;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self)
    {
        // style
        [presentedViewController setModalPresentationStyle:UIModalPresentationCustom];
    }
    return self;
}

// 画面開き時(開く前)
- (void)presentationTransitionWillBegin
{
    // ラッピングビュー
    [self callWrapperView];
    // 背景(影)ビュー
    [[self containerView] addSubview:[self callShadowView]];
}

// 画面閉じ時(閉じる前)
- (void)dismissalTransitionWillBegin
{
    // animation
    [self doAnimateAlongsideTransitionWithAlpha:0];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == [self presentedViewController])
    {
        [[self containerView] setNeedsLayout];
    }
}

// コンテナサイズ
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
    {
        return [((UIViewController*)container) preferredContentSize];
    }
    else
    {
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }
}

// モーダルビューサイズ
- (CGRect)frameOfPresentedViewInContainerView
{
    CGFloat insetHeight = 40;
    CGRect rect = CGRectInset([[self containerView] bounds], 0, insetHeight);
    rect.size.height += insetHeight;
    return rect;
}

// コンテナレイアウト
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    [[self callWrapperView] setFrame:[self frameOfPresentedViewInContainerView]];
}



#pragma mark - UIViewControllerAnimatedTransitioning
//
// UIViewControllerAnimatedTransitioning
//

// アニメーション時間
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ([transitionContext isAnimated] == YES) ? 0.25 : 0;
}

// アニメーション処理
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = transitionContext.containerView;

    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    BOOL isPresenting = (fromViewController == [self presentingViewController]);

    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toView];

    if (isPresenting == YES)
    {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX([containerView bounds]), CGRectGetMaxY([containerView bounds]));
        toViewInitialFrame.size = toViewFinalFrame.size;
        [toView setFrame:toViewInitialFrame];
    }
    else
    {
        fromViewFinalFrame = CGRectOffset([fromView frame], 0, CGRectGetHeight(fromView.frame));
    }

    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting == YES)
        {
            [toView setFrame:toViewFinalFrame];
        }
        else
        {
            [fromView setFrame:fromViewFinalFrame];
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:(wasCancelled == NO)];
    }];
}



#pragma mark - UIViewControllerTransitioningDelegate
//
// UIViewControllerTransitioningDelegate
//

//| ----------------------------------------------------------------------------
//  If the modalPresentationStyle of the presented view controller is
//  UIModalPresentationCustom, the system calls this method on the presented
//  view controller's transitioningDelegate to retrieve the presentation
//  controller that will manage the presentation.  If your implementation
//  returns nil, an instance of UIPresentationController is used.
//
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    return self;
}

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
//
//
//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;



#pragma mark - private
//
// private
//

// 背景(影)ビュー
- (UIView *)callShadowView
{
    if ([self shadowView] == nil)
    {
        UIView *_view = [[UIView alloc] initWithFrame:[[self containerView] bounds]];
        [_view setBackgroundColor:[UIColor blackColor]];
        [_view setOpaque:NO];
        [_view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapViewShadow)]];
        [_view setAlpha:0];
        [self setShadowView:_view];

        // animation
        [self doAnimateAlongsideTransitionWithAlpha:0.5];
    }
    return [self shadowView];
}

// ラッピングビュー
- (UIView *)callWrapperView
{
    if ([self wrappingView] == nil)
    {
        UIView *presentedViewControllerView = [super presentedView];
        [[presentedViewControllerView layer] setCornerRadius:4];
        [[presentedViewControllerView layer] setMasksToBounds:YES];

        UIView *_view = [[UIView alloc] initWithFrame:[self frameOfPresentedViewInContainerView]];
        [[_view layer] setShadowOpacity:0.5];
        [[_view layer] setShadowRadius:2];
        [[_view layer] setShadowOffset:CGSizeMake(0, -2)];
        [_view addSubview:presentedViewControllerView];
        [self setWrappingView:_view];
    }
    return [self wrappingView];
}

// ビュー押下時(影ビュー)
- (void)onTapViewShadow
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

// トラジションアニメーションの実行
- (void)doAnimateAlongsideTransitionWithAlpha:(CGFloat)alpha
{
    [[[self presentingViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [[self callShadowView] setAlpha:alpha];
    } completion:nil];
}

@end
