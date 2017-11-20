//
//  CTBaseListController.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTBaseTableController.h"
#import <CoreData/CoreData.h>

#import "CitrusTouchUI.h"

@interface CTBaseListController : CTBaseTableController <NSFetchedResultsControllerDelegate>
{
    // bar button item
    CTBarButtonItem *barButtonItem;
    // bar button inner item
    CTButton *addButton;
    CTButton *editStartButton;
    CTButton *editEndButton;
    CTButton *selectButton;
}



//
// property
//
@property (nonatomic, retain) CTBarButtonItem *barButtonItem;
@property (nonatomic, retain) CTButton *addButton;
@property (nonatomic, retain) CTButton *editStartButton;
@property (nonatomic, retain) CTButton *editEndButton;
@property (nonatomic, retain) CTButton *selectButton;



//
// method
//

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section;

// 表示(追加ボタン)
- (BOOL)visibleAddButton;

// 表示(編集ボタン)
- (BOOL)visibleEditButton;

// 表示(選択ボタン)
- (BOOL)visibleSelectButton;

// 編集時(移動可能)
- (BOOL)canMoveEditing;

// ボタン押下時(追加)
- (void)onTapBarButtonAdd;

// ボタン押下時(編集開始)
- (void)onTapBarButtonEditStart;

// ボタン押下時(編集終了)
- (void)onTapBarButtonEditEnd;

// ボタン押下時(選択)
- (void)onTapBarButtonSelect;

@end
