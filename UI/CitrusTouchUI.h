//
//  CitrusTouchUI.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#ifndef CitrusTouchUI_h
#define CitrusTouchUI_h


__attribute__((unused)) static CGFloat CT8(CGFloat hex)
{
    return hex * 8;
}
__attribute__((unused)) static NSString * CT8Str(CGFloat hex)
{
    return [@(CT8(hex)) stringValue];
}
__attribute__((unused)) static NSString * CTStr(CGFloat floatValue)
{
    return [@(floatValue) stringValue];
}

// base
#import "CTColor.h"
#import "CTStyle.h"

#import "CTControl.h"
#import "CTLabel.h"
#import "CTButton.h"

#import "CTView.h"

// overlay
#import "CTOverlayProgressIndicator.h"

// table cell
#import "CTTableCell.h"
#import "CTTableCellButton.h"
#import "CTTableCellLabel.h"
#import "CTTableCellTextField.h"
#import "CTTableCellTextFieldInnerTextField.h"

// table header footer
#import "CTTableHeaderFooterView.h"

#endif /* CitrusTouchUI_h */
