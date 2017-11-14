//
//  CTOverlayProgressIndicator.m
//  CitrusTouch3
//
//  Created by take64 on 2013/02/01.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTOverlayProgressIndicator.h"

#import "CTStyle.h"
#import "CTLabel.h"

@implementation CTOverlayProgressIndicator

//
// synthesize
//
@synthesize activityIndicator;
@synthesize progressBar;
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize percentageLabel;
@synthesize denominator;
@synthesize numerator;
@synthesize parentView;
@synthesize drawQueue;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CTLabel *label;
        
        // 背景
        [[self callStyle] addStyles:@{
                                      @"background-color"   :@"0000007F",
                                      }];
        
        // パネル
        CTControl *panel = [[CTControl alloc] initWithFrame:CGRectZero];
        [[panel callStyle] addStyles:@{
                                       @"top"               :CTStr((frame.size.height / 2) - (160 / 2)),
                                       @"left"              :CTStr((frame.size.width / 2) - (240 / 2)),
                                       @"width"             :@"240",
                                       @"height"            :@"160",
                                       @"background-color"  :@"0000007F",
                                       @"border-radius"     :@"8",
                                       }];
        [self addSubview:panel];
        
        // タイトル
        label = [[CTLabel alloc] initWithFrame:CGRectZero];
        [[label callStyle] addStyles:@{
                                       @"top"           :@"0",
                                       @"left"          :@"0",
                                       @"width"         :@"240",
                                       @"height"        :@"32",
                                       @"font-size"     :@"16",
                                       @"font-weight"   :@"bold",
                                       }];
        [panel addSubview:label];
        [self setTitleLabel:label];
        
        // アクティビティインジケーター
        [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithFrame:CGRectZero]];
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [[self activityIndicator] setCenter:CGPointMake(CT8(15), CT8(8))];
        [panel addSubview:[self activityIndicator]];
        
        // パーセント
        label = [[CTLabel alloc] initWithText:@"0/100"];
        [[label callStyle] addStyles:@{
                                       @"top"             :@"88",
                                       @"left"            :@"0",
                                       @"width"           :@"240",
                                       @"height"          :@"32",
                                       @"font-size"       :@"16",
                                       @"font-weight"     :@"bold",
                                       }];
        [panel addSubview:label];
        [self setPercentageLabel:label];
        
        // プログレスバー
        [self setProgressBar:[[UIProgressView alloc] initWithFrame:CGRectMake(CT8(2), CT8(15), CT8(26), 50)]];
        [[self progressBar] setProgressViewStyle:UIProgressViewStyleBar];
        [[self progressBar] setProgress:0 animated:NO];
        [panel addSubview:[self progressBar]];
        
        // メッセージ
        label = [[CTLabel alloc] initWithFrame:CGRectZero];
        [[label callStyle] addStyles:@{
                                       @"top"             :@"128",
                                       @"left"            :@"0",
                                       @"width"           :@"240",
                                       @"height"          :@"32",
                                       @"font-size"       :@"14",
                                       }];
        [panel addSubview:label];
        [self setMessageLabel:label];
        
        [self setDrawQueue: dispatch_queue_create("live.citrus.touch.draw",  DISPATCH_QUEUE_SERIAL)];
    }
    return self;
}


#pragma mark - method
//
// method
//

// 初期化
- (id)initWithParentView:(UIView *)parentViewValue
{
    CGRect parentFrame = [parentViewValue frame];
    CGFloat width;
    CGFloat height;
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait)
    {
        width   = MIN(parentFrame.size.width, parentFrame.size.height);
        height  = MAX(parentFrame.size.width, parentFrame.size.height);
    }
    else
    {
        width   = MAX(parentFrame.size.width, parentFrame.size.height);
        height  = MIN(parentFrame.size.width, parentFrame.size.height);
    }
    if(parentFrame.size.width != width)
    {
        parentFrame.origin.y = 0;
        parentFrame.origin.x = 0;
    }
    
    parentFrame.size.width = width;
    parentFrame.size.height = height;
    
    self = [self initWithFrame:parentFrame];
    if(self)
    {
        // 親ビュー
        [self setParentView:parentViewValue];
        
    }
    return self;
}


// 表示
- (void)show
{
    // 回転開始
    [[self activityIndicator] startAnimating];
    
    // 表示
    [[self parentView] addSubview:self];
}

// 非表示
- (void)hide
{
    // プログレス
    [self updateNumerator:@1 denominator:@1];
    
    // 回転停止
    [[self activityIndicator] stopAnimating];
    
    // 非表示
    [self removeFromSuperview];
}

// タイトル
- (void)setTitle:(NSString *) stringValue
{
    [[self titleLabel] setText:stringValue];
}

// メッセージ
- (void)setMessage:(NSString *) stringValue
{
    [[self messageLabel] setText:stringValue];
}

// パーセンテージ
- (void)setPercentage:(NSString *)stringValue
{
    CTLog(@"CTOverlayProgressIndicator.setPercentage:%@", stringValue);
    [[self percentageLabel] setText:stringValue];
}

// 分子更新
- (void)updateNumerator:(NSNumber *)numberValue
{
    CTLog(@"CTOverlayProgressIndicator.updateNumerator:%@", numberValue);
    
    if(numberValue == nil)
    {
        CTLog(@"%@", numberValue);
    }
    
    // 分子更新
    [self setNumerator:numberValue];
    
    // バー更新
    [self updateProgressBar];
}

// 分母更新
- (void)updateDenominator:(NSNumber *)numberValue
{
    CTLog(@"CTOverlayProgressIndicator.updateDenominator:%@", numberValue);
    
    // 分母更新
    [self setDenominator:numberValue];
    
    // バー更新
    [self updateProgressBar];
}

// 分子分母更新
- (void)updateNumerator:(NSNumber *)numberValue1 denominator:(NSNumber *)numberValue2
{
    CTLog(@"CTOverlayProgressIndicator.updateNumerator:%@ denominator:%@", numberValue1, numberValue2);
    
    // 分子更新
    [self setNumerator:numberValue1];
    // 分母更新
    [self setDenominator:numberValue2];
    
    
    // バー更新
    [self updateProgressBar];
}

// バー更新
- (void)updateProgressBar
{
    // 進捗計算
    CGFloat progress = [[self numerator] floatValue] / [[self denominator] floatValue];
    if(isnan(progress) == TRUE || progress < 0)
    {
        progress = 0;
    }
    
    dispatch_async([self drawQueue], ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            usleep(50000);
            
            // バー更新
            BOOL animated = (progress == 0 ? NO : YES);
            CTLog(@"percentage : %f", progress);
            [[self progressBar] setProgress:progress animated:animated];
            
            // パーセンテージ更新
            [self setPercentage:[NSString stringWithFormat:@"%.2f %%", (progress * 100)]];
            
            [self layoutIfNeeded];
        });
    });
}

// 分子更新
- (void)updateWithInfo:(NSDictionary *)infoValue;
{
    if([infoValue objectForKey:@"numerator"] != nil)
    {
        [self updateNumerator:[infoValue objectForKey:@"numerator"]];
    }
    if([infoValue objectForKey:@"denominator"] != nil)
    {
        [self updateDenominator:[infoValue objectForKey:@"denominator"]];
    }
    if([infoValue objectForKey:@"title"] != nil)
    {
        [self setTitle:[infoValue objectForKey:@"title"]];
    }
    if([infoValue objectForKey:@"message"] != nil)
    {
        [self setMessage:[infoValue objectForKey:@"message"]];
    }
}

@end
