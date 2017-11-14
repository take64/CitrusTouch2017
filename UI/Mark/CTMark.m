//
//  CTMark.m
//  CitrusTouch3
//
//  Created by take64 on 2017/05/07.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTMark.h"

@implementation CTMark

// mark clear
+ (UIImageView *)markClearWithSize:(CGSize)size
{
    return [CTMark markWithName:@"mark-clear" size:size];
}



// mark generate
+ (UIImageView *)markWithName:(NSString *)filename size:(CGSize)size
{
    UIImageView *imageView;
    UIImage *image;
    
    image = [UIImage imageNamed:filename];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    
    return imageView;
}

@end
