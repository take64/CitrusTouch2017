//
//  CTBaseListController.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseTableController.h"
#import <CoreData/CoreData.h>

@interface CTBaseListController : CTBaseTableController <NSFetchedResultsControllerDelegate>
{
    // bar button
    CTBarButtonItem *addBarButton;
    CTBarButtonItem *editStartBarButton;
    CTBarButtonItem *editEndBarButton;
    CTBarButtonItem *selectBarButton;
}

//
// property
//
@property (nonatomic, retain) CTBarButtonItem *addBarButton;
@property (nonatomic, retain) CTBarButtonItem *editStartBarButton;
@property (nonatomic, retain) CTBarButtonItem *editEndBarButton;
@property (nonatomic, retain) CTBarButtonItem *selectBarButton;

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
