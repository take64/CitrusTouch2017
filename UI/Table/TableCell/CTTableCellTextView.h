//
//  CTTableCellTextView.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@interface CTTableCellTextView : CTTableCell <UITextViewDelegate>
{
    // テキストビュー
    CTTextView *textView;
    
    // Did End Editing
    CitrusTouchBlock didEndEditingBlock;
//    id didEndEditingTarget;
//    SEL didEndEditingSelector;
}

//
// property
//
@property (nonatomic, retain) CTTextView *textView;
@property (nonatomic, copy)   CitrusTouchBlock didEndEditingBlock;
//@property (nonatomic, assign) id didEndEditingTarget;
//@property (nonatomic, assign) SEL didEndEditingSelector;



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

// テキスト編集完了時
//- (void)setDidEndEditingBlock:(CitrusTouchBlock)didEndEditingBlock
//- (void)setDidEndEditingTarget:(id)target selector:(SEL)selector;

@end
