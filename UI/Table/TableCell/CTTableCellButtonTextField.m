//
//  CTTableCellButtonTextField.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCellButtonTextField.h"

@implementation CTTableCellButtonTextField

//
// synthesize
//
//@synthesize inputMode;
@synthesize clearButton;
@synthesize selectButton;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayouted] == NO)
    {
        [[self textField] setFrame:[self contentFrame]];
        CGRect textFieldRect = [[self textField] frame];
        textFieldRect.size.width -= 88;
        textFieldRect.origin.x += 88;
        [[self textField] setFrame:textFieldRect];
        
        // レイアウト済み
        [self setSubLayouted:YES];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(selected == YES)
    {
        if([[self textField] canBecomeFirstResponder] == YES)
        {
            [[self textField] becomeFirstResponder];
        }
    }
}




#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

// 編集開始前
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue
{
//    [self activate];
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//// 編集終了後
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue
//{
//    [self deactivate];
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;




#pragma mark - method
//
// method
//

// 初期化
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:nil suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:nil suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
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

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self textField] setText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *)contentText
{
    if([[self textField] text] == nil)
    {
        return @"";
    }
    return [[self textField] text];
}

// テキスト設定
- (void)setContentText:(NSString *)stringValue
{
    [[self textField] setText:stringValue];
}

@end
