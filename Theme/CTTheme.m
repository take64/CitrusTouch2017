//
//  CTTheme.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/03/27.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTheme.h"

#import "CTColor.h"

@implementation CTTheme

//
// synthesize
//

@synthesize appIconImage;

@synthesize navigationBarTintColor;
@synthesize navigationBarTextColor;

@synthesize drawerBackColor;
@synthesize drawerPanelIconImage;
@synthesize drawerPanelBackColor;
@synthesize drawerCellHeadBackColor;
@synthesize drawerCellHeadTextColor;
@synthesize drawerCellBodyBackColor;
@synthesize drawerCellBodyTextColor;

@synthesize tableCellHeadBackColor;
@synthesize tableCellHeadTextColor;


#pragma mark - method
//
// method
//


// application
- (UIImage *)callAppIconImage   { return [CTNVL compare:[self appIconImage] replace:[[UIImage alloc] init]]; }

// navigation setting
- (UIColor *)callNavigationBarTintColor { return [CTNVL compare:[self navigationBarTintColor]   replace:[UIColor whiteColor]]; }
- (UIColor *)callNavigationBarTextColor { return [CTNVL compare:[self navigationBarTextColor]   replace:[UIColor whiteColor]]; }


// drawer setting
- (UIColor *)callDrawerBackColor        { return [CTNVL compare:[self drawerBackColor]          replace:[UIColor whiteColor]]; }
- (UIImage *)callDrawerPanelIconImage   { return [CTNVL compare:[self drawerPanelIconImage]     replace:[[UIImage alloc] init]]; }
- (UIColor *)callDrawerPanelBackColor   { return [CTNVL compare:[self drawerPanelBackColor]     replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellHeadBackColor{ return [CTNVL compare:[self drawerCellHeadBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellHeadTextColor{ return [CTNVL compare:[self drawerCellHeadTextColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellBodyBackColor{ return [CTNVL compare:[self drawerCellBodyBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *)callDrawerCellBodyTextColor{ return [CTNVL compare:[self drawerCellBodyTextColor]  replace:[UIColor whiteColor]]; }

// table setting
- (UIColor *)callTableCellHeadBackColor { return [CTNVL compare:[self tableCellHeadBackColor]   replace:[UIColor whiteColor]]; }
- (UIColor *)callTableCellHeadTextColor { return [CTNVL compare:[self tableCellHeadTextColor]   replace:[UIColor whiteColor]]; }

@end
