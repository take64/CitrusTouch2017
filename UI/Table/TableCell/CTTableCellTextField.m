//
//  CTTableCellTextField.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCellTextField.h"

@implementation CTTableCellTextField

//
// synthesize
//
@synthesize textField;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayouted] == NO)
    {
        [[self textField] setFrame:[self contentFrame]];
        
        CGRect textFieldRect = [[self textField] frame];
        textFieldRect.size.width -= 8;
        textFieldRect.origin.x += 8;
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




#pragma mark -
#pragma mark UITextFieldDelegate
//
// UITextFieldDelegate
//

//// 編集開始前
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue
//{
//    [self activate];
//    return YES;
//}
////- (void)textFieldDidBeginEditing:(UITextField *)textField;
////- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//// 編集終了後
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue
//{
//    [self deactivate];
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if([self nextCell] != nil && [[self nextCell] responder] != nil && [[[self nextCell] responder] canBecomeFirstResponder] == YES)
//    {
//        [[[self nextCell] responder] becomeFirstResponder];
//    }
//    else
//    {
//        [[self responder] resignFirstResponder];
//    }
//    return YES;
//}




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
- (id)initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // テキストフィールド
        CTTableCellTextFieldInnerTextField *_textField = [[CTTableCellTextFieldInnerTextField alloc] initWithFrame:CGRectZero];
        [_textField setFont:[UIFont systemFontOfSize:14.0]];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textField setReturnKeyType:UIReturnKeyDone];
        [_textField setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                         UIViewAutoresizingFlexibleRightMargin |
                                         UIViewAutoresizingFlexibleTopMargin |
                                         UIViewAutoresizingFlexibleBottomMargin |
                                         UIViewAutoresizingFlexibleWidth	|
                                         UIViewAutoresizingFlexibleHeight)];
        [_textField setDelegate:self];
//        [self setResponder:[self textField]];
        [[self contentView] addSubview:_textField];
        [self setTextField:_textField];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        // ツールバー(配置)
//        [[self textField] setInputAccessoryView:[self toolbar]];
    }
    return self;
}

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setContentText:textString];
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
