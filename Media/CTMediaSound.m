//
//  CTMediaSound.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTMediaSound.h"

#import <AudioToolbox/AudioToolbox.h>

@implementation CTMediaSound

// ボタン押下音
+ (void)playButtonSound
{
    static SystemSoundID beepSoundId;
    if(!beepSoundId)
    {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSURL *beepWavURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"buttonSound" ofType:@"m4a"] isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepWavURL, &beepSoundId);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        AudioServicesPlaySystemSound(beepSoundId);
    });
}

@end
