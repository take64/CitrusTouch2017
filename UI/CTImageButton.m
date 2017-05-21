//
//  CTImageButton.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/05/07.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTImageButton.h"

@implementation CTImageButton

//
// synthesize
//
@synthesize imageView;


// 初期化
- (instancetype)initWithImageView:(UIImageView *)_imageView
{
    self = [super initWithFrame:[_imageView frame]];
    if(self)
    {
        [self setImageView:_imageView];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[self imageView] setCenter:[self center]];
}

@end
