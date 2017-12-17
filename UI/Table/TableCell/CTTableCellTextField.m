//
//  CTTableCellTextField.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTTableCellTextField.h"

@implementation CTTableCellTextField



//
// synthesize
//
@synthesize textField;
@synthesize toolbar;
@synthesize prevNextSegmented;
@synthesize prevCell;
@synthesize nextCell;
@synthesize responder;



#pragma mark - extends
//
// extends
//

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 未レイアウトの場合
    if ([self isSubLayouted] == NO)
    {
        [[self textField] setFrame:[self contentFrame]];

        // size offset
        [[self textField] setFrame:CGRectDiff([[self textField] frame], [self callOffset])];

        // レイアウト済み
        [self setSubLayouted:YES];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected == YES)
    {
        if ([[self textField] canBecomeFirstResponder] == YES)
        {
            [[self textField] becomeFirstResponder];
        }
    }
}




#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

//// 編集開始前
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue;
////- (void)textFieldDidBeginEditing:(UITextField *)textField;
////- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//// 編集終了後
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue;
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;

// 編集開始時
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self refreshPrevNextSegmented];
    return YES;
}

// Return押し時
- (BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    [_textField resignFirstResponder];
    return YES;
}



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
    if (self)
    {
        // テキストフィールド
        CTTableCellTextFieldInnerTextField *_textField = [[CTTableCellTextFieldInnerTextField alloc] initWithFrame:CGRectZero];
        [_textField setFont:[UIFont systemFontOfSize:14.0]];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textField setReturnKeyType:UIReturnKeyDone];
        [_textField setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin  |
                                         UIViewAutoresizingFlexibleRightMargin |
                                         UIViewAutoresizingFlexibleTopMargin   |
                                         UIViewAutoresizingFlexibleBottomMargin|
                                         UIViewAutoresizingFlexibleWidth	   |
                                         UIViewAutoresizingFlexibleHeight)];
        [_textField setDelegate:self];
        [[self contentView] addSubview:_textField];
        [self setTextField:_textField];
        [self setResponder:[self textField]];

        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

        // ツールバー(配置)
        [[self textField] setInputAccessoryView:[self callAccessoryToolbar]];
    }
    return self;
}

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setContentText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *)contentText
{
    if ([[self textField] text] == nil)
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

// ボタン押下時(キーボードDONE)
- (void)onTapBarButtonDone
{
    if ([[self responder] canResignFirstResponder] == YES)
    {
        [[self responder] resignFirstResponder];
    }
}

// 値変更時(前後ボタン)
- (void)onChangePrevNextSegmented:(UISegmentedControl *)segmentedControl
{
    // 前へ(後へ)フラグ
    BOOL isPrev = ([segmentedControl selectedSegmentIndex] == 0 ? YES : NO);
    // 対象セル
    CTTableCellTextField *tableCell = (isPrev == YES ? [self prevCell] : [self nextCell]);
    // responder処理
    if ([self hasResponder:tableCell] == YES && [[tableCell responder] canBecomeFirstResponder] == YES)
    {
        [[tableCell responder] becomeFirstResponder];
    }
    // リフレッシュ
    [self refreshPrevNextSegmented];
}

// リフレッシュ(前後ボタン)
- (void)refreshPrevNextSegmented
{
    // 前後ボタン(前)
    [[self prevNextSegmented] setEnabled:[self hasResponder:[self prevCell]] forSegmentAtIndex:0];
    // 前後ボタン(後)
    [[self prevNextSegmented] setEnabled:[self hasResponder:[self nextCell]] forSegmentAtIndex:1];
    // 普通はタッチした時に選択状態になるが YES にすると、ボタンみたいに状態が元に戻る
    [[self prevNextSegmented] setMomentary:YES];
}

// レスポンダ設定(前へ)
- (void)setPrevCellResponder:(CTTableCellTextField *)tableCell
{
    if ([self isKindOfFriendlyCell:tableCell] == YES)
    {
        // 後ポインタの設定
        [tableCell setNextCellResponder:self];
        // 前ポインタの設定
        [self setPrevCell:tableCell];
        // リフレッシュ
        [self refreshPrevNextSegmented];
    }
}

// レスポンダ設定(次へ)
- (void)setNextCellResponder:(CTTableCellTextField *)tableCell
{
    if ([self isKindOfFriendlyCell:tableCell] == YES)
    {
        // 後ポインタの設定
        [self setNextCell:tableCell];
        // リフレッシュ
        [self refreshPrevNextSegmented];
    }
}

// textFieldのoffset
- (CGRect)callOffset
{
    return CGRectMake(CT8(1), 0, CT8(-1), 0);
}



#pragma mark - private
//
// private
//

// responder を持っているか
- (BOOL)hasResponder:(CTTableCellTextField *)tableCell
{
    BOOL result = NO;
    if (tableCell != nil && [tableCell responder] != nil)
    {
        result = YES;
    }
    return result;
}

// text 入力系クラスかどうか
- (BOOL)isKindOfFriendlyCell:(CTTableCellTextField *)tableCell
{
    BOOL result = NO;
    if ([tableCell isKindOfClass:[CTTableCellTextField class]] == YES
        || [tableCell isKindOfClass:[CTTableCellDatePicker class]] == YES
        || [tableCell isKindOfClass:[CTTableCellTextView class]] == YES)
    {
        result = YES;
    }
    return result;
}

// ツールバーの生成
- (UIToolbar *)callAccessoryToolbar
{
    if ([self toolbar] == nil)
    {
        // ツールバー本体
        UIToolbar *_toolber = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [_toolber setBarStyle:UIBarStyleBlackOpaque];
        [_toolber setBarTintColor:[[CitrusTouchApplication callTheme] callNavigationBarTintColor]];
        [_toolber setTranslucent:YES];
        [self setToolbar:_toolber];

        // 前後セグメント
        UISegmentedControl *_segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"前へ", @"次へ"]];
        [_segmentedControl addTarget:self action:@selector(onChangePrevNextSegmented:) forControlEvents:UIControlEventValueChanged];
        [_segmentedControl setTintColor:[UIColor whiteColor]];
        [self setPrevNextSegmented:_segmentedControl];

        // 完了ボタン
        CTButtonGroup *buttonGroup = [CTButtonGroup bottunGroup];
        [buttonGroup addButtonWithTitle:@"完了" complete:^(CTButton *buttonValue) {
            [self onTapBarButtonDone];
        }];

        // 配置
        [_toolber setItems:@[ [CTBarButtonItem customView:_segmentedControl], [CTBarButtonItem flexibleSpacerItem], [buttonGroup toBarButtonItem],
                             ]];
    }
    return [self toolbar];
}

@end
