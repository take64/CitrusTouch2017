//
//  CTTableCellTextView.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCellTextView.h"

@implementation CTTableCellTextView

//
// synthesize
//
@synthesize textView;
@synthesize didEndEditingBlock;
//@synthesize didEndEditingTarget;
//@synthesize didEndEditingSelector;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayouted] == NO)
    {
        [[self textView] setFrame:[self contentFrame]];
        
        
        // レイアウト済み
        [self setSubLayouted:YES];
    }
}




#pragma mark - UITextViewDelegate
//
// UITextViewDelegate
//

// 編集開始前
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    [self activate];
    return YES;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//- (void)textViewDidBeginEditing:(UITextView *)textView;
// 編集終了後
- (void)textViewDidEndEditing:(UITextView *)textView
{
//    [self deactivate];
    
    // 編集後処理が登録されていて、呼べれば呼ぶ
    if(self.didEndEditingBlock != nil)
    {
        self.didEndEditingBlock();
    }
//    if([[self didEndEditingTarget] respondsToSelector:[self didEndEditingSelector]] == YES)
//    {
//        [[self didEndEditingTarget] performSelector:[self didEndEditingSelector]];
//    }
    
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
//- (void)textViewDidChange:(UITextView *)textView;
//- (void)textViewDidChangeSelection:(UITextView *)textView;




#pragma mark - method
//
// method
//

// 初期化
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:nil content:nil suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // part
        CTTextView *_textView;
        
        // テキストフィールド
        _textView = [[CTTextView alloc] initWithFrame:CGRectZero];
        [_textView setFont:[UIFont systemFontOfSize:16.0]];
        [_textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textView setReturnKeyType:UIReturnKeyDone];
        [_textView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin        |
                                              UIViewAutoresizingFlexibleRightMargin |
                                              UIViewAutoresizingFlexibleTopMargin   |
                                              UIViewAutoresizingFlexibleBottomMargin|
                                              UIViewAutoresizingFlexibleWidth       |
                                              UIViewAutoresizingFlexibleHeight)];
        [_textView setDelegate:self];
//        [self setResponder:[self textView]];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [[self contentView] addSubview:_textView];
        [self setTextView:_textView];
        
        
        
        
//        [self setTextView:[[CTTextView alloc] initWithFrame:CGRectZero]];
//        [[self textView] setFont:[UIFont systemFontOfSize:16.0]];
//        [[self textView] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//        [[self textView] setReturnKeyType:UIReturnKeyDone];
//        [[self textView] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
//                                              UIViewAutoresizingFlexibleRightMargin |
//                                              UIViewAutoresizingFlexibleTopMargin |
//                                              UIViewAutoresizingFlexibleBottomMargin |
//                                              UIViewAutoresizingFlexibleWidth	|
//                                              UIViewAutoresizingFlexibleHeight)];
//        [[self textView] setDelegate:self];
//        [self setResponder:[self textView]];
//        [[self contentView] addSubview:[self textView]];
//        
//        [[self textView] setBackgroundColor:[UIColor clearColor]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
//        // ツールバー(配置)
//        [[self textView] setInputAccessoryView:[self toolbar]];
    }
    return self;
}

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self textView] setText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *)contentText
{
    return [[self textView] text];
}
// テキスト設定
- (void)setContentText:(NSString *)stringValue
{
    [[self textView] setText:stringValue];
}

//// テキスト編集完了時
//- (void)setDidEndEditingTarget:(id)target selector:(SEL)selector
//{
//    [self setDidEndEditingTarget:target];
//    [self setDidEndEditingSelector:selector];
//}

@end
