//
//  CTBaseEditController.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseEditController.h"

#import "CTBarButtonItem.h"

@interface CTBaseEditController ()

@end

@implementation CTBaseEditController

//
// synthesize
//
@synthesize saveBarButton;
@synthesize removeBarButton;
@synthesize rowOfSection;
@synthesize headTitles;
@synthesize datastore;
@synthesize temporary;
@synthesize relations;
@synthesize removeAlertController;

// init
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
        // part
        CTBarButtonItem *barButtonItem;
        
        // テーブル線タイプ
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        // セクション内セル数
        [self setRowOfSection:@[]];
        
        // ヘッダタイトル
        [self setHeadTitles:@[]];
        
        // バーボタン(保存)
        barButtonItem = [[CTBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonSave)];
        [self setSaveBarButton:barButtonItem];
        // バーボタン(削除)
        barButtonItem = [[CTBarButtonItem alloc] initWithTitle:@"削除" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonRemove)];
        [self setRemoveBarButton:barButtonItem];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // バーボタン再描画
    [self redrawBarButton];
    
//    [[self tableView] reloadData];
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [[self tableView] reloadData];
//}


#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self rowOfSection] objectAtIndex:section] integerValue];
}

// セルを返す
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// セクション数を返す
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self rowOfSection] count];
}

//// ヘッダタイトル
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[self headTitles] objectAtIndex:section];
//}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//
//// Editing
//
//// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//
//// Moving/reordering
//
//// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:

// 編集時移動可能
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath:]
//
//// Index
//
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED;  // tell table which section corresponds to section title/index (e.g. "B",1))
//
//// Data manipulation - insert and delete support
//
//// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
//// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//
//// Data manipulation - reorder / moving support
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

//
//// Display customization
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

// セルヘッダビュー
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//
//// Variable height support
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//// セルヘッダ高さ
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
////    NSNumber *height = [[self heightHeaders] objectForKey:@(section)];
////    if(height != nil)
////    {
////        return [height floatValue];
////    }
////    return 0;
////    UIView *headerView = [CTTableViewTrait callTableHeaderViewWithController:self tableView:tableView section:section];
//    UIView *headerView = [self tableView:tableView viewForHeaderInSection:section];
//    if(headerView == nil)
//    {
//        return 0;
//    }
////    CTLog(@"section = %ld, height = %f", (long)section, [headerView frame].size.height);
//    return [headerView frame].size.height;
//}
//// セルフッタ高さ
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
////    NSNumber *height = [[self heightFooters] objectForKey:@(section)];
////    if(height != nil)
////    {
////        CTLog(@"aa section = %ld, height = %f", section, [height floatValue]);
////        return [height floatValue]+24;
////    }
////    CTLog(@"aa section = %ld, height = %f", section, [height floatValue]);
////    return 0;
////    UIView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[CTTableHeaderFooterView reuseIdentifierWithSection:section]];
////    UIView *footerView = [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];
////    if(footerView != nil)
////    {
////        return [footerView frame].size.height;
////    }
////    return 0;
//    
//    UIView *footerView = [self tableView:tableView viewForFooterInSection:section];
////    UIView *footerView = [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];
//    if(footerView == nil)
//    {
//        return 0;
//    }
//    return [footerView frame].size.height;
//    
////    [self table]
//    
//////    UIView *footerView = [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];
////    UIView *footerView = [self tableView:tableView viewForFooterInSection:section];
////    if(footerView == nil)
////    {
////        CTLog(@"section = %ld, height = %f", (long)section, .0f);
////        return 0;
////    }
////    CTLog(@"section = %ld, height = %f", (long)section, [footerView frame].size.height);
////    return [footerView frame].size.height;
////    return 40;
//}
//
//// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
//// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//
//// Section header & footer information. Views are preferred over title should you decide to provide both
//
//// セルヘッダを返す
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // head title
//    NSString *titleString = [self callHeaderTitleWithSection:section];
//    
//    // head title exist
//    if([titleString length] > 0)
//    {
//        // head id
//        NSString *HeadID = [CTTableHeaderFooterView reuseHeaderIdentifierWithSection:section];
//        
//        // dequeue
//        CTTableHeaderFooterView *headerFooterView = (CTTableHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
//        
//        // generate
//        if(headerFooterView == nil)
//        {
//            headerFooterView = [[CTTableHeaderFooterView alloc] initWithReuseIdentifier:HeadID];
//        }
//        
//        // bind
//        if(headerFooterView != nil)
//        {
//            [headerFooterView bindTitle:titleString];
//        }
//        
//        return headerFooterView;
//    }
//    
//    return nil;
//}
//// セルヘッダを返す
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [CTTableViewTrait callTableHeaderViewWithController:self tableView:tableView section:section];
//    return headerView;
//}
//// セルフッタを返す
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];
//    return footerView;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height
//
//// Accessories (disclosures).
//
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//
//// Selection
//
//// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
//// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//
//// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//// Called after the user changes the selection.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//
//// Editing
//
//// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED; // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//
//// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//
//// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED;
//
//// Moving/reordering
//
//// Allows customization of the target row for a particular row as it is being moved/reordered

