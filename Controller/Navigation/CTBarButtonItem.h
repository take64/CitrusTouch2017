//
//  CTBarButtonItem.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/11.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTBarButtonItem : UIBarButtonItem

// カスタムビューの生成/取得
+ (CTBarButtonItem *)customView:(UIView *)viewValue;

// スペーサーの取得
+ (CTBarButtonItem *)flexibleSpacerItem;

@end
