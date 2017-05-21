//
//  CTTableCellDatePicker.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/22.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTTableCellDatePicker.h"

#import "CTPlatformDevice.h"

@implementation CTTableCellDatePicker


//
// synthesize
//
@synthesize datePicker;
@synthesize dateFormatter;
@synthesize pickerMode;
@synthesize inputPackingView;




#pragma mark - method
//
// method
//

// 初期化
- (id)initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGFloat datePickerHeight = 216;
        
        // ピッカー
        [self setDatePicker:[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, datePickerHeight)]];
        [[self datePicker] addTarget:self action:@selector(onChangeDate:) forControlEvents:UIControlEventValueChanged];
        
        // フォーマッター
        [self setDateFormatter:[[NSDateFormatter alloc] init]];
        [[self dateFormatter] setLocale:[NSLocale currentLocale]];
        
        // テキストフィールド
        [[self textField] setEnableMenu:NO];
        [[self textField] setClearButtonMode:UITextFieldViewModeNever];
        
        // パッキングビュー
        CGFloat width = 320;
        if([CTPlatformDevice isIPad] == YES)
        {
            width = 1024;
        }
        [self setInputPackingView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, datePickerHeight)]];
        [[self inputPackingView] setBackgroundColor:[CTColor colorWithHEXString:@"999999"]];
        
        // ピッカーモード
        [self changePickerMode:CTTableCellDatePickerModeNone];
        
        // 配置
        [[self textField] setInputView:[self inputPackingView]];
    }
    return self;
}

// 初期化
- (id)initWithPrefix:(NSString *)prefixString content:(NSDate *)dateValue suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self datePicker] setDate:dateValue];
    }
    return self;
}

// 変更(ピッカーモード)
- (void)changePickerMode:(CTTableCellDatePickerMode)_pickerModeValue
{
    // 設定
    [self setPickerMode:_pickerModeValue];
    
    // ピッカーモードなし
    if(_pickerModeValue == CTTableCellDatePickerModeNone)
    {
        // 一旦外し
        for(UIView *childView in [[self inputPackingView] subviews])
        {
            if([childView respondsToSelector:@selector(removeFromSuperview)] == YES)
            {
                [childView removeFromSuperview];
            }
        }
        
        // 位置変更
        [[self datePicker] setFrame:CGRectMake(0, 0, 320, 216)];
        [[self datePicker] setCenter:[[self inputPackingView] center]];
        
        // 配置
        [[self inputPackingView] addSubview:[self datePicker]];
        
        
    }
    // ピッカーモードスタンダード
    else if(_pickerModeValue == CTTableCellDatePickerModeStandard)
    {
        // 位置変更
        [[self datePicker] setFrame:CGRectMake(0, 32, 320, 216)];
        CGRect rect = [[self datePicker] frame];
        rect.origin.x = ([[self datePicker] center].x - (rect.size.width / 2));
        [[self datePicker] setFrame:rect];
        
        // パッキングビュー
        [[self inputPackingView] setFrame:CGRectMake(0, 0, 320, 248)];
        [[self inputPackingView] addSubview:[self datePicker]];
        
        // ボタンスタイル
        CTStyle *buttonStyle = [[CTStyle alloc] initWithStyles:@{
                                                                 @"top"                 :@"0",
                                                                 @"height"              :@"32",
                                                                 @"font-size"           :@"16",
                                                                 @"color"               :@"333333",
                                                                 @"background-color"    :@"FFFFFF",
                                                                 @"background-image"    :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.75) 0.05, rgba(0.80, 0.80, 0.80, 0.80) 1.00)",
                                                                 }];
        CTStyle *buttonStyleHighlighed = [[CTStyle alloc] initWithStyles:@{
                                                                           @"background-image"  :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.75) 0.05, rgba(0.80, 0.80, 0.80, 0.80) 1.00)",
                                                                           }];
        
        
//        CTStyle *buttonStyle = [[CTStyle alloc] initWithStyleDictionary:
//                                [NSDictionary dictionaryWithObjectsAndKeys:
////                                 @"32",             @"height",
////                                 @"0",              @"top",
////                                 @"16",             @"font-size",
//                                 @"333333",         @"color",
//                                 @"FFFFFF",         @"background-color",
//                                 @"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.75) 0.05, rgba(0.80, 0.80, 0.80, 0.80) 1.00)",  @"background-image",
//                                 nil]];
//        CTStyle *buttonStyleHighlighed = [[CTStyle alloc] initWithStyleDictionary:
//                                          [NSDictionary dictionaryWithObjectsAndKeys:
//                                           @"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 1.00)",  @"background-image",
//                                           nil]];
        
        NSArray *buttonProperties = @[
                                      @{@"title"    :@"06:00",
                                        @"time"     :@"06:00",
                                        @"width"    :@"51",
                                        @"left"     :@"0",
                                        },
                                      @{@"title"    :@"09:00",
                                        @"time"     :@"09:00",
                                        @"width"    :@"51",
                                        @"left"     :@"52",
                                        },
                                      @{@"title"    :@"12:00",
                                        @"time"     :@"12:00",
                                        @"width"    :@"51",
                                        @"left"     :@"104",
                                        },
                                      @{@"title"    :@"18:00",
                                        @"time"     :@"18:00",
                                        @"width"    :@"51",
                                        @"left"     :@"156",
                                        },
                                      @{@"title"    :@"21:00",
                                        @"time"     :@"21:00",
                                        @"width"    :@"51",
                                        @"left"     :@"208",
                                        },
                                      @{@"title"    :@"現時刻",
                                        @"time"     :[NSNull null],
                                        @"width"    :@"60",
                                        @"left"     :@"260",
                                        },
                                      ];
        
