//
//  CTDrawerViewController.h
//  CitrusTouch2017
//
//  Created by kouhei.takemoto on 2017/01/24.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTDrawerMenuPanel.h"

@class CTDrawerMenuSection;
//@class CTDrawerMenuPanel;

@interface CTDrawerViewController : UINavigationController<UITableViewDataSource, UITableViewDelegate>
{
//    // navigation view controller
//    UINavigationController *mainNavigationController;
    
    // view controller
    UIViewController *mainViewController;
    
    // menus
    NSArray<CTDrawerMenuSection *> *menuSections;
    
//    // color
//    UIColor *tintColor;
//    UIColor *headColor;
//    UIColor *cellColor;
    
    // menu button
    UIBarButtonItem *slideMenuButton;
    
    // menu visible
    BOOL menuVisible;
    
    // ヘッダビュー
    CTDrawerMenuPanel *menuPanel;
}

//
// property
//
//@property (nonatomic, retain) UINavigationController *mainNavigationController;
@property (nonatomic, retain) UIViewController *mainViewController;
@property (nonatomic, retain) NSArray<CTDrawerMenuSection *> *menuSections;
//@property (nonatomic, retain) UIColor *tintColor;
//@property (nonatomic, retain) UIColor *headColor;
//@property (nonatomic, retain) UIColor *cellColor;
@property (nonatomic, retain) UIBarButtonItem *slideMenuButton;
@property (nonatomic, assign) BOOL menuVisible;
@property (nonatomic, retain) CTDrawerMenuPanel *menuPanel;


//
// method
//

// init
- (id)initWithController:(UIViewController *)controllerValue menuSections:(NSArray<CTDrawerMenuSection *> *)menuSectionList;

//// setting color
//- (void)setTintColor:(UIColor *)tintColorValue headColor:(UIColor *)headColorValue cellColor:(UIColor *)cellColorValue;

// setting head image
- (void)setHeadImage:(UIImage *)imageValue;


@end
