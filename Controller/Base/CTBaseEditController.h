//
//  CTBaseEditController.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTBaseTableController.h"

@class CTBarButtonItem;

@interface CTBaseEditController : CTBaseTableController
{
    // bar button
    CTBarButtonItem *saveBarButton;
    CTBarButtonItem *removeBarButton;
    
    // ヘッダ内セル数
    NSArray *rowOfSection;
    
    // ヘッダタイトル
    NSArray *headTitles;
    
    // datastore/temporary
    NSMutableDictionary *datastore;
    NSMutableDictionary *temporary;
    NSMutableDictionary *relations;
    
    // remove alert
    UIAlertController *removeAlertController;
}

//
// property
//
@property (nonatomic, retain) CTBarButtonItem *saveBarButton;
@property (nonatomic, retain) CTBarButtonItem *removeBarButton;
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) NSArray *headTitles;
@property (nonatomic, retain) NSMutableDictionary *datastore;
@property (nonatomic, retain) NSMutableDictionary *temporary;
@property (nonatomic, retain) NSMutableDictionary *relations;
@property (nonatomic, retain) UIAlertController *removeAlertController;


//
// method
//

// 表示(保存ボタン)
- (BOOL)visibleSaveButton;

// 表示(削除ボタン)
- (BOOL)visibleRemoveButton;

// ボタン押下時(保存)
- (void)onTapBarButtonSave;

// ボタン押下時(削除)
- (void)onTapBarButtonRemove;

// フィールド内容変更処理
- (void)changeFieldWithIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass valueClass:(Class)valueClass;

// 保存処理
- (void)save;

// 削除処理
- (void)remove;

@end
