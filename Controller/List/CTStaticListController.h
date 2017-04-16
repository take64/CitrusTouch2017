//
//  CTStaticListController.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBaseListController.h"

@interface CTStaticListController : CTBaseListController
{
    // ヘッダ内セル数
    NSArray *rowOfSection;
    
    // ヘッダタイトル
    NSArray *headTitles;
    
}

//
// property
//
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) NSArray *headTitles;


@end
