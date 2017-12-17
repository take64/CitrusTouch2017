//
//  CTTableCell.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
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



//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 優先度設定
- (void)priorityPrefix:(CTTableCellPartPriority)prefix content:(CTTableCellPartPriority)content suffix:(CTTableCellPartPriority)suffix;

// bind entity
- (void)bindEntity:(NSManagedObject *)entityValue;

// bind object
- (void)bindObject:(NSObject *)objectValue;

// redraw
- (void)redraw;

@end
