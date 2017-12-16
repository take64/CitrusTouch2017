//
//  CTTableCellTextField.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@class CTTableCellTextFieldInnerTextField;

@interface CTTableCellTextField : CTTableCell <UITextFieldDelegate>
{
    // テキストフィールド
    CTTableCellTextFieldInnerTextField *textField;

    // 処理用ツールバー
    UIToolbar *toolbar;
    UISegmentedControl *prevNextSegmented;
    CTTableCellTextField *prevCell;
    CTTableCellTextField *nextCell;
    UIResponder *responder;
}



//
// property
//
@property (nonatomic, retain) CTTableCellTextFieldInnerTextField *textField;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *prevNextSegmented;
@property (nonatomic, retain) CTTableCellTextField *prevCell;
@property (nonatomic, retain) CTTableCellTextField *nextCell;
@property (nonatomic, retain) UIResponder *responder;



//
// method
//

// 初期化
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *)contentText;

// テキスト設定
- (void)setContentText:(NSString *)stringValue;

// レスポンダ設定(前へ)
- (void)setPrevCellResponder:(CTTableCell *)tableCell;

// レスポンダ設定(次へ)
- (void)setNextCellResponder:(CTTableCell *)tableCell;

// textFieldのoffset
- (CGRect)callOffset;

@end
