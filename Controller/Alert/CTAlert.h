//
//  CTAlert.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTAlert : UIAlertController


// OKアラート取得
+ (CTAlert *)callOkWithTitle:(NSString *)title messages:(id)messages;

// OKアラート表示
+ (void)okWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController;



@end
