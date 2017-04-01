//
//  CTTheme.h
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTTheme : NSObject
{
    // navigation color
    UIColor *navigationBarColor;
    
    // drawer setting
    UIColor *drawerBackColor;           // back color
    UIImage *drawerPanelIcon;           // panel icon
    UIColor *drawerPanelBackColor;      // panel back color
    UIColor *drawerCellHeadBackColor;   // cell head back color
    UIColor *drawerCellHeadTextColor;   // cell head text color
    UIColor *drawerCellBodyBackColor;   // cell body back color
    UIColor *drawerCellBodyTextColor;   // cell body text color
    
}

//
// property
//
@property (nonatomic, retain) UIColor *navigationBarColor;
// drawer setting
@property (nonatomic, retain) UIColor *drawerBackColor;           // back color
@property (nonatomic, retain) UIImage *drawerPanelIcon;           // panel icon
@property (nonatomic, retain) UIColor *drawerPanelBackColor;      // panel back color
@property (nonatomic, retain) UIColor *drawerCellHeadBackColor;   // cell head back color
@property (nonatomic, retain) UIColor *drawerCellHeadTextColor;   // cell head text color
@property (nonatomic, retain) UIColor *drawerCellBodyBackColor;   // cell body back color
@property (nonatomic, retain) UIColor *drawerCellBodyTextColor;   // cell body text color


// UINavigationBar - color
- (UIColor *)callNavigationBarColor;

// drawer setting
- (UIColor *)callDrawerBackColor;           // back color
- (UIImage *)callDrawerPanelIcon;           // panel icon
- (UIColor *)callDrawerPanelBackColor;      // panel back color
- (UIColor *)callDrawerCellHeadBackColor;   // cell head back color
- (UIColor *)callDrawerCellHeadTextColor;   // cell head text color
- (UIColor *)callDrawerCellBodyBackColor;   // cell body back color
- (UIColor *)callDrawerCellBodyTextColor;   // cell body text color

@end
