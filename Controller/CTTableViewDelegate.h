//
//  CTTableViewDelegate.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/05/03.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CTTableViewMode)
{
    CTTableViewModeList,
    CTTableViewModeEdit
};

@protocol CTTableViewDelegate <NSObject>

@optional

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section;

// セルフッタタイトル取得
- (NSString *)callFooterTitleWithSection:(NSInteger)section;

// セルヘッダビュー取得
- (UIView *)callHeaderViewWithSection:(NSInteger)section;

// セルフッタビュー取得
- (UIView *)callFooterViewWithSection:(NSInteger)section;

// テーブルモード
- (CTTableViewMode)callTableViewMode;

@end
