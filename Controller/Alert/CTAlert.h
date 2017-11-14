//
//  CTAlert.h
//  CitrusTouch3
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTAlert : UIAlertController


// OKアラート取得
+ (CTAlert *)callOkAlertWithTitle:(NSString *)title messages:(id)messages handler:(void (^)(UIAlertAction *action))handler;

// OKアラート表示
+ (void)okAlertWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController handler:(void (^)(UIAlertAction *action))handler;

// アクションシート取得
+ (CTAlert *)callActionSheetWithTitle:(NSString *)title messages:(id)messages actions:(NSArray<UIAlertAction *> *)actions;

@end
