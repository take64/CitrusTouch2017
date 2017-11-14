//
//  CTTableCellButtonTextField.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCellTextField.h"

//typedef NS_ENUM(NSInteger, CTTableCellButtonTextFieldMode) {
//    CTTableCellButtonTextFieldModeText,
//    CTTableCellButtonTextFieldModeNumber,
//    CTTableCellButtonTextFieldModeDecimal
//};

@interface CTTableCellButtonTextField : CTTableCellTextField <UITextFieldDelegate>
{
//    // input mode
//    CTTableCellButtonTextFieldMode inputMode;
    
    // button
    CTImageButton *clearButton;
//    CTButton *removeButton;
    CTButton *selectButton;
}

//
// property
//
//@property (nonatomic, assign) CTTableCellButtonTextFieldMode inputMode;
@property (nonatomic, retain) CTImageButton *clearButton;
//@property (nonatomic, retain) CTButton *removeButton;
@property (nonatomic, retain) CTButton *selectButton;


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

@end
