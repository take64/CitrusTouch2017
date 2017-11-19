//
//  CTDrawerViewController.m
//  CitrusTouch3
//
//  Created by take64 on 2017/01/24.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTDrawerViewController.h"

#import "CitrusTouchApplication.h"

#import "CTColor.h"
#import "CTBarButtonItem.h"
#import "CTTableCellLabel.h"

static CGFloat CTDrawerViewControllerMenuWidth()
{
    return CGRectGetWidth([[[UIApplication sharedApplication] keyWindow] frame]) * 0.8;
}
static CGFloat CTDrawerViewControllerMenuHeight()
{
    return CGRectGetHeight([[[UIApplication sharedApplication] keyWindow] frame]);
}

@interface CTDrawerViewController ()

@end

@implementation CTDrawerViewController

//
// synthesize
//
@synthesize mainViewController;
@synthesize menuSections;
@synthesize slideMenuButton;
@synthesize menuVisible;
@synthesize menuPanel;



- (void)loadView
{
    [super loadView];

    // ビュー
    [[self view] addSubview:[self callMenuPanel]];

    // メニューを隠す
    [self setMenuVisible:YES];
    [self closeSlide];

    // 再読み込み
    [[self callMenuTableView] reloadData];
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[self menuSections] objectAtIndex:section] menuItems] count];
}
// セルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CellID";

    CTTableCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if(cell == nil)
    {
        cell = [[CTTableCellLabel alloc] initWithPrefix:nil reuseIdentifier:CellID];
        [cell setBackgroundColor:[[CitrusTouchApplication callTheme] callDrawerCellBodyBackColor]];
        [[[cell label] callStyle] addStyles:@{
                                              @"font-size"  :@"14",
                                              @"color"      :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callDrawerCellBodyTextColor]],
                                              @"margin"     :@"0 0 0 8",
                                              }];
    }
    if(cell != nil)
    {
        NSInteger section = [indexPath section];
        NSInteger row = [indexPath row];

        CTDrawerMenuItem *menuItem = [[[[self menuSections] objectAtIndex:section] menuItems] objectAtIndex:row];
        [cell setContentText:[menuItem title]];
    }
    return cell;
}
// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self menuSections] count];
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[[self menuSections] objectAtIndex:section] title];
//}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;



#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    [view setTintColor:[[CitrusTouchApplication callTheme] callDrawerCellHeadBackColor]];
//    [[(UITableViewHeaderFooterView *)view textLabel] setTextColor:[[CitrusTouchApplication callTheme] callDrawerCellHeadTextColor]];
//}
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// セルヘッダ高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableHeaderHeightWithController:self tableView:tableView section:section];
//    if([self tableView:tableView viewForHeaderInSection:section] == nil)
//    {
//        return 0;
//    }
//    return CT8(3);
}
// セルフッタ高さ
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableFooterHeightWithController:self tableView:tableView section:section];
//    if([self tableView:tableView viewForFooterInSection:section] == nil)
//    {
//        return 0;
//    }
//    return CT8(3);
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section;
// セルヘッダを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableHeaderViewWithController:self tableView:tableView section:section];
}
// セルフッタを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];;
}
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
// セルタップ時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTDrawerMenuItem *menuItem = [[[[self menuSections] objectAtIndex:[indexPath section]] menuItems] objectAtIndex:[indexPath row]];
    [self changeViewController:[menuItem controller]];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context;
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator;
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView;



#pragma mark - CTTableViewDelegate
//
// CTTableViewDelegate
//

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section
{
    return [[[self menuSections] objectAtIndex:section] title];
}

// セルフッタタイトル取得
- (NSString *)callFooterTitleWithSection:(NSInteger)section
{
    return @"";
}

// セルヘッダビュー取得
- (UIView *)callHeaderViewWithSection:(NSInteger)section
{
    return nil;
}

// セルフッタビュー取得
- (UIView *)callFooterViewWithSection:(NSInteger)section
{
    return nil;
}


#pragma mark - UIGestureRecognizerDelegate
//
// UIGestureRecognizerDelegate
//

//// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
//// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
//// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
////
//// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
//// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
//// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
////
//// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
//// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press;



#pragma mark - method
//
// method
//

