//
//  CTTableCellTextField.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/09.
//  Copyright © 2017年 citrus.tk. All rights reserved.
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
        [[self contentView] addSubview:_textField];
        [self setTextField:_textField];
        [self setResponder:[self textField]];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
        
        // ツールバー
        [self setToolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)]];
        [[self toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self toolbar] setTranslucent:YES];
        [self setPrevNextSegmented:[[UISegmentedControl alloc] initWithItems:@[@"前へ", @"次へ"]]];
        //        [[self prevNextSegmented] setSegmentedControlStyle:UISegmentedControlStyleBar];
        [[self prevNextSegmented] addTarget:self action:@selector(onChangePrevNextSegmented:) forControlEvents:UIControlEventValueChanged];
        [[self prevNextSegmented] setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *barButtonPrevNext = [[UIBarButtonItem alloc] initWithCustomView:[self prevNextSegmented]];
        
        // ツールバーパーツ
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapBarButtonDone)];
        [barButtonDone setTintColor:[UIColor whiteColor]];
        [[self toolbar] setItems:[NSArray arrayWithObjects:barButtonPrevNext, barSpacer, barButtonDone, nil]];
        
        // ツールバー(配置)
        [[self textField] setInputAccessoryView:[self toolbar]];
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

// ボタン押下時(キーボードDONE)
- (void)onTapBarButtonDone
{
    if([[self responder] canResignFirstResponder] == YES)
    {
        [[self responder] resignFirstResponder];
    }
}

// 値変更時(前後ボタン)
- (void)onChangePrevNextSegmented:(UISegmentedControl *)segmentedControl
{
    switch ([segmentedControl selectedSegmentIndex])
    {
        case 0: // 前へ
            if([self prevCell] != nil && [[self prevCell] responder] != nil && [[[self prevCell] responder] canBecomeFirstResponder] == YES)
            {
                //                UITableView *tableView = (UITableView *)[self superview];
                //                [tableView scrollToRowAtIndexPath:[self prevIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [[[self prevCell] responder] becomeFirstResponder];
            }
            break;
        case 1: // 次へ
            if([self nextCell] != nil && [[self nextCell] responder] != nil && [[[self nextCell] responder] canBecomeFirstResponder] == YES)
            {
                //                UITableView *tableView = (UITableView *)[self superview];
                //                [tableView scrollToRowAtIndexPath:[self nextIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [[[self nextCell] responder] becomeFirstResponder];
            }
        default:
            break;
    }
    
    // リフレッシュ
    [self refreshPrevNextSegmented];
}

// リフレッシュ(前後ボタン)
- (void)refreshPrevNextSegmented
{
    // 前後ボタン
    if([self prevCell] != nil && [[self prevCell] responder] != nil)
    {
        [[self prevNextSegmented] setEnabled:YES forSegmentAtIndex:0];
    }
    else
    {
        [[self prevNextSegmented] setEnabled:NO forSegmentAtIndex:0];
    }
    if([self nextCell] != nil && [[self nextCell] responder] != nil)
    {
        [[self prevNextSegmented] setEnabled:YES forSegmentAtIndex:1];
    }
    else
    {
        [[self prevNextSegmented] setEnabled:NO forSegmentAtIndex:1];
    }
    [[self prevNextSegmented] setMomentary:YES];
}

// レスポンダ設定(前へ)
- (void)setPrevCellResponder:(CTTableCellTextField *)tableCell
{
    if([tableCell isKindOfClass:[CTTableCellTextField class]] == YES
       || [tableCell isKindOfClass:[CTTableCellDatePicker class]] == YES
       || [tableCell isKindOfClass:[CTTableCellTextView class]] == YES)
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
    if([tableCell isKindOfClass:[CTTableCellTextField class]] == YES
       || [tableCell isKindOfClass:[CTTableCellDatePicker class]] == YES
       || [tableCell isKindOfClass:[CTTableCellTextView class]] == YES)
    {
        // 後ポインタの設定
        [self setNextCell:tableCell];
        
        // リフレッシュ
        [self refreshPrevNextSegmented];
    }
}

//// レスポンダ設定(前へ)
//- (void)setPrevCellResponder:(CTTableCellTextField *)tableCell indexPath:(NSIndexPath *)indexPath
//{
//    // IndexPath
//    [self setPrevIndexPath:indexPath];
//    
//    // レスポンダ
//    [self setPrevCellResponder:tableCell];
//}
//
//// レスポンダ設定(次へ)
//- (void)setNextCellResponder:(CTTableCellTextField *)tableCell indexPath:(NSIndexPath *)indexPath
//{
//    // IndexPath
//    [self setNextIndexPath:indexPath];
//    
//    // レスポンダ
//    [self setNextCellResponder:tableCell];
//}


@end