// セクション変更時のセル設定
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//
//// Indentation
//
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//
//// Copy/Paste.  All three methods must be implemented by the delegate.
//
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//
//// Focus
//
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);



#pragma mark - CTTableViewDelagate
//
// CTTableViewDelagate
//

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section
{
    if([[self headTitles] count] >= (section + 1))
    {
        return [[self headTitles] objectAtIndex:section];
    }
    return @"";
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

// テーブルモード
- (CTTableViewMode)callTableViewMode
{
    return CTTableViewModeEdit;
}


#pragma mark - method
//
// method
//

// 表示(保存ボタン)
- (BOOL)visibleSaveButton
{
    return YES;
}

// 表示(削除ボタン)
- (BOOL)visibleRemoveButton
{
    return YES;
}

// ボタン押下時(保存)
- (void)onTapBarButtonSave
{
    [self save];
}

// ボタン押下時(削除)
- (void)onTapBarButtonRemove
{
    [self presentViewController:[self callRemoveAlertController] animated:YES completion:nil];
//    [[self callRemoveAlertController] showViewController:self sender:self];
}

// フィールド内容変更時
- (void)onChangeField
{
    
}

// フィールド内容変更処理
- (void)changeFieldWithIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass valueClass:(Class)valueClass
{
    if([[self tableView] cellForRowAtIndexPath:indexPath] != nil)
    {
        // CTTableCellTextField
        if(cellClass == [CTTableCellTextField class])
        {
            // 入力値
            NSString *stringValue = [(CTTableCellTextField *) [[self tableView] cellForRowAtIndexPath:indexPath] contentText];
            
            // default
            id defaultValue = [NSNull null];
            id settingValue = [NSNull null];
            // convert class
            if(valueClass == [NSString class])
            {
                defaultValue = @"";
                settingValue = stringValue;
            }
            else if(valueClass == [NSNumber class])
            {
                defaultValue = @0;
                settingValue = @([stringValue integerValue]);
            }
            else if(valueClass == [NSDecimalNumber class])
            {
                defaultValue = [NSDecimalNumber zero];
                settingValue = [CTDecimal decimalWithString:stringValue];
            }
            settingValue = [CTEmptyVL compare:settingValue value1:settingValue value2:defaultValue];
            
            // 設定
            [[self temporary] setObject:settingValue forKey:indexPath];
        }
        // CTTableCellTextView
        else if(cellClass == [CTTableCellTextView class])
        {
            // 入力値
            NSString *stringValue = [(CTTableCellTextView *) [[self tableView] cellForRowAtIndexPath:indexPath] contentText];
            
            // default
            id defaultValue = [NSNull null];
            id settingValue = [NSNull null];
            // convert class
            if(valueClass == [NSString class])
            {
                defaultValue = @"";
                settingValue = stringValue;
            }
            else if(valueClass == [NSNumber class])
            {
                defaultValue = @0;
                settingValue = @([stringValue integerValue]);
            }
            settingValue = [CTEmptyVL compare:settingValue value1:settingValue value2:defaultValue];
            
            // 設定
            [[self temporary] setObject:settingValue forKey:indexPath];
        }
    }
}

// 保存処理
- (void)save
{
    
}

// 削除処理
- (void)remove
{
    
}



#pragma mark - private
//
// private
//

// バーボタン再描画
- (void)redrawBarButton
{
    NSMutableArray<CTBarButtonItem *> *barButtonItems;
    
    // バーボタン表示
    barButtonItems = [@[] mutableCopy];
    if([self visibleSaveButton] == YES)
    {
        [barButtonItems addObject:[self saveBarButton]];
    }
    [[self navigationItem] setRightBarButtonItems:barButtonItems];
    
    // ツールバーボタン表示
    barButtonItems = [[self toolbarItems] mutableCopy];
    if(barButtonItems == nil)
    {
        barButtonItems = [@[] mutableCopy];
    }
    if([self visibleRemoveButton] == YES)
    {
        if([barButtonItems indexOfObject:[self removeBarButton]] == NSNotFound)
        {
            [barButtonItems insertObject:[self removeBarButton] atIndex:0];
        }
    }
    [self setToolbarItems:barButtonItems];
    [[self navigationController] setToolbarHidden:([barButtonItems count] == 0)];
    [[[self navigationController] toolbar] setBarTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTintColor]];
}

// 削除アラート
- (UIAlertController *)callRemoveAlertController
{
    if([self removeAlertController] == nil)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"削除してよろしいですか？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"削除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self remove];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // none
        }]];
        [self setRemoveAlertController:alert];
    }
    return [self removeAlertController];
}

@end
