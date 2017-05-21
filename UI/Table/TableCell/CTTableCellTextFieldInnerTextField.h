//
//  CTTableCellTextFieldInnerTextField.h
//  CitrusTouch
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CTTableCellTextFieldInnerTextFieldEditingEndBlock)(CTTableCellTextFieldInnerTextField *textFieldValue);

@interface CTTableCellTextFieldInnerTextField : UITextField
{
    // メニュー表示
    BOOL enableMenu;
    
    // ボタン押下時ブロック
    CTTableCellTextFieldInnerTextFieldEditingEndBlock editingEndBlock;
}

//
// property
//
@property (nonatomic, assign) BOOL enableMenu;
@property (nonatomic, copy)   CTTableCellTextFieldInnerTextFieldEditingEndBlock editingEndBlock;


//
// method
//

// ボタン押下時ブロック
- (void)setOnEditingEndComplete:(CTTableCellTextFieldInnerTextFieldEditingEndBlock)completeBlock;

// ボタン押下時
- (void)onEditingEndTextField:(CTTableCellTextFieldInnerTextField *)textFieldValue;

@end
