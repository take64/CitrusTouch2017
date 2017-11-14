//
//  CTAlert.m
//  CitrusTouch3
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTAlert.h"

@interface CTAlert ()

@end

@implementation CTAlert


// OKアラート取得
+ (CTAlert *)callOkAlertWithTitle:(NSString *)title messages:(id)messages handler:(void (^)(UIAlertAction *action))handler
{
    // alert
    CTAlert *alert = [CTAlert alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler]];
    
    // title
    [alert setTitle:title];
    // message
    NSString *messageString = @"";
    if([messages isKindOfClass:[NSArray class]] == YES)
    {
        messageString = [(NSArray *)messages componentsJoinedByString:@"\n"];
    }
    else if([messages isKindOfClass:[NSString class]] == YES)
    {
        messageString = (NSString *)messages;
    }
    [alert setMessage:messageString];
    
    return alert;
}

// OKアラート表示
+ (void)okAlertWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController handler:(void (^)(UIAlertAction *action))handler
{
    CTAlert *alert = [CTAlert callOkAlertWithTitle:title messages:messages handler:handler];
    [parentController presentViewController:alert animated:YES completion:nil];
}

// アクションシート取得
+ (CTAlert *)callActionSheetWithTitle:(NSString *)title messages:(id)messages actions:(NSArray<UIAlertAction *> *)actions
{
    CTAlert *alert = [CTAlert alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for(UIAlertAction *action in actions)
    {
        [alert addAction:action];
    }
    
    // title
    [alert setTitle:title];
    // message
    NSString *messageString = @"";
    if([messages isKindOfClass:[NSArray class]] == YES)
    {
        messageString = [(NSArray *)messages componentsJoinedByString:@"\n"];
    }
    else if([messages isKindOfClass:[NSString class]] == YES)
    {
        messageString = (NSString *)messages;
    }
    [alert setMessage:messageString];
    
    return alert;
}

@end
