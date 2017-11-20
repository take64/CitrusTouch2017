//
//  CTDrawerMenuPanel.h
//  CitrusTouch3
//
//  Created by take64 on 2017/01/25.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTView.h"

@interface CTDrawerMenuPanel : UIView
{
    // ヘッダ
    CTView *headView;
    UIImageView *headImageView;

    // メニュー
    UITableView *menuTableView;
}



//
// property
//
@property (nonatomic, retain) CTView *headView;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UITableView *menuTableView;

@end
