//
//  CTKeySelectModal.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/19.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBaseSelectModal.h"

@interface CTKeySelectModal : CTBaseSelectModal
{
    // 選択キー
    id selectedKey;
    
    // データ
    NSArray<NSArray *> *keyList;    // keyの多重配列
    NSDictionary *keyDict;          // key辞書
}

//
// property
//
@property (nonatomic, retain) id selectedKey;
@property (nonatomic, retain) NSArray<NSArray *> *keyList;
@property (nonatomic, retain) NSDictionary *keyDict;

//
// method
//

// データ読み込み
- (void)bindSelectData:(NSArray<NSArray *> *)_keyList keyValue:(NSDictionary *)_keyDict;

// データ設定
- (void)loadObject:(NSMutableArray<id> *)_selectedList;

@end
