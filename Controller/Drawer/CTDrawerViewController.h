//
//  CTDrawerViewController.h
//  CitrusTouch3
//
//  Created by take64 on 2017/01/24.
//  Copyright © 2017 citrus.tk. All rights reserved.
//

#import "CTNavigationController.h"

#import "CTDrawerMenuPanel.h"

@class CTDrawerMenuSection;
@class CTBarButtonItem;

@interface CTDrawerViewController : CTNavigationController<UITableViewDataSource, UITableViewDelegate, CTTableViewDelegate, UIGestureRecognizerDelegate>
{
    // view controller
    UIViewController *mainViewController;

    // menus
    NSArray<CTDrawerMenuSection *> *menuSections;

    // menu button
    CTBarButtonItem *slideMenuButton;

    // menu visible
    BOOL menuVisible;

    // ヘッダビュー
    CTDrawerMenuPanel *menuPanel;
}



//
// property
//
@property (nonatomic, retain) UIViewController *mainViewController;
@property (nonatomic, retain) NSArray<CTDrawerMenuSection *> *menuSections;
@property (nonatomic, retain) CTBarButtonItem *slideMenuButton;
@property (nonatomic, assign) BOOL menuVisible;
@property (nonatomic, retain) CTDrawerMenuPanel *menuPanel;



//
// method
//

// init
- (id)initWithController:(UIViewController *)controllerValue menuSections:(NSArray<CTDrawerMenuSection *> *)menuSectionList;

@end