//        NSArray *buttonProperties = [NSArray arrayWithObjects:
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"06:00", @"title",
//                                      @"06:00", @"time",
//                                      @"51",    @"width",
//                                      @"0",     @"left",
//                                      nil],
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"09:00", @"title",
//                                      @"09:00", @"time",
//                                      @"51",    @"width",
//                                      @"52",    @"left",
//                                      nil],
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"12:00", @"title",
//                                      @"12:00", @"time",
//                                      @"51",    @"width",
//                                      @"104",   @"left",
//                                      nil],
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"18:00", @"title",
//                                      @"18:00", @"time",
//                                      @"51",    @"width",
//                                      @"156",   @"left",
//                                      nil],
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"21:00", @"title",
//                                      @"21:00", @"time",
//                                      @"51",    @"width",
//                                      @"208",   @"left",
//                                      nil],
//                                     [NSDictionary dictionaryWithObjectsAndKeys:
//                                      @"現時刻", @"title",
//                                      [NSNull null], @"time",
//                                      @"60",    @"width",
//                                      @"260",   @"left",
//                                      nil],
//                                     nil];
        
        for(NSDictionary *buttonProperty in buttonProperties)
        {
            CGFloat left = [[buttonProperty objectForKey:@"left"] floatValue];
            if([CTPlatformDevice isIPad] == YES)
            {
                left += ((1024 - 320) / 2);
            }
            CTButton *buttonTime = [[CTButton alloc] initWithText:[buttonProperty objectForKey:@"title"]];
            [buttonTime setStyle:buttonStyle];
            [[buttonTime callStyle] addStyles:@{
                                                @"left"     :CTStr(left),
                                                @"width"    :[buttonProperty objectForKey:@"width"],
                                                }];
//            [[buttonTime callStyleNormal] addStyleKey:@"left" value:[@(left) stringValue]];
//            [[buttonTime callStyleNormal] addStyleKey:@"width" value:[buttonProperty objectForKey:@"width"]];
            [[buttonTime callStyleHighlighted] addStyles:[buttonStyleHighlighed callAllStyles]];
            [buttonTime setUserInfo:[@{@"time":[buttonProperty objectForKey:@"time"]} mutableCopy]];
//            [buttonTime setUserInfo:[NSMutableDictionary dictionaryWithObject:[buttonProperty objectForKey:@"time"] forKey:@"time"]];
            [buttonTime addTarget:self action:@selector(onTapButtonShortcut:) forControlEvents:UIControlEventTouchUpInside];
            [[self inputPackingView] addSubview:buttonTime];
        }
    }
    // ピッカーモード日付
    else if(_pickerModeValue == CTTableCellDatePickerModeDate)
    {
        // 日付モード
        [[self datePicker] setDatePickerMode:UIDatePickerModeDate];
        
        // 位置変更
        [[self datePicker] setFrame:CGRectMake(0, 0, 320, 216)];
        [[self datePicker] setCenter:[[self inputPackingView] center]];
        
        // パッキングビュー
        [[self inputPackingView] setFrame:CGRectMake(0, 0, 320, 248)];
        [[self inputPackingView] addSubview:[self datePicker]];
    }
}

// 取得(日付)
- (NSDate *)date
{
    // 日付
    NSDate *result = [[self datePicker] date];
    
    // 日付モードの時は時間を切る
    if([self pickerMode] == CTTableCellDatePickerModeDate)
    {
        result = [CTDate dateRemoveHHIISSWithDate:result];
    }
    
    return result;
}

// 設定(日付)
- (void)setDate:(NSDate *)dateValue
{
    if([dateValue isEqual:[NSNull null]] == YES)
    {
        [self setContentText:@""];
        return ;
    }
    
    [[self datePicker] setDate:dateValue];
    
    if([self dateFormatter] != nil)
    {
        [self setContentText:[[self dateFormatter] stringFromDate:dateValue]];
    }
    else
    {
        [self setContentText:[dateValue description]];
    }
}


#pragma mark - private
//
// private
//


// 値変更
- (void) onChangeDate:(UIDatePicker *)datePickerValue
{
    [self setDate:[datePickerValue date]];
}

// ボタン押下時(ショートカット)
- (void) onTapButtonShortcut:(CTButton *)buttonValue
{
    NSString *timeString = [[buttonValue userInfo] objectForKey:@"time"];
    NSInteger hour = 0;
    NSInteger minute = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if([timeString isEqual:[NSNull null]] == YES)
    {
        NSDateComponents *workComponents = [CTDate componentsWithDate:[NSDate date]];
//        NSDateComponents *workComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
        hour = [workComponents hour];
        minute = [workComponents minute];
    }
    else
    {
        NSArray *timeArray = [timeString componentsSeparatedByString:@":"];
        hour = [[timeArray objectAtIndex:0] integerValue];
        minute = [[timeArray objectAtIndex:1] integerValue];
    }
    
    NSDateComponents *components = [CTDate componentsWithDate:[self date]];
//    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[self date]];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:0];
    [self setDate:[calendar dateFromComponents:components]];
    [[self datePicker] sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
