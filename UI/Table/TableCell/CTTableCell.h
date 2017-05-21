//
//  CTTableCell.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CTTableCellPartPriorityHidden,
    CTTableCellPartPriorityHigh,
    CTTableCellPartPriorityMiddle,
    CTTableCellPartPriorityLow
} CTTableCellPartPriority;

@class CTLabel;
@class CTControl;

//
//@class CTColor;


@interface CTTableCell : UITableViewCell
{
    // entity
    NSManagedObject *entity;
    
    // object
    NSObject *object;
    
    
    // プレフィックスラベル
    CTLabel *prefixLabel;
    // サフィックスラベル
    CTLabel *suffixLabel;
    
    // コンテンツ用表示領域
    CGFloat prefixWidth;
    CGFloat suffixWidth;
    CGRect contentFrame;
    
    // 優先度
    CTTableCellPartPriority prefixPriority;
    CTTableCellPartPriority contentPriority;
    CTTableCellPartPriority suffixPriority;

    // レイアウト済み
    BOOL layouted;
    // サブクラスレイアウト済み
    BOOL subLayouted;
    
    // 背景ビュー
    CTControl *bgView;

    
//    // ActiveColor
//    CTColor *activateColor;
//    // deActiveColor
//    CTColor *deactivateColor;
//    
//
//
//    // レスポンダー
//
//    // セル
//    NSIndexPath *prevIndexPath;
//    NSIndexPath *nextIndexPath;
//
////    
//    // 処理用ツールバー
//    UIToolbar *toolbar;
//    UISegmentedControl *prevNextSegmented;
//    CTTableCell *prevCell;
//    CTTableCell *nextCell;
//    UIResponder *responder;


//
//
//    // 背景View
//    CTControl *bgView;
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;
@property (nonatomic, retain) NSObject *object;
@property (nonatomic, retain) CTLabel *prefixLabel;
@property (nonatomic, retain) CTLabel *suffixLabel;
@property (nonatomic, assign) CGFloat prefixWidth;
@property (nonatomic, assign) CGFloat suffixWidth;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CTTableCellPartPriority prefixPriority;
@property (nonatomic, assign) CTTableCellPartPriority contentPriority;
@property (nonatomic, assign) CTTableCellPartPriority suffixPriority;
@property (nonatomic, assign, getter = isLayouted) BOOL layouted;
@property (nonatomic, assign, getter = isSubLayouted) BOOL subLayouted;
@property (nonatomic, retain) CTControl *bgView;


//@property (nonatomic, retain) CTColor *activateColor;
//@property (nonatomic, retain) CTColor *deactivateColor;

//@property (nonatomic, retain) NSIndexPath *prevIndexPath;
//@property (nonatomic, retain) NSIndexPath *nextIndexPath;


//@property (nonatomic, retain) CTControl *bgView;

//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 優先度設定
- (void)priorityPrefix:(CTTableCellPartPriority)prefix content:(CTTableCellPartPriority)content suffix:(CTTableCellPartPriority)suffix;


//
//// アクティブ
//- (void) activate;
//
//// デアクティブ
//- (void) deactivate;
//
//
//// ボタン押下時(キーボードDONE)
//- (void) onTapBarButtonDone;
//
//// 値変更時(前後ボタン)
//- (void) onChangeSegmentedPrevNext:(UISegmentedControl *)segmentedControl;
//
//// リフレッシュ(前後ボタン)
//- (void) refreshSegmentedPrevNext;
//
//// レスポンダ設定(前へ)
//- (void) setPrevCellResponder:(CTTableCell *)tableCell;
//
//// レスポンダ設定(次へ)
//- (void) setNextCellResponder:(CTTableCell *)tableCell;
//
//// レスポンダ設定(前へ)
//- (void) setPrevCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath;
//
//// レスポンダ設定(次へ)
//- (void) setNextCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath;
//
//
//// アクティブ色
//- (CTColor *) activateColor;
//
//// デアクティブ色
//- (CTColor *) deactivateColor;
//
//// height
//+ (CGFloat)callHeight;


// bind entity
- (void)bindEntity:(NSManagedObject *)entityValue;

// bind object
- (void)bindObject:(NSObject *)objectValue;

// redraw
- (void)redraw;


@end
