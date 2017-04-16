//
//  CTTableCellTextField.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCell.h"

@class CTTableCellTextFieldInnerTextField;

@interface CTTableCellTextField : CTTableCell <UITextFieldDelegate>
{
    // テキストフィールド
    CTTableCellTextFieldInnerTextField *textField;
}

//
// property
//
@property (nonatomic, retain) CTTableCellTextFieldInnerTextField *textField;



//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *)contentText;

// テキスト設定
- (void)setContentText:(NSString *)stringValue;

@end
