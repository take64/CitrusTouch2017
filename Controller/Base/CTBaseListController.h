//
//  CTBaseListController.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CTBaseListController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    // bar button
    CTBarButtonItem *addBarButton;
    CTBarButtonItem *editStartBarButton;
    CTBarButtonItem *editEndBarButton;
}

//
// property
//
@property (nonatomic, retain) CTBarButtonItem *addBarButton;
@property (nonatomic, retain) CTBarButtonItem *editStartBarButton;
@property (nonatomic, retain) CTBarButtonItem *editEndBarButton;

//
// method
//

// タイトル取得
- (NSString *)callTitle;

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section;

// 表示(追加ボタン)
- (BOOL)visibleAddButton;

// 表示(編集ボタン)
- (BOOL)visibleEditButton;

// 編集時(移動可能)
- (BOOL)canMoveEditing;

// ボタン押下時(追加)
- (void)onTapBarButtonAdd;

// ボタン押下時(編集開始)
- (void)onTapBarButtonEditStart;

// ボタン押下時(編集終了)
- (void)onTapBarButtonEditEnd;

@end
