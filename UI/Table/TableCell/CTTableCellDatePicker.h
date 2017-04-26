//
//  CTTableCellDatePicker.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCellTextField.h"

typedef NS_ENUM(NSInteger, CTTableCellDatePickerMode) {
    CTTableCellDatePickerModeNone,
    CTTableCellDatePickerModeStandard,
    CTTableCellDatePickerModeDate,
};

@interface CTTableCellDatePicker : CTTableCellTextField
{
    // ピッカー
    UIDatePicker *datePicker;
    
    // フォーマット
    NSDateFormatter *dateFormatter;
    
    // ピッカーモード
    CTTableCellDatePickerMode pickerMode;
    
    // パッキングビュー
    UIView *inputPackingView;
}

//
// property
//
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic) CTTableCellDatePickerMode pickerMode;
@property (nonatomic, retain) UIView *inputPackingView;


//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSDate *)dateValue suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 設定(ピッカーモード)
- (void)chnagePickerMode:(CTTableCellDatePickerMode)_pickerModeValue;

// 取得(日付)
- (NSDate *)date;

// 設定(日付)
- (void)setDate:(NSDate *)dateValue;

@end
