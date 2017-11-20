//
//  CitrusTouchUI.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#ifndef CitrusTouchUI_h
#define CitrusTouchUI_h


__attribute__((unused)) static CGFloat CT8(CGFloat oct)
{
    return oct * 8;
}
__attribute__((unused)) static NSString * CT8Str(CGFloat oct)
{
    return [@(CT8(oct)) stringValue];
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
#import "CTButtonGroup.h"
#import "CTImageButton.h"

#import "CTView.h"

#import "CTTextView.h"


// overlay
#import "CTOverlayProgressIndicator.h"

// table cell
#import "CTTableCell.h"
#import "CTTableCellButton.h"
#import "CTTableCellButtonTextField.h"
#import "CTTableCellDatePicker.h"
#import "CTTableCellLabel.h"
#import "CTTableCellTextView.h"
#import "CTTableCellTextField.h"
#import "CTTableCellTextFieldInnerTextField.h"

// table header footer
#import "CTTableHeaderFooterView.h"
#import "CTTableHeaderView.h"
#import "CTTableFooterView.h"

// mark
#import "CTMark.h"


#endif /* CitrusTouchUI_h */
