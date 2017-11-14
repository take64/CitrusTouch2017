//
//  CTChartList.h
//  CitrusTouch3
//
//  Created by take64 on 2016/02/06.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTChartData;
@class CTColor;

@interface CTChartList : NSObject
{
    // タイトル
    NSString *title;
    
    // リスト
    NSArray<CTChartData *> *dataList;
    
    // 最小値・最大値
    NSNumber *minValue;
    NSNumber *maxValue;
    
    // 色
    UIColor *color;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray<CTChartData *> *dataList;
@property (nonatomic, retain) NSNumber *minValue;
@property (nonatomic, retain) NSNumber *maxValue;
@property (nonatomic, retain) UIColor *color;


//
// method
//

// 初期化
- (id)initWithTitle:(NSString *)titleString values:(NSArray<CTChartData *> *)dataValue;


@end
