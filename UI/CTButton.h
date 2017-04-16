//
//  CTButton.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTControl.h"

@class CTButton;

typedef void (^CTButtonTappedBlock)(CTButton *buttonValue);

@interface CTButton : CTControl
{
    // ボタン押下時ブロック
    CTButtonTappedBlock tappedBlock;
}

//
// property
//
@property (nonatomic, copy) CTButtonTappedBlock tappedBlock;


//
// method
//

// ボタン押下時ブロック
- (void)setOnTappedComplete:(CTButtonTappedBlock)completeBLock;

// ボタン押下時
- (void)onTapButton:(CTButton *)buttonValue;

@end
