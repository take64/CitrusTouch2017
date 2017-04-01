//
//  CitrusTouchUI.h
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#ifndef CitrusTouchUI_h
#define CitrusTouchUI_h


__attribute__((unused)) static CGFloat CT8(int hex)
{
    return hex * 8;
}
__attribute__((unused)) static NSString * CT8Str(int hex)
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

#import "CTView.h"

// table cell
#import "CTTableCell.h"

#endif /* CitrusTouchUI_h */
