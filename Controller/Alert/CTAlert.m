//
//  CTAlert.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTAlert.h"

@interface CTAlert ()

@end

@implementation CTAlert


// OKアラート取得
+ (CTAlert *)callOkWithTitle:(NSString *)title messages:(id)messages
{
    static CTAlert *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [CTAlert alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [singleton addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    });
    
    // title
    [singleton setTitle:title];
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
    [singleton setMessage:messageString];
    
    return singleton;
}

// OKアラート表示
+ (void)okWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController
{
    CTAlert *alert = [CTAlert callOkWithTitle:title messages:messages];
    [parentController presentViewController:alert animated:YES completion:nil];
}


@end
