//
//  CTLabel.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTLabel.h"

#import "CitrusTouchUI.h"

@implementation CTLabel

//
// synthesize
//


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:NO];
    }
    return self;
}


// 表示設定
- (void)setText:(NSString *)textString
{
    [super setText:textString];
//    [self setNeedsDisplay];
}


@end
