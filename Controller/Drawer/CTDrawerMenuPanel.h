//
//  CTDrawerMenuPanel.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/01/25.
//  Copyright © 2017年 citrus.live. All rights reserved.
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


//
// method
//

//// bind
//- (void)bindImage:(UIImage *)imageValue;

//// setter head background-color
//- (void)setHeadBackgroundColor:(UIColor *)colorValue;
//
//// setter table view background-color
//- (void)setTableViewBackgroundColor:(UIColor *)colorValue;

@end