// init
- (id)initWithController:(UIViewController *)controllerValue menuSections:(NSArray<CTDrawerMenuSection *> *)menuSectionList
{
    self = [super initWithRootViewController:controllerValue];
    if(self)
    {
        // part
        CTBarButtonItem *barButtonItem;
        UIButton *button;

        // メニュー設定
        [self setMenuSections:menuSectionList];

        // 初期化
        [self setMainViewController:controllerValue];

        // エッジジェスチャー
        UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onScreenEdgeMenuPanel:)];
        [panGesture setMinimumNumberOfTouches:1];
        [panGesture setEdges:UIRectEdgeLeft];
        [panGesture setDelegate:self];
        [[self view] addGestureRecognizer:panGesture];

        // メニューボタン
        button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [[[button widthAnchor] constraintEqualToConstant:32] setActive:YES];
        [[[button heightAnchor] constraintEqualToConstant:32] setActive:YES];
        [button setBackgroundImage:[[CitrusTouchApplication callTheme] callAppIconImage] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(slideMenu) forControlEvents:UIControlEventTouchUpInside];
        barButtonItem = [[CTBarButtonItem alloc] initWithCustomView:button];
        [self setSlideMenuButton:barButtonItem];
        [[[self mainViewController] navigationItem] setLeftBarButtonItem:[self slideMenuButton]];
    }

    return self;
}



#pragma mark - private
//
// private
//

// スライド処理
- (void)slideMenu
{
    // メニュー表示
    CGRect menuFrame = [[self callMenuPanel] frame];

    // shadow
    CGSize shadowOffset = CGSizeZero;
    CGFloat shadowRadius = 0;
    CGFloat shadowOpacity = 0;

    // メニューが表示されていない時
    if([self menuVisible] == NO)
    {
        // メニューを表示させる
        menuFrame.origin.x = 0;
        shadowOffset = CGSizeMake(1, 1);
        shadowRadius = 5;
        shadowOpacity = 0.5;
    }
    else
    {
        // メニューを隠す
        menuFrame.origin.x = (CTDrawerViewControllerMenuWidth() * -1);
        shadowOffset = CGSizeZero;
        shadowRadius = 0;
        shadowOpacity = 0;
    }

    // アニメーション開始
    [UIView beginAnimations:@"master" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];

    // アニメーション内容
    [[[self callMenuPanel] layer] setShadowOffset:shadowOffset];
    [[[self callMenuPanel] layer] setShadowRadius:shadowRadius];
    [[[self callMenuPanel] layer] setShadowOpacity:shadowOpacity];
    [[[self callMenuPanel] layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[[self callMenuPanel] layer] setShadowPath:[UIBezierPath bezierPathWithRect:[[self callMenuPanel] bounds]].CGPath];
    [[self callMenuPanel] setFrame:menuFrame];

    // アニメーション終了
    [UIView commitAnimations];

    // メニュー表示フラグ切り替え
    [self setMenuVisible:![self menuVisible]];
}

// スライドを開ける
- (void) openSlide
{
    if([self menuVisible] == NO)
    {
        [self slideMenu];
    }
}

// スライドを閉じる
- (void) closeSlide
{
    if([self menuVisible] == YES)
    {
        [self slideMenu];
    }
}

// メインビュー変更
- (void)changeViewController:(UIViewController *)viewController
{
    // メニュースライド
    [self slideMenu];

    if([self topViewController] != viewController)
    {
        [[[self topViewController] view] removeFromSuperview];
        [self setViewControllers:@[ viewController ] animated:NO];

        // スライドボタンの移動
        [[[self topViewController] navigationItem] setLeftBarButtonItem:[self slideMenuButton]];
        [self setMenuVisible:NO];
    }
}

// スワイプジェスチャー処理
- (void)onSwipeMenuPanel:(UISwipeGestureRecognizer *) gesture
{
    UISwipeGestureRecognizerDirection direction = [gesture direction];

    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            // スライドを閉じる
            [self closeSlide];
            break;

        default:
            break;
    }
}

// エッジジェスチャー処理
- (void)onScreenEdgeMenuPanel:(UIScreenEdgePanGestureRecognizer *) gesture
{
    [self openSlide];
}



#pragma mark - singleton
//
// singleton
//

// menu view controller
- (UITableView *)callMenuTableView
{
    if([[[self callMenuPanel] menuTableView] delegate] == nil || [[[self callMenuPanel] menuTableView] dataSource] == nil)
    {
        [[[self callMenuPanel] menuTableView] setDataSource:self];
        [[[self callMenuPanel] menuTableView] setDelegate:self];
    }
    return [[self callMenuPanel] menuTableView];
}

// menu head
- (CTDrawerMenuPanel *)callMenuPanel
{
    if([self menuPanel] == nil)
    {
        [self setMenuPanel:[[CTDrawerMenuPanel alloc] initWithFrame:CGRectMake((CTDrawerViewControllerMenuWidth() * -1), 0, CTDrawerViewControllerMenuWidth(), CTDrawerViewControllerMenuHeight())]];

        // スワイプイベント
        UISwipeGestureRecognizer *swipe;
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeMenuPanel:)];
        [swipe setNumberOfTouchesRequired:1];
        [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [[self menuPanel] addGestureRecognizer:swipe];
    }
    return [self menuPanel];
}

@end
