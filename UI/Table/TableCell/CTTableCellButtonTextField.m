//
//  CTTableCellButtonTextField.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableCellButtonTextField.h"

@implementation CTTableCellButtonTextField

//
// synthesize
//
@synthesize clearButton;
@synthesize selectButton;



#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

// 編集開始前
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue
{
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//// 編集終了後
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue;
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;



#pragma mark - method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:nil suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // part
        CTButton *button;
        CTImageButton *imageButton;

        // style
        CTStyle *buttonHighlightedStyle = [[CTStyle alloc] initWithStyles:@{
                                                                            @"background-image" :@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                            }];
        CTStyle *buttonDisabledStyle = [[CTStyle alloc] initWithStyles:@{
                                                                         @"background-color"    :@"666666",
                                                                         }];

        // 削除ボタン
        imageButton = [[CTImageButton alloc] initWithImageView:[CTMark markClearWithSize:CGSizeMake(24, 24)]];
        [[imageButton callStyle] addStyles:@{
                                             @"width"              :@"44",
                                             @"height"             :@"44",
                                             }];
        [self addSubview:imageButton];
        [self setClearButton:imageButton];

        // 選択ボタン
        button = [[CTButton alloc] initWithText:@"..."];
        [[button callStyle] addStyles:@{
                                        @"left"               :@"40",
                                        @"width"              :@"80",
                                        @"font-size"          :@"14",
                                        @"font-weight"        :@"bold",
                                        @"color"              :@"333333",
                                        @"background-color"   :@"FFFFFF",
                                        @"border-color"       :@"CCCCCC",
                                        @"border-width"       :@"1",
                                        @"border-radius"      :@"4",
                                        @"margin"             :@"4 4 8 4",
                                        }];
        [button setStyleHighlighted:buttonHighlightedStyle];
        [button setStyleDisabled:buttonDisabledStyle];
        [self addSubview:button];
        [self setSelectButton:button];

        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

// textFieldのoffset
- (CGRect)callOffset
{
    return CGRectMake(CT8(11), 0, CT8(-11), 0);
}

@end
