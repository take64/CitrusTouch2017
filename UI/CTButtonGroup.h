//
//  CTButtonGroup.h
//  CitrusTouch3
//
//  Created by take64 on 2017/11/20.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@interface CTButtonGroup : CTControl
{
    // ボタン一覧
    NSMutableArray<CTButton *> *buttons;
}



//
// property
//
@property (nonatomic, retain) NSMutableArray<CTButton *> *buttons;


//
// method
//

// ボタンの追加
- (void)addButton:(CTButton *)buttonValue;

// ボタンの追加(文字列から)
- (CTButton *)addButtonWithTitle:(NSString *)titleString complete:(CTButtonTappedBlock)completeBlock;

@end
