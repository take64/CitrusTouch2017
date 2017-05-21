//
//  CTImageButton.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/05/07.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTButton.h"

@interface CTImageButton : CTButton
{
    UIImageView *imageView;
}

//
// property
//
@property (nonatomic, retain) UIImageView *imageView;


//
// method
//

// 初期化
- (instancetype)initWithImageView:(UIImageView *)_imageView;

@end
